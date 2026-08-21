using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngineInternal;

namespace UnityEngine;

[NativeHeader("Runtime/Misc/ResourceManagerUtility.h")]
[NativeHeader("Runtime/Export/Resources/Resources.bindings.h")]
internal static class ResourcesAPIInternal
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Resources_Bindings::FindObjectsOfTypeAll")]
	[TypeInferenceRule(TypeInferenceRules.ArrayOfTypeReferencedByFirstArgument)]
	public static extern Object[] FindObjectsOfTypeAll(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetShaderNameRegistry().FindShader")]
	public static extern Shader FindShaderByName(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[TypeInferenceRule(TypeInferenceRules.TypeReferencedBySecondArgument)]
	[FreeFunction("Resources_Bindings::Load")]
	[NativeThrows]
	public static extern Object Load(string path, [NotNull("ArgumentNullException")] Type systemTypeInstance);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	[FreeFunction("Resources_Bindings::LoadAll")]
	public static extern Object[] LoadAll([NotNull("ArgumentNullException")] string path, [NotNull("ArgumentNullException")] Type systemTypeInstance);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Resources_Bindings::LoadAsyncInternal")]
	internal static extern ResourceRequest LoadAsyncInternal(string path, Type type);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Scripting::UnloadAssetFromScripting")]
	public static extern void UnloadAsset(Object assetToUnload);
}
