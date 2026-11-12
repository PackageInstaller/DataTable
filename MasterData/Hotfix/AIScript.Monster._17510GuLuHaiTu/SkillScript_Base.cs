#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class SkillScript_Base : SkillSimpleBase
{
	protected static string actionStateTagName = "AcitonFinish";

	protected static string sinkStateTag = "SinkFinish";

	protected IEnumerator FlyingFish(LogicEntity master)
	{
		List<TSVector2> spwanPOS = new List<TSVector2>
		{
			TransLocalPosToWorldPos(GetEntityPositionObsoleted(master), GetEntityForward(master), new TSVector2(-10, 0)),
			TransLocalPosToWorldPos(GetEntityPositionObsoleted(master), GetEntityForward(master), new TSVector2(-5, 6)),
			TransLocalPosToWorldPos(GetEntityPositionObsoleted(master), GetEntityForward(master), new TSVector2(5, 2)),
			TransLocalPosToWorldPos(GetEntityPositionObsoleted(master), GetEntityForward(master), new TSVector2(10, 7))
		};
		for (int i = 0; i < spwanPOS.Count; i++)
		{
			PlayEffect("fx_m17510_base_Skill03_fire", 0.5f, default, spwanPOS.get_Item(i));
			yield return WaitTime(GetRandomValue(0, 0.3));
		}
		spwanPOS.Clear();
	}

	protected IEnumerator FishJumpIn(TSVector2 initialPOS, TSVector2 forward)
	{
		FP randomValue = GetRandomValue(-2, 2);
		FP randomValue2 = GetRandomValue(-2, 2);
		TSVector2 position = TransLocalPosToWorldPos(initialPOS, forward, new TSVector2(-2, -8 + randomValue));
		TSVector2 spawnDown = TransLocalPosToWorldPos(initialPOS, forward, new TSVector2(2, -8 + randomValue2));
		PlayEffect("fx_m17510_base_Skill03_fish_down", 1f, default, position);
		yield return WaitTime(0.07);
		PlayEffect("fx_m17510_base_Skill03_fish_down", 1f, default, spawnDown);
	}

	protected IEnumerator WaveAttack(TSVector2 beginPOS, TSVector2 forward)
	{
		PlayWwiseSound("mon_17510_skywater_warning");
		List<TSVector2> warningFxPos = new List<TSVector2>();
		warningFxPos.AddRange(GetWarningFxPos(beginPOS, forward));
		List<long> warningFxID = new List<long>();
		for (int i = 0; i < warningFxPos.Count; i++)
		{
			warningFxID.Add(PlayEffect("fx_m17510_loop_Skill05_warning", 1.5f, 0.7, warningFxPos.get_Item(i), GetTSVectToAngle(forward, 0)));
			yield return WaitTime(0.5);
		}
		StartCor(FishJumpIn(beginPOS, forward));
		yield return WaitTime(0.5);
		if (warningFxID != null && warningFxID.Count > 0)
		{
			for (int j = 0; j < warningFxID.Count; j++)
			{
				StopEffect(warningFxID.get_Item(j));
			}
		}
		TSVector2 shootPOS = TransLocalPosToWorldPos(beginPOS, forward, new TSVector2(0, -4.5));
		PlayEffect("fx_m17510_loop_Skill2_wave_bullet_start", 1f, 0.7, shootPOS, GetTSVectToAngle(forward, 0));
		yield return WaitTime(0.25);
		RectangleMultipleShoot("GuLuHaiTu_WaveBullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, awaitShootCompletion: true, 1, 0, shootPOS, 0.7, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 24, 0);
		yield return WaitTime(1);
		warningFxPos.Clear();
		warningFxID.Clear();
	}

	private List<TSVector2> GetWarningFxPos(TSVector2 beginPOS, TSVector2 forward)
	{
		List<TSVector2> list = new List<TSVector2>();
		TSVector2 tSVector = beginPOS;
		for (int i = 0; i < 3; i++)
		{
			list.Add(tSVector);
			TSVector2 tSVector2 = tSVector;
			NovaLogger.Debug("咕噜海兔.通用API.预警位置" + tSVector2.ToString());
			tSVector = TransLocalPosToWorldPos(tSVector, forward, new TSVector2(0, 8));
		}
		return list;
	}
}
