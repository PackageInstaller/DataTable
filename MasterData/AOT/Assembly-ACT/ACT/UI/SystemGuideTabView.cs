using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SystemGuideTabView : BaseTabContent
{
	public TextMeshProUGUI nickName;

	public TextMeshProUGUI level;

	public BImage avatar;

	public Slider expBar;

	public TextMeshProUGUI currentExp;

	public TextMeshProUGUI maxExp;

	[SerializeField]
	private GameObject _expRoot;

	[SerializeField]
	private GameObject _maxExpRoot;

	[SerializeField]
	public BookViewMultiplePrefabsOSA bookViewMultiplePrefabsOSA;

	private MonoJourneyTracesView _journeyTracesView;

	public MonoJourneyTracesView JourneyTracesView => _journeyTracesView;

	private void Start()
	{
		int playerLevel = SystemUnlockManager.playerLevel;
		PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[playerLevel];
		long num = G.detailUserInfo.Attributes[93];
		currentExp.text = $"{num.ToString()}/";
		TextMeshProUGUI textMeshProUGUI = maxExp;
		int xpEachLv = playerLevelData.xpEachLv;
		textMeshProUGUI.text = xpEachLv.ToString();
		expBar.value = (float)num / (float)playerLevelData.xpEachLv;
		level.text = SystemUnlockManager.playerLevel.ToString();
		try
		{
			nickName.text = G.detailUserInfo.Brief.Nickname;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			nickName.text = "本地游戏";
		}
		try
		{
			Station.LoadSprite(GameLoader.meta.dramaAsideAtalasNameAssetID, RuntimeConfigs.data.MtyAvatars[G.localPlayer.Profile.EscInfo.CurAvatarId].iconID, avatar);
		}
		catch (Exception)
		{
			Console.WriteLine("本地游戏");
			Station.LoadSprite(GameLoader.meta.dramaAsideAtalasNameAssetID, RuntimeConfigs.data.MtyAvatars[10001].iconID, avatar);
		}
		_expRoot.SetActive(SystemUnlockManager.playerLevel < RuntimeConfigs.data.game.playerMaxLevel);
		_maxExpRoot.SetActive(SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.playerMaxLevel);
	}

	protected override void OnRelease()
	{
		gameObject.SetActive(value: false);
		bookViewMultiplePrefabsOSA.Unload();
		base.OnRelease();
	}

	public void InitOsa(MonoJourneyTracesView journeyTracesView)
	{
		_journeyTracesView = journeyTracesView;
		bookViewMultiplePrefabsOSA.canPlayAnimation = true;
		bookViewMultiplePrefabsOSA.InitOSA(this);
		bookViewMultiplePrefabsOSA.canPlayAnimation = false;
	}

	public void PlayAnimation(int index, MonoJourneyTracesView journeyTracesView)
	{
		if (index == 1)
		{
			InitOsa(journeyTracesView);
			anim?.GetSequence("Show").Play();
			return;
		}
		anim?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			gameObject.SetActive(value: false);
			bookViewMultiplePrefabsOSA?.bookRightPanel?.Close();
		}).Play();
	}

	public void OnLevelClicked()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SYSTEMGUIDEREWARD);
	}
}
