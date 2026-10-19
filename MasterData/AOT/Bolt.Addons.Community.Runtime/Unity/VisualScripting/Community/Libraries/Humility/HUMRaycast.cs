using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMRaycast
{
	public static class Data
	{
		public struct Find(Vector3 origin)
		{
			public Vector3 origin = origin;
		}

		public struct With(Vector3 origin)
		{
			public Vector3 origin = origin;
		}

		public struct Multiple(Vector3 origin)
		{
			public Vector3 origin = origin;
		}

		public struct Is(Vector3 origin)
		{
			public Vector3 origin = origin;
		}

		public struct Touching(Vector3 origin)
		{
			public Vector3 origin = origin;
		}
	}

	public static Data.Is Is(this Vector3 origin)
	{
		return new Data.Is(origin);
	}

	public static Data.Find Find(this Vector3 origin)
	{
		return new Data.Find(origin);
	}
}
