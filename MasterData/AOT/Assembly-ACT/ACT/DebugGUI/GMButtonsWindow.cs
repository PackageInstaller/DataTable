using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using UnityEngine;

namespace ACT.DebugGUI;

public class GMButtonsWindow : DebugWindow
{
	public struct CommandData
	{
		public string[] commands;

		public string name;

		public GUIContent GUIContent;
	}

	private bool invokingCommands;

	private List<CommandData> commands = new List<CommandData>();

	public override string Name => "GM按钮";

	public GMButtonsWindow()
	{
		foreach (KeyValuePair<int, GmCommandGroup> gmCommandGroup in RuntimeConfigs.data.gmCommandGroups)
		{
			string[] commandGroup = gmCommandGroup.Value.commandGroup;
			string gmName = gmCommandGroup.Value.gmName;
			commands.Add(new CommandData
			{
				commands = commandGroup,
				name = gmName,
				GUIContent = new GUIContent(gmName)
			});
		}
	}

	protected override void OnDraw()
	{
		Color contentColor = GUI.contentColor;
		GUI.contentColor = Color.red;
		if (GUILayout.Button("关闭"))
		{
			Close();
		}
		GUI.contentColor = contentColor;
		for (int i = 0; i < commands.Count; i++)
		{
			CommandData commandData = commands[i];
			if (GUILayout.Button(commandData.GUIContent, GUILayout.Height(35f)))
			{
				InvokeComands(commandData.commands);
			}
		}
	}

	protected async void InvokeComands(string[] commands)
	{
		if (commands != null && commands.Length != 0)
		{
			_ = commands[0];
			Array.Empty<string>();
			if (commands.Length > 1)
			{
				commands.Skip(1).ToArray();
			}
		}
	}
}
