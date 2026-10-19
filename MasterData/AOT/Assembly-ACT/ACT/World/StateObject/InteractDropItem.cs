using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.World.Actions;
using ACT.World.Behave;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractDropItem")]
public class InteractDropItem : StateObjectBase
{
	[NonSerialized]
	[HideInInspector]
	public DropItemBehaveEvents dropItem;

	public InteractEntry interactEntry;

	public Rigidbody rig;

	public float maxPickupDistanceSqrt = 50f;

	[NonSerialized]
	[HideInInspector]
	public DropItem dropItemData;

	private int m_ItemId;

	private AssetLoadHandle m_Handle;

	private DropItemStaticNode m_StaticNode;

	public override bool serviceSave => false;

	public int quality { get; private set; }

	public int itemId
	{
		get
		{
			return m_ItemId;
		}
		private set
		{
			if (m_ItemId != value)
			{
				m_ItemId = value;
				ItemData itemData = RuntimeConfigs.data.itemDatas[value];
				if (AssetLoadHandleExtensions.IsValid(m_Handle))
				{
					AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
					m_Handle = default;
				}
				if (string.IsNullOrEmpty(itemData.address))
				{
					m_Handle = AssetStationManager.BattleStation.Instantiate(GameLoader.meta.defaultItemBhaveAssetID[itemData.quality - 1], transform);
				}
				else
				{
					m_Handle = AssetStationManager.BattleStation.Instantiate("StateObjectBehave/" + itemData.address, transform);
				}
				dropItem = m_Handle.AsGameObject().GetComponent<DropItemBehaveEvents>();
				dropItem.interactDropItem = this;
				quality = itemData.quality;
			}
		}
	}

	public bool OnGround { get; private set; }

	public override void InitStateObject(int stateId)
	{
		itemId = dropItemData.ItemId;
		interactEntry.BindInteractObjectBase(this);
		interactEntry.BindInteractState(1, 0);
		OnGround = false;
		DelayEnterPickState().Forget();
		interactEntry.onInteract = OnInteract;
		if (dropItem.interactType == InteractType.Button)
		{
			interactEntry.LocalizedString.TableEntryReference = RuntimeConfigs.data.itemDatas[itemId].nameLocal;
		}
		else if (dropItem.interactType == InteractType.TriggerEnter)
		{
			interactEntry.ResetInteractType(InteractType.TriggerEnter);
			GetComponentInChildren<BoxCollider>().size = dropItem.GetComponentInChildren<BoxCollider>().size;
		}
		base.InitStateObject(stateId);
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 1 && entryIndex == 0)
		{
			interactEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 1)
		{
			if (!MonoECS.instance.localPlayer.robotEntity.IsValid || dropItem.robotNotPick)
			{
				interactEntry.HandleEnter();
			}
			else
			{
				interactEntry.HandleInteract(MonoECS.instance.localPlayer.battleEntity, InteractAction.InteractSource.Player);
			}
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 1 && (!MonoECS.instance.localPlayer.robotEntity.IsValid || dropItem.robotNotPick))
		{
			interactEntry.HandleExit();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		switch (currentStateId)
		{
		case 0:
			rig.velocity = Singleton<DropItemManager>.instance.DropDir();
			dropItem.Drop();
			break;
		case 1:
			if (currentStateId == 1 && (!MonoECS.instance.localPlayer.robotEntity.IsValid || dropItem.robotNotPick))
			{
				interactEntry.HandleInit();
			}
			break;
		case 2:
			dropItem.Pick();
			break;
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 1 && (!MonoECS.instance.localPlayer.robotEntity.IsValid || dropItem.robotNotPick))
		{
			interactEntry.HandleUninit();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	private void OnCollisionEnter(Collision collision)
	{
		if (currentStateId == 0 && ((1 << collision.gameObject.layer) & BattleConsts.enviromentMask) > 0)
		{
			OnGround = true;
			dropItem.OnGround();
		}
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId <= 2;
		}
		return false;
	}

	private async UniTask DelayEnterPickState()
	{
		await UniTask.Delay(TimeSpan.FromSeconds(UnityEngine.Random.Range(GameLoader.meta.collectCD.x, GameLoader.meta.collectCD.y)));
		EnterState(1);
	}

	private void OnInteract(Entity eb)
	{
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		if (localPlayer.robotEntity.IsValid && !dropItem.robotNotPick)
		{
			dropItem.Collect(localPlayer.battleEntity.GetRootTransform());
		}
		else
		{
			dropItem.CollectImmediately();
		}
	}

	protected void FixedUpdate()
	{
		if (currentStateId == 1 && Vector3.SqrMagnitude(transform.position - MonoECS.instance.mainEntity.GetRootTransform().position) > maxPickupDistanceSqrt)
		{
			OnInteract(default);
		}
	}

	public void SetDropItemNode(DropItemStaticNode node)
	{
		m_StaticNode = node;
	}

	public void RemoveDropItemNode()
	{
		Singleton<DropItemManager>.instance.ReleaseDropItemNode(m_StaticNode);
	}

	protected override InteractEntry GetInteractEntry()
	{
		return interactEntry;
	}
}
