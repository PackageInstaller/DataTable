using ACT.Model;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldLevelItem : MonoBehaviour
{
	[SerializeField]
	private Image _normal;

	[SerializeField]
	private Image achievementIcon;

	[SerializeField]
	private Image greenLightIcon;

	[SerializeField]
	private TextMeshProUGUI _playerLevel;

	[SerializeField]
	private Image _worldLevelImage;

	[SerializeField]
	private Image _lockIcon;

	[SerializeField]
	private Image _completeIcon;

	[SerializeField]
	private RedDotItem _redDotItem;

	[SerializeField]
	private RectTransform _effectRT;

	public void SetActive(bool active, bool isWorldLevelBreakType)
	{
		_worldLevelImage.gameObject.SetActive(isWorldLevelBreakType);
	}

	public void SetPlayerLevel(string level, bool isWorldLevelBreakType)
	{
		if (isWorldLevelBreakType)
		{
			_playerLevel.text = "";
		}
		else
		{
			_playerLevel.text = level;
		}
	}

	public void RefreshCompleteAndLockIcon(bool itemCollected, bool isWorldLevelBreakType, bool canReceiveAward)
	{
		if (isWorldLevelBreakType)
		{
			greenLightIcon.gameObject.SetActive(value: false);
			_effectRT.gameObject.SetActive(value: false);
			if (canReceiveAward && !itemCollected)
			{
				_lockIcon.gameObject.SetActive(value: false);
				_completeIcon.gameObject.SetActive(value: false);
				achievementIcon.gameObject.SetActive(value: true);
				greenLightIcon.gameObject.SetActive(value: true);
				_effectRT.gameObject.SetActive(value: true);
			}
			else if (itemCollected)
			{
				_lockIcon.gameObject.SetActive(value: false);
				_completeIcon.gameObject.SetActive(value: true);
				achievementIcon.gameObject.SetActive(value: true);
			}
			else
			{
				_lockIcon.gameObject.SetActive(value: true);
				_completeIcon.gameObject.SetActive(value: false);
				achievementIcon.gameObject.SetActive(value: false);
			}
			return;
		}
		ColorUtility.TryParseHtmlString((canReceiveAward | itemCollected) ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.White) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.Dark), out var color);
		_playerLevel.color = color;
		_lockIcon.gameObject.SetActive(value: false);
		greenLightIcon.gameObject.SetActive(value: false);
		_effectRT.gameObject.SetActive(value: false);
		if (canReceiveAward && !itemCollected)
		{
			_completeIcon.gameObject.SetActive(value: false);
			achievementIcon.gameObject.SetActive(value: true);
			greenLightIcon.gameObject.SetActive(value: true);
			_effectRT.gameObject.SetActive(value: true);
		}
		else if (itemCollected)
		{
			_completeIcon.gameObject.SetActive(value: true);
			achievementIcon.gameObject.SetActive(value: true);
		}
		else if (!canReceiveAward && !itemCollected)
		{
			_completeIcon.gameObject.SetActive(value: false);
			achievementIcon.gameObject.SetActive(value: false);
		}
	}

	public void RefreshRedDotItem(bool active)
	{
		_redDotItem.dot.gameObject.SetActive(active);
	}
}
