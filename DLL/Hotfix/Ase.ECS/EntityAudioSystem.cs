using System.Collections.Generic;
using FMOD.Studio;
using FMODUnity;

namespace Ase.ECS;

public class EntityAudioSystem : BaseSystem
{
	private List<Bus> pausableBus;

	private List<string> busPath = new List<string>
	{
		"bus:/SFX/Ambience", "bus:/SFX/Boss Performance", "bus:/SFX/Boss", "bus:/SFX/footstep gen", "bus:/SFX/MapItem", "bus:/SFX/Monster", "bus:/SFX/Player frequently(normal attack)", "bus:/SFX/Player Hobby", "bus:/SFX/Player Idle", "bus:/SFX/Player Performance",
		"bus:/SFX/Player Skill"
	};

	private bool isBusPausedByHitStop;

	private int busTimer;

	private readonly int delayPauseTime = 6;

	private bool needPause;

	protected override bool IsLogicSystem { get; }

	public override void OnStart(object data = null)
	{
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		base.OnStart(data);
		pausableBus = new List<Bus>(busPath.Count);
		for (int i = 0; i < busPath.Count; i++)
		{
			Bus bus = RuntimeManager.GetBus(busPath[i]);
			pausableBus.Add(bus);
		}
	}

	public override void OnGameSpeedChanged(float beforeTheChangeSpeed, float gameSpeed)
	{
		base.OnGameSpeedChanged(beforeTheChangeSpeed, gameSpeed);
		if (!world.InGameSpeed())
		{
			if (isBusPausedByHitStop)
			{
				isBusPausedByHitStop = false;
				PauseBus(pause: false);
			}
			needPause = false;
		}
		else if (world.GameSpeedIgnoreEntityCount() > 0 && !isBusPausedByHitStop && !needPause)
		{
			busTimer = delayPauseTime;
			needPause = true;
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (needPause)
		{
			busTimer--;
			if (busTimer == 0)
			{
				PauseBus(pause: true);
				isBusPausedByHitStop = true;
				needPause = false;
			}
		}
	}

	private void PauseBus(bool pause)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		for (int i = 0; i < pausableBus.Count; i++)
		{
			Bus val = pausableBus[i];
			((Bus)(ref val)).setPaused(pause);
		}
	}
}
