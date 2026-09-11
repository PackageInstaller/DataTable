using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

[JobProducerType(typeof(IJobExtensions.JobStruct<>))]
public interface IJob
{
	void Execute();
}
