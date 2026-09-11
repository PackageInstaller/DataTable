using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("UI剧情", 0)]
[Category("Render/UI")]
[Description("UI剧情")]
public class CallShowStory : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> IDInput = AddValueInput<int>("剧情ID");
		ValueInput<bool> checkPlayedInput = AddValueInput<bool>("忽略播放过的");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput finishedOutt = AddFlowOutput("播放完成");
		AddFlowInput("", delegate(Flow f)
		{
			if (!LuaHelper.IsLuaClientInited())
			{
				falseOut.Call(f);
			}
			else
			{
				try
				{
					Action action = delegate
					{
						finishedOutt.Call(f);
						action = null;
					};
					LuaHelper.CallFunction("ShowStory", IDInput.value, checkPlayedInput.value, action);
				}
				catch (Exception ex)
				{
					Debug.LogError("UI剧情 出错");
					Debug.LogError(ex.Message);
					Debug.LogError(ex.StackTrace);
				}
				trueOut.Call(f);
			}
		});
	}
}
