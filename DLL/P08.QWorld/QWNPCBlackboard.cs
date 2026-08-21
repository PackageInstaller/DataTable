using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class QWNPCBlackboard : QWBlackboard
{
	public bool isAlert;

	public QWLookAtComponent lookAtComp;

	public QWBodyDitherComponent bodyDitherComp;

	public Vector3 defaultForward;

	public QWLocomotionBehaviour locomotion;

	public SDCharacter renderEffect;

	public QworldEntityLookAtType lookAtType;

	public Vector3 lookAtPos;

	public int lookAtEntityId;

	private Transform head;

	public override bool IsInSeeking
	{
		get
		{
			if (!(locomotion == null))
			{
				return locomotion.IsInSeeking;
			}
			return false;
		}
	}

	public Transform GetHead()
	{
		if (head == null)
		{
			head = attachPoint.GetHeadBone();
		}
		if (head == null)
		{
			return base.transform;
		}
		return head;
	}

	public override void InitBlackboard()
	{
		isAlert = false;
		animator = null;
		locomotion = GetComponent<QWLocomotionBehaviour>();
		bodyDitherComp = new QWBodyDitherComponent();
		bodyDitherComp.Init(GetAgent());
		defaultForward = base.transform.forward;
	}

	public override void ResetBlackboard()
	{
		base.ResetBlackboard();
		isAlert = false;
		inputMovement.Direction = Vector3.zero;
		inputMovement.Magnitude = 0f;
		animator = null;
		lookAtComp = null;
	}

	public override void OnFirstAddToStage(GameObject obj)
	{
		base.OnFirstAddToStage(obj);
		if ((bool)attachPoint)
		{
			if ((bool)attachPoint.GetPerformRoot())
			{
				animator = attachPoint.GetPerformRoot().GetComponent<Animator>();
				renderEffect = attachPoint.GetPerformRoot().GetComponent<SDCharacter>();
			}
			else
			{
				Debug.LogError("错误,未挂载QWAttachPointSetup组件");
			}
			head = attachPoint.GetHeadBone();
		}
		else
		{
			animator = obj.GetComponent<Animator>();
		}
		if (lookAtComp != null)
		{
			lookAtComp.head = attachPoint.GetHeadBone();
			lookAtComp.TryInit();
		}
		if (locomotion != null)
		{
			locomotion.OnFirstAddToStage();
		}
	}

	public override void OnAddToStage()
	{
		if (lookAtComp != null)
		{
			lookAtComp.Show();
		}
	}

	public override void OnRemoveToStage()
	{
		if (lookAtComp != null)
		{
			lookAtComp.Pause();
		}
		head = null;
		renderEffect = null;
		attachPoint = null;
	}

	public override void Dispose()
	{
		base.Dispose();
		bodyDitherComp.Dispose();
	}
}
