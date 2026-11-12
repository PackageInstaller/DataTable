namespace AIScript.Monster.Soldier._30901;

public class MainSkill : SkillAdvancedBase
{
	private int buffId = 250105701;

	private int buffId_2 = 250105702;

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_actor.buffComponent.AddBuff(buffId, _actor);
		if (PotentialLv >= 2)
		{
			_actor.buffComponent.AddBuff(buffId_2, _actor);
		}
		OnFinish();
	}
}
