using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Action : AIBase
{
	protected enum SkillId
	{
		skill_Solo = 5052101,
		skill_Duet,
		skill_Tutti
	}

	private readonly FP StartWaitTime = 4;

	private readonly List<List<int>> initialSkillList = new List<List<int>>
	{
		new List<int> { 5052102, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052101, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052101, 4 },
		new List<int> { 5052103, 20 }
	};

	private readonly List<List<int>> loopSkillList = new List<List<int>>
	{
		new List<int> { 5052102, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052101, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052101, 4 },
		new List<int> { 5052102, 4 },
		new List<int> { 5052103, 20 }
	};

	private CoroutineNode _startSkill;

	private CoroutineNode _chooseSkill;

	private bool isLoopState;

	private int skillIndex;

	public void OnEnable()
	{
		skillIndex = 0;
		isLoopState = false;
	}

	public void OnStart()
	{
		StartCoroutine(ref _startSkill, StartSkill());
	}

	public void OnDisable()
	{
		StopCoroutine(ref _chooseSkill);
		StopCoroutine(ref _startSkill);
	}

	private IEnumerator StartSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(StartWaitTime));
		ChooseSkill();
	}

	private void ChooseSkill()
	{
		if (!_actor.actorHealthInfo.isAlive)
		{
			return;
		}
		if (!isLoopState)
		{
			StartCoroutine(ref _chooseSkill, ChooseSkill(initialSkillList.get_Item(skillIndex)));
			skillIndex++;
			if (skillIndex == initialSkillList.Count)
			{
				isLoopState = true;
				skillIndex = 0;
			}
		}
		else
		{
			StartCoroutine(ref _chooseSkill, ChooseSkill(loopSkillList.get_Item(skillIndex)));
			skillIndex++;
			if (skillIndex == loopSkillList.Count)
			{
				skillIndex = 0;
			}
		}
	}

	private IEnumerator ChooseSkill(List<int> skillInfo)
	{
		ILRuntimeAPI.CreateSkill(skillInfo.get_Item(0), _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(skillInfo.get_Item(1)));
		ChooseSkill();
	}
}
