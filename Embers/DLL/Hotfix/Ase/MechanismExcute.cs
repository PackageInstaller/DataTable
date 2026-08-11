using Ase.ECS;
using DG.Tweening;
using UnityEngine;

namespace Ase;

public class MechanismExcute : BaseMechanism
{
	public MechanismType MechanismType;

	public TriggerEntityType TriggerEntityType;

	public int LaserBulletId;

	public Vector3 RotateAngle;

	public float RotateTime;

	public GameObject RotateObj;

	private Animator AnimatorComp;

	private MechanismNode mechanismNode;

	private Vector3 bulletPos;

	private bool IsTriggerMechanism;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		AnimatorComp = ((Component)(object)this).GetComponent<Animator>();
		if ((Object)(object)AnimatorComp != null)
		{
			AnimatorComp.Rebind();
			AnimatorComp.keepAnimatorStateOnDisable = true;
		}
		mechanismNode = data as MechanismNode;
		if ((Object)(object)mechanismNode != null && mechanismNode.RunState == MechanismRunState.Close)
		{
			OnClose();
		}
		if (MechanismType == MechanismType.ControlRotateLaser)
		{
			ActiveInteractive(mechanismNode.InteractiveName);
		}
	}

	public void CreateBullet()
	{
		mechanismNode.CreateBullet(LaserBulletId, ((Component)(object)this).transform.eulerAngles, ((Component)(object)this).transform.position);
	}

	public override void OnMathTriggerEnter(MathTriggerEventData eventData)
	{
		base.OnMathTriggerEnter(eventData);
		if (!IsTriggerMechanism)
		{
			EntityView component = eventData.Other.GetComponent<EntityView>();
			if (CheckTriggerType(component))
			{
				IsTriggerMechanism = true;
				AnimatorComp.SetBool("Open", true);
			}
		}
	}

	public override void OnMathTriggerExit(MathTriggerEventData eventData)
	{
		if (MechanismType == MechanismType.ControlRotateLaser)
		{
			base.OnMathTriggerExit(eventData);
		}
	}

	public override void OnMathTriggerStay(MathTriggerEventData eventData)
	{
		if (MechanismType == MechanismType.ControlRotateLaser)
		{
			base.OnMathTriggerStay(eventData);
		}
	}

	public override void InteractiveFinishCallback(int obj)
	{
		base.InteractiveFinishCallback(obj);
		if (MechanismType == MechanismType.ControlRotateLaser && RotateObj != null)
		{
			RotateObj.transform.DOLocalRotate(RotateObj.transform.localEulerAngles + RotateAngle, RotateTime);
		}
	}

	public void EndAnimation()
	{
		AnimatorComp.SetBool("Open", false);
		IsTriggerMechanism = false;
	}

	public async void CreateLaserBullet()
	{
		if (MechanismType == MechanismType.AutoRotateLaser || MechanismType == MechanismType.ControlRotateLaser)
		{
			await mechanismNode.CreateLaserBullet(LaserBulletId, Vector3.zero, ((Component)(object)this).transform.position);
		}
	}

	public override void OnClose()
	{
		if ((Object)(object)AnimatorComp != null)
		{
			AnimatorComp.SetBool("Stop", true);
			AnimatorComp.Play("Idle");
		}
	}

	public override void OnOpen()
	{
		if ((Object)(object)AnimatorComp != null)
		{
			AnimatorComp.SetBool("Stop", false);
		}
	}

	private bool CheckTriggerType(EntityView entityView)
	{
		if ((entityView.Entity.IsActorEntity && (TriggerEntityType == TriggerEntityType.Player || TriggerEntityType == TriggerEntityType.All)) || (entityView.Entity is MonsterEntity && (TriggerEntityType == TriggerEntityType.Monster || TriggerEntityType == TriggerEntityType.All)))
		{
			return true;
		}
		if ((TriggerEntityType == TriggerEntityType.AI || TriggerEntityType == TriggerEntityType.All) && (entityView.Entity as HeroEntity).IsAi)
		{
			return true;
		}
		return false;
	}

	public override void ResetData()
	{
		base.ResetData();
		IsTriggerMechanism = false;
		if ((Object)(object)AnimatorComp != null)
		{
			if (AnimatorComp.GetBool("Stop"))
			{
				AnimatorComp.SetBool("Stop", true);
			}
			if (AnimatorComp.GetBool("Open"))
			{
				AnimatorComp.SetBool("Open", false);
			}
		}
	}
}
