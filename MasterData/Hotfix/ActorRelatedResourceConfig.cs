using UnityEngine;

[CreateAssetMenu(fileName = "RelatedResource", menuName = "游戏/角色/角色关联资源配置")]
public class ActorRelatedResourceConfig : ScriptableObject
{
	public CommonResourceConfig[] timelines;

	public CommonResourceConfig[] monsterTimelines;

	public FeedbackEffectConfigureData[] feedbackEffectConfigureDatas;

	public CommonResourceConfig[] fxs;

	public CommonResourceConfig[] areaEffects;

	public CommonResourceConfig[] drops;

	public CommonResourceConfig[] bullets;

	public SummonConfig[] summons;

	public GameObject GetTimelineByAlias(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (timelines == null || timelines.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < timelines.Length; i++)
		{
			CommonResourceConfig commonResourceConfig = timelines[i];
			if (commonResourceConfig.alias == alias)
			{
				if (!(commonResourceConfig.overridePrefab != null))
				{
					return commonResourceConfig.prefab;
				}
				return commonResourceConfig.overridePrefab;
			}
		}
		return null;
	}

	public GameObject GetMonsterTimelineByAlias(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (monsterTimelines == null || monsterTimelines.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < monsterTimelines.Length; i++)
		{
			CommonResourceConfig commonResourceConfig = monsterTimelines[i];
			if (commonResourceConfig.alias == alias)
			{
				if (!(commonResourceConfig.overridePrefab != null))
				{
					return commonResourceConfig.prefab;
				}
				return commonResourceConfig.overridePrefab;
			}
		}
		return null;
	}

	public GameObject GetFXByAlias(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (fxs == null || fxs.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < fxs.Length; i++)
		{
			CommonResourceConfig commonResourceConfig = fxs[i];
			if (commonResourceConfig.alias == alias)
			{
				if (!(commonResourceConfig.overridePrefab != null))
				{
					return commonResourceConfig.prefab;
				}
				return commonResourceConfig.overridePrefab;
			}
		}
		return null;
	}

	public GameObject GetAreaEffectByAlias(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (areaEffects == null || areaEffects.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < areaEffects.Length; i++)
		{
			CommonResourceConfig commonResourceConfig = areaEffects[i];
			if (commonResourceConfig.alias == alias)
			{
				if (!(commonResourceConfig.overridePrefab != null))
				{
					return commonResourceConfig.prefab;
				}
				return commonResourceConfig.overridePrefab;
			}
		}
		return null;
	}

	public GameObject GetDropByAlias(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (drops == null || drops.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < drops.Length; i++)
		{
			CommonResourceConfig commonResourceConfig = drops[i];
			if (commonResourceConfig.alias == alias)
			{
				if (!(commonResourceConfig.overridePrefab != null))
				{
					return commonResourceConfig.prefab;
				}
				return commonResourceConfig.overridePrefab;
			}
		}
		return null;
	}

	public GameObject GetBulletByAlias(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (bullets == null || bullets.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < bullets.Length; i++)
		{
			CommonResourceConfig commonResourceConfig = bullets[i];
			if (commonResourceConfig.alias == alias)
			{
				if (!(commonResourceConfig.overridePrefab != null))
				{
					return commonResourceConfig.prefab;
				}
				return commonResourceConfig.overridePrefab;
			}
		}
		return null;
	}

	public AdventurePlayerFeedbackEffectConfigureData GetFeedbackEffectConfigureData(string alias)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		if (feedbackEffectConfigureDatas == null || feedbackEffectConfigureDatas.Length == 0)
		{
			return null;
		}
		for (int i = 0; i < feedbackEffectConfigureDatas.Length; i++)
		{
			FeedbackEffectConfigureData feedbackEffectConfigureData = feedbackEffectConfigureDatas[i];
			if (string.Equals(feedbackEffectConfigureData.alias, alias))
			{
				return feedbackEffectConfigureData.configureData;
			}
		}
		return null;
	}
}
