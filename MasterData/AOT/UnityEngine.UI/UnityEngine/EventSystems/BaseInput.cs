namespace UnityEngine.EventSystems;

public class BaseInput : UIBehaviour
{
	public virtual string compositionString => Input.compositionString;

	public virtual IMECompositionMode imeCompositionMode
	{
		get
		{
			return Input.imeCompositionMode;
		}
		set
		{
			Input.imeCompositionMode = value;
		}
	}

	public virtual Vector2 compositionCursorPos
	{
		get
		{
			return Input.compositionCursorPos;
		}
		set
		{
			Input.compositionCursorPos = value;
		}
	}

	public virtual bool mousePresent => Input.mousePresent;

	public virtual Vector2 mousePosition => Input.mousePosition;

	public virtual Vector2 mouseScrollDelta => Input.mouseScrollDelta;

	public virtual bool touchSupported => Input.touchSupported;

	public virtual int touchCount => Input.touchCount;

	public virtual bool GetMouseButtonDown(int button)
	{
		return Input.GetMouseButtonDown(button);
	}

	public virtual bool GetMouseButtonUp(int button)
	{
		return Input.GetMouseButtonUp(button);
	}

	public virtual bool GetMouseButton(int button)
	{
		return Input.GetMouseButton(button);
	}

	public virtual Touch GetTouch(int index)
	{
		return Input.GetTouch(index);
	}

	public virtual float GetAxisRaw(string axisName)
	{
		return Input.GetAxisRaw(axisName);
	}

	public virtual bool GetButtonDown(string buttonName)
	{
		return Input.GetButtonDown(buttonName);
	}
}
