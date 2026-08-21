using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Ase.Paradox;

[Name("设置场景去饱和度", 0)]
[Category("✫ DragonLost/Scene")]
[Description("设置场景去饱和度")]
public class SetSceneDesaturateStencil : ActionTaskBase
{
	[Name("去饱和值", 0)]
	[SliderField(0, 1)]
	public BBParameter<float> value;

	[Name("过渡时间", 0)]
	public BBParameter<float> curveTime;

	[Name("持续时间", 0)]
	public BBParameter<float> durationTime;

	[Name("是否强制关闭", 0)]
	public BBParameter<bool> isForceClose;

	protected ScriptableRendererFeature rendererFeature;

	protected DesaturateStencilVolume stencil;

	protected bool lastRenderIsOpen;

	protected bool lastStencilIsOpen;

	protected float frameValue;

	protected const string RENDER_FEATURE_NAME = "DesaturateStencil";

	protected override void OnExecute()
	{
		base.OnExecute();
		rendererFeature = SetRendererFeature.GetRenderFeature("DesaturateStencil");
		if ((Object)(object)rendererFeature == null)
		{
			OnActionFinish();
			return;
		}
		GetDesaturateStencilVolume();
		if (stencil == null)
		{
			OnActionFail();
			return;
		}
		if (isForceClose.value)
		{
			stencil.desaturate.value = 0f;
			OnActionFinish();
			return;
		}
		if (curveTime.value > durationTime.value)
		{
			OnActionFinish();
			return;
		}
		lastRenderIsOpen = rendererFeature.isActive;
		lastStencilIsOpen = stencil.active;
		frameValue = value.value - stencil.desaturate.value;
		frameValue = frameValue / curveTime.value * base.ownerSystem.deltaTime;
		rendererFeature.SetActive(true);
		stencil.active = true;
	}

	private void GetDesaturateStencilVolume()
	{
		Object[] array = Object.FindObjectsOfType(typeof(Volume));
		for (int i = 0; i < array.Length && (!(array[i] is Volume volume) || !volume.profile.TryGet<DesaturateStencilVolume>(out stencil)); i++)
		{
		}
	}

	protected override void OnUpdate()
	{
		if (isForceClose.value || base.elapsedTime > durationTime.value)
		{
			ResetDesaturateStencil();
			OnActionFinish();
		}
		else
		{
			if (base.elapsedTime <= 0f)
			{
				return;
			}
			if (base.elapsedTime <= curveTime.value)
			{
				if (stencil != null)
				{
					stencil.desaturate.value += frameValue;
				}
			}
			else
			{
				ResetDesaturateStencil();
				OnActionFinish();
			}
		}
	}

	private void ResetDesaturateStencil()
	{
		if ((Object)(object)rendererFeature != null)
		{
			rendererFeature.SetActive(lastRenderIsOpen);
		}
		if (stencil != null)
		{
			stencil.active = lastStencilIsOpen;
			stencil.desaturate.value = value.value;
		}
	}
}
