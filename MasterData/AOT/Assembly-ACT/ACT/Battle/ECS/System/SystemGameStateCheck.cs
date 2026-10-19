using ACT.EventTrack;
using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle.ECS.System;

public class SystemGameStateCheck : ECSSystem
{
	private const float FallingDeadSecond = 15f;

	public override Filter MajorFilter => null;

	protected override void OnCreate()
	{
	}

	public override void FixedUpdate()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid || !mainEntity.IsLogicAvailable() || !(mainEntity.GetCompPhysics().FreeFallingTime > 15f))
		{
			return;
		}
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		bool flag = false;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.IsAlive())
			{
				teamCharacter.KillEntity();
				flag = true;
			}
		}
		if (flag)
		{
			FallEvt evt = EventTrackSolver.Instance.GetEvt<FallEvt>();
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}
}
