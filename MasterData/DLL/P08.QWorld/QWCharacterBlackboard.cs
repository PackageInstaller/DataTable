using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class QWCharacterBlackboard : QWBlackboard
{
	public const string ATTACH_POINT_PREFIX = "gua_";

	public QWCharacterCommonBehaviour characterCommonBehaviour;

	public QWCharacterProxy curProxy;

	[HideInInspector]
	public int status;

	public bool IsFalling;

	public bool playerHide;

	public bool isInPlayerFocus;

	public QWLocomotionBehaviour locomotionBehaviour;

	public QWCharacterCamera characterCameraBehaviour;

	public QWBodyDitherComponent bodyDitherComp;

	public virtual bool IsAlive { get; set; }

	public override bool IsInSeeking
	{
		get
		{
			if (!(locomotionBehaviour == null))
			{
				return locomotionBehaviour.IsInSeeking;
			}
			return false;
		}
	}

	public SDCharacter renderEffect => curProxy.renderEffect;

	public Transform head => curProxy.head;

	public Transform defaultCamPos => curProxy.DefaultCamPos;

	public CapsuleCollider BodyCollider => curProxy.BodyCollider;

	public override Animator animator
	{
		get
		{
			return curProxy.animator;
		}
		set
		{
		}
	}

	public override void InitBlackboard()
	{
		status = 0;
		isInStage = true;
		IsFalling = false;
		locomotionBehaviour = GetComponent<QWLocomotionBehaviour>();
		characterCameraBehaviour = GetComponent<QWCharacterCamera>();
		characterCommonBehaviour = GetComponent<QWCharacterCommonBehaviour>();
		playerHide = false;
		bodyDitherComp = new QWBodyDitherComponent();
		bodyDitherComp.Init(GetAgent());
	}

	public override void ResetBlackboard()
	{
		IsFalling = false;
		IsAlive = false;
		ActionHandler = null;
		disableMove = false;
		status = 0;
		inputMovement.Direction = Vector3.zero;
		inputMovement.Magnitude = 0f;
	}

	internal Transform FindAttachPoint(string path)
	{
		return curProxy.FindAttachPoint(path);
	}

	public override void Dispose()
	{
		base.Dispose();
		bodyDitherComp.Dispose();
	}
}
