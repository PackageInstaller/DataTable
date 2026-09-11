using System.Collections.Generic;

namespace Capture.Runtime;

public static class ComponnetChunk
{
	public static int TransformChunk = 1 << ComponentConst.TransformComponentType;

	public static int OBBChunk = TransformChunk | (1 << ComponentConst.OBBComponentType);

	public static int OcculusionChunk = OBBChunk | (1 << ComponentConst.OcclusionComponentType);

	public static int OccluderChunk = OBBChunk | (1 << ComponentConst.OccluderComponentType);

	public static List<ComponentChunkEnum> QueryChunks = new List<ComponentChunkEnum>
	{
		ComponentChunkEnum.OBBChunk,
		ComponentChunkEnum.OcculusionChunk,
		ComponentChunkEnum.OccluderChunk,
		ComponentChunkEnum.TransformChunk
	};

	public static int GetChunkTemplate(ComponentChunkEnum chunkEnum)
	{
		return chunkEnum switch
		{
			ComponentChunkEnum.OBBChunk => OBBChunk, 
			ComponentChunkEnum.OccluderChunk => OccluderChunk, 
			ComponentChunkEnum.OcculusionChunk => OcculusionChunk, 
			ComponentChunkEnum.TransformChunk => TransformChunk, 
			_ => 0, 
		};
	}
}
