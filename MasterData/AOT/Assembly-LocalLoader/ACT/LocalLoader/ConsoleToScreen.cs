using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.LocalLoader;

public class ConsoleToScreen : MonoBehaviour
{
	private const int maxLines = 50;

	private const int maxLineLength = 120;

	private string _logStr = "";

	private readonly List<string> _lines = new List<string>();

	public int fontSize = 15;

	private void OnEnable()
	{
		Application.logMessageReceived += Log;
	}

	private void OnDisable()
	{
		Application.logMessageReceived -= Log;
	}

	public void Log(string logString, string stackTrace, LogType type)
	{
		string[] array = logString.Split('\n');
		foreach (string text in array)
		{
			if (text.Length <= 120)
			{
				_lines.Add(text);
				continue;
			}
			int num = text.Length / 120 + 1;
			for (int j = 0; j < num; j++)
			{
				if ((j + 1) * 120 <= text.Length)
				{
					_lines.Add(text.Substring(j * 120, 120));
				}
				else
				{
					_lines.Add(text.Substring(j * 120, text.Length - j * 120));
				}
			}
		}
		if (_lines.Count > 50)
		{
			_lines.RemoveRange(0, _lines.Count - 50);
		}
		_logStr = string.Join("\n", _lines);
	}

	private void OnGUI()
	{
		GUI.matrix = Matrix4x4.TRS(Vector3.zero, Quaternion.identity, new Vector3((float)Screen.width / 1200f, (float)Screen.height / 800f, 1f));
		GUIStyle gUIStyle = new GUIStyle
		{
			fontSize = Math.Max(10, fontSize)
		};
		gUIStyle.normal.textColor = new Color(1f, 0f, 0f, 1f);
		GUI.Label(new Rect(10f, 10f, 800f, 370f), _logStr, gUIStyle);
	}
}
