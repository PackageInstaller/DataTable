using UnityEngine.EventSystems;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.OnScreen;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/OnScreen.html#on-screen-buttons")]
[AddComponentMenu("Input/On-Screen Button")]
public class OnScreenButton : OnScreenControl, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	[SerializeField]
	[InputControl(layout = "Button")]
	private string m_ControlPath;

	protected override string controlPathInternal
	{
		get
		{
			return m_ControlPath;
		}
		set
		{
			m_ControlPath = value;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		SendValueToControl(0f);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		SendValueToControl(1f);
	}
}
