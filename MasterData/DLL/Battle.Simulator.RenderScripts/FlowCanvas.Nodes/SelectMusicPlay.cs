using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("选择背景音乐(BGM)(渲染)", 0)]
[Category("Render/声音")]
[Description("从一堆背景音乐配置中,选择 索引 对应的那组;\n当索引大于列表列表长度时候,走 error 分支")]
public class SelectMusicPlay : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<List<string>> cueSheetArrInput = AddValueInput<List<string>>("CueSheet组", "cueSheetArr");
		ValueInput<List<string>> cueNameArrInput = AddValueInput<List<string>>("CueName组", "cueNameArr");
		ValueInput<bool> useStreamInput = AddValueInput<bool>("使用流式", "useStream").SetDefaultAndSerializedValue(v: true);
		ValueInput<int> indexInput = AddValueInput<int>("索引", "index");
		ValueInput<bool> flagInput = AddValueInput<bool>("使用地图配置的额外音乐").SetDefaultAndSerializedValue(v: true);
		AddFlowInput("In", delegate(Flow f)
		{
			if (flagInput.value)
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene != null && battleScene.mapConfig != null && !string.IsNullOrEmpty(battleScene.mapConfig.ExternalParam))
				{
					AudioManager.Instance.Play("music", battleScene.mapConfig.ExternalParam, battleScene.mapConfig.ExternalParam, useStreamInput.value);
					output.Call(f);
					return;
				}
			}
			int value = indexInput.value;
			List<string> value2 = cueSheetArrInput.value;
			List<string> value3 = cueNameArrInput.value;
			if (value < 0 || value2 == null || value2.Count <= value || cueNameArrInput == null || value3.Count <= value)
			{
				error.Call(f);
			}
			else
			{
				string cueSheetName = value2[value];
				string cueName = value3[value];
				AudioManager.Instance.Play("music", cueSheetName, cueName, useStreamInput.value);
				output.Call(f);
			}
		});
	}
}
