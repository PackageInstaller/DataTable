using ACT.Battle;
using ACT.Config;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBigWorldChallengePoint : InteractObject
{
	private static readonly int State = Animator.StringToHash("state");

	private BigWorldChallengeData _data;

	private AssetLoadHandle _switchModelHandle;

	private const string SwitchConfigPath = "Configs/ChallengeSwitchConfig";

	private Animator _switchAnimator;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BigWorldChallengeData data)
		{
			_data = data;
			LoadSwitchModel();
			base.InitStateObject(stateId);
		}
	}

	private void LoadSwitchModel()
	{
		ChallengeSwitchConfig challengeSwitchConfig = AssetStationManager.BattleStation.Load<ChallengeSwitchConfig>("Configs/ChallengeSwitchConfig").As<ChallengeSwitchConfig>();
		if (challengeSwitchConfig == null)
		{
			return;
		}
		YooAssetReference switchModelGuid = challengeSwitchConfig.GetSwitchModelGuid(_data.ChallengeType);
		if (GameUtility.RuntimeGuidIsValid(switchModelGuid.GUID))
		{
			_switchModelHandle = AssetStationManager.BattleStation.Instantiate(switchModelGuid, transform);
			GameObject gameObject = _switchModelHandle.AsGameObject();
			if (_data.SwitchPos != null)
			{
				gameObject.transform.position = _data.SwitchPos.value;
				gameObject.transform.rotation = _data.SwitchPos.rotate;
				gameObject.transform.localScale = _data.SwitchPos.localScale;
			}
			_switchAnimator = gameObject.GetComponentInChildren<Animator>();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (_switchAnimator != null)
		{
			_switchAnimator.SetInteger(State, stateId);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == 2;
		}
		return true;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0)
		{
			Singleton<BigWorldChallengeManager>.instance.StartChallenge(_data.ChallengeType, _data.ChallengeConfigId, transform);
		}
	}

	public override void ReleaseStateObject()
	{
		if (_switchModelHandle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(_switchModelHandle);
		}
		base.ReleaseStateObject();
	}
}
