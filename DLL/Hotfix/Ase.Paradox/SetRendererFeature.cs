#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Reflection;
using GameFramework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Ase.Paradox;

[Name("设置RenderFeature", 0)]
[Category("✫ DragonLost/Render")]
[Description("设置RenderFeature的开启或关闭")]
public class SetRendererFeature : ActionTaskBase
{
	[Name("渲染器名称", 0)]
	public string renderName;

	[Name("是否打开", 0)]
	public bool isOpen;

	protected override void OnExecute()
	{
		base.OnExecute();
		RenderPipelineAsset renderPipeline = QualitySettings.renderPipeline;
		if (renderPipeline == null)
		{
			Log.Error("Quality -> 渲染器资产不存在");
			OnActionFinish();
			return;
		}
		UniversalRenderPipelineAsset val = (UniversalRenderPipelineAsset)(object)((renderPipeline is UniversalRenderPipelineAsset) ? renderPipeline : null);
		if (val == null || (Object)(object)val == null)
		{
			Log.Error("当前渲染器资产无法转换为URP渲染");
			OnActionFinish();
			return;
		}
		ScriptableRenderer renderer = val.GetRenderer(0);
		if (renderer == null)
		{
			Log.Error("当前URP渲染器的渲染配置为空");
			OnActionFinish();
			return;
		}
		ScriptableRendererFeature val2 = (typeof(ScriptableRenderer).GetProperty("rendererFeatures", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(renderer) as List<ScriptableRendererFeature>)?.Find((ScriptableRendererFeature b) => ((Object)(object)b).name == renderName) ?? null;
		if ((Object)(object)val2 == null)
		{
			Log.Error("当前 RenderFeature : " + renderName + " 不存在");
			OnActionFinish();
		}
		else
		{
			val2.SetActive(isOpen);
			OnActionFinish();
		}
	}

	public static ScriptableRendererFeature GetRenderFeature(string renderName)
	{
		RenderPipelineAsset renderPipeline = QualitySettings.renderPipeline;
		if (renderPipeline == null)
		{
			Log.Error("Quality -> 渲染器资产不存在");
			return null;
		}
		UniversalRenderPipelineAsset val = (UniversalRenderPipelineAsset)(object)((renderPipeline is UniversalRenderPipelineAsset) ? renderPipeline : null);
		if (val == null || (Object)(object)val == null)
		{
			Log.Error("当前渲染器资产无法转换为URP渲染");
			return null;
		}
		ScriptableRenderer renderer = val.GetRenderer(0);
		if (renderer == null)
		{
			Log.Error("当前URP渲染器的渲染配置为空");
			return null;
		}
		return (typeof(ScriptableRenderer).GetProperty("rendererFeatures", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(renderer) as List<ScriptableRendererFeature>)?.Find((ScriptableRendererFeature b) => ((Object)(object)b).name == renderName) ?? null;
	}
}
