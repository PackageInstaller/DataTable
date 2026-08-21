using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("修正模式截屏释放(渲染)", 0)]
[Category("Render/特效")]
[Description("现在用于修正模式进入、退出的截屏效果")]
public class FreeSnapshot : FlowControlNode
{
	private FlowOutput _Out;

	private CameraExtension _CameraEx;

	public override void OnGraphStoped()
	{
		_CameraEx = null;
	}

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (_CameraEx == null)
			{
				_CameraEx = Camera.main.GetComponent<CameraExtension>();
			}
			_CameraEx.FreeSnapshot();
			_Out.Call(f);
		});
	}
}
