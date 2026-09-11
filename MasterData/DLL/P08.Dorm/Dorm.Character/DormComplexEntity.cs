using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace Dorm.Character;

public class DormComplexEntity : DormEntity
{
	private int keepInteractTo;

	[SerializeField]
	internal int defaultMouth;

	internal SDCharacter sdChara;

	private const string ANIMATOR_EMOTE_LAYER = "Emote Layer";

	private int animatorEmoteLayer = -1;

	private string startIdleAnime;

	private float waitIdle;

	internal bool faceToCamera;

	private const float TURN_THREASHOLD = 0f;

	internal int KeepInteractTo
	{
		get
		{
			return keepInteractTo;
		}
		set
		{
			if (keepInteractTo != value)
			{
				DormEntityManager.RemoveKeepAsInteract(keepInteractTo, id);
				DormEntityManager.AddKeepAsInteract(value, id);
				keepInteractTo = value;
			}
		}
	}

	internal EntityCmdExecutor CmdExecuter { get; set; }

	public InteractAreaScanner Scanner { get; private set; }

	internal override int DefaultMouth => defaultMouth;

	internal FadeBehaviour Fade { get; private set; }

	internal FlashBehaviour Flash { get; private set; }

	internal PlayerCharacterFaceControl FaceControl { get; private set; }

	internal int AnimatorEmoteLayer
	{
		get
		{
			if (!animatorInfoInit && (bool)base.animator)
			{
				PullAnimatorInfo();
			}
			return animatorEmoteLayer;
		}
	}

	protected bool onCompleteCallOnceFlag { get; set; }

	protected bool onIdleCallOnceFlag { get; set; }

	private Vector3 FaceToCamDir
	{
		get
		{
			Vector3 vector = Camera.main.transform.position - GetWorldPos();
			vector.y = 0f;
			vector.Normalize();
			if (vector == Vector3.zero)
			{
				return GetForward();
			}
			return vector;
		}
	}

	private bool NeedTurnToFaceToCam
	{
		get
		{
			if (faceToCamera)
			{
				return Vector3.Angle(GetForward(), FaceToCamDir) > 0f;
			}
			return false;
		}
	}

	public float FirstIdleWaitTime => Random.Range(3f, 15f);

	public float IdleWaitTime => Random.Range(20f, 30f);

	public bool NextIdleNoCrossFade { get; internal set; }

	internal override void DestoryEntity(float delay)
	{
		CmdExecuter.enabled = false;
		CmdExecuter.StopAllCmdTask();
		KeepInteractTo = 0;
		base.DestoryEntity(delay);
	}

	internal DormComplexEntity(int id, GameObject model, bool needDestoryModelOnDispose, bool isPooled)
		: base(id, model, needDestoryModelOnDispose, isPooled)
	{
		CmdExecuter = InitComponent<EntityCmdExecutor>();
		CmdExecuter.entity = this;
		CmdExecuter.enabled = true;
		InteractAreaScanner interactAreaScanner = InitComponent<InteractAreaScanner>();
		interactAreaScanner.entity = this;
		Scanner = interactAreaScanner;
		sdChara = base.model.GetComponent<SDCharacter>();
		if ((bool)sdChara)
		{
			Fade = InitComponent<FadeBehaviour>();
			Fade.sdChara = sdChara;
			Flash = InitComponent<FlashBehaviour>();
			Flash.sdChara = sdChara;
		}
		FaceControl = model.GetComponent<PlayerCharacterFaceControl>();
		FaceControl?.UseNormalFace();
		interactProvider = model.GetComponent<IProvideInteractEntity>();
		if (interactProvider != null)
		{
			interactProvider.Bind(this);
		}
	}

	protected void OnIdle()
	{
		DormEntityAction.Notify("ON_DORM_CHARACTER_IDLE", id);
	}

	internal void ResetCallOnceBeforeIdle()
	{
		onCompleteCallOnceFlag = false;
		onIdleCallOnceFlag = false;
	}

	internal void TurnToCam()
	{
		if (NeedTurnToFaceToCam)
		{
			base.ModelTrs.forward = FaceToCamDir;
		}
	}

	internal virtual void IdleUpdate()
	{
		if (!onCompleteCallOnceFlag)
		{
			onCompleteCallOnceFlag = true;
			Play(DormEntityAnime.Stand, NextIdleNoCrossFade ? 0f : 0.05f);
			NextIdleNoCrossFade = false;
			waitIdle = Time.time + FirstIdleWaitTime;
		}
		if (base.IsInteracted)
		{
			return;
		}
		if (string.IsNullOrEmpty(startIdleAnime))
		{
			if (Time.time > waitIdle)
			{
				if (!onIdleCallOnceFlag)
				{
					OnIdle();
					onIdleCallOnceFlag = true;
				}
				startIdleAnime = Play(DormEntityAnime.Idle);
			}
		}
		else if (base.CurPlaying != startIdleAnime || DormEntity.GetCurAnimePlayNormalizedTime(base.animator) > 1f)
		{
			startIdleAnime = null;
			waitIdle = Time.time + IdleWaitTime;
			Play(DormEntityAnime.Stand);
		}
		TurnToCam();
	}

	internal void PlayNormalFaceExpression(string faceAnime, string faceAnimeSub, float crossFade)
	{
		FaceControl?.UseNormalFace();
		int num = AnimatorEmoteLayer;
		if (num != -1)
		{
			FindAnimeClip(faceAnime, faceAnimeSub, num, out var hash);
			PlayInternal(hash, num, crossFade);
		}
	}

	internal void PlaySpecialFaceExpression(string efxFacePath, float duration)
	{
		FaceControl?.PlaySpecialFaceExpression(efxFacePath, duration);
	}

	internal override void PullAnimatorInfo()
	{
		animatorEmoteLayer = base.animator.GetLayerIndex("Emote Layer");
		base.PullAnimatorInfo();
	}

	internal override void BeInteractedBy(int otherEntity, DormEntityManager.WaitForNotify _event)
	{
		base.BeInteractedBy(otherEntity, _event);
	}

	internal override void BeInteractedFinished(DormEntityManager.WaitForNotify _event)
	{
		base.BeInteractedFinished(_event);
	}

	public void TriggerResetAnimeDuringMove()
	{
		CmdTask curCmdTask = CmdExecuter.CurCmdTask;
		if (curCmdTask != null)
		{
			if (curCmdTask is DormEntityAction.MoveByControllerCmd moveByControllerCmd)
			{
				moveByControllerCmd.ResetMoveAnime = true;
			}
			else if (curCmdTask is DormEntityAction.MoveCmdTask moveCmdTask)
			{
				moveCmdTask.ResetMoveAnime = true;
			}
		}
	}
}
