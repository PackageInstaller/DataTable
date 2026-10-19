using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

[JobProducerType(typeof(IJobParallelForExtensions.ParallelForJobStruct<>))]
public interface IJobParallelFor
{
	void Execute(int index);
}
