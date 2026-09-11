using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到当前BGM(Render)", 0)]
[Category("Render/Config")]
[Description("从播放列表中得到当前战斗BGM的信息")]
public class GetCurBGMInfo : FlowControlNode
{
	private string m_cueSheet;

	private string m_cueName;

	private string m_cueAwb;

	protected override void RegisterPorts()
	{
		ValueInput<string> cueSheetInput = AddValueInput<string>("Sheet Name", "cueSheet");
		ValueInput<string> cueNameInput = AddValueInput<string>("Cue Name", "cueName");
		ValueInput<string> awbFileInput = AddValueInput<string>("Awb File(xxx.awb)", "awbFile");
		FlowOutput trueOut = AddFlowOutput("True", "trueOut");
		FlowOutput falseOut = AddFlowOutput("False", "falseOut");
		FlowOutput errorOut = AddFlowOutput("Error", "errorOut");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			CriAtomSource player = AudioManager.Instance.GetPlayer("music");
			if (player == null)
			{
				errorOut.Call(f);
				Debug.LogError("当前没有正在播放的战斗BGM");
			}
			else if (cueSheetInput.value == player.cueSheet && cueNameInput.value == player.cueName && awbFileInput.value == player.cueSheet + ".awb")
			{
				m_cueSheet = player.cueSheet;
				m_cueName = player.cueName;
				m_cueAwb = player.cueSheet + ".awb";
				trueOut.Call(f);
			}
			else
			{
				m_cueSheet = player.cueSheet;
				m_cueName = player.cueName;
				m_cueAwb = player.cueSheet + ".awb";
				falseOut.Call(f);
			}
		});
		AddValueOutput("包名(CueSheet)", "cueSheet", () => m_cueSheet);
		AddValueOutput("曲名(CueName)", "cueName", () => m_cueName);
		AddValueOutput("流式文件(CueAwb)", "cueAwb", () => m_cueAwb);
	}
}
