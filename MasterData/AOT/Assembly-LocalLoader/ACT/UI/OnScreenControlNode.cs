using System;
using UnityEngine;

namespace ACT.UI;

public abstract class OnScreenControlNode : MonoBehaviour, IOnScreenControlNode
{
	public const string OnScreenControlNodeMark = "OnScreenControlNode";

	[SerializeField]
	private string _controlPath;

	private OnScreenControlNode _nextControlNodeOnDevice;

	public abstract Type ValueType { get; }

	public string ControlPath
	{
		get
		{
			return _controlPath;
		}
		set
		{
			_controlPath = value;
		}
	}

	protected virtual void OnEnable()
	{
	}

	protected virtual void OnDisable()
	{
	}
}
public abstract class OnScreenControlNode<T> : OnScreenControlNode where T : struct
{
	public delegate void HandleOnScreenDeviceInput(string path, T value);

	private bool _changed;

	private T _value;

	public override Type ValueType => typeof(T);

	public static HandleOnScreenDeviceInput InputCallback { get; set; }

	public static Type GetValueType()
	{
		return typeof(T);
	}

	public void SendValue(T value, bool immediate = false)
	{
		if (!value.Equals(_value))
		{
			_value = value;
			if (immediate)
			{
				SendValueToControl(_value);
			}
			else
			{
				_changed = true;
			}
		}
	}

	protected void Update()
	{
		if (_changed)
		{
			SendValueToControl(_value);
			_changed = false;
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		_value = default;
		SentDefaultValueToControl();
	}

	protected void SentDefaultValueToControl()
	{
		InputCallback?.Invoke(ControlPath, default);
	}

	protected void SendValueToControl(T value)
	{
		InputCallback?.Invoke(ControlPath, value);
	}
}
