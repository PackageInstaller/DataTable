using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class AIParadoxComponent : BaseComponent
{
	public static string AI_PARADOX_KEY = "ParadoxTreeId";

	public static string EXTERNAL_PARADOX_KEY = "ExternalParadoxes";

	private bool initialize;

	private int _treeId = -1;

	private int _propSkillTreeId = -1;

	private int _deputyBattlePropSkillId = -1;

	private List<int> _externalTreeIdList;

	private bool isPause;

	public override void OnAwake(object data = null)
	{
		ParadoxSystem system = mBaseEntity.GetSystem<ParadoxSystem>();
		if (system == null)
		{
			return;
		}
		int data2 = GetData<int>(AI_PARADOX_KEY);
		if (data2 > 0)
		{
			_treeId = system.ExecuteTreeOrFsm(mBaseEntity, data2);
		}
		List<int> data3 = GetData<List<int>>(EXTERNAL_PARADOX_KEY);
		if (!data3.IsNullOrEmpty())
		{
			_externalTreeIdList = new List<int>(data3.Count);
			for (int i = 0; i < data3.Count; i++)
			{
				int item = system.ExecuteTreeOrFsm(mBaseEntity, data3[i]);
				_externalTreeIdList.Add(item);
			}
		}
		initialize = true;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if (mBaseEntity is HeroEntity heroEntity)
		{
			ExecutePropSkillTree(heroEntity.BattleHeroData);
		}
	}

	public override void OnPause()
	{
		base.OnPause();
		PauseParadoxTree();
		isPause = true;
	}

	public override void OnResume()
	{
		base.OnResume();
		ResumeParadoxTree();
		isPause = false;
	}

	private void ExecutePropSkillTree(BattleHeroData heroData)
	{
		_propSkillTreeId = mBaseEntity.GetSystem<ParadoxSystem>().ExecuteTreeOrFsm(mBaseEntity, heroData.BpData?.AiTreeId ?? 0);
		_deputyBattlePropSkillId = mBaseEntity.GetSystem<ParadoxSystem>().ExecuteTreeOrFsm(mBaseEntity, heroData.DeputyBpData?.AiTreeId ?? 0);
	}

	public bool IsLoadingFinished()
	{
		return _treeId > -1;
	}

	public void ChangeEntityState(int stateId)
	{
		SetVariableValues("s_entityState", stateId);
	}

	public void ChangeToHitState(Vector3 hitDirect)
	{
		if (initialize && _treeId != -1)
		{
			float paramValue = ((!Mathf.Approximately(hitDirect.sqrMagnitude, 0f)) ? (Mathf.Atan2(hitDirect.x, hitDirect.z) * 57.29578f) : 0f);
			ParadoxSystem system = mBaseEntity.GetSystem<ParadoxSystem>();
			if (system != null)
			{
				system.SetVariableValues(_treeId, "s_hit", paramValue: true);
				system.SetVariableValues(_treeId, "s_bulletDirection", paramValue);
			}
		}
	}

	public void ChangeToWeaknessAttackPower(int power)
	{
		mBaseEntity.GetSystem<ParadoxSystem>().SetVariableValues(_treeId, "s_WeaknessAttackPower", power);
	}

	public void SetVariableValues<T>(string paramKey, T paramValue)
	{
		if (_treeId != -1)
		{
			mBaseEntity.GetSystem<ParadoxSystem>().SetVariableValues(_treeId, paramKey, paramValue);
		}
	}

	public void SetPropSkillVariableValues(int propId, int propLevel, Vector3 skillPosition, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		int num = -1;
		switch (heroSkillTypeEnum)
		{
		case HeroSkillTypeEnum.PropSkill:
			num = _propSkillTreeId;
			break;
		case HeroSkillTypeEnum.DeputyPropSkill:
			num = _deputyBattlePropSkillId;
			break;
		}
		if (num != -1)
		{
			ParadoxSystem system = mBaseEntity.GetSystem<ParadoxSystem>();
			if (system != null)
			{
				system.SetVariableValues(num, "BattlePropId", propId);
				system.SetVariableValues(num, "BattlePropLevel", propLevel);
				system.SetVariableValues(num, "PropSkillPosition", skillPosition);
				system.SetVariableValues(num, "PropSkillStartPlay", paramValue: true);
			}
		}
	}

	public T GetVariableValue<T>(string variableKey)
	{
		if (_treeId == -1)
		{
			return default(T);
		}
		return mBaseEntity.GetSystem<ParadoxSystem>().GetVariableValues<T>(_treeId, variableKey);
	}

	public void AICalculationEnd(int calculation)
	{
	}

	public void PauseParadoxTree()
	{
		if (_treeId == -1)
		{
			return;
		}
		ParadoxSystem system = mBaseEntity.GetSystem<ParadoxSystem>();
		if (system == null)
		{
			return;
		}
		system.PauseTree(_treeId);
		if (_externalTreeIdList.IsNullOrEmpty())
		{
			return;
		}
		foreach (int externalTreeId in _externalTreeIdList)
		{
			system.PauseTree(externalTreeId);
		}
	}

	public void ResumeParadoxTree()
	{
		if (_treeId == -1)
		{
			return;
		}
		ParadoxSystem system = mBaseEntity.GetSystem<ParadoxSystem>();
		if (system == null)
		{
			return;
		}
		system.ResumeTree(_treeId);
		if (_externalTreeIdList.IsNullOrEmpty())
		{
			return;
		}
		foreach (int externalTreeId in _externalTreeIdList)
		{
			system.ResumeTree(externalTreeId);
		}
	}

	public void StopParadoxTree()
	{
		if (_treeId == -1)
		{
			return;
		}
		ParadoxSystem system = mBaseEntity.GetSystem<ParadoxSystem>();
		if (system == null)
		{
			return;
		}
		system.StopTree(_treeId);
		_treeId = -1;
		if (_externalTreeIdList.IsNullOrEmpty())
		{
			return;
		}
		foreach (int externalTreeId in _externalTreeIdList)
		{
			system.StopTree(externalTreeId);
		}
		_externalTreeIdList = null;
	}

	private void StopPropSkillParadoxTree()
	{
		if (_propSkillTreeId != -1)
		{
			mBaseEntity.GetSystem<ParadoxSystem>().StopTree(_propSkillTreeId);
			_propSkillTreeId = -1;
		}
		if (_deputyBattlePropSkillId != -1)
		{
			mBaseEntity.GetSystem<ParadoxSystem>().StopTree(_deputyBattlePropSkillId);
			_deputyBattlePropSkillId = -1;
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		StopParadoxTree();
		StopPropSkillParadoxTree();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (isPause)
		{
			ResumeParadoxTree();
			isPause = false;
		}
	}
}
