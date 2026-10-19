using System.Collections.Generic;
using ACT.Model;
using Bamboo.ImageCenter;
using Fundamental;
using Lumin.LoungeSystem.UI;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class FavorabilityUpgradeGroup : MonoBehaviour
{
	[SerializeField]
	private BImage m_FavorabilityLevelImage;

	[SerializeField]
	private TextMeshProUGUI m_FavorabilityLevelText;

	[SerializeField]
	private TextMeshProUGUI m_FavorabilityLevelText2;

	[SerializeField]
	private LoopVerticalScrollRect _FavorabilityUpgradeSR;

	[SerializeField]
	private GameObject m_FavorabilityLevelUpRoot;

	[SerializeField]
	private GameObject m_FavorabilityAddValueRoot;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private int m_characterId;

	private ImageAssetStation station;

	private bool isLevelUp;

	private bool hideOnShowAnimationComplete;

	public void UpdateView()
	{
		gameObject.SetActive(value: true);
		m_characterId = LoungeUIScene.instance.PendingClickCharacterId;
		if (Model<FavorabilityModel>.Interface.CurLikeabilityLv > Model<FavorabilityModel>.Interface.BeforeSendGiftFavorLevel)
		{
			isLevelUp = true;
			hideOnShowAnimationComplete = false;
			m_FavorabilityLevelUpRoot.SetActive(value: true);
			m_FavorabilityAddValueRoot.SetActive(value: false);
			RefreshFavorabilityLevel();
			RefreshFavorabilityUpgradeSR();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Backyard/Affection_LevelUp");
		}
		else
		{
			isLevelUp = false;
			hideOnShowAnimationComplete = true;
			m_FavorabilityLevelUpRoot.SetActive(value: false);
			m_FavorabilityAddValueRoot.SetActive(value: true);
			ResetFavorabilityUpgradeSR();
			RefreshFavorabilityLevel(Model<FavorabilityModel>.Interface.CurLikeabilityLv);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Backyard/Affection_Earned");
		}
		PlayShowAnimation();
	}

	private void PlayShowAnimation()
	{
		if (isLevelUp)
		{
			_betterAnimation.GetSequence("Up")?.OnComplete((AnimationBuilder _) =>
			{
			}).Play();
		}
		else
		{
			_betterAnimation.GetSequence("LitUp")?.OnComplete(OnShowAnimationComplete).Play();
		}
	}

	private void OnShowAnimationComplete(AnimationBuilder builder)
	{
		if (hideOnShowAnimationComplete)
		{
			gameObject.SetActive(value: false);
		}
	}

	public void StopAndHide()
	{
		_betterAnimation?.StopAnimation();
		ResetFavorabilityUpgradeSR();
		gameObject.SetActive(value: false);
	}

	private void RefreshFavorabilityLevel(int preLevel = -1)
	{
		int curLikeabilityLv = Model<FavorabilityModel>.Interface.CurLikeabilityLv;
		m_FavorabilityLevelText.text = Model<FavorabilityModel>.Interface.ToTwoDigitString(curLikeabilityLv);
	}

	private void RefreshFavorabilityUpgradeSR()
	{
		List<UnlockEntry> favorabilityLevelList = Model<FavorabilityModel>.Interface.GetFavorabilityLevelList(m_characterId, Model<FavorabilityModel>.Interface.BeforeSendGiftFavorLevel, Model<FavorabilityModel>.Interface.CurLikeabilityLv);
		_FavorabilityUpgradeSR.gameObject.SetActive(favorabilityLevelList.Count > 0);
		_FavorabilityUpgradeSR.ClearCells();
		_FavorabilityUpgradeSR.totalCount = favorabilityLevelList.Count;
		_FavorabilityUpgradeSR.RefillCells();
	}

	private void ResetFavorabilityUpgradeSR()
	{
		if (!(_FavorabilityUpgradeSR == null))
		{
			_FavorabilityUpgradeSR.ClearCells();
			_FavorabilityUpgradeSR.totalCount = 0;
			_FavorabilityUpgradeSR.gameObject.SetActive(value: false);
		}
	}
}
