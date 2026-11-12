using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Bombard_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_Bombard = "LiPaoHongJiP2";

	private static FP EnergyThreshold_Low = 33;

	private static FP EnergyThreshold_Mid = 67;

	private static readonly int[] waveCount = new int[6] { 1415346281, 1701668200, 1802659152, 1701336156, 1180657005, 1768713313 };

	private FP waveInterval = 2;

	private readonly string[] landPlaceHolders = new string[9] { "P1_Nv_Skill1_1", "P1_Nv_Skill1_2", "P1_Nv_Skill1_3", "P1_Nv_Skill1_4", "P1_Nv_Skill1_5", "P1_Nv_Skill1_6", "P1_Nv_Skill1_7", "P1_Nv_Skill1_8", "P1_Nv_Skill1_9" };

	private static readonly int[] shotCount_Low;

	private static readonly int[] shotCount_Mid;

	private static readonly int[] shotCount_High;

	private const string areaEffectAlias_Low = "AreaEffect_72012_Skill1_LiPao";

	private const string areaEffectAlias_Mid = "AreaEffect_72012_Skill1_LiPao";

	private const string areaEffectAlias_High = "AreaEffect_72012_Skill1_LiPao";

	private FP ringInnerRadius = 1;

	private FP ringOuterRadius = 4;

	private FP areaEffectSpawnInterval = FP.FromFloat(0f);

	public static FP BombardFinalHitRadius;

	public const long BombardFinalToughnessReduce = 10L;

	private const string bulletAlias_Final = "AreaEffect_72012_Skill1_Final_NoRing";

	private static readonly string[] fromPositionHolders;

	private static readonly string[] toPositionHolders;

	private FP approachMoveSpeed = 36;

	private bool finished;

	private int _summonLevel;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearOwnerWeapon();
			AddBuffToTarget(_actor, 720130108);
			RemoveBuffFromTarget(_actor, 720130107);
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = (int)(long)GetRandomValue(0, fromPositionHolders.Length, isInt: true);
		TSVector2 fromPos = GetPlaceHolderPosition(fromPositionHolders[num]);
		TSVector2 toPos = GetPlaceHolderPosition(toPositionHolders[num]);
		Teleport(fromPos, checkPositionReachable: false);
		BeginLookAtByPos(TSVector2.zero, default, 1000);
		yield return WaitTime(0.1);
		AddBuffToTarget(_actor, 720130109);
		AddBuffToTarget(_actor, 720130107);
		FP origSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(toPos, 0.2f);
		PlayWwiseSound("mon_72012_move");
		yield return WaitMoveStatus();
		_actor.actorInfo.runSpeed = origSpeed;
		_actor.actorInfo.walkSpeed = origSpeed;
		BeginAttack(1, "LiPaoHongJiP2", flushInputedKeys: true);
		int strength = GetStrength();
		int num2 = ((_summonLevel >= 0) ? ((_summonLevel >= waveCount.Length) ? (waveCount.Length - 1) : _summonLevel) : 0);
		int waves = waveCount[num2];
		for (int w = 0; w < waves; w++)
		{
			yield return StartCor(FireWave(strength));
			if (w < waves - 1)
			{
				yield return WaitTime(waveInterval);
			}
		}
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCustomEvent("FinalShoot");
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		long id = PlayAreaEffect("AreaEffect_72012_Skill1_Final_NoRing", entityPosition);
		AreaEffectEntity finalAreaEntity = GetAreaEffect(id);
		long _lockFxId = PlayLinkEffect("fx_m72012_loop_skill1_bullet_link_LeftHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		long _lockFxId2 = PlayLinkEffect("fx_m72012_loop_skill1_bullet_link_RightHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		yield return WaitTime(1.5);
		FreezeLinkEffectTarget(_lockFxId);
		FreezeLinkEffectTarget(_lockFxId2);
		yield return WaitTime(0.4);
		StopEffect(_lockFxId);
		StopEffect(_lockFxId2);
		long _ShootFxId = PlayLinkEffect("fx_m72012_bullet_skill1_LeftHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		long _ShootFxId2 = PlayLinkEffect("fx_m72012_bullet_skill1_RightHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		yield return WaitTime(0.15);
		StopEffect(_ShootFxId);
		StopEffect(_ShootFxId2);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtPosition(TSVector2.zero, 1000);
		FP retSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(fromPos, 0.2f);
		yield return WaitMoveStatus();
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
		_actor.actorInfo.runSpeed = retSpeed;
		_actor.actorInfo.walkSpeed = retSpeed;
		CancelAim();
	}

	private void FreezeLinkEffectTarget(long id)
	{
		List<AdventureFXHandler> handlers = SceneSingleton<AdventureFXManager>.Instance.handlers;
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.token == id)
			{
				Vector3 targetPosition = adventureFXPlayer.targetPosition;
				adventureFXPlayer.target = null;
				adventureFXPlayer.targetPosition = targetPosition;
				break;
			}
		}
	}

	private IEnumerator FireWave(int strength)
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			yield break;
		}
		TSVector2 playerPos = GetEntityPosition(currentPlayer);
		TSVector2 bossPos = GetPosition();
		string alias = GetWaveAlias(strength);
		List<string> list = new List<string>(landPlaceHolders);
		list.Sort((string a, string b) =>
		{
			FP fP = TSVector2.Distance(GetPlaceHolderPosition(a), playerPos);
			FP other = TSVector2.Distance(GetPlaceHolderPosition(b), playerPos);
			return fP.CompareTo(other);
		});
		int count = (int)(long)TSMath.Min(GetShotCount(strength), list.Count);
		List<string> selected = list.GetRange(0, count);
		selected.Sort((string a, string b) =>
		{
			FP fP = TSVector2.Distance(GetPlaceHolderPosition(a), bossPos);
			FP other = TSVector2.Distance(GetPlaceHolderPosition(b), bossPos);
			return fP.CompareTo(other);
		});
		for (int i = 0; i < selected.Count; i++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(selected.get_Item(i));
			Skill_Bombard_JuXingMoXiang skill_Bombard_JuXingMoXiang = this;
			FP radius = ringOuterRadius;
			FP innerRadius = ringInnerRadius;
			DeterministicShape shapeData = skill_Bombard_JuXingMoXiang.GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius, innerRadius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			PlayAreaEffect(alias, shapeRandomPoint);
			if (i < selected.Count - 1)
			{
				yield return WaitTime(areaEffectSpawnInterval);
			}
		}
	}

	private int GetStrength()
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, Common_73001.EnergyTag);
		if (logicTagFpValue <= EnergyThreshold_Low)
		{
			return 0;
		}
		if (logicTagFpValue <= EnergyThreshold_Mid)
		{
			return 1;
		}
		return 2;
	}

	private int GetShotCount(int strength)
	{
		int num = ((_summonLevel >= 0) ? ((_summonLevel >= shotCount_Low.Length) ? (shotCount_Low.Length - 1) : _summonLevel) : 0);
		return strength switch
		{
			0 => shotCount_Low[num], 
			1 => shotCount_Mid[num], 
			_ => shotCount_High[num], 
		};
	}

	private string GetWaveAlias(int strength)
	{
		if (strength == 0)
		{
			return "AreaEffect_72012_Skill1_LiPao";
		}
		_ = 1;
		return "AreaEffect_72012_Skill1_LiPao";
	}

	static Skill_Bombard_JuXingMoXiang()
	{
		//IL_003a: Field data (rva=0x4b0) could not be found in any section!
		//IL_003a: Field data (rva=0x4b0) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._02CBF74A6E3E59C808EE3CF22BB07C7FD50A3BECE20E7B4F45894F1AB510E8A8));
		shotCount_Low = array;
		shotCount_Mid = new int[6] { 1852399976, 1097748319, 1667331188, 1984716651, 54, 1229009920 };
		shotCount_High = new int[6] { 1816485733, 1920230245, 1818313327, 1935879788, 16777216, 838860800 };
		BombardFinalHitRadius = 4;
		fromPositionHolders = new string[3] { "JuXingApproach_From_Left", "JuXingApproach_From_Right", "JuXingApproach_From_Up" };
		toPositionHolders = new string[3] { "JuXingApproach_To_Left", "JuXingApproach_To_Right", "JuXingApproach_To_Up" };
	}
}
