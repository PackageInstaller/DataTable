using Config;
using UnityEngine;
using UnityEngine.UI;

public class AchievementTemplate : MonoBehaviour
{
	public Image icon;

	public Image[] icons;

	public Image coinicon;

	public Text text;

	public Text number;

	public void Init(int achievementID)
	{
		if (!ConfigHelper.GetInstance().TryGetConfig<battle_achievement>(achievementID, out var config))
		{
			Debug.LogError("没有对应成就配置 " + achievementID);
			return;
		}
		text.text = WorldStateManager.GetSystemTableI18N(config.Name);
		int num = config.Level - 1;
		for (int i = 0; i < icons.Length; i++)
		{
			icons[i].gameObject.SetActive(i == num);
		}
		number.text = config.Reward.ToString();
	}
}
