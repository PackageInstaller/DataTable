using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复制SceneSetting(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("只能跟着场景走, 不能在角色和怪物机制里用;\n 从场景里带的隐藏的SceneSettingFogConfig里拷贝参数到外面激活的组件里\n 整合几个复制场景参数的节点\n 路径是相对路径, 从外面生效的SceneSettingFogConfig开始\n 每次调用都会有GetComponent的消耗")]
public class BuffCopySceneSetting : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<string> targetPathInput = AddValueInput<string>("路径");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Transform transform = battleScene.sceneSetting.transform.Find(targetPathInput.value);
				if (transform == null)
				{
					errorOut.Call(f);
				}
				else
				{
					SceneSetting component = transform.GetComponent<SceneSetting>();
					if (component == null)
					{
						errorOut.Call(f);
					}
					else
					{
						battleScene.sceneSetting.fogColor = component.fogColor;
						battleScene.sceneSetting.fogColor2 = component.fogColor2;
						battleScene.sceneSetting.fogMode = component.fogMode;
						battleScene.sceneSetting.fogStart = component.fogStart;
						battleScene.sceneSetting.fogEnd = component.fogEnd;
						battleScene.sceneSetting.fogHeight = component.fogHeight;
						battleScene.sceneSetting.fogHeightGradient = component.fogHeightGradient;
						battleScene.sceneSetting.fogDensity = component.fogDensity;
						battleScene.sceneSetting.bakeReflection = component.bakeReflection;
						battleScene.sceneSetting.bakeReflectionTex = component.bakeReflectionTex;
						battleScene.sceneSetting.bakeReflectionScale = component.bakeReflectionScale;
						battleScene.sceneSetting.DecalShadow = component.DecalShadow;
						battleScene.sceneSetting.NormalClipThreshold = component.NormalClipThreshold;
						battleScene.sceneSetting.DecalCubeHeight = component.DecalCubeHeight;
						battleScene.sceneSetting.VisualizeCube = component.VisualizeCube;
						battleScene.sceneSetting.GroundHeight = component.GroundHeight;
						battleScene.sceneSetting.GroundShadowInclination = component.GroundShadowInclination;
						battleScene.sceneSetting.GroundShadowAzimuth = component.GroundShadowAzimuth;
						battleScene.sceneSetting.GroundShadowFade = component.GroundShadowFade;
						battleScene.sceneSetting.GroundShadowColor = component.GroundShadowColor;
						battleScene.sceneSetting.ShadowScatter = component.ShadowScatter;
						battleScene.sceneSetting.ShadowScatterColor = component.ShadowScatterColor;
						battleScene.sceneSetting.ShadowScatterRange = component.ShadowScatterRange;
						battleScene.sceneSetting.probeLightingBase = component.probeLightingBase;
						battleScene.sceneSetting.probeLightingScale = component.probeLightingScale;
						battleScene.sceneSetting.sceneLightProbe = component.sceneLightProbe;
						battleScene.sceneSetting.setLightProbe = component.setLightProbe;
						battleScene.sceneSetting.skyColor = component.skyColor;
						battleScene.sceneSetting.equatorColor = component.equatorColor;
						battleScene.sceneSetting.groundColor = component.groundColor;
						battleScene.sceneSetting.tonemapping = component.tonemapping;
						battleScene.sceneSetting.exposure = component.exposure;
						battleScene.sceneSetting.contrast = component.contrast;
						battleScene.sceneSetting.threshold = component.threshold;
						battleScene.sceneSetting.RequireAlphaChannel = component.RequireAlphaChannel;
						battleScene.sceneSetting.skyboxInputs = component.skyboxInputs;
						battleScene.sceneSetting.SupportDirectionalLight = component.SupportDirectionalLight;
						battleScene.sceneSetting.realReflectionMode = component.realReflectionMode;
						battleScene.sceneSetting.realReflectionScale = component.realReflectionScale;
						battleScene.sceneSetting.waterSurfaceHeight = component.waterSurfaceHeight;
						battleScene.sceneSetting.tint = component.tint;
						battleScene.sceneSetting.VertexAmbientScale = component.VertexAmbientScale;
						output.Call(f);
					}
				}
			}
		});
	}
}
