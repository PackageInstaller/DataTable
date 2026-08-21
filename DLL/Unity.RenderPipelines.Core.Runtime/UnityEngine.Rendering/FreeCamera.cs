using UnityEngine.InputSystem;

namespace UnityEngine.Rendering;

public class FreeCamera : MonoBehaviour
{
	private const float k_MouseSensitivityMultiplier = 0.01f;

	public float m_LookSpeedController = 120f;

	public float m_LookSpeedMouse = 4f;

	public float m_MoveSpeed = 10f;

	public float m_MoveSpeedIncrement = 2.5f;

	public float m_Turbo = 10f;

	private InputAction lookAction;

	private InputAction moveAction;

	private InputAction speedAction;

	private InputAction yMoveAction;

	private float inputRotateAxisX;

	private float inputRotateAxisY;

	private float inputChangeSpeed;

	private float inputVertical;

	private float inputHorizontal;

	private float inputYAxis;

	private bool leftShiftBoost;

	private bool leftShift;

	private bool fire1;

	private void OnEnable()
	{
		RegisterInputs();
	}

	private void RegisterInputs()
	{
		InputActionMap map = new InputActionMap("Free Camera");
		lookAction = map.AddAction("look", InputActionType.Value, "<Mouse>/delta");
		moveAction = map.AddAction("move", InputActionType.Value, "<Gamepad>/leftStick");
		speedAction = map.AddAction("speed", InputActionType.Value, "<Gamepad>/dpad");
		yMoveAction = map.AddAction("yMove");
		lookAction.AddBinding("<Gamepad>/rightStick").WithProcessor("scaleVector2(x=15, y=15)");
		moveAction.AddCompositeBinding("Dpad").With("Up", "<Keyboard>/w").With("Up", "<Keyboard>/upArrow")
			.With("Down", "<Keyboard>/s")
			.With("Down", "<Keyboard>/downArrow")
			.With("Left", "<Keyboard>/a")
			.With("Left", "<Keyboard>/leftArrow")
			.With("Right", "<Keyboard>/d")
			.With("Right", "<Keyboard>/rightArrow");
		speedAction.AddCompositeBinding("Dpad").With("Up", "<Keyboard>/home").With("Down", "<Keyboard>/end");
		yMoveAction.AddCompositeBinding("Dpad").With("Up", "<Keyboard>/pageUp").With("Down", "<Keyboard>/pageDown")
			.With("Up", "<Keyboard>/e")
			.With("Down", "<Keyboard>/q")
			.With("Up", "<Gamepad>/rightshoulder")
			.With("Down", "<Gamepad>/leftshoulder");
		moveAction.Enable();
		lookAction.Enable();
		speedAction.Enable();
		yMoveAction.Enable();
	}

	private void UpdateInputs()
	{
		inputRotateAxisX = 0f;
		inputRotateAxisY = 0f;
		leftShiftBoost = false;
		fire1 = false;
		Vector2 vector = lookAction.ReadValue<Vector2>();
		inputRotateAxisX = vector.x * m_LookSpeedMouse * 0.01f;
		inputRotateAxisY = vector.y * m_LookSpeedMouse * 0.01f;
		leftShift = Keyboard.current?.leftShiftKey?.isPressed == true;
		Mouse current = Mouse.current;
		int num;
		if (current == null || current.leftButton?.isPressed != true)
		{
			Gamepad current2 = Gamepad.current;
			num = ((current2 != null && current2.xButton?.isPressed == true) ? 1 : 0);
		}
		else
		{
			num = 1;
		}
		fire1 = (byte)num != 0;
		inputChangeSpeed = speedAction.ReadValue<Vector2>().y;
		Vector2 vector2 = moveAction.ReadValue<Vector2>();
		inputVertical = vector2.y;
		inputHorizontal = vector2.x;
		inputYAxis = yMoveAction.ReadValue<Vector2>().y;
	}

	private void Update()
	{
		if (DebugManager.instance.displayRuntimeUI)
		{
			return;
		}
		UpdateInputs();
		if (inputChangeSpeed != 0f)
		{
			m_MoveSpeed += inputChangeSpeed * m_MoveSpeedIncrement;
			if (m_MoveSpeed < m_MoveSpeedIncrement)
			{
				m_MoveSpeed = m_MoveSpeedIncrement;
			}
		}
		if (inputRotateAxisX != 0f || inputRotateAxisY != 0f || inputVertical != 0f || inputHorizontal != 0f || inputYAxis != 0f)
		{
			float x = base.transform.localEulerAngles.x;
			float y = base.transform.localEulerAngles.y + inputRotateAxisX;
			float num = x - inputRotateAxisY;
			if (x <= 90f && num >= 0f)
			{
				num = Mathf.Clamp(num, 0f, 90f);
			}
			if (x >= 270f)
			{
				num = Mathf.Clamp(num, 270f, 360f);
			}
			base.transform.localRotation = Quaternion.Euler(num, y, base.transform.localEulerAngles.z);
			float num2 = Time.deltaTime * m_MoveSpeed;
			if (fire1 || (leftShiftBoost && leftShift))
			{
				num2 *= m_Turbo;
			}
			base.transform.position += base.transform.forward * num2 * inputVertical;
			base.transform.position += base.transform.right * num2 * inputHorizontal;
			base.transform.position += Vector3.up * num2 * inputYAxis;
		}
	}
}
