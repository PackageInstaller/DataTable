using UnityEngine;

namespace Unity.VisualScripting;

public static class ApplicationVariables
{
	public const string assetPath = "ApplicationVariables";

	private static VariablesAsset _asset;

	public static VariablesAsset asset
	{
		get
		{
			if (_asset == null)
			{
				Load();
			}
			return _asset;
		}
	}

	public static VariableDeclarations runtime { get; private set; }

	public static VariableDeclarations initial => asset.declarations;

	public static VariableDeclarations current
	{
		get
		{
			if (!Application.isPlaying)
			{
				return initial;
			}
			return runtime;
		}
	}

	public static void Load()
	{
		_asset = Resources.Load<VariablesAsset>("ApplicationVariables") ?? ScriptableObject.CreateInstance<VariablesAsset>();
	}

	public static void OnEnterEditMode()
	{
		DestroyRuntimeDeclarations();
	}

	public static void OnExitEditMode()
	{
	}

	internal static void OnEnterPlayMode()
	{
		CreateRuntimeDeclarations();
	}

	internal static void OnExitPlayMode()
	{
	}

	private static void CreateRuntimeDeclarations()
	{
		runtime = asset.declarations.CloneViaFakeSerialization();
	}

	private static void DestroyRuntimeDeclarations()
	{
		runtime = null;
	}
}
