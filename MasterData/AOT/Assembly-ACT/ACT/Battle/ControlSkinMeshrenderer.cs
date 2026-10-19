using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class ControlSkinMeshrenderer : AniPart
{
	public enum ActivePartType
	{
		OnForwardPlayStartEnable,
		OnForwardPlayStartDisable
	}

	public ActivePartType activePartType;

	protected override bool UsesMaterialPropertyBlock => false;

	public override void OnForwardPlayStart(Entity entity)
	{
		bool enabled = true;
		switch (activePartType)
		{
		case ActivePartType.OnForwardPlayStartEnable:
			enabled = true;
			break;
		case ActivePartType.OnForwardPlayStartDisable:
			enabled = false;
			break;
		}
		Renderer[] array = renders;
		foreach (Renderer renderer in array)
		{
			if (renderer != null)
			{
				renderer.enabled = enabled;
			}
		}
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		bool enabled = true;
		switch (activePartType)
		{
		case ActivePartType.OnForwardPlayStartEnable:
			enabled = false;
			break;
		case ActivePartType.OnForwardPlayStartDisable:
			enabled = true;
			break;
		}
		Renderer[] array = renders;
		foreach (Renderer renderer in array)
		{
			if (renderer != null)
			{
				renderer.enabled = enabled;
			}
		}
	}
}
