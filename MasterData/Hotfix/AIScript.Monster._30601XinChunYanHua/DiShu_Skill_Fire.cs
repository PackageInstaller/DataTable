using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30601XinChunYanHua;

public class DiShu_Skill_Fire : SkillSimpleBase
{
	private static readonly string Blue = "Area_Sparkler_Blue";

	private static readonly string Purple = "Area_Sparkler_Purple";

	private static readonly string Red = "Area_Sparkler_Red";

	private static readonly string Yellow = "Area_Sparkler_Yellow";

	private static readonly FP FireTime = 10;

	private readonly FP roteteSpeed = -480;

	private static readonly FP DashSpeed = 10;

	private static readonly FP DashDistance = 3;

	private static readonly FP Offset = 45;

	private TSVector2 DashDirection;

	private string BombName;

	private FP TimeCount;

	private List<AreaEffectEntity> AreaList = new List<AreaEffectEntity>();

	private List<LogicEntity> YanHuaTong = new List<LogicEntity>();

	private LogicEntity MoveTarget;

	private DeterministicShape AttackShape;

	private DeterministicShape FindShape;

	private TSVector2 MovePoint;

	private long Area1;

	private long Area2;

	private long Area3;

	private long Area4;

	private FP _time;

	private bool TimeFinish;

	private bool MoveMode;

	protected override void OnSkillEnable()
	{
		AreaList.Clear();
		TimeCount = 0;
		TimeFinish = false;
		switch (randomWeight(new int[2] { 8, 2 }))
		{
		case 0:
			MoveMode = true;
			break;
		case 1:
			MoveMode = false;
			break;
		}
	}

	protected override void OnSkillDisable()
	{
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(Timer());
		StartCor(GetPoint());
		PlayRandomArea();
		int PorN = 1;
		while (!TimeFinish)
		{
			YanHuaTong.Clear();
			DiShu_Skill_Fire diShu_Skill_Fire = this;
			DiShu_Skill_Fire diShu_Skill_Fire2 = this;
			TSVector2 position = GetPosition();
			FP radius = 15;
			diShu_Skill_Fire.FindShape = diShu_Skill_Fire2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
			List<LogicEntity> list = new List<LogicEntity>();
			list.AddRange(GetTargetByTeammateIndex(0));
			YanHuaTong = GetTargetsFromShape(FindShape, list);
			if (MoveMode && YanHuaTong.Count != 0)
			{
				for (int i = 0; i < YanHuaTong.Count; i++)
				{
					if (GetBuffNum(YanHuaTong.get_Item(i), 306010001) < 1)
					{
						MoveTarget = YanHuaTong.get_Item(i);
						break;
					}
				}
				if (MoveTarget != null)
				{
					DashDirection = RotateTo(GetEntityPosition(MoveTarget) - GetPosition(), Offset * PorN);
					PorN = -1 * PorN;
				}
				else
				{
					DashDirection = RotateTo(MovePoint - GetPosition(), Offset * PorN);
					PorN = -1 * PorN;
				}
			}
			else
			{
				DashDirection = RotateTo(MovePoint - GetPosition(), Offset * PorN);
				PorN = -1 * PorN;
			}
			Dash();
			yield return WaitDashFinish();
		}
		yield return WaitFrame(1);
	}

	private void PlayRandomArea()
	{
		Area1 = PlayAreaEffect(Blue, GetPosition(), GetRotation());
		Area2 = PlayAreaEffect(Purple, GetPosition(), GetRotation() + 90);
		Area3 = PlayAreaEffect(Red, GetPosition(), GetRotation() + 180);
		Area4 = PlayAreaEffect(Yellow, GetPosition(), GetRotation() + 270);
		AreaEffectEntity areaEffect = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(Area1);
		AreaEffectEntity areaEffect2 = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(Area2);
		AreaEffectEntity areaEffect3 = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(Area3);
		AreaEffectEntity areaEffect4 = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(Area4);
		AreaList.Add(areaEffect);
		AreaList.Add(areaEffect2);
		AreaList.Add(areaEffect3);
		AreaList.Add(areaEffect4);
		FixAreaRotation();
	}

	private void FixAreaRotation()
	{
		for (int i = 0; i < AreaList.Count; i++)
		{
			FP t = GetRotation() + i * 90 + _time * roteteSpeed;
			t = TSMath.Repeat(t, 360f);
			AreaList.get_Item(i).tsTransform.Rotation = t;
		}
	}

	public void OnUpdate()
	{
		_time += LockStepManager.deltaTime;
		FixAreaRotation();
	}

	private void Dash()
	{
		BeginDash(1, DashDirection, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private IEnumerator Timer()
	{
		while (TimeCount <= FireTime)
		{
			yield return WaitFrame(1);
			TimeCount += (FP)0.033;
		}
		TimeFinish = true;
	}

	private IEnumerator GetPoint()
	{
		while (TimeCount <= FireTime)
		{
			DiShu_Skill_Fire diShu_Skill_Fire = this;
			DiShu_Skill_Fire diShu_Skill_Fire2 = this;
			TSVector2 position = GetPosition();
			FP radius = 15;
			FP innerRadius = 8;
			diShu_Skill_Fire.AttackShape = diShu_Skill_Fire2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			MovePoint = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
			yield return WaitTime(FireTime / 2);
		}
	}
}
