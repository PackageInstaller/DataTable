using UnityEngine.InputSystem;

namespace UnityEngine.Rendering;

public class MousePositionDebug
{
	private static MousePositionDebug s_Instance;

	public static MousePositionDebug instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new MousePositionDebug();
			}
			return s_Instance;
		}
	}

	public void Build()
	{
	}

	public void Cleanup()
	{
	}

	public Vector2 GetMousePosition(float ScreenHeight, bool sceneView)
	{
		return GetInputMousePosition();
	}

	private Vector2 GetInputMousePosition()
	{
		if (Pointer.current == null)
		{
			return new Vector2(-1f, -1f);
		}
		return Pointer.current.position.ReadValue();
	}

	public Vector2 GetMouseClickPosition(float ScreenHeight)
	{
		return Vector2.zero;
	}
}
