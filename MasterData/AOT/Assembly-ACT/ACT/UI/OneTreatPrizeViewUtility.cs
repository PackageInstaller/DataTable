using System;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

internal static class OneTreatPrizeViewUtility
{
	public static int GetTierImageId(string tier)
	{
		if (string.Equals(tier, "S", StringComparison.OrdinalIgnoreCase))
		{
			return 1;
		}
		if (string.Equals(tier, "A", StringComparison.OrdinalIgnoreCase))
		{
			return 2;
		}
		if (string.Equals(tier, "B", StringComparison.OrdinalIgnoreCase))
		{
			return 3;
		}
		if (string.Equals(tier, "C", StringComparison.OrdinalIgnoreCase))
		{
			return 4;
		}
		if (string.Equals(tier, "D", StringComparison.OrdinalIgnoreCase))
		{
			return 5;
		}
		if (string.Equals(tier, "E", StringComparison.OrdinalIgnoreCase))
		{
			return 6;
		}
		return 0;
	}

	public static Image FindChildImage(GameObject root, string childName)
	{
		if (root == null || string.IsNullOrEmpty(childName))
		{
			return null;
		}
		Transform[] componentsInChildren = root.GetComponentsInChildren<Transform>(includeInactive: true);
		foreach (Transform transform in componentsInChildren)
		{
			if (transform != null && transform.name == childName)
			{
				return transform.GetComponent<Image>();
			}
		}
		return null;
	}

	public static BImage CreateImageTarget(Image image)
	{
		if (image == null)
		{
			return null;
		}
		image.preserveAspect = true;
		return new BImage
		{
			icon = image
		};
	}

	public static bool LoadTierIcon(string tier, ImageAssetStation station, BImage image)
	{
		int tierImageId = GetTierImageId(tier);
		if (image == null || image.icon == null || station == null || tierImageId <= 0)
		{
			if (image?.icon != null)
			{
				image.icon.sprite = null;
			}
			return false;
		}
		image.icon.sprite = null;
		station.LoadImage(245, tierImageId, image);
		return true;
	}

	public static void SetActiveIfChanged(GameObject target, bool active)
	{
		if (target != null && target.activeSelf != active)
		{
			target.SetActive(active);
		}
	}
}
