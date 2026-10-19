using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.DialogueSystem;
using ACT.Drama;
using ACT.Event;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionPlayNpcAvgDialogue : NpcInteractAction
{
	private static ObjectPool<ChatOptionNode> _objectPool = new ObjectPool<ChatOptionNode>((ChatOptionNode x) =>
	{
		x.children.Clear();
	}, null);

	[FormerlySerializedAs("dialogueEnvironmentID")]
	public int avgGroupID;

	private LuminDialogueFlowAsset _asset;

	private bool _isDialogueObjectLoaded = true;

	public override int ActionId => NpcInteractActionIds.PlayNpcAvgDialogue;

	public ActionPlayNpcAvgDialogue()
	{
		useNpcCamera = true;
	}

	protected internal override UniTask AfterDoAction()
	{
		if (!_isDialogueObjectLoaded)
		{
			return UniTask.WaitUntil(() => _isDialogueObjectLoaded);
		}
		return UniTask.CompletedTask;
	}

	protected override async UniTask DoAction()
	{
		_isDialogueObjectLoaded = false;
		if (!Context.Npc.IsValid)
		{
			_isDialogueObjectLoaded = true;
			return;
		}
		GameObject asset = null;
		try
		{
			MonoECS.instance.PushPauseAllInput();
			asset = await GetCopyDialogueGameObject(avgGroupID);
			MonoECS.instance.PopPauseAllInput();
		}
		finally
		{
			_isDialogueObjectLoaded = true;
		}
		if (!asset)
		{
			Debug.LogError($"AvgGroupID {avgGroupID} 的对话树不存在");
			return;
		}
		if (Context.StackDepth == 1)
		{
			DialogueEnvironment component = asset.GetComponent<DialogueEnvironment>();
			if (!component || !component.FlowAsset)
			{
				Debug.LogError($"AvgGroupID {avgGroupID} 的对话树缺少DialogueEnvironment或FlowAsset");
				return;
			}
			_asset = UnityEngine.Object.Instantiate(component.FlowAsset);
			if (!(_asset.data.root.children[0].children.LastOrDefault((DialogueNode x) => x is ChatNode) is ChatNode chatNode))
			{
				Debug.LogWarning($"AvgGroupID {avgGroupID}的对话树根节点下没有ChatNode，无法播放NPC专用AVG");
				return;
			}
			AddToFlowAsset(chatNode);
			component.FlowAsset = _asset;
		}
		NpcEvent npcEvent = Singleton<EventManager>.instance.GetEvt<NpcEvent>();
		npcEvent.NpcID = _npcId;
		npcEvent.AvgGroupID = avgGroupID;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_Dialog_Start, npcEvent);
		await Singleton<ConversationManager>.instance.BeginConversation(asset);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_Dialog_Finish, npcEvent);
		Singleton<EventManager>.instance.ReleaseEvt(npcEvent);
		AssetStationManager.BattleStation.ReleaseInstance(asset);
		await base.DoAction();
	}

	private async UniTask<GameObject> GetCopyDialogueGameObject(int id)
	{
		DialogueStoryGroupData data = CoreUtils.GetData(id, RuntimeConfigs.data.dialogueStoryGroupDatas);
		if (data == null)
		{
			return null;
		}
		AssetLoadHandle dialogueAssetHandle = AssetStationManager.BattleStation.InstantiateAsync(data.path);
		await dialogueAssetHandle;
		return dialogueAssetHandle.As<GameObject>();
	}

	private void AddToFlowAsset(ChatNode chatNode)
	{
		List<DialogueNode> list = ListPool<DialogueNode>.Get();
		foreach (NpcInteractOption interactOption in Context.InteractEntryConfig.interactOptions)
		{
			if (!interactOption.ShouldShow())
			{
				continue;
			}
			chatNode.important = true;
			ChatOptionNode node = _objectPool.Get();
			node = interactOption.ConvertToDialogueNode(node) as ChatOptionNode;
			if (node == null)
			{
				continue;
			}
			List<NpcInteractAction> tempOptions = ListPool<NpcInteractAction>.Get();
			foreach (NpcInteractAction allInteractAction in interactOption.GetAllInteractActions())
			{
				tempOptions.Add(allInteractAction);
			}
			tempOptions.Sort();
			ChatOptionNode chatOptionNode = node;
			chatOptionNode.OnSelectCallback = (Func<UniTask>)Delegate.Combine(chatOptionNode.OnSelectCallback, new Func<UniTask>(OnOptionOnSelectCallback));
			list.Add(node);
			async UniTask OnOptionOnSelectCallback()
			{
				foreach (NpcInteractAction item in tempOptions)
				{
					item.DoAction(Context).Forget();
					await item.AfterDoAction();
				}
				ListPool<NpcInteractAction>.Release(tempOptions);
				ChatOptionNode chatOptionNode2 = node;
				chatOptionNode2.OnSelectCallback = (Func<UniTask>)Delegate.Remove(chatOptionNode2.OnSelectCallback, new Func<UniTask>(OnOptionOnSelectCallback));
				_objectPool.Release(node);
			}
		}
		chatNode.children.AddRange(list);
		ListPool<DialogueNode>.Release(list);
	}
}
