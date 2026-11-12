using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/播放简单动画", 4)]
public class Task_PlayAnimator : TaskCellBase
{
	public enum AnimatorType
	{
		[InspectorName("动画引用")]
		instance,
		[InspectorName("动画路径")]
		path
	}

	public AnimatorType animatorType;

	public Animator animator;

	public string animatorPath;

	public string stateName;

	public float fadeTime = 0.25f;

	public bool suspendPlayer;

	public bool enableCinemaMode;

	public bool waitUntilFinish;

	private bool _played;

	private Animator _animator;

	protected override void OnExecute()
	{
		bool flag = true;
		if (string.IsNullOrEmpty(stateName))
		{
			flag = false;
		}
		else if (animatorType == AnimatorType.instance)
		{
			if (animator == null)
			{
				flag = false;
			}
			else
			{
				_animator = animator;
			}
		}
		else if (animatorType == AnimatorType.path)
		{
			if (string.IsNullOrEmpty(animatorPath))
			{
				flag = false;
			}
			else
			{
				_animator = GameObject.Find(animatorPath)?.GetComponent<Animator>();
				if (_animator == null)
				{
					flag = false;
				}
			}
		}
		if (!flag)
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		if (suspendPlayer)
		{
			TaskCellBase.SuspendPlayer();
			TaskCellBase.SetHud_Invisible();
		}
		if (enableCinemaMode)
		{
			TaskCellBase.EnterCinemaMode();
			TaskCellBase.SetHud_Invisible();
		}
		_played = false;
		SetupAndPlay();
	}

	protected override void LogicUpdate()
	{
		if (!waitUntilFinish)
		{
			EndAction();
			return;
		}
		AnimatorStateInfo currentAnimatorStateInfo = _animator.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.IsName(stateName))
		{
			_played = true;
			if (ElapsedTime >= currentAnimatorStateInfo.length / _animator.speed)
			{
				EndAction();
			}
		}
		else if (_played)
		{
			EndAction();
		}
	}

	protected override void OnStop(bool success)
	{
		if (success)
		{
			if (suspendPlayer)
			{
				TaskCellBase.ResumePlayer();
				TaskCellBase.SetHud_Visible();
			}
			if (enableCinemaMode)
			{
				TaskCellBase.ExitCinemaMode();
				TaskCellBase.SetHud_Visible();
			}
		}
	}

	protected void SetupAndPlay()
	{
		_animator.CrossFadeInFixedTime(stateName, fadeTime, 0);
	}
}
