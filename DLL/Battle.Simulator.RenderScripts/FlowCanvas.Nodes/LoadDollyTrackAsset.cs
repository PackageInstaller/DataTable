using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("加载相机轨道(渲染)", 0)]
[Category("Render/UI")]
[Description("加载相机轨道,路径距离:DollyTrack/DollyTrack_5030605")]
public class LoadDollyTrackAsset : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> assetNameInput = AddValueInput<string>("资源路径(看备注)", "assetName");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (null == battleScene)
			{
				errorOut.Call(f);
			}
			else
			{
				GameObject gameObject = Asset.InstantiateWithoutCache(assetNameInput.value);
				if (gameObject == null)
				{
					errorOut.Call(f);
				}
				else
				{
					gameObject.transform.position = Vector3.zero;
					gameObject.transform.rotation = Quaternion.identity;
					CinemachineSmoothPath componentInChildren = gameObject.GetComponentInChildren<CinemachineSmoothPath>();
					if (battleScene.virtualCameraParam != null)
					{
						P08CinemachineTrackPathExtend p08CinemachineTrackPathExtend = battleScene.virtualCameraParam.gameObject.AddComponent<P08CinemachineTrackPathExtend>();
						if (p08CinemachineTrackPathExtend != null)
						{
							p08CinemachineTrackPathExtend.m_path = componentInChildren;
							p08CinemachineTrackPathExtend.m_follow = battleScene.virtualCameraParam.virtualCamera.Follow;
							p08CinemachineTrackPathExtend.m_cart = gameObject.GetComponentInChildren<CinemachineDollyCart>();
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
