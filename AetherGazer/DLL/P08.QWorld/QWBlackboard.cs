using UnityEngine;

[DisallowMultipleComponent]
public class QWBlackboard : MonoBehaviour, IQWBlackboard
{
	public delegate void AgentActionHandler(QWAgentAction a);

	public QWAttachPointSetup attachPoint;

	public string Name;

	public bool ActiveHud;

	public bool HudDisplay;

	public bool disableMove;

	public bool disablePosition;

	public bool hasMoveInput;

	public bool disableMoveInput;

	public int diablePositionFrame;

	public float ditherMax = 0.7f;

	public float ditherMin = 0.48f;

	public string defaultAnim;

	public QWCharacterMovement inputMovement;

	public bool isInStage;

	public bool isInHide;

	public bool isTracking;

	public AgentActionHandler ActionHandler;

	private QWAgent mAgent;

	public virtual Animator animator { get; set; }

	public virtual bool IsInSeeking => false;

	public QWAgent GetAgent()
	{
		if (mAgent == null)
		{
			mAgent = GetComponent<IQWAgent>() as QWAgent;
		}
		return mAgent;
	}

	public void ActionAdd(QWAgentAction action)
	{
		ActionHandler?.Invoke(action);
		QWAgentActionFactory.Return(action);
	}

	public virtual void InitBlackboard()
	{
	}

	public virtual void ResetBlackboard()
	{
		ActionHandler = null;
		inputMovement.Direction = Vector3.zero;
		inputMovement.Magnitude = 0f;
		disableMove = false;
		disablePosition = false;
		disableMoveInput = false;
		diablePositionFrame = 0;
	}

	public virtual void OnFirstAddToStage(GameObject obj)
	{
		attachPoint = obj.GetComponent<QWAttachPointSetup>();
	}

	public virtual void OnAddToStage()
	{
	}

	public virtual void OnRemoveToStage()
	{
	}

	public virtual Transform GetHudPoint()
	{
		if (attachPoint != null)
		{
			return attachPoint.GetHudPoint();
		}
		return null;
	}

	public virtual void Dispose()
	{
	}
}
