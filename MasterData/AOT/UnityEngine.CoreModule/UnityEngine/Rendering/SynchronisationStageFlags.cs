namespace UnityEngine.Rendering;

public enum SynchronisationStageFlags
{
	VertexProcessing = 1,
	PixelProcessing = 2,
	ComputeProcessing = 4,
	AllGPUOperations = 7
}
