using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SystemGuideView : BaseUIView<SystemGuideViewInputController>
{
	private SystemGuideViewData m_data;

	public BetterAnimation anim;

	public TextMeshProUGUI nickName;

	public TextMeshProUGUI level;

	public TextMeshProUGUI uid;

	public UIAtlasImage avatar;

	public Slider expBar;

	public TextMeshProUGUI currentExp;

	public TextMeshProUGUI maxExp;

	[SerializeField]
	private BookViewMultiplePrefabsOSA bookViewMultiplePrefabsOSA;

	public BookViewMultiplePrefabsOSA GetBookViewOSA()
	{
		return bookViewMultiplePrefabsOSA;
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	public void OnLevelClicked()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SYSTEMGUIDEREWARD);
	}

	protected override void Init()
	{
		base.Init();
		bookViewMultiplePrefabsOSA.canPlayAnimation = true;
		PlayAnim();
		int playerLevel = SystemUnlockManager.playerLevel;
		PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[playerLevel];
		long num = G.detailUserInfo.Attributes[93];
		currentExp.text = $"{num}/";
		maxExp.SetText("{0:0}", playerLevelData.xpEachLv);
		expBar.value = (float)num / (float)playerLevelData.xpEachLv;
		level.SetText("LV.{0:0}", SystemUnlockManager.playerLevel);
		try
		{
			nickName.text = G.detailUserInfo.Brief.Nickname;
			uid.text = G.detailUserInfo.Brief.AccountId.ToString();
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			nickName.text = "本地游戏";
			uid.text = "0";
		}
		try
		{
			Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, RuntimeConfigs.data.MtyAvatars[G.localPlayer.Profile.EscInfo.CurAvatarId].iconID, avatar);
		}
		catch (Exception)
		{
			Console.WriteLine("本地游戏");
			Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, RuntimeConfigs.data.MtyAvatars[10001].iconID, avatar);
		}
		bookViewMultiplePrefabsOSA.canPlayAnimation = false;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		bookViewMultiplePrefabsOSA.Unload();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		anim.GetSequence("Hide").Play();
		base.Close();
	}

	public void PlayAnim()
	{
		anim.GetSequence("Show").Play();
	}
}
