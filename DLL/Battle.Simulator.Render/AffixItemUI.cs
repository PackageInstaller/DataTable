using UnityEngine;
using UnityEngine.UI;

public class AffixItemUI : MonoBehaviour
{
	private Image Icon;

	private Text Name;

	private Text Level;

	private string descStr;

	private int descIndex;

	private int descLevel;

	private bool hasDesc;

	private void Awake()
	{
		Icon = GetComponent<Image>();
		Name = base.transform.Find("Name").GetComponent<Text>();
		Level = base.transform.Find("Level").GetComponent<Text>();
	}

	public void SetIcon(string icon)
	{
		Icon.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/BuffIcon/" + icon);
	}

	public void SetName(string name)
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager != null && (string.IsNullOrEmpty(worldStateManager.textLanguageSetting) || worldStateManager.textLanguageSetting == "zh_cn"))
		{
			Name.text = name;
		}
		else
		{
			Name.text = "";
		}
	}

	public void SetDesc(int index, int level)
	{
		if (index != descIndex || level != descLevel)
		{
			descIndex = index;
			descLevel = level;
			hasDesc = false;
		}
	}

	public string GetDesc()
	{
		if (hasDesc)
		{
			return descStr;
		}
		hasDesc = true;
		descStr = WorldStateManager.GetCfgDescription(descIndex, descLevel);
		return descStr;
	}

	public void SetLevel(int level)
	{
		Level.text = level.ToString();
	}

	public void SetActive(bool active)
	{
		base.gameObject.SetActive(active);
	}
}
