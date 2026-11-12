using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_SkillBase_3 : SkillAdvancedBase
{
	protected int _skillId_whelmed;

	protected int _violentBuffId;

	protected FP _rotateSpeed;

	protected LookAtTarget _lookAtTarget;

	protected ComboAttack _comboAttack;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		if (_lookAtTarget == null)
		{
			_lookAtTarget = new LookAtTarget();
		}
		_skillId_whelmed = (int)(long)_actor.logicVariable.GetLogicTagValue("SkillId_whelmed");
		_violentBuffId = (int)(long)_actor.logicVariable.GetLogicTagValue("ViolentBuffId");
	}

	public virtual void OnStart()
	{
		BeginLookAt();
	}

	public void BeginLookAt()
	{
		FP zero = FP.Zero;
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 b = logicEntity.tsTransform.Position - _actor.tsTransform.Position;
			zero = TSVector2.Angle(forward, b);
			FP rotateSpeed = _rotateSpeed;
			FP fP = 0;
			bool flag;
			if (rotateSpeed > 0)
			{
				fP = zero / rotateSpeed;
				flag = !(fP < 0.2);
			}
			else
			{
				flag = false;
			}
			if (flag)
			{
				_lookAtTarget.BeginLookAt(_actor, logicEntity, fP, rotateSpeed, () =>
				{
					BeginSkill();
				});
			}
			else
			{
				BeginSkill();
			}
		}
		else
		{
			_skill?.Clear();
		}
	}

	protected virtual void BeginSkill()
	{
		_comboAttack.InterruptAttack();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_lookAtTarget?.StopLookAt();
		_lookAtTarget?.Clear();
		_comboAttack?.Clear();
	}
}
