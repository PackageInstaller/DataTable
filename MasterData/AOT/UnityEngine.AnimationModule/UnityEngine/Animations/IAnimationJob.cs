using Unity.Jobs.LowLevel.Unsafe;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[MovedFrom("UnityEngine.Experimental.Animations")]
[JobProducerType(typeof(ProcessAnimationJobStruct<>))]
public interface IAnimationJob
{
	void ProcessAnimation(AnimationStream stream);

	void ProcessRootMotion(AnimationStream stream);
}
