using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.MultiPlayer;

public struct CmdHit
{
	public bool enHit;

	public bool attackerIsMonster;

	public bool lockRotationNeedChangDir;

	public bool attackeeAtLeft;

	public bool overrideSpeed;

	public bool attackerInAir;

	public bool dontChangeDir;

	public bool groundprotection;

	public Entity caster;

	public int hitType;

	public int hitLevel;

	public bool lastHavePosture;

	public bool lastIsWeak;

	public int expressiveAngle;

	public int hitEndureLevel;

	public byte bodyIndex;

	public float length;

	public float angle;

	public float hitBrakingDeceleration;

	public float hitHorizontalFriction;

	public float upwardGravity;

	public float upwardFriction;

	public float downwardGravity;

	public float downwardMaxSpeed;

	public float downwardFriction;

	public Vector3 touchPos;

	public int horizontalHitWallNum;

	public int verticalHitWallNum;

	public Adjust1AttackTypeTag adjust1AttackTypeTag;

	public Adjust2AttackTypeTag adjust2AttackTypeTag;

	public bool isPostureHit;

	public bool defaultFrameHalt;

	public bool changeDir;

	public bool hitBack;

	public float hitSpeedX;

	public float hitSpeedY;

	public bool needLockRotationChangeDirTrigger;

	public int globalSpeedConfigIndex;

	public bool globalSpeedUseSuperArmor;

	public HitReactionType hitReactionType;
}
