using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class Config
{
	public const int teammateIndex_BaoLin = 1;

	public const string comboTag_BaoLin_Spawn = "";

	public const string fxKey_BaoLin_Active = "";

	public static readonly FP delayTime_BaoLin_Active = 1;

	public const string comboTag_BaoLin_Death = "";

	public const string eventName_BaoLin_Explosion = "";

	public const string areaEffectKey_BaoLin_Explosion = "";

	public const int buffId_Burst = 318010010;

	public const string areaEffectKey_Burst = "Area_BaoYan_Meteor";

	public static readonly DeterministicShape generateAreaEffectShape_Burst = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		innerRadius = 0,
		radius = 11,
		position = new TSVector2(0, 0)
	};

	public static readonly FP generateInterval_Burst = 2;

	public const string comboTag_Spwan = "Spawn";

	public const string comboTag_Ground_Death = "Die_Ground";

	public const string comboTag_Fly_Death = "Die_Fly";

	public const int skillId_Bite = 3180101;

	public const string comboTag_Bite_Left = "Tearing_Left";

	public const string comboTag_Bite_Right = "Tearing_Right";

	public const string eventName_GenerateBaoLin_Bite = "BaoLin";

	public static readonly FP innerRadius_GenerateBaoLin_Bite = 3;

	public static readonly FP outerRadius_GenerateBaoLin_Bite = 5;

	public static readonly FP angle_GenerateBaoLin_Bite = 180;

	public static readonly FP offsetAngle_GenerateBaoLin_Bite = 45;

	public const int totalCount_GenerateBaoLin_Bite = 3;

	public static readonly FP interval_GenerateBaoLin_Bite = 0;

	public const string comboTag_Bite_Strength_Left = "Tearing_2_Left";

	public const string comboTag_Bite_Strength_Right = "Tearing_2_Right";

	public const string eventName_Bite_Strength_BaoLin = "BaoLin";

	public static readonly FP innerRadius_GenerateBaoLin_Bite_Strength = 3;

	public static readonly FP outerRadius_GenerateBaoLin_Bite_Strength = 5;

	public static readonly FP angle_GenerateBaoLin_Bite_Strength = 180;

	public static readonly FP offsetAngle_GenerateBaoLin_Bite_Strength = 45;

	public const int totalCount_GenerateBaoLin_Bite_Strength = 3;

	public static readonly FP interval_GenerateBaoLin_Bite_Strength = 0;

	public const int skillId_Claw = 3180102;

	public static readonly FP turnDuration_Claw = 0.5;

	public static readonly FP turnSpeed_Claw = 180;

	public const string comboTag_CostalJointHit_Claw = "WingStrike_1";

	public const string eventName_BaoLin_Left_Claw = "BaoLin_Left";

	public static readonly FP radius_GenerateBaoLin_Left_Claw = 4;

	public static readonly FP angle_GenerateBaoLin_Left_Claw = 120;

	public static readonly FP offsetAngle_GenerateBaoLin_Left_Claw = 60;

	public const int totalCount_GenerateBaoLin_Left_Claw = 5;

	public static readonly FP interval_GenerateBaoLin_Left_Claw = 0;

	public const string eventName_BaoLin_Right_Claw = "BaoLin_Right";

	public static readonly FP radius_GenerateBaoLin_Right_Claw = 4;

	public static readonly FP angle_GenerateBaoLin_Right_Claw = 120;

	public static readonly FP offsetAngle_GenerateBaoLin_Right_Claw = -60;

	public const int totalCount_GenerateBaoLin_Right_Claw = 5;

	public static readonly FP interval_GenerateBaoLin_Right_Claw = 0;

	public const string comboTag_Smash_Claw = "WingStrike_2";

	public const string eventName_BaoLin_Both_Claw = "BaoLin";

	public const int skillId_Tail = 3180103;

	public const string comboTag_Tail_Left = "TailStrike_Left";

	public const string comboTag_Tail_Right = "TailStrike_Right";

	public const string eventName_Tail_BaoLin = "BaoLin";

	public static readonly FP innerRadius_GenerateBaoLin_Tail = 4;

	public static readonly FP outerRadius_GenerateBaoLin_Tail = 6;

	public static readonly FP angle_GenerateBaoLin_Tail = 180;

	public static readonly FP offsetAngle_GenerateBaoLin_Tail = 180;

	public const int totalCount_GenerateBaoLin_Tail = 6;

	public static readonly FP interval_GenerateBaoLin_Tail = 0;

	public const string comboTag_Tail_Strength_Left = "TailStrike_Plus_Left";

	public const string comboTag_Tail_Strength_Right = "TailStrike_Plus_Right";

	public const string eventName_Tail_Strength_BaoLin = "BaoLin";

	public static readonly FP innerRadius_GenerateBaoLin_Tail_Strength = 6;

	public static readonly FP outerRadius_GenerateBaoLin_Tail_Strength = 8;

	public static readonly FP angle_GenerateBaoLin_Tail_Strength = 270;

	public static readonly FP offsetAngle_GenerateBaoLin_Tail_Strength = 225;

	public const int totalCount_GenerateBaoLin_Tail_Strength = 9;

	public static readonly FP interval_GenerateBaoLin_Tail_Strength = 0;

	public const int skillId_Push = 3180104;

	public const string comboTag_Charge_Push = "Dash_Ready";

	public static readonly FP loopTime_Charge_Push = 0.5;

	public const string comboTag_DashDrift_Push = "Dash_Mode1";

	public const string comboTag_DashHit_Push = "Dash_Mode2";

	public static readonly FP dashSpeed_Push = 10;

	public static readonly FP dashDistance_Push = 20;

	public static readonly FP driftDashSpeed_Push = 3;

	public static readonly FP driftDashDistance_Push = 2.4;

	public static readonly FP driftRotateSpeed_Push = 180;

	public static readonly FP length_GenerateBaoLin_Dash_Push = 2;

	public static readonly FP width_GenerateBaoLin_Dash_Push = 6;

	public static readonly FP offset_GenerateBaoLin_Dash_Push = -2;

	public const int count_GenerateBaoLin_Dash_Push = 1;

	public const int count_GenerateBaoLin_Dash_Strength_Push = 2;

	public static readonly FP interval_GenerateBaoLin_Dash_Push = 0.2;

	public const string eventName_Push_Strength_BaoLin = "BaoLin";

	public static readonly FP innerRadius_GenerateBaoLin_Push_Strength = 7;

	public static readonly FP outerRadius_GenerateBaoLin_Push_Strength = 8;

	public static readonly FP angle_GenerateBaoLin_Push_Strength = 120;

	public static readonly FP offsetAngle_GenerateBaoLin_Push_Strength = 0;

	public const int totalCount_GenerateBaoLin_Push_Strength = 4;

	public static readonly FP interval_GenerateBaoLin_Push_Strength = 0;

	public const int skillId_FireBreath = 3180111;

	public const string comboTag_FireBreath = "FanFire";

	public const string eventName_GenerateBaoLin_FireBreath = "BaoLin";

	public static readonly FP radius_GenerateBaoLin_FireBreath = 6;

	public static readonly FP angle_GenerateBaoLin_FireBreath = 120;

	public static readonly FP offset_GenerateBaoLin_FireBreath = 1;

	public const int totalCount_GenerateBaoLin_FireBreath = 4;

	public static readonly FP interval_GenerateBaoLin_FireBreath = 0;

	public static readonly FP loopTime_FireBreath = 4;

	public static readonly FP rotateSpeed_FireBreath = 10;

	public const string eventName_Attack_FireBreath = "BaoLin_Fire";

	public static readonly FP radius_Attack_FireBreath = 12;

	public static readonly FP angle_Attack_FireBreath = 90;

	public static readonly FP offset_Attack_FireBreath = 4.5;

	public const int skillId_HeatDischarge = 3180112;

	public const string comboTag_HeatDischarge = "CircleFire";

	public const string eventName_GenerateBaoLin_HeatDischarge = "BaoLin";

	public static readonly FP radius_GenerateBaoLin_HeatDischarge = 8;

	public const int totalCount_GenerateBaoLin_HeatDischarge = 8;

	public static readonly FP interval_GenerateBaoLin_HeatDischarge = 0.12;

	public static readonly FP loopTime_HeatDischarge = 4;

	public const string eventName_Attack_HeatDischarge = "BaoLin_Fire";

	public static readonly int radius_Attack_HeatDischarge = 8;

	public const int skillId_FireBurst = 3180113;

	public const string comboTag_Ground_FireBurst = "Transform_Ground";

	public const string comboTag_Fly_FireBurst = "Transform_Fly";

	public static readonly int areaEffectTag_FireBurst = CommonHelper.StringToHash("Area_Transform_FireWave");

	public const int skillId_Tired = 3180132;

	public const string comboTag_Tired = "Tired";

	public static readonly FP loopTime_Tired = 3;

	public const int skillId_Fly = 3180131;

	public const string comboTag_Fly = "Fly_Start";

	public const int skillId_FireBall = 3180121;

	public const string comboTag_FireBall = "FireBall";

	public const int loopTimes_FireBall = 3;

	public static readonly FP limitAngle_FireBall = 360;

	public const string eventName_Shoot_FireBall = "Fire";

	public const string bulletKey_FireBall = "";

	public static readonly FP shootOffset_FireBall = 1;

	public static readonly FP shootPositionY_FireBall = 1;

	public const int skillId_Strike = 3180123;

	public const string comboTag_Left_Strike = "FlyDash_Left";

	public const string comboTag_Right_Strike = "FlyDash_Right";

	public static readonly List<TSVector2> targetPointList_Strike = new List<TSVector2>
	{
		new TSVector2(11f, 0f),
		new TSVector2(9.526279f, 5.5f),
		new TSVector2(5.5f, 9.526279f),
		new TSVector2(0f, 11f),
		new TSVector2(-5.5f, 9.526279f),
		new TSVector2(-9.526279f, 5.5f),
		new TSVector2(-11f, 0f),
		new TSVector2(-9.526279f, -5.5f),
		new TSVector2(-5.5f, -9.526279f),
		new TSVector2(0f, -11f),
		new TSVector2(5.5f, -9.526279f),
		new TSVector2(9.526279f, -5.5f)
	};

	public static readonly FP distance_FilterTargetPoint_Strike = 10;

	public static readonly FP hopeDistance_FilterTargetPoint_Strike = 3;

	public static readonly FP minAngle_FilterTargetPoint_Strike = 15;

	public static readonly FP maxAngle_FilterTargetPoint_Strike = 45;

	public static readonly FP rotateSpeed_First_Strike = 180;

	public static readonly FP rotateSpeed_Second_Strike = 180;

	public static readonly FP dashSpeed_Strike = 15;

	public static readonly FP length_GenerateBaoLin_Dash_Strike = 6;

	public static readonly FP width_GenerateBaoLin_Dash_Strike = 2;

	public static readonly FP offset_GenerateBaoLin_Dash_Strike = 0;

	public const int count_GenerateBaoLin_Dash_Strike = 2;

	public static readonly FP interval_GenerateBaoLin_Dash_Strike = 0.15;

	public const int skillId_Bombing = 3180122;

	public const string comboTag_First_Bombing = "";

	public const string eventName_First_GenerateBaoLin_Bombing = "BaoLin";

	public static readonly FP innerRadius_First_GenerateBaoLin_Bombing = 1;

	public static readonly FP outerRadius_First_GenerateBaoLin_Bombing = 1;

	public const int totalCount_First_GenerateBaoLin_Bombing = 1;

	public static readonly FP interval_First_GenerateBaoLin_Bombing = 1;

	public const string comboTag_Second_Bombing = "";

	public const string eventName_Second_GenerateBaoLin_Bombing = "BaoLin";

	public static readonly FP radius_Second_GenerateBaoLin_Bombing = 1;

	public const int totalCount_Second_GenerateBaoLin_Bombing = 1;

	public static readonly FP interval_Second_GenerateBaoLin_Bombing = 1;

	public const string comboTag_Third_Bombing = "";

	public const string eventName_Third_GenerateBaoLin_Bombing = "BaoLin";

	public static readonly FP length_Third_GenerateBaoLin_Bombing = 1;

	public static readonly FP width_Third_GenerateBaoLin_Bombing = 1;

	public static readonly FP offset_Third_GenerateBaoLin_Bombing = 1;

	public const int totalCount_Third_GenerateBaoLin_Bombing = 1;

	public static readonly FP interval_Third_GenerateBaoLin_Bombing = 1;

	public const int skillId_CriticalityDischarge = 3180124;

	public static readonly FP generateInterval_Burst_CriticalityDischarge = 1;

	public const string fxKey_EarlyWarning_CriticalityDischarge = "fx_warning_circular_10";

	public static readonly FP duration_EarlyWarning_CriticalityDischarge = 5;

	public static readonly FP followTime_EarlyWarning_CriticalityDischarge = 3;

	public const string comboTag_Ready_CriticalityDischarge = "Ultra_Ready";

	public static readonly FP loopTime_Ready_CriticalityDischarge = 3;

	public const string comboTag_LiftOff_CriticalityDischarge = "";

	public const string eventName_Hide_CriticalityDischarge = "Hide";

	public const string comboTag_Dive_CriticalityDischarge = "Ultra_Attack";

	public const string eventName_GenerateBaoLin_CriticalityDischarge = "BaoLin";

	public static readonly FP radius_GenerateBaoLin_CriticalityDischarge = 10;

	public const int totalCount_GenerateBaoLin_CriticalityDischarge = 12;

	public static readonly FP interval_GenerateBaoLin_CriticalityDischarge = 0;

	public const string comboTag_End_CriticalityDischarge = "";

	public const int skillId_ToughnessBrokenByFly = 3180133;

	public const string comboTag_ToughnessBrokenByFly = "Idle";

	public static readonly FP hpPercent_ChangeStage = 0.75;

	public const int battleLevel_ChangeStage_BossRush = 15;

	public static readonly FP defautRate_TriggerTiredSkill = 60;

	public static readonly FP reduceRate_TriggerTiredSkill = 30;

	public static readonly FP filterDistance_FlySkill = 8;

	public static readonly int tag_BaoLin = CommonHelper.StringToHash("BaoLin");

	public static readonly int eventHashCode_BaoLin_Explosion = CommonHelper.StringToHash("BaoLin_Explosion");

	public const string logicTag_SkillStrength = "SkillStrength";

	public const string logicTag_CanTriggerBurst = "logicTag_CanTriggerBurst";

	public const string logicTag_FireBurst_Times = "FireBurst_Times";

	public const string logicTag_IsFlyState = "IsFlyState";

	public const string logicTag_GenerateInterval_Burst = "GenerateInterval_Burst";

	public const string logicTag_ExitBurstByToughnessBroken = "ExitBurstByToughnessBroken";
}
