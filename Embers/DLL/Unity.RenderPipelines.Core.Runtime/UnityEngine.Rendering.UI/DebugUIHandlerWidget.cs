using System;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerWidget : MonoBehaviour
{
	[HideInInspector]
	public Color colorDefault = new Color(0.8f, 0.8f, 0.8f, 1f);

	[HideInInspector]
	public Color colorSelected = new Color(0.25f, 0.65f, 0.8f, 1f);

	protected DebugUI.Widget m_Widget;

	public DebugUIHandlerWidget parentUIHandler { get; set; }

	public DebugUIHandlerWidget previousUIHandler { get; set; }

	public DebugUIHandlerWidget nextUIHandler { get; set; }

	protected virtual void OnEnable()
	{
	}

	internal virtual void SetWidget(DebugUI.Widget widget)
	{
		m_Widget = widget;
	}

	internal DebugUI.Widget GetWidget()
	{
		return m_Widget;
	}

	protected T CastWidget<T>() where T : DebugUI.Widget
	{
		T obj = m_Widget as T;
		string text = ((m_Widget == null) ? "null" : m_Widget.GetType().ToString());
		if (obj == null)
		{
			throw new InvalidOperationException("Can't cast " + text + " to " + typeof(T));
		}
		return obj;
	}

	public virtual bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		return true;
	}

	public virtual void OnDeselection()
	{
	}

	public virtual void OnAction()
	{
	}

	public virtual void OnIncrement(bool fast)
	{
	}

	public virtual void OnDecrement(bool fast)
	{
	}

	public virtual DebugUIHandlerWidget Previous()
	{
		if (previousUIHandler != null)
		{
			return previousUIHandler;
		}
		if (parentUIHandler != null)
		{
			return parentUIHandler;
		}
		return null;
	}

	public virtual DebugUIHandlerWidget Next()
	{
		if (nextUIHandler != null)
		{
			return nextUIHandler;
		}
		if (parentUIHandler != null)
		{
			DebugUIHandlerWidget debugUIHandlerWidget = parentUIHandler;
			while (debugUIHandlerWidget != null)
			{
				DebugUIHandlerWidget debugUIHandlerWidget2 = debugUIHandlerWidget.nextUIHandler;
				if (debugUIHandlerWidget2 != null)
				{
					return debugUIHandlerWidget2;
				}
				debugUIHandlerWidget = debugUIHandlerWidget.parentUIHandler;
			}
		}
		return null;
	}
}
