using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Model;
using ACT.UI;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class OpenMiniGame : InteractAction
{
	public bool custom;

	public SeparateSegmentConfig separateSegmentConfig;

	public InteractActionList onTrue = new InteractActionList();

	public InteractActionList onFalse = new InteractActionList();

	private bool _over;

	private bool _fail;

	protected override AbilityAuth auth => AbilityAuth.Client;

	public override IEnumerator<InteractActionList> GetEnumerator()
	{
		yield return onTrue;
		yield return onFalse;
	}

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		bool flag = true;
		_over = false;
		_fail = false;
		foreach (InteractAction interactAction in onTrue.interactActions)
		{
			interactAction.BindInteractObject(stateObjectBase);
		}
		foreach (InteractAction interactAction2 in onFalse.interactActions)
		{
			interactAction2.BindInteractObject(stateObjectBase);
		}
		if (!(stateObjectBase.entity.GetCompStateObject().StateWorldAssetData is IMiniGameData miniGameData))
		{
			Debug.LogError($"Data is null OpenMiniGame不是适用于 {stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.GetType()} 类型");
		}
		else
		{
			flag = miniGameData.UseMiniGame;
			if (!custom)
			{
				separateSegmentConfig = Model<SeparateSegmentGameModel>.Interface.GetRandomConfigs(miniGameData.Difficulty);
			}
		}
		if (flag && separateSegmentConfig != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CONNECTIONMINIGAME, new ConnectionMiniGameViewData
			{
				separateSegmentConfig = separateSegmentConfig,
				callback = ResultCallBack,
				swid = stateObjectBase.swid
			});
		}
		else
		{
			_over = true;
			_fail = false;
		}
		await UniTask.WaitUntil(() => _over);
		if (_fail)
		{
			if (onFalse.interactActions == null)
			{
				return;
			}
			foreach (InteractAction interactAction3 in onFalse.interactActions)
			{
				await interactAction3.TryInteract(behave);
			}
		}
		else
		{
			if (onTrue.interactActions == null)
			{
				return;
			}
			foreach (InteractAction interactAction4 in onTrue.interactActions)
			{
				await interactAction4.TryInteract(behave);
			}
		}
	}

	public void ResultCallBack(bool fail)
	{
		_over = true;
		_fail = fail;
	}
}
