using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMAssets
{
	public static class Data
	{
		public struct GameObjectIs(GameObject gameObject)
		{
			public GameObject gameObject = gameObject;
		}

		public struct ComponentListTo<T>(IEnumerable<T> components) where T : MonoBehaviour
		{
			public IEnumerable<T> components = components;
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Find
		{
		}

		public struct FindType(Type type)
		{
			public Type type = type;
		}

		public struct All(Find find)
		{
			public Find find = find;
		}

		public struct FindTypeAll(FindType find)
		{
			public FindType find = find;
		}

		public struct FindUsingType(Type type)
		{
			public Type type = type;
		}

		public struct AssetsUsingType(FindUsingType find)
		{
			public FindUsingType find = find;
		}

		public struct Assets(Find find)
		{
			public Find find = find;
		}

		public struct FindTypeOfAssets(FindType find)
		{
			public FindType find = find;
		}

		public struct AssetsWith(Assets assets)
		{
			public Assets assets = assets;
		}

		public struct AssetsWithUsingType(AssetsUsingType assets)
		{
			public AssetsUsingType assets = assets;
		}

		public struct PrefabsUsingType(FindUsingType find)
		{
			public FindUsingType find = find;
		}

		public struct Prefabs(Find find)
		{
			public Find find = find;
		}

		public struct BehavioursUsingType(FindUsingType find)
		{
			public FindUsingType find = find;
		}

		public struct Behaviours(Find find)
		{
			public Find find = find;
		}
	}
}
