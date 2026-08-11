using Unity.Jobs.LowLevel.Unsafe;

namespace UnityEngine.Jobs;

[JobProducerType(typeof(IJobParallelForTransformExtensions.TransformParallelForLoopStruct<>))]
public interface IJobParallelForTransform
{
	void Execute(int index, TransformAccess transform);
}
