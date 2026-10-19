using System;
using System.Collections.Generic;
using System.Text;
using ACT.Config;
using ACT.Model;
using Bamboo.ImageCenter;
using Lumin.LoungeSystem.UI;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class FavorabilityProgressPreviewComponent : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI m_FavorabilityLevelText;

	[SerializeField]
	private LocalizeStringEvent m_FavorabilityNameText;

	[SerializeField]
	private TextMeshProUGUI m_FavorabilityValueText;

	[SerializeField]
	private Image m_CurrentProgressBar;

	[SerializeField]
	private Image m_PreviewProgressBar;

	private float m_CurrentFavorability;

	private float m_MaxFavorability = 400f;

	private float m_PreviewAddedFavorability;

	private int m_characterId = 10101;

	private int m_currFavorabilityLevel;

	private int m_currFavorabilitylocalNameId;

	private const string NormalColorTag = "#ffe7ed";

	private const string PreviewColorTag = "#ffea86";

	private static readonly Color NormalTextColor = new Color32(byte.MaxValue, 231, 237, byte.MaxValue);

	private readonly StringBuilder _favorabilityValueBuilder = new StringBuilder(64);

	public void InitFavorabilityUI(ImageAssetStation station)
	{
		m_characterId = LoungeUIScene.instance.PendingClickCharacterId;
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(m_characterId);
		(m_currFavorabilityLevel, _) = characterFavorInfo;
		if (m_FavorabilityLevelText != null)
		{
			m_FavorabilityLevelText.text = Model<FavorabilityModel>.Interface.ToTwoDigitString(m_currFavorabilityLevel) ?? "";
		}
		m_CurrentFavorability = Mathf.Floor(characterFavorInfo.Item2);
		m_MaxFavorability = Model<FavorabilityModel>.Interface.GetFavorabilityEachLv(m_currFavorabilityLevel, m_characterId);
		m_currFavorabilitylocalNameId = Model<FavorabilityModel>.Interface.GetFavorabilityName(m_currFavorabilityLevel);
		m_FavorabilityNameText.StringReference.TableEntryReference = m_currFavorabilitylocalNameId;
		m_PreviewAddedFavorability = 0f;
		UpdateFavorabilityUI(station);
	}

	public void SetSelectCount(int giftId, int count)
	{
		m_characterId = LoungeUIScene.instance.PendingClickCharacterId;
		float f = Model<FavorabilityModel>.Interface.CalculateGiftFavorability(giftId, m_characterId, Math.Abs(count));
		if (count > 0)
		{
			m_PreviewAddedFavorability += Mathf.Floor(f);
			return;
		}
		m_PreviewAddedFavorability -= Mathf.Floor(f);
		if (m_PreviewAddedFavorability < 0f)
		{
			m_PreviewAddedFavorability = 0f;
		}
	}

	public bool IsPreviewFavorabilityMaxReached()
	{
		m_characterId = LoungeUIScene.instance.PendingClickCharacterId;
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(m_characterId);
		List<FavorabilityLevel> favorabilityLevelConfigs = Model<FavorabilityModel>.Interface.GetFavorabilityLevelConfigs(m_characterId);
		if (favorabilityLevelConfigs == null || favorabilityLevelConfigs.Count == 0)
		{
			return false;
		}
		int num = 0;
		foreach (FavorabilityLevel item2 in favorabilityLevelConfigs)
		{
			if (item2.favorabilityLevel > num)
			{
				num = item2.favorabilityLevel;
			}
		}
		if (num <= 0)
		{
			return false;
		}
		(int, int) previewFavorabilityResult = Model<FavorabilityModel>.Interface.GetPreviewFavorabilityResult(m_characterId, characterFavorInfo.Item1, characterFavorInfo.Item2, m_PreviewAddedFavorability);
		if (previewFavorabilityResult.Item1 < num)
		{
			return false;
		}
		int item = Model<FavorabilityModel>.Interface.GetFavorabilityEachLvAndFavorabilityTotal(m_characterId, num).Item1;
		if (item <= 0)
		{
			return true;
		}
		return previewFavorabilityResult.Item2 >= item;
	}

	public bool IsCurrentPreviewAtCap()
	{
		m_characterId = LoungeUIScene.instance.PendingClickCharacterId;
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(m_characterId);
		int maxFavorabilityStage = Model<FavorabilityModel>.Interface.GetMaxFavorabilityStage();
		if (maxFavorabilityStage <= 0)
		{
			return false;
		}
		(int, int) favorabilityEachLvAndFavorabilityTotal = Model<FavorabilityModel>.Interface.GetFavorabilityEachLvAndFavorabilityTotal(m_characterId, characterFavorInfo.Item1);
		(int, int) favorabilityEachLvAndFavorabilityTotal2 = Model<FavorabilityModel>.Interface.GetFavorabilityEachLvAndFavorabilityTotal(m_characterId, maxFavorabilityStage);
		if (favorabilityEachLvAndFavorabilityTotal.Item1 <= 0 || favorabilityEachLvAndFavorabilityTotal.Item2 < 0 || favorabilityEachLvAndFavorabilityTotal2.Item1 <= 0 || favorabilityEachLvAndFavorabilityTotal2.Item2 < 0)
		{
			return false;
		}
		m_CurrentFavorability = Mathf.Floor(characterFavorInfo.Item2);
		m_MaxFavorability = favorabilityEachLvAndFavorabilityTotal2.Item2 + favorabilityEachLvAndFavorabilityTotal2.Item1;
		return (float)favorabilityEachLvAndFavorabilityTotal.Item2 + m_CurrentFavorability + Mathf.Floor(m_PreviewAddedFavorability) >= m_MaxFavorability;
	}

	public void UpdateFavorabilityUI(ImageAssetStation station)
	{
		if (m_FavorabilityLevelText != null)
		{
			(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(m_characterId);
			m_currFavorabilityLevel = characterFavorInfo.Item1;
			m_CurrentFavorability = characterFavorInfo.Item2;
			int favorabilityLevelByPreviewAddedFavorability = Model<FavorabilityModel>.Interface.GetFavorabilityLevelByPreviewAddedFavorability(m_characterId, m_currFavorabilityLevel, m_CurrentFavorability, m_PreviewAddedFavorability);
			m_FavorabilityLevelText.text = Model<FavorabilityModel>.Interface.ToTwoDigitString(favorabilityLevelByPreviewAddedFavorability);
			m_currFavorabilitylocalNameId = Model<FavorabilityModel>.Interface.GetFavorabilityName(favorabilityLevelByPreviewAddedFavorability);
			m_FavorabilityNameText.StringReference.TableEntryReference = m_currFavorabilitylocalNameId;
		}
		m_MaxFavorability = Model<FavorabilityModel>.Interface.GetFavorabilityEachLv(m_currFavorabilityLevel, m_characterId);
		float fillAmount = m_CurrentFavorability / m_MaxFavorability;
		float num = m_CurrentFavorability + Mathf.Floor(m_PreviewAddedFavorability);
		float fillAmount2 = ((num / m_MaxFavorability > 1f) ? 1f : (num / m_MaxFavorability));
		if (num >= m_MaxFavorability && Model<FavorabilityModel>.Interface.CurLikeabilityLv == Model<FavorabilityModel>.Interface.GetMaxFavorabilityStage())
		{
			num = m_MaxFavorability;
		}
		if (m_FavorabilityValueText != null)
		{
			if (m_PreviewAddedFavorability == 0f)
			{
				m_FavorabilityValueText.text = $"{num}/{m_MaxFavorability}";
				m_FavorabilityValueText.color = NormalTextColor;
			}
			else
			{
				_favorabilityValueBuilder.Clear();
				_favorabilityValueBuilder.Append("<color=");
				_favorabilityValueBuilder.Append("#ffea86");
				_favorabilityValueBuilder.Append('>');
				_favorabilityValueBuilder.Append(num);
				_favorabilityValueBuilder.Append("</color><color=");
				_favorabilityValueBuilder.Append("#ffe7ed");
				_favorabilityValueBuilder.Append(">/");
				_favorabilityValueBuilder.Append(m_MaxFavorability);
				_favorabilityValueBuilder.Append("</color>");
				m_FavorabilityValueText.text = _favorabilityValueBuilder.ToString();
			}
		}
		if (m_CurrentProgressBar != null)
		{
			m_CurrentProgressBar.fillAmount = fillAmount;
		}
		if (m_PreviewProgressBar != null)
		{
			m_PreviewProgressBar.fillAmount = fillAmount2;
		}
	}

	public void AfterSendGiftRefreshFavorabilityUI(ImageAssetStation station)
	{
		m_PreviewAddedFavorability = 0f;
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(m_characterId);
		(m_currFavorabilityLevel, _) = characterFavorInfo;
		if (m_FavorabilityLevelText != null)
		{
			m_FavorabilityLevelText.text = Model<FavorabilityModel>.Interface.ToTwoDigitString(characterFavorInfo.Item1);
		}
		m_currFavorabilitylocalNameId = Model<FavorabilityModel>.Interface.GetFavorabilityName(characterFavorInfo.Item1);
		m_FavorabilityNameText.StringReference.TableEntryReference = m_currFavorabilitylocalNameId;
		m_MaxFavorability = Model<FavorabilityModel>.Interface.GetFavorabilityEachLv(characterFavorInfo.Item1, m_characterId);
		if (m_FavorabilityValueText != null)
		{
			m_FavorabilityValueText.text = $"{Mathf.Floor(characterFavorInfo.Item2)}/{m_MaxFavorability}";
		}
		m_FavorabilityValueText.color = NormalTextColor;
		float fillAmount = Mathf.Floor(characterFavorInfo.Item2) / m_MaxFavorability;
		if (m_CurrentProgressBar != null)
		{
			m_CurrentProgressBar.fillAmount = fillAmount;
		}
		if (m_PreviewProgressBar != null)
		{
			m_PreviewProgressBar.fillAmount = 0f;
		}
	}

	public void RefreshFavorabilityUI(int characterId, int favorLevel, float favorValue, int currLevelFavorabilityMax, ImageAssetStation station)
	{
		if (m_FavorabilityValueText != null)
		{
			m_FavorabilityValueText.text = $"{favorValue}/{currLevelFavorabilityMax}";
		}
		m_FavorabilityValueText.color = NormalTextColor;
		if (m_FavorabilityLevelText != null)
		{
			m_FavorabilityLevelText.text = Model<FavorabilityModel>.Interface.ToTwoDigitString(favorLevel);
		}
		m_currFavorabilitylocalNameId = Model<FavorabilityModel>.Interface.GetFavorabilityName(favorLevel);
		m_FavorabilityNameText.StringReference.TableEntryReference = m_currFavorabilitylocalNameId;
		m_MaxFavorability = Model<FavorabilityModel>.Interface.GetFavorabilityEachLv(favorLevel, characterId);
		float fillAmount = favorValue / m_MaxFavorability;
		if (m_CurrentProgressBar != null)
		{
			m_CurrentProgressBar.fillAmount = fillAmount;
		}
	}
}
