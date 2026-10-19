using ACT.Battle;
using Com.ForbiddenByte.OSA.Core;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem;

namespace ACT.UI;

public class OSAGamepadScrollController : MonoBehaviour
{
	public enum ScrollMode
	{
		Continuous,
		ItemByItem
	}

	[Header("OSA 引用")]
	[SerializeField]
	[Tooltip("要控制的 OSA 实例（会自动查找）")]
	private MonoBehaviour targetOSAComponent;

	[SerializeField]
	private string bindingAction;

	[Header("滚动设置")]
	[SerializeField]
	[Tooltip("滚动模式")]
	private ScrollMode scrollMode;

	[SerializeField]
	[Tooltip("连续滚动速度")]
	private float continuousScrollSpeed = 1200f;

	[SerializeField]
	[Tooltip("按项滚动的步进速度")]
	private float itemStepScrollSpeed = 0.3f;

	[SerializeField]
	[Tooltip("死区阈值")]
	[Range(0f, 0.9f)]
	private float deadZone = 0.3f;

	[SerializeField]
	[Tooltip("平滑滚动插值速度")]
	[Range(1f, 20f)]
	private float smoothSpeed = 10f;

	[SerializeField]
	[Tooltip("反转滚动方向")]
	private bool invertScroll;

	[Header("输入限制")]
	[SerializeField]
	[Tooltip("输入冷却时间（按项滚动模式）")]
	private float inputCooldown = 0.2f;

	[SerializeField]
	[Tooltip("是否仅在可见时响应输入")]
	private bool onlyWhenVisible = true;

	private IOSA _osa;

	private Canvas _parentCanvas;

	private float _currentScrollVelocity;

	private float _lastInputTime;

	private float _lastInputValue;

	private bool _isInitialized;

	private IBaseUIView _uiView;

	private void Start()
	{
		InitializeOSA();
		if (onlyWhenVisible)
		{
			_parentCanvas = GetComponentInParent<Canvas>();
		}
		if (bindingAction == string.Empty)
		{
			bindingAction = "UI/ScrollViewRightStickControl";
		}
	}

	private void InitializeOSA()
	{
		if (targetOSAComponent != null)
		{
			_osa = targetOSAComponent as IOSA;
		}
		if (_osa == null)
		{
			_osa = GetComponentInParent<IOSA>();
		}
		if (_osa == null)
		{
			Debug.LogWarning("未找到 OSA 实例，将在下一帧重试。");
			Invoke("InitializeOSA", 0.1f);
		}
		else
		{
			_uiView = GetComponentInParent<IBaseUIView>();
			_isInitialized = true;
		}
	}

	private bool CheckIsInTopUIView()
	{
		if (_uiView == null)
		{
			return true;
		}
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null)
		{
			return true;
		}
		return topActiveUI.GetUIView() == _uiView;
	}

	private void Update()
	{
		if (_isInitialized && _osa != null && _osa.IsInitialized && CheckIsInTopUIView() && (!onlyWhenVisible || IsVisible()))
		{
			float num = GetVerticalInput();
			if (Mathf.Abs(num) < deadZone)
			{
				num = 0f;
			}
			if (invertScroll)
			{
				num = 0f - num;
			}
			switch (scrollMode)
			{
			case ScrollMode.Continuous:
				HandleContinuousScroll(num);
				break;
			case ScrollMode.ItemByItem:
				HandleItemByItemScroll(num);
				break;
			}
		}
	}

	private float GetVerticalInput()
	{
		InputActionPhase phase;
		if (MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			return 0f - Singleton<GameInputActionManager>.GetInstance().ReadActionValue<Vector2>(bindingAction, out phase).y;
		}
		return 0f;
	}

	private void HandleContinuousScroll(float input)
	{
		float b = input * continuousScrollSpeed;
		_currentScrollVelocity = Mathf.Lerp(_currentScrollVelocity, b, Time.deltaTime * smoothSpeed);
		if (Mathf.Abs(_currentScrollVelocity) > 0.01f)
		{
			float delta = _currentScrollVelocity * Time.deltaTime;
			ApplyScroll(delta);
		}
	}

	private void HandleItemByItemScroll(float input)
	{
		if (Time.time - _lastInputTime < inputCooldown)
		{
			return;
		}
		if (Mathf.Abs(_lastInputValue) < deadZone && Mathf.Abs(input) >= deadZone)
		{
			_lastInputTime = Time.time;
			_lastInputValue = input;
			if (input > 0f)
			{
				ScrollByItems(-1);
			}
			else
			{
				ScrollByItems(1);
			}
		}
		else
		{
			_lastInputValue = input;
		}
	}

	private void ApplyScroll(float delta)
	{
		if (_osa != null && _osa.IsInitialized)
		{
			double normalizedPosition = _osa.GetNormalizedPosition();
			float num = delta / (float)_osa.GetContentSize();
			double normalizedPosition2 = Mathf.Clamp01((float)(normalizedPosition - (double)num));
			_osa.SetNormalizedPosition(normalizedPosition2);
		}
	}

	private void ScrollByItems(int itemCount)
	{
		if (_osa != null && _osa.IsInitialized)
		{
			int num = Mathf.Clamp(((_osa.GetItemsCount() > 0) ? Mathf.RoundToInt((float)_osa.GetNormalizedPosition() * (float)_osa.GetItemsCount()) : 0) + itemCount, 0, _osa.GetItemsCount() - 1);
			if (_osa.GetItemsCount() > 0)
			{
				float num2 = (float)num / (float)_osa.GetItemsCount();
				_osa.SetNormalizedPosition(num2);
			}
		}
	}

	private bool IsVisible()
	{
		if (_parentCanvas == null)
		{
			return true;
		}
		if (_parentCanvas.enabled)
		{
			return gameObject.activeInHierarchy;
		}
		return false;
	}

	public void SetScrollMode(ScrollMode mode)
	{
		scrollMode = mode;
		_currentScrollVelocity = 0f;
	}

	public void SetScrollSpeed(float speed)
	{
		continuousScrollSpeed = Mathf.Max(0f, speed);
	}

	public void ScrollToTop()
	{
		if (_osa != null && _osa.IsInitialized)
		{
			_osa.SetNormalizedPosition(0.0);
		}
	}

	public void ScrollToBottom()
	{
		if (_osa != null && _osa.IsInitialized)
		{
			_osa.SetNormalizedPosition(1.0);
		}
	}

	public void ScrollToItem(int itemIndex)
	{
		if (_osa != null && _osa.IsInitialized && _osa.GetItemsCount() > 0)
		{
			float num = Mathf.Clamp01((float)itemIndex / (float)_osa.GetItemsCount());
			_osa.SetNormalizedPosition(num);
		}
	}
}
