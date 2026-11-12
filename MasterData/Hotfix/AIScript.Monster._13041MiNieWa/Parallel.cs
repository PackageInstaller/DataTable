using System.Collections;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Parallel : AIScript.Monster.Template.Parallel
{
	protected readonly FP checkRadius = 20;

	protected readonly FP checkInnerRadius = 6;

	protected readonly FP checkIntervalTime = 0.3;

	protected readonly int checkCount = 70;

	protected readonly string StarMoonFieldAttack = "StarMoonFieldWarning";

	protected CoroutineNode _corCheck;

	private FP distance = 4;

	private FP continueTime = 10;

	private FP timer;

	private bool isTaskFinish;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public void OnUpdate()
	{
		if (_actor.logicVariable.GetLogicTagToggle("13041StarMoonField_Area"))
		{
			_actor.logicVariable.ToggleLogicTag("13041StarMoonField_Area", value: false);
			StopCoroutine(ref _corCheck);
			StartCoroutine(ref _corCheck, CorCheck());
		}
		CheckDistance();
	}

	private IEnumerator CorCheck()
	{
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		for (int i = 0; i < checkCount; i++)
		{
			FP fP = _actor.DistanceWithRadius(target);
			if (checkInnerRadius <= fP && fP <= checkRadius)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, StarMoonFieldAttack, target.tsTransform.Position, _actor.tsTransform.Rotation);
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(checkIntervalTime));
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref _corCheck);
	}

	public override void OnStart()
	{
		base.OnStart();
		timer = 0;
		isTaskFinish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.MiNieWaZhuxian_001);
	}

	public void CheckDistance()
	{
		if (isTaskFinish || !(mainCtrActor != null))
		{
			return;
		}
		if (TSVector2.Distance(_actor.tsTransform.Position, mainCtrActor.tsTransform.Position) <= distance)
		{
			timer += _actor.LogicDeltaTime;
			if (timer > continueTime)
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.MiNieWaZhuxian_001);
				isTaskFinish = true;
			}
		}
		else
		{
			timer = 0;
		}
	}
}
