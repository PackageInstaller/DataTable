namespace UnityEngine.Rendering.Universal.Internal;

internal static class CharacterOutlineStencil
{
	internal const int PureGreaterReference = 37;

	internal const byte RelationReadMask = 3;

	internal const byte OutlineMaterialWriteMask = 100;

	internal static RenderStateBlock CreatePureGreaterGBufferOverride()
	{
		StencilState stencilState = new StencilState(enabled: true, 3, 100, CompareFunction.Greater, StencilOp.Replace);
		RenderStateBlock result = new RenderStateBlock(RenderStateMask.Stencil);
		result.stencilReference = 37;
		result.stencilState = stencilState;
		return result;
	}
}
