using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace ACT.DebugGUI;

public class CommandWindow : DebugGUIWindow
{
	private Vector2 m_Pos;

	private bool invoking;

	protected override void OnDraw()
	{
		m_Pos = GUILayout.BeginScrollView(m_Pos);
		GUI.enabled = !invoking;
		foreach (string item in File.ReadLines(""))
		{
			string[] array = item.Split(',');
			array[0].Split('|');
			GUILayout.Button(array[1]);
		}
		GUI.enabled = true;
		GUILayout.EndScrollView();
	}

	public async void Invoke(IEnumerable<string> commands)
	{
	}
}
