using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Attack_Artillery : SkillSimpleBase
{
	private bool isRed;

	private int lv;

	private int phase;

	private int ScanSuccessSquareCount;

	private AdventureActor summoner;

	private string Color;

	private int BulletAmount;

	private FP ShootTotalTime;

	private bool IsUpgrade;

	private string BulletName;

	private string StartFX1Name;

	private string StartFX2Name;

	private string ScanFXName;

	private string ScanSuccessSquareFXName;

	private string StartFX3Name_Plus;

	private string ShootFXName;

	private string SelfAttackAreaName;

	private List<int> SuccessIndexes;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		IsUpgrade = false;
		SuccessIndexes = new List<int>();
		BulletAmount = Config.ArtilleryShootCountBase;
		ShootTotalTime = Config.ArtilleryShootDurationBase;
		ChessInitialize();
	}

	protected override IEnumerator DoMainLogic()
	{
		FP initialRotation = GetRotation();
		TSVector2 position;
		FP rotation;
		if (lv >= 3)
		{
			Skill_Attack_Artillery skill_Attack_Artillery = this;
			string scanFXName = ScanFXName;
			position = GetPosition();
			rotation = GetRotation();
			skill_Attack_Artillery.PlayEffect(scanFXName, 1f, default, position, rotation);
			ScanSuccessSquareCount = CalExtraShootCount();
			if (phase >= 3 && ScanSuccessSquareCount < 2)
			{
				ScanSuccessSquareCount = 2;
			}
			IsUpgrade = true;
			BulletAmount += 3 * ScanSuccessSquareCount;
			ShootTotalTime += (FP)ScanSuccessSquareCount;
			yield return WaitTime(0.7);
			foreach (int successIndex in SuccessIndexes)
			{
				TSVector2 cellPosByIndex = Config.GetCellPosByIndex(successIndex);
				Skill_Attack_Artillery skill_Attack_Artillery2 = this;
				string scanSuccessSquareFXName = ScanSuccessSquareFXName;
				position = cellPosByIndex;
				skill_Attack_Artillery2.PlayEffect(scanSuccessSquareFXName, 1f, default, position);
			}
			yield return WaitTime(0.5);
		}
		FP y = Config.GetCurIndexByPos(GetPosition()).y;
		if (lv >= 3 && phase >= 2 && (y == 0 || y == 4))
		{
			yield return BeginLookAt(GetCurrentPlayer(), 0.5, 360);
		}
		if (IsUpgrade)
		{
			Skill_Attack_Artillery skill_Attack_Artillery3 = this;
			string startFX3Name_Plus = StartFX3Name_Plus;
			position = GetPosition();
			rotation = GetRotation();
			skill_Attack_Artillery3.PlayEffect(startFX3Name_Plus, 1f, default, position, rotation);
		}
		Skill_Attack_Artillery skill_Attack_Artillery4 = this;
		position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4.5));
		rotation = GetRotation();
		skill_Attack_Artillery4.PlayEarlyWarningEffect("ShooLineWarning", 1f, default, position, rotation);
		yield return WaitTime(1);
		PlayAreaEffect(SelfAttackAreaName, GetPosition(), initialRotation);
		BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
		Skill_Attack_Artillery skill_Attack_Artillery5 = this;
		string startFX1Name = StartFX1Name;
		position = GetPosition();
		rotation = GetRotation();
		skill_Attack_Artillery5.PlayEffect(startFX1Name, 1f, default, position, rotation);
		Skill_Attack_Artillery skill_Attack_Artillery6 = this;
		string startFX2Name = StartFX2Name;
		position = GetPosition();
		rotation = GetRotation();
		skill_Attack_Artillery6.PlayEffect(startFX2Name, 1f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopWaitLookAt();
		int curCount = 0;
		FP interval = ShootTotalTime / (BulletAmount - 1);
		while (curCount < BulletAmount)
		{
			Skill_Attack_Artillery skill_Attack_Artillery7 = this;
			string shootFXName = ShootFXName;
			position = GetPosition();
			rotation = GetRotation();
			skill_Attack_Artillery7.PlayEffect(shootFXName, 1f, default, position, rotation);
			RectangleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, awaitShootCompletion: false, ScanSuccessSquareCount / 2 + 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5)), 1.6, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 3, 1);
			curCount++;
			yield return WaitTime(interval);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_actor.DestroySelf();
	}

	private int CalExtraShootCount()
	{
		int num = 0;
		List<long> logicTagListLongValue = GetLogicTagListLongValue(summoner, "MapGrids_Color");
		GridColor gridColor = (isRed ? GridColor.Red : GridColor.Green);
		int y = Config.GetCurIndexByPos(GetPosition()).y.AsInt();
		for (int i = 1; i < Config.cellCount; i++)
		{
			int num2 = ((!isRed) ? Config.GetCellIndexByIndex(4 - i, y) : Config.GetCellIndexByIndex(i, y));
			if (logicTagListLongValue.get_Item(num2) == (long)gridColor)
			{
				num++;
				SuccessIndexes.Add(num2);
			}
		}
		return num;
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		BulletName = "Weapon_72004QiZiPao_" + Color;
		StartFX1Name = "fx_m72004_base_atk_charge_01_" + Color;
		StartFX2Name = "fx_m72004_base_atk_charge_02_" + Color;
		ScanFXName = "fx_m72004_base_atk_scan_" + Color;
		ScanSuccessSquareFXName = "fx_m72004_base_atk_light_5x5_" + Color;
		StartFX3Name_Plus = "fx_m72004_loop_atk_charge_03_" + Color + "_strengthen";
		ShootFXName = "fx_m72004_base_atk_shoot_" + Color;
		if (IsUpgrade)
		{
			StartFX1Name = "fx_m72004_base_atk_charge_01_" + Color + "_strengthen";
			StartFX2Name = "fx_m72004_base_atk_charge_02_" + Color + "_strengthen";
		}
		SelfAttackAreaName = "AreaEffect_72004_SelfAttack_" + Color;
	}
}
