using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace P08.Gamepad;

internal class GamepadDeviceWatcher
{
	private List<string> _devices = new List<string>();

	private static string[] psKeywords = new string[1] { "playstation" };

	private static string[] ignoreNames = new string[1] { "uinput-fpc" };

	private float _lastTickTime = -1f;

	public event Action<string> OnDeviceAdded;

	public event Action<string> OnDeviceRemoved;

	public static En_GamepadType GetGamepadTypeForName(string name)
	{
		name = name.ToLower();
		if (psKeywords.FirstOrDefault((string k) => name.Contains(k)) != null)
		{
			return En_GamepadType.PS4;
		}
		return En_GamepadType.Xbox;
	}

	private bool IsIgnore(string name)
	{
		return ignoreNames.Contains(name);
	}

	public void Tick()
	{
		if (Time.time - _lastTickTime < 1f)
		{
			return;
		}
		_lastTickTime = Time.time;
		string[] joystickNames = Input.GetJoystickNames();
		string[] array = joystickNames;
		foreach (string text in array)
		{
			if (!string.IsNullOrEmpty(text) && !_devices.Contains(text))
			{
				_devices.Add(text);
				if (!IsIgnore(text))
				{
					OnDeviceAdded?.Invoke(text);
				}
			}
		}
		int num = 0;
		while (num < _devices.Count)
		{
			string text2 = _devices[num];
			if (!joystickNames.Contains(text2))
			{
				_devices.Remove(text2);
				if (!IsIgnore(text2))
				{
					OnDeviceRemoved?.Invoke(text2);
				}
			}
			else
			{
				num++;
			}
		}
	}
}
