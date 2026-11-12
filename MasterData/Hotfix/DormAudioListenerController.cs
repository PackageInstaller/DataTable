using UnityEngine;

public class DormAudioListenerController : SceneSingleton<DormAudioListenerController>
{
	public enum Mode
	{
		Default,
		DefaultWithFocus,
		View,
		ViewWithFocus,
		Edit,
		Visitor,
		SwitchActor
	}

	public DormAudioListenerConfigData modeConfigDefault;

	public DormAudioListenerConfigData modeConfigDefaultWithFocus;

	public DormAudioListenerConfigData modeConfigView;

	public DormAudioListenerConfigData modeConfigViewWithFocus;

	public DormAudioListenerConfigData modeConfigEdit;

	public DormAudioListenerConfigData modeConfigVisitor;

	public DormAudioListenerConfigData modeConfigSwitchActor;

	[Space]
	public Vector3 listenerTargetPositionOffset;

	public float modeSwitchSmoothTime = 0.3f;

	[Space]
	public GameObject audioTriggerAgent;

	private Transform _cameraTrans;

	private Mode _mode;

	private float _curForwardOffset;

	private bool _transitionActive;

	private float _transitionElapsed;

	private float _transitionStartForwardOffset;

	private Vector3 _transitionStartListenerPosition;

	private Vector3 _transitionStartAgentPosition;

	private void Start()
	{
		_cameraTrans = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform;
		MonoSingleton<WwiseAudioManager>.Instance.SetAudioListenerTarget(transform);
	}

	private void LateUpdate()
	{
		float deltaTime = Time.deltaTime;
		DormAudioListenerConfigData modeConfig = GetModeConfig(_mode);
		DormCameraController instance = SceneSingleton<DormCameraController>.Instance;
		Transform transform = ((null != instance) ? instance.focusTarget : null);
		float num = ((modeSwitchSmoothTime < 0f) ? 0.5f : modeSwitchSmoothTime);
		float num2 = 0f;
		if (_transitionActive)
		{
			_transitionElapsed += deltaTime;
			float num3 = ((num > 0f) ? Mathf.Clamp01(_transitionElapsed / num) : 1f);
			if (num3 >= 1f)
			{
				_transitionActive = false;
			}
			num2 = num3 * num3 * (3f - 2f * num3);
		}
		_curForwardOffset = ((num2 > 0f) ? Mathf.Lerp(_transitionStartForwardOffset, modeConfig.forwardOffset, num2) : modeConfig.forwardOffset);
		Vector3 vector = ((null != transform) ? (transform.position + listenerTargetPositionOffset) : _cameraTrans.position);
		Vector3 vector2 = vector - _cameraTrans.position;
		Vector3 vector3 = ((vector2.sqrMagnitude > float.Epsilon) ? (vector2.normalized * _curForwardOffset) : Vector3.zero);
		Vector3 vector4 = _cameraTrans.position + vector3;
		if (modeConfig.alignVerticalToTarget)
		{
			vector4.y = vector.y;
		}
		if (num2 > 0f)
		{
			vector4 = Vector3.Lerp(_transitionStartListenerPosition, vector4, num2);
		}
		base.transform.position = vector4;
		if (null != transform)
		{
			Vector3 forward = vector - vector4;
			base.transform.rotation = ((forward.sqrMagnitude > float.Epsilon) ? Quaternion.LookRotation(forward, Vector3.up) : transform.rotation);
		}
		else
		{
			base.transform.rotation = _cameraTrans.rotation;
		}
		Vector3 vector5 = ((!(null != transform) || !modeConfig.alignAgentPositionToTarget) ? _cameraTrans.position : transform.position);
		if (num2 > 0f)
		{
			vector5 = Vector3.Lerp(_transitionStartAgentPosition, vector5, num2);
		}
		audioTriggerAgent.transform.position = vector5;
	}

	public void SwitchDormMode(DormActor.DormMode dormMode)
	{
		_mode = dormMode switch
		{
			DormActor.DormMode.Default => Mode.Default, 
			DormActor.DormMode.View => Mode.View, 
			DormActor.DormMode.Edit => Mode.Edit, 
			DormActor.DormMode.Visitor => Mode.Visitor, 
			DormActor.DormMode.SwitchActor => Mode.SwitchActor, 
			_ => Mode.Default, 
		};
		BeginTransition();
	}

	public void NotifyEnterFocus()
	{
		if (_mode == Mode.Default)
		{
			_mode = Mode.DefaultWithFocus;
			BeginTransition();
		}
		else if (_mode == Mode.View)
		{
			_mode = Mode.ViewWithFocus;
			BeginTransition();
		}
	}

	public void NotifyExitFocus()
	{
		if (_mode == Mode.DefaultWithFocus)
		{
			_mode = Mode.Default;
			BeginTransition();
		}
		else if (_mode == Mode.ViewWithFocus)
		{
			_mode = Mode.View;
			BeginTransition();
		}
	}

	private DormAudioListenerConfigData GetModeConfig(Mode mode)
	{
		return mode switch
		{
			Mode.Default => modeConfigDefault, 
			Mode.DefaultWithFocus => modeConfigDefaultWithFocus ?? modeConfigDefault, 
			Mode.View => modeConfigView ?? modeConfigDefault, 
			Mode.ViewWithFocus => modeConfigViewWithFocus ?? modeConfigDefault, 
			Mode.Edit => modeConfigEdit ?? modeConfigDefault, 
			Mode.Visitor => modeConfigVisitor ?? modeConfigDefault, 
			Mode.SwitchActor => modeConfigSwitchActor ?? modeConfigDefault, 
			_ => modeConfigDefault, 
		};
	}

	private void BeginTransition()
	{
		_transitionStartForwardOffset = _curForwardOffset;
		_transitionStartListenerPosition = transform.position;
		_transitionStartAgentPosition = audioTriggerAgent.transform.position;
		_transitionElapsed = 0f;
		_transitionActive = true;
	}
}
