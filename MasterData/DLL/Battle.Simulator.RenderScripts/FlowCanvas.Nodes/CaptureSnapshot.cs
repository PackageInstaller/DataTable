using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("修正模式截屏(渲染)", 0)]
[Category("Render/特效")]
[Description("现在用于修正模式进入、退出的截屏效果,注意,后续必须要接释放,否则会浪费内存")]
public class CaptureSnapshot : FlowControlNode
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
			_CameraEx.CaptureSnapshot();
			_Out.Call(f);
		});
	}
}
