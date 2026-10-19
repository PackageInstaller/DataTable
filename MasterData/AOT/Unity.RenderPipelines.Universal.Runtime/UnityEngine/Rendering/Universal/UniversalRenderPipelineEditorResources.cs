using System;

namespace UnityEngine.Rendering.Universal;

public class UniversalRenderPipelineEditorResources : ScriptableObject
{
	[Serializable]
	[ReloadGroup]
	public sealed class MaterialResources
	{
		[Reload("Runtime/Materials/Lit.mat", ReloadAttribute.Package.Root)]
		public Material lit;

		[Reload("Runtime/Materials/ParticlesLit.mat", ReloadAttribute.Package.Root)]
		public Material particleLit;

		[Reload("Runtime/Materials/Decal.mat", ReloadAttribute.Package.Root)]
		public Material decal;
	}

	public MaterialResources materials;
}
