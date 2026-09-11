using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

[JobProducerType(typeof(IJobForExtensions.ForJobStruct<>))]
public interface IJobFor
{
	void Execute(int index);
}
