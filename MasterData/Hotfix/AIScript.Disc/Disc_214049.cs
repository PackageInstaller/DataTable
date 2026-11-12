using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214049 : DiscScriptBase
{
	private const int discId = 214049;

	private List<int> skillId_s1 = new List<int> { 404901, 404902, 404903, 404904, 404905, 404906 };

	private List<FP> hpPercet = new List<FP> { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 };

	private List<int> shiledId = new List<int> { 4049001, 4049002, 4049003, 4049004, 4049005, 4049006 };

	private List<FP> cd = new List<FP> { 30, 30, 30, 30, 30, 30 };

	private int lv_s1;

	private int stage_s1;

	private CoroutineNode corAddShiled;

	private FP currentCd;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		currentCd = 0;
		(stage_s1, lv_s1) = GetDiscInfo(214049, skillId_s1);
		if (lv_s1 >= 1)
		{
			StartCoroutine(ref corAddShiled, DoAddShiled());
		}
	}

	private IEnumerator DoAddShiled()
	{
		while (true)
		{
			FP fP = hpPercet.get_Item(stage_s1);
			if (_actor != null && _actor.actorHealthInfo.hpPercentage < fP && currentCd <= 0)
			{
				currentCd = cd.get_Item(stage_s1);
				_actor.actorShield.AddShield(shiledId.get_Item(stage_s1), _actor);
			}
			currentCd -= LockStepManager.deltaTime;
			yield return null;
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		StopCoroutine(ref corAddShiled);
	}
}
