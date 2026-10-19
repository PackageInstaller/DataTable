using UnityEngine;

namespace ACT.DebugGUI;

public abstract class DebugWindow
{
	public Rect position = DebugWindowManager.instance.defaultWindowRect;

	public Vector2 scroll;

	public virtual string Name { get; }

	public bool Active { get; private set; }

	public void Open()
	{
		if (!Active)
		{
			DebugWindowManager.instance.RegisterWindow(this);
			Active = true;
			OnOpen();
		}
	}

	public void Close()
	{
		if (Active)
		{
			DebugWindowManager.instance.UnregisterWindow(this);
			Active = false;
			OnClose();
		}
	}

	public void Draw(int id)
	{
		position = GUI.Window(id, position, DrawWindow, Name);
		if (UnityEngine.Event.current.type == EventType.MouseDown)
		{
			UnityEngine.Event.current.Use();
		}
		void DrawWindow(int _id)
		{
			scroll = GUILayout.BeginScrollView(scroll);
			OnDraw();
			GUILayout.EndScrollView();
			GUI.DragWindow();
		}
	}

	public void Update()
	{
		OnUpdate();
	}

	protected virtual void OnOpen()
	{
	}

	protected virtual void OnClose()
	{
	}

	protected virtual void OnDraw()
	{
	}

	protected virtual void OnUpdate()
	{
	}
}
