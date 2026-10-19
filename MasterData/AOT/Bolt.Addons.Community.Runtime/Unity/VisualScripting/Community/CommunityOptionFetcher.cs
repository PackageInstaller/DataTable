using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.CommunityOptionFetcher")]
public static class CommunityOptionFetcher
{
	private static object lockObject;

	public static bool DefinedEvent_ForceOptimizedInEditor { get; }

	public static bool DefinedEvent_RestrictEventTypes { get; }

	public static bool SilenceLogMessages { get; }

	static CommunityOptionFetcher()
	{
		lockObject = new object();
		DefinedEvent_ForceOptimizedInEditor = false;
		DefinedEvent_RestrictEventTypes = true;
		SilenceLogMessages = false;
		lock (lockObject)
		{
			Type type = typeof(CommunityOptions);
			List<Type> source = (from p in AppDomain.CurrentDomain.GetAssemblies().SelectMany((Assembly s) => s.GetTypes())
				where type.IsAssignableFrom(p) && p.Assembly != type.Assembly
				select p).ToList();
			if (Enumerable.Count(source) > 1)
			{
				Debug.LogError("Multiple Community Options scripts found.");
			}
			else if (Enumerable.Count(source) == 1)
			{
				CommunityOptions communityOptions = (CommunityOptions)Activator.CreateInstance(source.First());
				DefinedEvent_ForceOptimizedInEditor = communityOptions.DefinedEvent_ForceOptimizedInEditor;
				DefinedEvent_RestrictEventTypes = communityOptions.DefinedEvent_RestrictEventTypes;
				SilenceLogMessages = communityOptions.SilenceLogMessages;
				if (!SilenceLogMessages)
				{
					Debug.Log("Custom Community Options script found.");
					LogOptionsSelected();
				}
			}
			else
			{
				Debug.Log("No Community Options script found; using defaults");
			}
		}
	}

	private static void LogOptionsSelected()
	{
		Debug.Log($"Defined Events optimized in editor: {FormatBool(DefinedEvent_ForceOptimizedInEditor)}");
		Debug.Log($"Defined Events restrict type to interface implementors: {FormatBool(DefinedEvent_RestrictEventTypes)}");
	}

	private static object FormatBool(bool input)
	{
		if (!input)
		{
			return "False";
		}
		return "True";
	}
}
