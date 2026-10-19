using System;
using System.Runtime.CompilerServices;
using Unity.Jobs;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Director/AnimationStream.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimatorJobExtensions.bindings.h")]
[NativeHeader("Modules/Animation/Director/AnimationSceneHandles.h")]
[NativeHeader("Modules/Animation/Animator.h")]
[NativeHeader("Modules/Animation/Director/AnimationStreamHandles.h")]
[StaticAccessor("AnimatorJobExtensionsBindings", StaticAccessorType.DoubleColon)]
[MovedFrom("UnityEngine.Experimental.Animations")]
public static class AnimatorJobExtensions
{
	public static void AddJobDependency(this Animator animator, JobHandle jobHandle)
	{
		InternalAddJobDependency(animator, jobHandle);
	}

	public static TransformStreamHandle BindStreamTransform(this Animator animator, Transform transform)
	{
		TransformStreamHandle transformStreamHandle = default;
		InternalBindStreamTransform(animator, transform, out transformStreamHandle);
		return transformStreamHandle;
	}

	public static PropertyStreamHandle BindStreamProperty(this Animator animator, Transform transform, Type type, string property)
	{
		return animator.BindStreamProperty(transform, type, property, isObjectReference: false);
	}

	public static PropertyStreamHandle BindCustomStreamProperty(this Animator animator, string property, CustomStreamPropertyType type)
	{
		PropertyStreamHandle propertyStreamHandle = default;
		InternalBindCustomStreamProperty(animator, property, type, out propertyStreamHandle);
		return propertyStreamHandle;
	}

	public static PropertyStreamHandle BindStreamProperty(this Animator animator, Transform transform, Type type, string property, [DefaultValue("false")] bool isObjectReference)
	{
		PropertyStreamHandle propertyStreamHandle = default;
		InternalBindStreamProperty(animator, transform, type, property, isObjectReference, out propertyStreamHandle);
		return propertyStreamHandle;
	}

	public static TransformSceneHandle BindSceneTransform(this Animator animator, Transform transform)
	{
		TransformSceneHandle transformSceneHandle = default;
		InternalBindSceneTransform(animator, transform, out transformSceneHandle);
		return transformSceneHandle;
	}

	public static PropertySceneHandle BindSceneProperty(this Animator animator, Transform transform, Type type, string property)
	{
		return animator.BindSceneProperty(transform, type, property, isObjectReference: false);
	}

	public static PropertySceneHandle BindSceneProperty(this Animator animator, Transform transform, Type type, string property, [DefaultValue("false")] bool isObjectReference)
	{
		PropertySceneHandle propertySceneHandle = default;
		InternalBindSceneProperty(animator, transform, type, property, isObjectReference, out propertySceneHandle);
		return propertySceneHandle;
	}

	public static bool OpenAnimationStream(this Animator animator, ref AnimationStream stream)
	{
		return InternalOpenAnimationStream(animator, ref stream);
	}

	public static void CloseAnimationStream(this Animator animator, ref AnimationStream stream)
	{
		InternalCloseAnimationStream(animator, ref stream);
	}

	public static void ResolveAllStreamHandles(this Animator animator)
	{
		InternalResolveAllStreamHandles(animator);
	}

	public static void ResolveAllSceneHandles(this Animator animator)
	{
		InternalResolveAllSceneHandles(animator);
	}

	internal static void UnbindAllHandles(this Animator animator)
	{
		InternalUnbindAllStreamHandles(animator);
		InternalUnbindAllSceneHandles(animator);
	}

	public static void UnbindAllStreamHandles(this Animator animator)
	{
		InternalUnbindAllStreamHandles(animator);
	}

	public static void UnbindAllSceneHandles(this Animator animator)
	{
		InternalUnbindAllSceneHandles(animator);
	}

	private static void InternalAddJobDependency([NotNull("ArgumentNullException")] Animator animator, JobHandle jobHandle)
	{
		InternalAddJobDependency_Injected(animator, ref jobHandle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalBindStreamTransform([NotNull("ArgumentNullException")] Animator animator, [NotNull("ArgumentNullException")] Transform transform, out TransformStreamHandle transformStreamHandle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalBindStreamProperty([NotNull("ArgumentNullException")] Animator animator, [NotNull("ArgumentNullException")] Transform transform, [NotNull("ArgumentNullException")] Type type, [NotNull("ArgumentNullException")] string property, bool isObjectReference, out PropertyStreamHandle propertyStreamHandle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalBindCustomStreamProperty([NotNull("ArgumentNullException")] Animator animator, [NotNull("ArgumentNullException")] string property, CustomStreamPropertyType propertyType, out PropertyStreamHandle propertyStreamHandle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalBindSceneTransform([NotNull("ArgumentNullException")] Animator animator, [NotNull("ArgumentNullException")] Transform transform, out TransformSceneHandle transformSceneHandle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalBindSceneProperty([NotNull("ArgumentNullException")] Animator animator, [NotNull("ArgumentNullException")] Transform transform, [NotNull("ArgumentNullException")] Type type, [NotNull("ArgumentNullException")] string property, bool isObjectReference, out PropertySceneHandle propertySceneHandle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool InternalOpenAnimationStream([NotNull("ArgumentNullException")] Animator animator, ref AnimationStream stream);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalCloseAnimationStream([NotNull("ArgumentNullException")] Animator animator, ref AnimationStream stream);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalResolveAllStreamHandles([NotNull("ArgumentNullException")] Animator animator);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalResolveAllSceneHandles([NotNull("ArgumentNullException")] Animator animator);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalUnbindAllStreamHandles([NotNull("ArgumentNullException")] Animator animator);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalUnbindAllSceneHandles([NotNull("ArgumentNullException")] Animator animator);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InternalAddJobDependency_Injected(Animator animator, ref JobHandle jobHandle);
}
