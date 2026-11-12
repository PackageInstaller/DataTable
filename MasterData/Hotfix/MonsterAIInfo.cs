using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class MonsterAIInfo : LogicComponent
{
	private bool _checkAchievement;

	protected int _spawnSkillId;

	protected int _idleShowSkillId;

	protected int _deathSkillId;

	protected int _themeSkillId;

	protected FP _thinkInterval;

	protected FP _wanderRange;

	protected FP _wanderInterval;

	protected FP _wanderRate;

	protected List<int> _actionBranchIds;

	protected List<MonsterActionBranch> _actionBranchs;

	public bool checkAchievement
	{
		get
		{
			return _checkAchievement;
		}
		set
		{
			_checkAchievement = value;
		}
	}

	public int spawnSkillId
	{
		get
		{
			return _spawnSkillId;
		}
		set
		{
			_spawnSkillId = value;
		}
	}

	public int idleShowSkillId
	{
		get
		{
			return _idleShowSkillId;
		}
		set
		{
			_idleShowSkillId = value;
		}
	}

	public int deathSkillId
	{
		get
		{
			return _deathSkillId;
		}
		set
		{
			_deathSkillId = value;
		}
	}

	public int themeSkillId
	{
		get
		{
			return _themeSkillId;
		}
		set
		{
			_themeSkillId = value;
		}
	}

	public FP thinkInterval
	{
		get
		{
			return _thinkInterval;
		}
		set
		{
			_thinkInterval = value;
		}
	}

	public FP wanderRange
	{
		get
		{
			return _wanderRange;
		}
		set
		{
			_wanderRange = value;
		}
	}

	public FP wanderInterval
	{
		get
		{
			return _wanderInterval;
		}
		set
		{
			_wanderInterval = value;
		}
	}

	public FP wanderRate
	{
		get
		{
			return _wanderRate;
		}
		set
		{
			_wanderRate = value;
		}
	}

	public List<int> actionBranchIds
	{
		get
		{
			return _actionBranchIds;
		}
		set
		{
			_actionBranchIds = value;
			_actionBranchs = new List<MonsterActionBranch>();
			for (int i = 0; i < value.Count; i++)
			{
				MonsterActionBranch monsterActionBranch = Singleton<HotfixDataController>.Instance.GetMonsterActionBranch(value.get_Item(i));
				if (monsterActionBranch == null)
				{
					Debug.LogError($"monster ai action branch id not exist:{value.get_Item(i)}");
				}
				else
				{
					_actionBranchs.Add(monsterActionBranch);
				}
			}
		}
	}

	public List<MonsterActionBranch> actionBranchs => _actionBranchs;
}
