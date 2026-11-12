using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30282ShengDanLiWuJi;

public class Skill_Gift : SkillSimpleBase
{
	private Dictionary<string, List<string>> BulletNameSquare = new Dictionary<string, List<string>>
	{
		["Lv1"] = new List<string> { "Bullet_30282_Gift_Atk_S", "Bullet_30282_Gift_Cd_L", "Bullet_30282_Gift_Def_S", "Bullet_30282_Gift_Energy_L", "Bullet_30282_Gift_Speed_L" },
		["Lv2"] = new List<string> { "Bullet_30282_Gift_Atk_M", "Bullet_30282_Gift_Def_M", "Bullet_30282_Gift_Speed_L" },
		["Lv3"] = new List<string> { "Bullet_30282_Gift_Atk_L" }
	};

	private List<string> BulletNameList = new List<string>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		BulletNameList = BulletNameSquare.get_Item(GetMonsterTagValue(_actor, 1));
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		string bulletAlias = BulletNameList.get_Item(TSRandom.Range(0, BulletNameList.Count));
		Skill_Gift skill_Gift = this;
		TSVector2 position = GetPosition();
		FP radius = 6;
		FP innerRadius = 3;
		DeterministicShape shapeData = skill_Gift.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetCurrentPlayer(), isReachable: true);
		PlayEffect("Box_shoot", 1f, default, GetPosition(), default, 1f, actorScale: true);
		CircleMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: true, 0, 1, 0, GetPosition(), default, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, shapeRandomPoint);
		yield return null;
	}
}
