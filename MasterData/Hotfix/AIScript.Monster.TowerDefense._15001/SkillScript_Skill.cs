using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15001;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private const string ComboTag_Sweep = "150_Main_Skill_A1";

	private const string ComboTag_Laser = "150_Main_Skill_B1";

	private const int perkId_1 = 1500101;

	private static readonly string[] ComboTagList_Sweep_P1 = new string[3] { "150_Main_Skill_A1", "150_Main_Skill_A2", "150_Main_Skill_A3" };

	private static readonly string[] ComboTagList_Laser_P1 = new string[3] { "150_Main_Skill_B1", "150_Main_Skill_B2", "150_Main_Skill_B3" };

	private const int perkId_2 = 1500102;

	private const string ComboTag_Laser_P2 = "150_Main_Skill_2_C1";

	private static readonly string[] ComboTagList_Laser_P1_P2 = new string[3] { "150_Main_Skill_2_C1", "150_Main_Skill_2_C2", "150_Main_Skill_2_C3" };

	private static readonly FP laserLoopTime_2 = 4;

	private static readonly FP rotateSpeed_2 = 90;

	private const int perkId_3 = 1500103;

	private const string eventName_GenerateAreaEffect_P3 = "ElectricGrid_Start";

	private const string areaEffectKey_P3 = "AreaEffect_150_Main_Skill_P01_ElectricGrid";

	private readonly AimTarget _aimTarget = new AimTarget();

	private readonly Queue<string> _sweepComboTagQueue = new Queue<string>();

	private LogicEntity _targetEntity;

	private int _performedSweepCount;

	private FP _laserLoopTimeLeft;

	private FP _laserRotateSpeed;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_targetEntity = null;
		_performedSweepCount = 0;
		_laserLoopTimeLeft = 0;
		_laserRotateSpeed = 0;
		_sweepComboTagQueue.Clear();
		_aimTarget.Cancel();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		DefaultLookAt();
		BuildSweepQueue();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_targetEntity = null;
		_performedSweepCount = 0;
		_laserLoopTimeLeft = 0;
		_laserRotateSpeed = 0;
		_sweepComboTagQueue.Clear();
		_aimTarget.Cancel();
	}

	public void OnStart()
	{
		SweepAttack();
	}

	public void OnUpdate()
	{
		UpdateAimTarget();
		UpdateLaserLoop();
	}

	private void UpdateAimTarget()
	{
		if (_actor.attackTarget != null)
		{
			if (_targetEntity != _actor.attackTarget)
			{
				_targetEntity = _actor.attackTarget;
				_aimTarget.Cancel();
				_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			_targetEntity = null;
			_aimTarget.Cancel();
		}
	}

	private void BuildSweepQueue()
	{
		if (GetPerk(1500101))
		{
			for (int i = 0; i < ComboTagList_Sweep_P1.Length; i++)
			{
				_sweepComboTagQueue.Enqueue(ComboTagList_Sweep_P1[i]);
			}
		}
		else
		{
			_sweepComboTagQueue.Enqueue("150_Main_Skill_A1");
		}
	}

	private void SweepAttack()
	{
		if (_sweepComboTagQueue.Count <= 0)
		{
			ShootLaser();
			return;
		}
		LookAtCurrentTargetImmediate();
		string actionTag = _sweepComboTagQueue.Dequeue();
		_performedSweepCount++;
		Action onActivationEnd = OnSweepActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private void OnSweepActivationEnd()
	{
		if (_sweepComboTagQueue.Count > 0)
		{
			SweepAttack();
		}
		else
		{
			ShootLaser();
		}
	}

	private void ShootLaser()
	{
		LookAtCurrentTargetImmediate();
		string text = "150_Main_Skill_B1";
		if (GetPerk(1500101))
		{
			int num = _performedSweepCount - 1;
			if (num < 0)
			{
				num = 0;
			}
			if (GetPerk(1500102))
			{
				if (num >= ComboTagList_Laser_P1_P2.Length)
				{
					num = ComboTagList_Laser_P1_P2.Length - 1;
				}
				text = ComboTagList_Laser_P1_P2[num];
			}
			else
			{
				if (num >= ComboTagList_Laser_P1.Length)
				{
					num = ComboTagList_Laser_P1.Length - 1;
				}
				text = ComboTagList_Laser_P1[num];
			}
		}
		else if (GetPerk(1500102))
		{
			text = "150_Main_Skill_2_C1";
		}
		_laserLoopTimeLeft = 0;
		_laserRotateSpeed = 0;
		if (GetPerk(1500102))
		{
			_laserLoopTimeLeft = laserLoopTime_2;
			_laserRotateSpeed = rotateSpeed_2;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnLaserCustomEvent;
		Action onRecoveryBegin = OnLaserRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnLaserCustomEvent(string eventName)
	{
		if (GetPerk(1500103) && string.Equals(eventName, "ElectricGrid_Start"))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Main_Skill_P01_ElectricGrid", position);
		}
	}

	private void UpdateLaserLoop()
	{
		if (!(_laserLoopTimeLeft <= 0))
		{
			if (_actor.attackTarget != null)
			{
				RotateToCurrentTarget();
			}
			_laserLoopTimeLeft -= _actor.LogicDeltaTime;
			if (_laserLoopTimeLeft <= 0)
			{
				comboAttack?.CancelAttack();
			}
		}
	}

	private void RotateToCurrentTarget()
	{
		TSVector2 tSVector = _actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position;
		if (!(tSVector == TSVector2.zero))
		{
			TSVector2 normalized = tSVector.normalized;
			FP fP = TSVector2.SignedAngle(_actor.tsTransform.Forward, normalized);
			FP fP2 = _laserRotateSpeed * _actor.LogicDeltaTime;
			FP degrees = ((TSMath.Abs(fP) <= fP2) ? fP : (fP2 * TSMath.Sign(fP)));
			_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, degrees);
		}
	}

	private void OnLaserRecoveryBegin()
	{
		if (!GetPerk(1500102))
		{
			_laserLoopTimeLeft = 0;
			_laserRotateSpeed = 0;
		}
	}

	private void LookAtCurrentTargetImmediate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
	}

	private void OnFinish()
	{
		_laserLoopTimeLeft = 0;
		_laserRotateSpeed = 0;
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
