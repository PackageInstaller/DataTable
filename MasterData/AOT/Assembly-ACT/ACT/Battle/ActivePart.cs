using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class ActivePart : AniPart
{
	public enum ActivePartType
	{
		OnForwardPlayStartEnable,
		OnForwardPlayStartDisable
	}

	public ActivePartType activePartType;

	public GameObject[] parts;

	protected override bool UsesMaterialPropertyBlock => false;

	public override void OnForwardPlayStart(Entity entity)
	{
		bool active = true;
		switch (activePartType)
		{
		case ActivePartType.OnForwardPlayStartEnable:
			active = true;
			break;
		case ActivePartType.OnForwardPlayStartDisable:
			active = false;
			break;
		}
		if (parts == null)
		{
			return;
		}
		GameObject[] array = parts;
		foreach (GameObject gameObject in array)
		{
			if (gameObject != null)
			{
				gameObject.SetActive(active);
			}
		}
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		bool active = true;
		switch (activePartType)
		{
		case ActivePartType.OnForwardPlayStartEnable:
			active = false;
			break;
		case ActivePartType.OnForwardPlayStartDisable:
			active = true;
			break;
		}
		if (parts == null)
		{
			return;
		}
		GameObject[] array = parts;
		foreach (GameObject gameObject in array)
		{
			if (gameObject != null)
			{
				gameObject.SetActive(active);
			}
		}
	}
}
