using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill5_BroomShoot : SkillSimpleBase
{
	private struct SpawnPoint
	{
		public TSVector2 position;

		public TSVector2 direction;
	}

	private const string ComboKeyP1 = "Skill5_1_BroomShoot";

	private const string ComboKeyP2 = "Skill5_1_BroomShoot_Plus";

	private const string ComboKeyP3 = "Skill5_3_BroomShoot_Fly";

	private const string SummonBroomEvent = "SummonBroom";

	private const string BroomBulletAliasP1 = "Weapon_70061WuYu_Skill5_BroomBullet";

	private const string BroomBulletAliasP2 = "Weapon_70061WuYu_Skill5_BroomBullet_Big";

	private const string BroomBulletAliasP3 = "Weapon_70061WuYu_Skill5_BroomBullet_Big";

	private const string BroomStartFxAlias = "fx_70061WuYu_base_Attack13_broom_start";

	private static readonly FP BulletShootHeight = 0;

	private static readonly FP BroomStartFxDelayP1 = 1.5;

	private static readonly FP BroomStartFxSpawnSizeP1 = 1;

	private static readonly FP BroomStartFxSpeedP1 = 1;

	private static readonly FP BroomStartFxDelayP23 = 1.5;

	private static readonly FP BroomStartFxSpawnSizeP23 = 2;

	private static readonly FP BroomStartFxSpeedP23 = 1;

	private static readonly FP SpawnOffset = 2;

	private static readonly FP SummonIntervalP1 = 1.1;

	private const int SummonCountP1 = 2;

	private const int SummonCountP2 = 1;

	private static readonly FP SideAngle = 45;

	private static readonly FP HalfFieldSplitAngle = 40;

	public const string SideAreaFx_Phase2 = "AreaEffect_70061WuYu_Skill5_BroomBulletArea";

	public static readonly FP LayInterval_Phase2 = 1.2;

	public static readonly FP LaySideOffset_Phase2 = 2;

	public const string TrailAreaFx_Phase3 = "AreaEffect_70061WuYu_Skill5_BroomBulletArea";

	public static readonly FP LayInterval_Phase3 = 1.4;

	private const string BulletWarningFxAliasP3 = "fx_warning_dash_3x23";

	private static readonly FP BulletWarningDurationP3 = 2;

	public const string LayBulletEventName = "WuYu_Skill5_RegisterLayBullet";

	private readonly List<SpawnPoint> _spawnPointList = new List<SpawnPoint>(2);

	private static readonly FP FarProbe = 50;

	protected override IEnumerator DoMainLogic()
	{
		int phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		string actionKey;
		if (phase >= 3)
		{
			actionKey = "Skill5_3_BroomShoot_Fly";
		}
		else
		{
			actionKey = ((phase >= 2) ? "Skill5_1_BroomShoot_Plus" : "Skill5_1_BroomShoot");
		}
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonBroom");
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 bossPos = GetPosition();
		TSVector2 playerPos = ((currentPlayer != null) ? currentPlayer.tsTransform.Position : (bossPos + GetForward()));
		List<SpawnPoint> spawnList = CalcSpawnPoints(phase, bossPos, playerPos);
		FP startFxDelay = ((phase >= 2) ? BroomStartFxDelayP23 : BroomStartFxDelayP1);
		FP startFxSize = ((phase >= 2) ? BroomStartFxSpawnSizeP23 : BroomStartFxSpawnSizeP1);
		FP startFxSpeed = ((phase >= 2) ? BroomStartFxSpeedP23 : BroomStartFxSpeedP1);
		FP summonInterval = ((phase >= 3) ? ((FP)0) : SummonIntervalP1);
		for (int i = 0; i < spawnList.Count; i++)
		{
			StartCor(ShootBulletSequence(phase, spawnList.get_Item(i), bossPos, playerPos, startFxDelay, startFxSize, startFxSpeed));
			if (i < spawnList.Count - 1)
			{
				yield return WaitTime(summonInterval);
			}
		}
		yield return WaitTime(startFxDelay);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ShootBulletSequence(int phase, SpawnPoint spawnPoint, TSVector2 bossPos, TSVector2 playerPos, FP startFxDelay, FP startFxSize, FP startFxSpeed)
	{
		TSVector2 aimPos;
		if (phase < 2)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			aimPos = ((currentPlayer != null) ? currentPlayer.tsTransform.Position : (bossPos + GetForward()));
		}
		else
		{
			aimPos = playerPos;
		}
		TSVector2 tSVector = aimPos - spawnPoint.position;
		TSVector2 shootDir = ((tSVector.magnitude > FP.Zero) ? tSVector.normalized : GetForward());
		Skill5_BroomShoot skill5_BroomShoot = this;
		float playbackSpeed = startFxSpeed.AsFloat();
		TSVector2 position = spawnPoint.position;
		FP angle = shootDir.GetAngle();
		float spawnSize = startFxSize.AsFloat();
		long startFxId = skill5_BroomShoot.PlayEffect("fx_70061WuYu_base_Attack13_broom_start", playbackSpeed, default, position, angle, spawnSize);
		if (phase >= 3)
		{
			PlayEarlyWarningEffect("fx_warning_dash_3x23", BulletWarningDurationP3.AsFloat(), BulletShootHeight, spawnPoint.position, shootDir.GetAngle());
		}
		yield return WaitTime(startFxDelay);
		string bulletAlias;
		if (phase >= 3)
		{
			bulletAlias = "Weapon_70061WuYu_Skill5_BroomBullet_Big";
		}
		else
		{
			bulletAlias = ((phase >= 2) ? "Weapon_70061WuYu_Skill5_BroomBullet_Big" : "Weapon_70061WuYu_Skill5_BroomBullet");
		}
		long num = Shoot(bulletAlias, spawnPoint.position, BulletShootHeight, default, shootDir, AimType.Position, BulletDirectionType.BulletToTarget, aimPos);
		StopEffect(startFxId);
		if (num > 0 && phase > 1)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = "WuYu_Skill5_RegisterLayBullet";
			adventureActorCustomEvent.intParam = phase;
			adventureActorCustomEvent.target = GetBulletByID(num);
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private List<SpawnPoint> CalcSpawnPoints(int phase, TSVector2 bossPos, TSVector2 playerPos)
	{
		List<SpawnPoint> spawnPointList = _spawnPointList;
		spawnPointList.Clear();
		if (phase >= 3)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition("CenterPoint");
			TSVector2 tSVector = bossPos - placeHolderPosition;
			tSVector = ((tSVector.magnitude > FP.Zero) ? tSVector.normalized : GetForward());
			TSVector2 value = RotateTo(TSVector2.up, -HalfFieldSplitAngle);
			TSVector2 tSVector2 = ((TSVector2.Dot(tSVector, value) >= FP.Zero) ? tSVector : (-tSVector));
			TSVector2 dir = RotateTo(tSVector2, SideAngle);
			AddSpawnPoint(spawnPointList, GetArenaEdge(placeHolderPosition, dir), playerPos);
			TSVector2 dir2 = RotateTo(tSVector2, -SideAngle);
			AddSpawnPoint(spawnPointList, GetArenaEdge(placeHolderPosition, dir2), playerPos);
		}
		else
		{
			TSVector2 tSVector3 = playerPos - bossPos;
			tSVector3 = ((tSVector3.magnitude > FP.Zero) ? tSVector3.normalized : GetForward());
			TSVector2 position = bossPos + tSVector3 * SpawnOffset;
			int num = ((phase >= 2) ? 1 : 2);
			for (int i = 0; i < num; i++)
			{
				spawnPointList.Add(new SpawnPoint
				{
					position = position,
					direction = tSVector3
				});
			}
		}
		return spawnPointList;
	}

	private TSVector2 GetArenaEdge(TSVector2 center, TSVector2 dir)
	{
		TSVector2 tSVector = center + dir * FarProbe;
		AdventureActor actor = _actor;
		if ((object)actor != null && !actor.QueryPositionWalkable(tSVector) && actor.LinecastNavmeshGraph(center, tSVector, out var linecastHitPoint))
		{
			return linecastHitPoint;
		}
		return tSVector;
	}

	private void AddSpawnPoint(List<SpawnPoint> list, TSVector2 pos, TSVector2 playerPos)
	{
		TSVector2 tSVector = playerPos - pos;
		TSVector2 direction = ((tSVector.magnitude > FP.Zero) ? tSVector.normalized : GetForward());
		list.Add(new SpawnPoint
		{
			position = pos,
			direction = direction
		});
	}
}
