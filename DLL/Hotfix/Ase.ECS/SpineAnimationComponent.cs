using System;
using GameFramework;
using GameFramework.Runtime;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("播放Spine动画", 0)]
[Category("✫ Spine")]
[Description("播放Spine动画")]
public class SpineAnimationComponent : BaseComponent
{
	private SpineAnimationEvent animationEvent;

	public AsyncResult PlayAnimation(string animation, bool loop = false)
	{
		SpineData spineData = ReferencePool.Acquire<SpineData>();
		spineData.animName = animation;
		spineData.loop = loop;
		animationEvent(spineData);
		return spineData.AsyncResult;
	}

	public void RegisterEvent(SpineAnimationEvent animEvent)
	{
		animationEvent = (SpineAnimationEvent)Delegate.Combine(animationEvent, animEvent);
	}

	public void UnRegisterEvent(SpineAnimationEvent animEvent)
	{
		animationEvent = (SpineAnimationEvent)Delegate.Remove(animationEvent, animEvent);
	}
}
