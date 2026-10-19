using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.Behave;

public abstract class BehaveControlBaseBehaveEvent : MonoBehaviour
{
	private bool _stop;

	public int CurrEventIndex { get; protected set; }

	public Animator Anim { get; protected set; }

	public SphereCollider TriggerBox { get; protected set; }

	public Entity Entity { get; protected set; }

	public bool Running { get; protected set; }

	public virtual bool StopFlag
	{
		get
		{
			return _stop;
		}
		protected set
		{
			_stop = value;
		}
	}

	public abstract void Init(int state);

	public abstract void RefreshRunState(int state);

	public abstract void RefreshRunEventIndex(int state = -100);

	public abstract void ChangeState(int state);

	public abstract bool AwaitHandleStopEvent();

	public abstract bool HandleBehaveEvent();

	public void Update()
	{
		if (!Running || !HandleBehaveEvent() || !Running)
		{
			return;
		}
		if (StopFlag)
		{
			StopFlag = !AwaitHandleStopEvent();
			if (StopFlag)
			{
				return;
			}
		}
		if (RefreshMove())
		{
			StopFlag = true;
		}
	}

	public abstract void StopMove();

	public abstract void SetTarPos(Vector3 tarPos);

	public abstract bool RefreshMove();

	public virtual void OnTriggerEnter(Collider collision)
	{
	}

	public virtual void OnTriggerExit(Collider collision)
	{
	}
}
