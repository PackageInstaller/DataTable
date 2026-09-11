using System;
using UnityEngine;

public class CharPreviewSetting : MonoBehaviour
{
	[SerializeField]
	private int[] CharacterIdArray;

	[SerializeField]
	private GameObject[] CharacterModelArray;

	private Action validataHandler;

	public int[] GetCharacterList()
	{
		return CharacterIdArray;
	}

	public GameObject[] GetCharacterModelList()
	{
		return CharacterModelArray;
	}

	public void RegisterValidataHandler(Action handler)
	{
		validataHandler = handler;
	}

	public void Refresh()
	{
		if (validataHandler != null)
		{
			validataHandler();
		}
	}

	public static string[] GetCharacterAnimationList(Animator animator)
	{
		return null;
	}

	public static string[] GetCharacterAnimationClipList(Animator animator)
	{
		return null;
	}

	public static string[] GetCharacterTimelineList(string tposeName)
	{
		return null;
	}

	public static string[] GetCharacterTimelineWithAssetNameList(string tposeName, out string[] nameArray)
	{
		nameArray = null;
		return null;
	}

	public static GameObject EditorTryLoadAsset(string title)
	{
		return EditorTryLoadAsset(title, Application.dataPath);
	}

	public static GameObject EditorTryLoadAsset(string title, string dir)
	{
		return null;
	}
}
