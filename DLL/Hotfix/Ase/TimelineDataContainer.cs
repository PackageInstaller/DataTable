using System;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

[RequireComponent(typeof(CustomSignalReceiver))]
public class TimelineDataContainer : SerializedMonoBehaviour
{
	public GameObject[] PlayerCharacterModels = new GameObject[2];

	public event EventHandler OnEndSrory;

	public void Init()
	{
		int characterIndex = StoryUtility.GetCharacterIndex();
		for (int i = 0; i < PlayerCharacterModels.Length; i++)
		{
			if (PlayerCharacterModels[i] != null)
			{
				PlayerCharacterModels[i].SetActive(i == characterIndex);
			}
		}
	}

	public void EndStory()
	{
		if (OnEndSrory != null)
		{
			OnEndSrory(this, null);
		}
	}

	private void OnDestroy()
	{
		OnEndSrory = null;
	}

	protected override void OnBeforeSerialize()
	{
	}
}
