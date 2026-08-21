using System;
using System.Collections.Generic;
using Config;
using UnityEngine;

public class OutSourcingAttributeModifier : MonoBehaviour
{
	private SimEntity[] _simEntities;

	private bool m_showAddRole;

	protected List<int> _roleIDs = new List<int>();

	protected Vector2 scrollPosition;

	private static Action<int, int> aiAction;

	private static SimWorldState worldState;

	private Dictionary<int, bool> m_dictRoleLoaded = new Dictionary<int, bool>();

	private void Awake()
	{
		PlayerPrefs.SetInt("frame", 1);
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		AudioManager.Instance.SetListener(Camera.main.gameObject);
		AudioManager.Instance.CreateCriAtom();
		float volume = AudioManager.Instance.GetVolume("effect");
		volume = Mathf.Clamp01(volume);
		AudioManager.Instance.SetVolume("effect", volume);
		volume = AudioManager.Instance.GetVolume("voice");
		volume = Mathf.Clamp01(volume);
		AudioManager.Instance.SetVolume("voice", volume);
		volume = AudioManager.Instance.GetVolume("music");
		volume = Mathf.Clamp01(volume);
		AudioManager.Instance.SetVolume("music", volume);
		AudioManager.Instance.Play("music", "bgm_battle_choose", "bgm_battle_choose", useStream: true);
	}

	private void Update()
	{
		_simEntities = ClientSimulator.Instance.mSimContext.GetEntities();
		NScene nScene = null;
		if (SceneDirector.Instance != null)
		{
			nScene = NScene.GetCurrentScene();
		}
		if (!(nScene != null) || !(nScene is OutSourcingBattleScene))
		{
			return;
		}
		OutSourcingBattleScene outSourcingBattleScene = nScene as OutSourcingBattleScene;
		for (int i = 0; i < _simEntities.Length; i++)
		{
			SimEntity simEntity = _simEntities[i];
			if (simEntity.hasEntityBlackboard && simEntity.hasEntityConfig && outSourcingBattleScene.ignoreAI && simEntity.hasEntityActionMoveDirection && simEntity.hasEntityCamp && RoleCampProcessor.IsEnemy(simEntity.entityCamp.mRoleTypeCamp))
			{
				AIProcessor.StopAIMovement(simEntity.creationIndex);
			}
			if (outSourcingBattleScene.ignoreCD && simEntity.hasEntityCD && RoleCampProcessor.IsPlayer(simEntity.entityCamp.mRoleTypeCamp))
			{
				CDProcessor.CleanAllCD(simEntity);
			}
			if (outSourcingBattleScene.fullPower && simEntity.hasEntityCamp && RoleCampProcessor.IsPlayer(simEntity.entityCamp.mRoleTypeCamp))
			{
				if (!AttributeProcessor.TryAddPowerValue(simEntity, 1000000, out var newValue, out var oldValue))
				{
					break;
				}
				AttributeProcessor.TryGetEnergyMaxValue(simEntity, out var maxValue);
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(simEntity.entityConfig.mId);
				if (ClientSimulator.Instance.mSimContext.GetSimInterface().mOnPowerUpdate != null)
				{
					ClientSimulator.Instance.mSimContext.GetSimInterface().mOnPowerUpdate(simEntity.creationIndex, newValue, oldValue, maxValue, maxValue, (EnergyType)config.EnergyType);
				}
			}
			if (outSourcingBattleScene.ignoreAI && ClientSimulator.Instance.mSimContext.GetSimInterface().mUpdateAILogicEvent != null)
			{
				aiAction = ClientSimulator.Instance.mSimContext.GetSimInterface().mUpdateAILogicEvent;
				ClientSimulator.Instance.mSimContext.GetSimInterface().mUpdateAILogicEvent = null;
			}
			else if (!outSourcingBattleScene.ignoreAI && aiAction != null)
			{
				ClientSimulator.Instance.mSimContext.GetSimInterface().mUpdateAILogicEvent = aiAction;
				aiAction = null;
			}
			if (outSourcingBattleScene.ignoreAI)
			{
				worldState = ClientSimulator.Instance.mSimContext.sEntityWorldState.status;
				worldState.mBattleStart = false;
			}
			else if (worldState != null)
			{
				worldState.mBattleStart = true;
			}
		}
	}
}
