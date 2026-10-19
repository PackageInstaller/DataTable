using System;
using System.Collections.Generic;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[Serializable]
[AssetFileNameExtension("playable", new string[] { })]
[RequiredByNativeCode]
public abstract class PlayableAsset : ScriptableObject, IPlayableAsset
{
	public virtual double duration => PlayableBinding.DefaultDuration;

	public virtual IEnumerable<PlayableBinding> outputs => PlayableBinding.None;

	public abstract Playable CreatePlayable(PlayableGraph graph, GameObject owner);

	[RequiredByNativeCode]
	internal unsafe static void Internal_CreatePlayable(PlayableAsset asset, PlayableGraph graph, GameObject go, IntPtr ptr)
	{
		Playable playable = ((!(asset == null)) ? asset.CreatePlayable(graph, go) : Playable.Null);
		Playable* ptr2 = (Playable*)ptr.ToPointer();
		*ptr2 = playable;
	}

	[RequiredByNativeCode]
	internal unsafe static void Internal_GetPlayableAssetDuration(PlayableAsset asset, IntPtr ptrToDouble)
	{
		double num = asset.duration;
		double* ptr = (double*)ptrToDouble.ToPointer();
		*ptr = num;
	}
}
