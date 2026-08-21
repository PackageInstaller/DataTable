using System;
using System.Collections.Generic;
using UnityEngine;

namespace Sirenix.Utilities;

public static class GUILayoutOptions
{
	internal enum GUILayoutOptionType
	{
		Width,
		Height,
		MinWidth,
		MaxHeight,
		MaxWidth,
		MinHeight,
		ExpandHeight,
		ExpandWidth
	}

	public sealed class GUILayoutOptionsInstance : IEquatable<GUILayoutOptionsInstance>
	{
		private float value;

		internal GUILayoutOptionsInstance Parent;

		internal GUILayoutOptionType GUILayoutOptionType;

		private GUILayoutOption[] GetCachedOptions()
		{
			if (!GUILayoutOptionsCache.TryGetValue(this, out var result))
			{
				return GUILayoutOptionsCache[Clone()] = CreateOptionsArary();
			}
			return result;
		}

		public static implicit operator GUILayoutOption[](GUILayoutOptionsInstance options)
		{
			return options.GetCachedOptions();
		}

		private GUILayoutOption[] CreateOptionsArary()
		{
			List<GUILayoutOption> list = new List<GUILayoutOption>();
			for (GUILayoutOptionsInstance gUILayoutOptionsInstance = this; gUILayoutOptionsInstance != null; gUILayoutOptionsInstance = gUILayoutOptionsInstance.Parent)
			{
				switch (gUILayoutOptionsInstance.GUILayoutOptionType)
				{
				case GUILayoutOptionType.Width:
					list.Add(GUILayout.Width(gUILayoutOptionsInstance.value));
					break;
				case GUILayoutOptionType.Height:
					list.Add(GUILayout.Height(gUILayoutOptionsInstance.value));
					break;
				case GUILayoutOptionType.MaxHeight:
					list.Add(GUILayout.MaxHeight(gUILayoutOptionsInstance.value));
					break;
				case GUILayoutOptionType.MaxWidth:
					list.Add(GUILayout.MaxWidth(gUILayoutOptionsInstance.value));
					break;
				case GUILayoutOptionType.MinHeight:
					list.Add(GUILayout.MinHeight(gUILayoutOptionsInstance.value));
					break;
				case GUILayoutOptionType.MinWidth:
					list.Add(GUILayout.MinWidth(gUILayoutOptionsInstance.value));
					break;
				case GUILayoutOptionType.ExpandHeight:
					list.Add(GUILayout.ExpandHeight(gUILayoutOptionsInstance.value > 0.2f));
					break;
				case GUILayoutOptionType.ExpandWidth:
					list.Add(GUILayout.ExpandWidth(gUILayoutOptionsInstance.value > 0.2f));
					break;
				}
			}
			return list.ToArray();
		}

		private GUILayoutOptionsInstance Clone()
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = null;
			gUILayoutOptionsInstance = new GUILayoutOptionsInstance
			{
				value = value,
				GUILayoutOptionType = GUILayoutOptionType
			};
			GUILayoutOptionsInstance gUILayoutOptionsInstance2 = gUILayoutOptionsInstance;
			GUILayoutOptionsInstance parent = Parent;
			while (parent != null)
			{
				gUILayoutOptionsInstance2.Parent = new GUILayoutOptionsInstance
				{
					value = parent.value,
					GUILayoutOptionType = parent.GUILayoutOptionType
				};
				parent = parent.Parent;
				gUILayoutOptionsInstance2 = gUILayoutOptionsInstance2.Parent;
			}
			return gUILayoutOptionsInstance;
		}

		internal GUILayoutOptionsInstance()
		{
		}

		public GUILayoutOptionsInstance Width(float width)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.Width, width);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance Height(float height)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.Height, height);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance MaxHeight(float height)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MaxHeight, height);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance MaxWidth(float width)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MaxWidth, width);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance MinHeight(float height)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MinHeight, height);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance MinWidth(float width)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MinWidth, width);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance ExpandHeight(bool expand = true)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.ExpandHeight, expand);
			return gUILayoutOptionsInstance;
		}

		public GUILayoutOptionsInstance ExpandWidth(bool expand = true)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
			gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.ExpandWidth, expand);
			return gUILayoutOptionsInstance;
		}

		internal void SetValue(GUILayoutOptionType type, float value)
		{
			GUILayoutOptionType = type;
			this.value = value;
		}

		internal void SetValue(GUILayoutOptionType type, bool value)
		{
			GUILayoutOptionType = type;
			this.value = (value ? 1 : 0);
		}

		public bool Equals(GUILayoutOptionsInstance other)
		{
			GUILayoutOptionsInstance gUILayoutOptionsInstance = this;
			GUILayoutOptionsInstance gUILayoutOptionsInstance2 = other;
			while (gUILayoutOptionsInstance != null && gUILayoutOptionsInstance2 != null)
			{
				if (gUILayoutOptionsInstance.GUILayoutOptionType != gUILayoutOptionsInstance2.GUILayoutOptionType || gUILayoutOptionsInstance.value != gUILayoutOptionsInstance2.value)
				{
					return false;
				}
				gUILayoutOptionsInstance = gUILayoutOptionsInstance.Parent;
				gUILayoutOptionsInstance2 = gUILayoutOptionsInstance2.Parent;
			}
			if (gUILayoutOptionsInstance2 != null || gUILayoutOptionsInstance != null)
			{
				return false;
			}
			return true;
		}

		public override int GetHashCode()
		{
			int num = 0;
			int num2 = 17;
			for (GUILayoutOptionsInstance gUILayoutOptionsInstance = this; gUILayoutOptionsInstance != null; gUILayoutOptionsInstance = gUILayoutOptionsInstance.Parent)
			{
				num2 = num2 * 29 + GUILayoutOptionType.GetHashCode() + value.GetHashCode() * 17 + num++;
			}
			return num2;
		}
	}

	private static int CurrentCacheIndex;

	private static readonly GUILayoutOptionsInstance[] GUILayoutOptionsInstanceCache;

	private static readonly Dictionary<GUILayoutOptionsInstance, GUILayoutOption[]> GUILayoutOptionsCache;

	public static readonly GUILayoutOption[] EmptyGUIOptions;

	static GUILayoutOptions()
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsCache = new Dictionary<GUILayoutOptionsInstance, GUILayoutOption[]>();
		EmptyGUIOptions = (GUILayoutOption[])(object)new GUILayoutOption[0];
		GUILayoutOptionsInstanceCache = new GUILayoutOptionsInstance[30];
		GUILayoutOptionsInstanceCache[0] = new GUILayoutOptionsInstance();
		for (int i = 1; i < 30; i++)
		{
			GUILayoutOptionsInstanceCache[i] = new GUILayoutOptionsInstance();
			GUILayoutOptionsInstanceCache[i].Parent = GUILayoutOptionsInstanceCache[i - 1];
		}
	}

	public static GUILayoutOptionsInstance Width(float width)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.Width, width);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance Height(float height)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.Height, height);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance MaxHeight(float height)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MaxHeight, height);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance MaxWidth(float width)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MaxWidth, width);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance MinWidth(float width)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MinWidth, width);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance MinHeight(float height)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.MinHeight, height);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance ExpandHeight(bool expand = true)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.ExpandHeight, expand);
		return gUILayoutOptionsInstance;
	}

	public static GUILayoutOptionsInstance ExpandWidth(bool expand = true)
	{
		CurrentCacheIndex = 0;
		GUILayoutOptionsInstance gUILayoutOptionsInstance = GUILayoutOptionsInstanceCache[CurrentCacheIndex++];
		gUILayoutOptionsInstance.SetValue(GUILayoutOptionType.ExpandWidth, expand);
		return gUILayoutOptionsInstance;
	}
}
