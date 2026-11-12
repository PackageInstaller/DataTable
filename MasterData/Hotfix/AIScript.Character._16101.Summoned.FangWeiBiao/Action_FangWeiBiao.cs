using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class Action_FangWeiBiao : AIBase
{
	private const int perkId_23 = 516123;

	private const int skillId_FWB_Attack = 16133005;

	private static readonly FP delayTime = 0.5;

	private IState curState;

	private ClassObjectPool<SkillState> skillPool;

	private FP _elapsed;

	private bool bAttack => GetPerk(516123);

	public void OnEnable()
	{
		skillPool = new ClassObjectPool<SkillState>(() => new SkillState(_actor), 2);
		_elapsed = 0;
	}

	public void OnDisable()
	{
		skillPool?.Clear(clearUsed: true);
		curState = null;
	}

	public void OnStart()
	{
	}

	public void OnUpdate()
	{
		if (_elapsed < delayTime)
		{
			_elapsed += _actor.LogicDeltaTime;
		}
		else
		{
			if (!bAttack)
			{
				return;
			}
			if (curState != null && !curState.IsEnd)
			{
				curState.Update();
				return;
			}
			if (curState is SkillState instance)
			{
				skillPool.Return(instance);
				curState = null;
			}
			SkillState skillState = skillPool.Rent();
			skillState.SetSkill(16133005);
			skillState.Enter();
			if (skillState.CanCast)
			{
				curState = skillState;
			}
			else
			{
				skillPool.Return(skillState);
			}
		}
	}
}
