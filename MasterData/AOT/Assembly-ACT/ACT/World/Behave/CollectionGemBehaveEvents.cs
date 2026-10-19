using System;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

public class CollectionGemBehaveEvents : AttackCollectionBehaveEvents
{
	[Tooltip("出trigger之后等待解锁的时间")]
	public float unLockDelayTime;

	[Tooltip("提示可以攻击的范围")]
	public BoxCollider canAttackArea;

	[Tooltip("lockState的触发范围")]
	public BoxCollider lockAttackArea;

	[Tooltip("lockState的攻击ability")]
	public string[] lockStateAbilities;

	private CancellationTokenSource source;

	private TriggerProxy _proxyAttack;

	private TriggerProxy _proxyLock;

	private bool inAttackTrigger;

	private bool inLockTrigger;

	private void Start()
	{
		source = new CancellationTokenSource();
		_proxyAttack = canAttackArea.gameObject.AddComponent<TriggerProxy>();
		TriggerProxy proxyAttack = _proxyAttack;
		proxyAttack.triggerEnter = (Action<Collider>)Delegate.Combine(proxyAttack.triggerEnter, new Action<Collider>(OnGemsCanTriggerAttack));
		TriggerProxy proxyAttack2 = _proxyAttack;
		proxyAttack2.triggerExit = (Action<Collider>)Delegate.Combine(proxyAttack2.triggerExit, new Action<Collider>(OnGemsUnTriggerAttack));
		_proxyLock = lockAttackArea.gameObject.AddComponent<TriggerProxy>();
		TriggerProxy proxyLock = _proxyLock;
		proxyLock.triggerEnter = (Action<Collider>)Delegate.Combine(proxyLock.triggerEnter, new Action<Collider>(OnGemsEnterLock));
		TriggerProxy proxyLock2 = _proxyLock;
		proxyLock2.triggerExit = (Action<Collider>)Delegate.Combine(proxyLock2.triggerExit, new Action<Collider>(OnGemsExitLock));
	}

	private void OnGemsEnterLock(Collider other)
	{
		source = new CancellationTokenSource();
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity)
		{
			inLockTrigger = true;
			(interactCollection as InteractCollectionGem).SetGemLock(b: true);
		}
	}

	private async void OnGemsExitLock(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity)
		{
			inLockTrigger = false;
			await UniTask.Delay(TimeSpan.FromSeconds(unLockDelayTime));
			if (!inLockTrigger)
			{
				(interactCollection as InteractCollectionGem).SetGemLock(b: false);
			}
		}
	}

	public void SetGemLock(bool b)
	{
		animator.SetInteger("state", b ? 3 : 0);
		if (!b && inAttackTrigger)
		{
			ActiveUITip(active: true);
		}
	}

	protected void OnGemsCanTriggerAttack(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity)
		{
			inAttackTrigger = true;
			if (interactCollection.currentStateId == 0)
			{
				ActiveUITip(active: true);
			}
		}
	}

	protected void OnGemsUnTriggerAttack(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity)
		{
			inAttackTrigger = false;
			if (interactCollection.currentStateId == 0)
			{
				ActiveUITip(active: false);
			}
		}
	}

	public override void OnInteract(Entity eb)
	{
		TriggerProxy proxyAttack = _proxyAttack;
		proxyAttack.triggerEnter = (Action<Collider>)Delegate.Remove(proxyAttack.triggerEnter, new Action<Collider>(OnGemsCanTriggerAttack));
		TriggerProxy proxyAttack2 = _proxyAttack;
		proxyAttack2.triggerExit = (Action<Collider>)Delegate.Remove(proxyAttack2.triggerExit, new Action<Collider>(OnGemsUnTriggerAttack));
		TriggerProxy proxyLock = _proxyLock;
		proxyLock.triggerEnter = (Action<Collider>)Delegate.Remove(proxyLock.triggerEnter, new Action<Collider>(OnGemsEnterLock));
		TriggerProxy proxyLock2 = _proxyLock;
		proxyLock2.triggerExit = (Action<Collider>)Delegate.Remove(proxyLock2.triggerExit, new Action<Collider>(OnGemsExitLock));
		if (inAttackTrigger)
		{
			ActiveUITip(active: false);
		}
		base.OnInteract(eb);
	}

	private void ActiveUITip(bool active)
	{
		UIChangeEvt evt = Singleton<EventManager>.instance.GetEvt<UIChangeEvt>();
		evt.changeIcon = false;
		evt.changeEffect = active;
		evt.type = ActionUIChange.IconType.conmmonAttack;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_IconChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
