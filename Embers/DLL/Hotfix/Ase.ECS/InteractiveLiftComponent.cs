using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class InteractiveLiftComponent : BaseComponent
{
	private int hp;

	private bool hitSwitch;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		hp = GetData<int>("Hp");
		hitSwitch = GetData<bool>(Constant.InteractiveConstant.INTERACTIVE_HITSWITCH_KEY);
	}

	public void OnHit(int attackPower)
	{
		if (hitSwitch)
		{
			bool isStruckDown = false;
			hp = Mathf.Max(0, hp - attackPower);
			if (hp == 0)
			{
				mBaseEntity.GetComponent<InteractiveStateComponent>().ChangeInteractiveState(MapItemState.Dead);
				isStruckDown = true;
			}
			ObserverHitParams observerHitParams = ReferencePool.Acquire<ObserverHitParams>();
			observerHitParams.Init(mBaseEntity, null, 0, attackPower, 0, isStruckDown, null, null, isCrit: false);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.Hit, observerHitParams);
			ReferencePool.Release(observerHitParams);
		}
	}
}
