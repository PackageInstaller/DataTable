using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.World;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class TriggerObject : LuminSerializedMonoBehaviour, IDamageable, ITrigger, IResetBehave
{
	public List<TriggerObjectEntry> entries = new List<TriggerObjectEntry>();

	private CancellationTokenSource m_TokenSource = new CancellationTokenSource();

	public CancellationToken Token => m_TokenSource.Token;

	private void OnTriggerEnter(Collider other)
	{
		if (TryGetMonoEntity(other, out var mono))
		{
			if (TryGetEntityContext(other, mono, out var context))
			{
				DispatchTriggerEnter(context);
			}
		}
		else
		{
			HandleFreeObjectEnter(other);
		}
	}

	private void OnTriggerStay(Collider other)
	{
		if (TryGetMonoEntity(other, out var mono))
		{
			if (TryGetEntityContext(other, mono, out var context))
			{
				DispatchTriggerStay(context);
			}
		}
		else
		{
			HandleFreeObjectStay(other);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (TryGetMonoEntity(other, out var mono))
		{
			if (TryGetEntityContext(other, mono, out var context))
			{
				DispatchTriggerExit(context);
			}
		}
		else
		{
			HandleFreeObjectExit(other);
		}
	}

	private static bool TryGetMonoEntity(Collider other, out MonoEntity mono)
	{
		if (other.TryGetComponent<MonoEntity>(out mono))
		{
			return true;
		}
		if (other.attachedRigidbody != null)
		{
			return other.attachedRigidbody.TryGetComponent<MonoEntity>(out mono);
		}
		return false;
	}

	private static bool TryGetEntityContext(Collider other, MonoEntity mono, out TriggerActionContext context)
	{
		context = default;
		if (!mono.entity.IsValid || !mono.entity.IsLogicAvailable())
		{
			return false;
		}
		context = new TriggerActionContext(mono.entity, mono.gameObject, other);
		return true;
	}

	private void DispatchTriggerEnter(TriggerActionContext context)
	{
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerEnter(context, this).Forget();
		}
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = true;
		evt.trigger = this;
		evt.entity = context.Entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void DispatchTriggerStay(TriggerActionContext context)
	{
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerStay(context, this).Forget();
		}
	}

	private void DispatchTriggerExit(TriggerActionContext context)
	{
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerExit(context, this).Forget();
		}
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = false;
		evt.trigger = this;
		evt.entity = context.Entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void HandleFreeObjectEnter(Collider other)
	{
		if (SupportsFreeObjects())
		{
			GameObject gameObject = ResolveFreeObject(other);
			if (!(gameObject == null))
			{
				DispatchFreeObjectEnter(new TriggerActionContext(default, gameObject, other));
			}
		}
	}

	private void HandleFreeObjectStay(Collider other)
	{
		if (!SupportsFreeObjects())
		{
			return;
		}
		GameObject gameObject = ResolveFreeObject(other);
		if (gameObject == null)
		{
			return;
		}
		TriggerActionContext context = new TriggerActionContext(default, gameObject, other);
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerStay(context, this).Forget();
		}
	}

	private void HandleFreeObjectExit(Collider other)
	{
		if (!SupportsFreeObjects())
		{
			return;
		}
		GameObject gameObject = ResolveFreeObject(other);
		if (gameObject == null)
		{
			return;
		}
		TriggerActionContext context = new TriggerActionContext(default, gameObject, other);
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerExit(context, this).Forget();
		}
	}

	private void DispatchFreeObjectEnter(TriggerActionContext context)
	{
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerEnter(context, this).Forget();
		}
	}

	private bool SupportsFreeObjects()
	{
		for (int i = 0; i < entries.Count; i++)
		{
			if (entries[i] != null && (entries[i].filter & TriggerObjectFilter.freeObject) != 0)
			{
				return true;
			}
		}
		return false;
	}

	private static GameObject ResolveFreeObject(Collider other)
	{
		if (other == null)
		{
			return null;
		}
		TriggerObjectSource componentInParent = other.GetComponentInParent<TriggerObjectSource>();
		if (!(componentInParent != null))
		{
			return null;
		}
		return componentInParent.gameObject;
	}

	public async void Do(ActionMemory actionMemory)
	{
		foreach (TriggerObjectEntry entry in entries)
		{
			await entry.OnAttack(actionMemory.caster, this);
		}
	}

	private void OnDestroy()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
	}

	public void TriggerExit()
	{
		if (m_TokenSource.IsCancellationRequested)
		{
			return;
		}
		TriggerActionContext context = new TriggerActionContext(MonoECS.instance.mainEntity, null, null);
		foreach (TriggerObjectEntry entry in entries)
		{
			entry.OnTriggerExit(context, this).Forget();
		}
	}

	public void Reset()
	{
		if ((bool)this)
		{
			Animator component = GetComponent<Animator>();
			if (!(component == null))
			{
				component.SetInteger("state", 0);
			}
		}
	}
}
