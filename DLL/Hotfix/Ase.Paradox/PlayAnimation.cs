using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放动画", 0)]
[Category("✫ DragonLost/Animator")]
[Description("播放Animator动画.")]
public class PlayAnimation : ActionTaskBase
{
	[RequiredField]
	public BBParameter<string> animation;

	[Name("是否等待动画播完", 0)]
	public bool waitUntilFinish;

	[ShowIf("waitUntilFinish", 1)]
	[Name("动画总时长", 0)]
	public float animLength = 1f;

	[Name("是否开启动画融合", 0)]
	[Description("是否开启动画融合(变量描述)")]
	public bool isOpenAnimationBlend = true;

	[Name("动画过渡类型", 0)]
	[ShowIf("isOpenAnimationBlend", 1)]
	[Tooltip("动画过渡类型:\nNone:不过渡\nRatio:比例过渡\nTime:时间过渡")]
	public AnimationBlendType animationBlendType = AnimationBlendType.Time;

	[SliderField(0f, 1f)]
	[ShowIf("animationBlendType", 1)]
	[Name("混合时间比例", 0)]
	public BBParameter<float> normalizedTransitionDuration = 0.2f;

	[ShowIf("animationBlendType", 2)]
	[Name("混合时间值", 0)]
	public BBParameter<float> normalizedTransitionTime = 0.2f;

	[Name("动画层级", 0)]
	public BBParameter<int> animationLayer = -1;

	[SliderField(0f, 1f)]
	[Name("动画初始时间比例", 0)]
	public BBParameter<float> normalizedTimeOffset = 0f;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			OnActionFail();
			return;
		}
		AnimatorComponent component = ownerEntity.GetComponent<AnimatorComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		if (isOpenAnimationBlend)
		{
			switch (animationBlendType)
			{
			case AnimationBlendType.Ratio:
				component?.PlayCrossFadeAnimation(animation.value, animationLayer.value, normalizedTransitionDuration.value, normalizedTimeOffset.value);
				break;
			case AnimationBlendType.Time:
				component?.PlayCrossFadeAnimationFixedTime(animation.value, normalizedTransitionTime.value, animationLayer.value, normalizedTimeOffset.value);
				break;
			}
		}
		else
		{
			component?.PlayAnimation(animation.value, animationLayer.value, normalizedTimeOffset.value);
		}
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		if (waitUntilFinish && base.elapsedTime >= animLength)
		{
			OnActionFinish();
		}
	}
}
