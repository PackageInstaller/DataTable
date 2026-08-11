namespace UnityEngine.EventSystems;

public class BaseInput : UIBehaviour
{
	public virtual string compositionString => Input.compositionString;

	public virtual IMECompositionMode imeCompositionMode
	{
		get
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			return Input.imeCompositionMode;
		}
		set
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
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
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
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
