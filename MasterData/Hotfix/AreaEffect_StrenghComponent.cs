using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_位移力")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_StrenghComponent : AreaEffect_Component
{
	public FP pullDelay = 0;

	public FP strenghInterval = 0.1;

	public FP strenghSpeed = 3;

	public int strenghLevel = 99;

	public FP strength = 4;

	public bool enterPull;

	public bool changeForward = true;

	private FP _strenghTime;

	private List<DeterministicCollider> _actorCollider;

	private FP _pullDelay;

	protected override void OnSetup()
	{
		base.OnSetup();
		_strenghTime = 0;
		_pullDelay = pullDelay;
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (strenghInterval <= 0)
		{
			return;
		}
		if (_pullDelay > 0)
		{
			_pullDelay -= logicDeltaTime;
			return;
		}
		_strenghTime -= logicDeltaTime;
		if (!(_strenghTime > 0))
		{
			StrenghMove();
			_strenghTime = strenghInterval;
		}
	}

	protected void StrenghMove()
	{
		if (strenghSpeed == 0)
		{
			return;
		}
		if (_actorCollider == null)
		{
			_actorCollider = new List<DeterministicCollider>(16);
		}
		_context.DeterministicCollision(_actorCollider, 256, checkTargetWithTag ? _checkTagHashCode : 0);
		_actorCollider.RemoveAll((DeterministicCollider collider) => !_context.CheckEntitySearchable(collider.Entity) || !_context.CheckTarget(collider.Entity, TargetType.Enemy));
		CommonHelper.SearchEntityAlive(_actorCollider);
		TSVector2 position = _context.tsTransform.Position;
		for (int num = 0; num < _actorCollider.Count; num++)
		{
			AdventureActor adventureActor = _actorCollider.get_Item(num).Entity as AdventureActor;
			if (adventureActor == null)
			{
				continue;
			}
			FP fP = strenghSpeed * strenghInterval;
			TSVector2 normalized;
			if (strenghSpeed > 0)
			{
				normalized = (adventureActor.tsTransform.Position - position).normalized;
			}
			else
			{
				fP = -fP;
				normalized = (position - adventureActor.tsTransform.Position).normalized;
				FP fP2 = TSVector2.Distance(position, adventureActor.tsTransform.Position);
				if (fP2 < fP)
				{
					fP = fP2;
				}
			}
			if (fP > 0.1f)
			{
				if (enterPull)
				{
					adventureActor.GetComponent<AdventureActor>()?.EnterPull(strength, TSMath.Abs(strenghSpeed), fP, normalized, isCoExist: true, changeForward, strenghLevel, _owner);
				}
				else
				{
					adventureActor.GetComponent<AdventureActor>()?.EnterForceMove(strength, (strenghSpeed > 0) ? strenghSpeed : (-strenghSpeed), fP, normalized, isCoExist: true, changeForward, strenghLevel, _owner);
				}
			}
		}
	}
}
