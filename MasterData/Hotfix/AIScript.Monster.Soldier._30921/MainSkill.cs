using System.Collections;
using TrueSync;

namespace AIScript.Monster.Soldier._30921;

public class MainSkill : SkillAdvancedBase
{
	public const int BuffId = 250106001;

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
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

	private IEnumerator DoMainLogic()
	{
		_actor.buffComponent.AddBuff(250106001, _actor);
		yield return null;
		OnFinish();
	}
}
