using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Unity.VisualScripting.Community.Utility;

[RenamedFrom("Bolt.Addons.Community.Utility.EditorState")]
public static class EditorState
{
	private static object lockObject;

	public static IEditorStateFetcher Fetcher { get; set; }

	static EditorState()
	{
		lockObject = new object();
		lock (lockObject)
		{
			Type type = typeof(IEditorStateFetcher);
			List<Type> source = (from p in AppDomain.CurrentDomain.GetAssemblies().SelectMany((Assembly s) => s.GetTypes())
				where type.IsAssignableFrom(p) && p.Assembly != type.Assembly
				select p).ToList();
			if (Enumerable.Count(source) == 1)
			{
				Fetcher = (IEditorStateFetcher)Activator.CreateInstance(source.First());
			}
		}
	}

	public static bool IsEditorPaused()
	{
		if (Fetcher != null)
		{
			return Fetcher.IsEditorPaused();
		}
		return false;
	}
}
