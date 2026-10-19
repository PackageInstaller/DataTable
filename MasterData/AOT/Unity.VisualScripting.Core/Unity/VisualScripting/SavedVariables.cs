using System;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

public static class SavedVariables
{
	public const string assetPath = "SavedVariables";

	public const string playerPrefsKey = "LudiqSavedVariables";

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

	public static VariableDeclarations initial => asset.declarations;

	public static VariableDeclarations saved { get; private set; }

	public static VariableDeclarations merged { get; private set; }

	public static VariableDeclarations current
	{
		get
		{
			if (!Application.isPlaying)
			{
				return initial;
			}
			return merged;
		}
	}

	public static void Load()
	{
		_asset = Resources.Load<VariablesAsset>("SavedVariables") ?? ScriptableObject.CreateInstance<VariablesAsset>();
	}

	public static void OnEnterEditMode()
	{
		FetchSavedDeclarations();
		DestroyMergedDeclarations();
	}

	public static void OnExitEditMode()
	{
		SaveDeclarations(saved);
	}

	internal static void OnEnterPlayMode()
	{
		FetchSavedDeclarations();
		MergeInitialAndSavedDeclarations();
		VariableDeclarations variableDeclarations = merged;
		variableDeclarations.OnVariableChanged = (Action)Delegate.Combine(variableDeclarations.OnVariableChanged, (Action)(() =>
		{
			if (VariablesSaver.instance == null)
			{
				VariablesSaver.Instantiate();
			}
		}));
	}

	internal static void OnExitPlayMode()
	{
		SaveDeclarations(merged);
	}

	public static void SaveDeclarations(VariableDeclarations declarations)
	{
		WarnAndNullifyUnityObjectReferences(declarations);
		try
		{
			SerializationData serializationData = declarations.Serialize();
			if (serializationData.objectReferences.Length != 0)
			{
				throw new InvalidOperationException("Cannot use Unity object variable references in saved variables.");
			}
			PlayerPrefs.SetString("LudiqSavedVariables", serializationData.json);
			PlayerPrefs.Save();
		}
		catch (Exception arg)
		{
			Debug.LogWarning($"Failed to save variables to player prefs: \n{arg}");
		}
	}

	public static void FetchSavedDeclarations()
	{
		if (PlayerPrefs.HasKey("LudiqSavedVariables"))
		{
			try
			{
				saved = (VariableDeclarations)new SerializationData(PlayerPrefs.GetString("LudiqSavedVariables")).Deserialize();
				return;
			}
			catch (Exception arg)
			{
				Debug.LogWarning($"Failed to fetch saved variables from player prefs: \n{arg}");
				saved = new VariableDeclarations();
				return;
			}
		}
		saved = new VariableDeclarations();
	}

	private static void MergeInitialAndSavedDeclarations()
	{
		merged = initial.CloneViaFakeSerialization();
		WarnAndNullifyUnityObjectReferences(merged);
		foreach (string item in saved.Select((VariableDeclaration vd) => vd.name))
		{
			if (!merged.IsDefined(item))
			{
				merged[item] = saved[item];
			}
			else if (merged[item] == null)
			{
				if (saved[item] == null || saved[item].GetType().IsNullable())
				{
					merged[item] = saved[item];
				}
				else
				{
					Debug.LogWarning("Cannot convert saved player pref '" + item + "' to null.\n");
				}
			}
			else if (saved[item].IsConvertibleTo(merged[item].GetType(), guaranteed: true))
			{
				merged[item] = saved[item];
			}
			else
			{
				Debug.LogWarning($"Cannot convert saved player pref '{item}' to expected type ({merged[item].GetType()}).\nReverting to initial value.");
			}
		}
	}

	private static void DestroyMergedDeclarations()
	{
		merged = null;
	}

	private static void WarnAndNullifyUnityObjectReferences(VariableDeclarations declarations)
	{
		Ensure.That("declarations").IsNotNull(declarations);
		foreach (VariableDeclaration declaration in declarations)
		{
			if (declaration.value is UnityEngine.Object)
			{
				Debug.LogWarning("Saved variable '" + declaration.name + "' refers to a Unity object. This is not supported. Its value will be null.");
				declarations[declaration.name] = null;
			}
		}
	}
}
