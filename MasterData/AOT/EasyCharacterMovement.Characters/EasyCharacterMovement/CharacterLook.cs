using UnityEngine;

namespace EasyCharacterMovement;

public class CharacterLook : MonoBehaviour
{
	[Space(15f)]
	[Tooltip("Determines if the mouse cursor should be locked.")]
	[SerializeField]
	private bool _lockCursor;

	[Tooltip("Determines if the vertical axis should be inverted.")]
	[SerializeField]
	private bool _invertLook;

	[Tooltip("The horizontal sensitivity while using Mouse input, higher values cause faster movement.")]
	[SerializeField]
	private float _mouseHorizontalSensitivity;

	[Tooltip("The vertical sensitivity while using Mouse input, higher values cause faster movement.")]
	[SerializeField]
	private float _mouseVerticalSensitivity;

	[Tooltip("The horizontal sensitivity while using a Controller, higher values cause faster movement.")]
	[SerializeField]
	private float _controllerHorizontalSensitivity;

	[Tooltip("The vertical sensitivity while using a Controller, higher values cause faster movement.")]
	[SerializeField]
	private float _controllerVerticalSensitivity;

	[Space(15f)]
	[Tooltip("Determines if pitch rotation should be clamped between minPitchAngle and maxPitchAngle.")]
	[SerializeField]
	private bool _clampPitchRotation;

	[Tooltip("If clamp pitch rotation is enabled, determines the minimum pitch angle (in degrees).")]
	[SerializeField]
	private float _minPitchAngle;

	[Tooltip("If clamp pitch rotation is enabled, determines the maximum pitch angle (in degrees).")]
	[SerializeField]
	private float _maxPitchAngle;

	protected bool _isCursorLocked;

	public bool lockCursor
	{
		get
		{
			return _lockCursor;
		}
		set
		{
			_lockCursor = value;
			if (!_lockCursor)
			{
				Cursor.lockState = CursorLockMode.None;
				Cursor.visible = true;
			}
		}
	}

	public float mouseHorizontalSensitivity
	{
		get
		{
			return _mouseHorizontalSensitivity;
		}
		set
		{
			_mouseHorizontalSensitivity = Mathf.Max(0f, value);
		}
	}

	public float mouseVerticalSensitivity
	{
		get
		{
			return _mouseVerticalSensitivity;
		}
		set
		{
			_mouseVerticalSensitivity = Mathf.Max(0f, value);
		}
	}

	public float controllerHorizontalSensitivity
	{
		get
		{
			return _controllerHorizontalSensitivity;
		}
		set
		{
			_controllerHorizontalSensitivity = Mathf.Max(0f, value);
		}
	}

	public float controllerVerticalSensitivity
	{
		get
		{
			return _controllerVerticalSensitivity;
		}
		set
		{
			_controllerVerticalSensitivity = Mathf.Max(0f, value);
		}
	}

	public bool invertLook
	{
		get
		{
			return _invertLook;
		}
		set
		{
			_invertLook = value;
		}
	}

	public bool clampPitchRotation
	{
		get
		{
			return _clampPitchRotation;
		}
		set
		{
			_clampPitchRotation = value;
		}
	}

	public float minPitchAngle
	{
		get
		{
			return _minPitchAngle;
		}
		set
		{
			_minPitchAngle = value;
		}
	}

	public float maxPitchAngle
	{
		get
		{
			return _maxPitchAngle;
		}
		set
		{
			_maxPitchAngle = value;
		}
	}

	public virtual bool IsCursorLocked()
	{
		return _isCursorLocked;
	}

	public virtual void LockCursor()
	{
		if (lockCursor)
		{
			_isCursorLocked = true;
		}
		UpdateCursorLockState();
	}

	public virtual void UnlockCursor()
	{
		_isCursorLocked = false;
		UpdateCursorLockState();
	}

	protected virtual void UpdateCursorLockState()
	{
		if (lockCursor)
		{
			if (IsCursorLocked())
			{
				Cursor.lockState = CursorLockMode.Locked;
				Cursor.visible = false;
			}
			else
			{
				Cursor.lockState = CursorLockMode.None;
				Cursor.visible = true;
			}
		}
	}

	protected virtual void OnReset()
	{
		lockCursor = true;
		mouseHorizontalSensitivity = 0.1f;
		mouseVerticalSensitivity = 0.1f;
		controllerHorizontalSensitivity = 0.5f;
		controllerVerticalSensitivity = 0.5f;
		invertLook = true;
		clampPitchRotation = true;
		minPitchAngle = -80f;
		maxPitchAngle = 80f;
	}

	protected virtual void OnOnValidate()
	{
		mouseHorizontalSensitivity = _mouseHorizontalSensitivity;
		mouseVerticalSensitivity = _mouseVerticalSensitivity;
		controllerHorizontalSensitivity = _controllerHorizontalSensitivity;
		controllerVerticalSensitivity = _controllerVerticalSensitivity;
		minPitchAngle = _minPitchAngle;
		maxPitchAngle = _maxPitchAngle;
	}

	protected virtual void OnStart()
	{
		if (lockCursor)
		{
			LockCursor();
		}
	}

	private void Start()
	{
		OnStart();
	}

	private void Reset()
	{
		OnReset();
	}

	private void OnValidate()
	{
		OnOnValidate();
	}
}
