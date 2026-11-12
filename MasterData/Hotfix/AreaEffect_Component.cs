using TrueSync;
using UnityEngine;

public class AreaEffect_Component : LogicMonoComponent, ILogicComponentUpdate, ILogicComponent
{
	[Space]
	public bool checkTargetWithTag;

	public string checkTag;

	protected AreaEffectEntity _context;

	protected AdventureActor _owner;

	[SerializeField]
	[HideInInspector]
	protected int _checkTagHashCode;

	public bool RunningLogic { get; protected set; }

	public bool FinishAreaEffect { get; protected set; }

	protected virtual bool ShowCheckTag => true;

	public void Setup()
	{
		_context = Entity as AreaEffectEntity;
		_owner = _context.owner;
		FinishAreaEffect = false;
		RunningLogic = false;
		OnSetup();
	}

	protected virtual void OnSetup()
	{
	}

	public void StartLogic()
	{
		RunningLogic = true;
		OnStartLogic();
	}

	protected virtual void OnStartLogic()
	{
	}

	public void OnLogicUpdate()
	{
		if (!RunningLogic)
		{
			OnEarlyWarningUpdate(_context.LogicDeltaTime);
		}
		else
		{
			OnLogicUpdate(_context.LogicDeltaTime);
		}
	}

	protected virtual void OnEarlyWarningUpdate(FP logicDeltaTime)
	{
	}

	protected virtual void OnLogicUpdate(FP logicDeltaTime)
	{
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		FinishAreaEffect = true;
		RunningLogic = false;
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		if (RunningLogic && !FinishAreaEffect && !(other == null) && !(other.Entity == null))
		{
			OnDeterministicCollisionEnter(other.Entity);
		}
	}

	protected virtual void OnDeterministicCollisionEnter(LogicEntity entity)
	{
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
		if (RunningLogic && !FinishAreaEffect && !(other == null) && !(other.Entity == null))
		{
			OnDeterministicCollisionStay(other.Entity);
		}
	}

	protected virtual void OnDeterministicCollisionStay(LogicEntity entity)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		if (RunningLogic && !FinishAreaEffect && !(other == null) && !(other.Entity == null))
		{
			OnDeterministicCollisionExit(other.Entity);
		}
	}

	protected virtual void OnDeterministicCollisionExit(LogicEntity entity)
	{
	}

	public virtual void OnAreaScaleChange()
	{
	}

	private void OnCheckTagChange()
	{
		_checkTagHashCode = CommonHelper.StringToHash(checkTag);
	}
}
