using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace BilliardGame.Runtime;

public class BilliardMainHeroHeadUI : MonoBehaviour
{
	private static string headBasePath = "TextureConfig/Character/LittleIcon/{0}";

	private const string PATH = "TextureConfig/Activity_SummerPub/BilliardGame/buff/{0}";

	[HideInInspector]
	public int heroID;

	[HideInInspector]
	public int index;

	public ControllerExCollection controllerExCollection;

	[HideInInspector]
	public ControllerEx heroStateController;

	[HideInInspector]
	public ControllerEx tipsSliderController;

	public Image headIcon;

	public Image hpBar;

	public Image shieldBar;

	public Text hpText;

	public Image cdBar;

	public Text cdText;

	public Text costText;

	public Button skillBtn;

	public Image infoBar;

	public GameObject buffGo;

	[HideInInspector]
	public List<GameObject> buffGoList_;

	[HideInInspector]
	public List<int> buffIDList_;

	[HideInInspector]
	public List<int> timeList_;

	public void Init(int heroID, int index)
	{
		this.heroID = heroID;
		this.index = index;
		BilliardCharacterConfig playerCfg = BilliardGameDataManager.GetPlayerCfg(heroID);
		string spritePath = string.Format(headBasePath, playerCfg.hero_ball_image);
		AtlasManager.GetSpriteWithoutAtlas(headIcon, spritePath);
		heroStateController = controllerExCollection.GetController("righthero");
		tipsSliderController = controllerExCollection.GetController("TipsSlider");
		buffGoList_ = new List<GameObject>();
		buffIDList_ = new List<int>();
		timeList_ = new List<int>();
	}

	public void ShowHeroInfo(int index)
	{
		BilliardGameLogicManager.Instance.ShowHeroInfo(index, buffIDList_, timeList_);
	}

	public void RefreshHeroHead(HeroHeadContext context)
	{
		if (context.curHp + context.curShield >= context.maxHp)
		{
			float fillAmount = (float)context.curHp / ((float)context.curHp + (float)context.curShield);
			hpBar.fillAmount = fillAmount;
			shieldBar.fillAmount = 1f;
		}
		else
		{
			hpBar.fillAmount = (float)context.curHp / (float)context.maxHp;
			shieldBar.fillAmount = ((float)context.curHp + (float)context.curShield) / (float)context.maxHp;
		}
		hpText.text = context.curHp.ToString();
		cdBar.fillAmount = (float)(context.maxCd - context.curCd) / (float)context.maxCd;
		cdText.text = (context.maxCd - context.curCd).ToString();
		costText.text = context.skillCost.ToString();
		if (context.curHp <= 0)
		{
			heroStateController.SetSelectedState("lose");
		}
		else if (context.curCd <= 0 && context.skillCost <= BilliardGameLogicManager.Instance.Food && !context.isTired)
		{
			heroStateController.SetSelectedState("skillmax");
		}
		else
		{
			heroStateController.SetSelectedState("skillcd");
		}
		if (context.buffIDList == null)
		{
			return;
		}
		buffIDList_.Clear();
		timeList_.Clear();
		buffIDList_.AddRange(context.buffIDList);
		timeList_.AddRange(context.timeList);
		for (int i = 0; i < context.buffIDList.Count; i++)
		{
			GameObject gameObject;
			if (i < buffGoList_.Count)
			{
				gameObject = buffGoList_[i];
			}
			else
			{
				gameObject = Object.Instantiate(buffGo, buffGo.transform.parent, worldPositionStays: false);
				buffGoList_.Add(gameObject);
			}
			gameObject.SetActive(value: true);
			BilliardBuffConfig buffCfg = BilliardGameDataManager.GetBuffCfg(context.buffIDList[i]);
			string spritePath = $"TextureConfig/Activity_SummerPub/BilliardGame/buff/{buffCfg.icon}";
			AtlasManager.GetSpriteWithoutAtlas(gameObject.transform.Find("BilliardGame_Buff/bufficon").GetComponent<Image>(), spritePath);
		}
		for (int j = context.buffIDList.Count; j < buffGoList_.Count; j++)
		{
			buffGoList_[j].SetActive(value: false);
		}
	}

	public void RefreshInfoBarShow(bool isShow)
	{
		tipsSliderController.SetSelectedState(isShow ? "on" : "off");
	}

	public void RefreshInfoBar(float time, float allTime)
	{
		infoBar.fillAmount = time / allTime;
	}

	public void OnDisable()
	{
		for (int num = buffGoList_.Count - 1; num >= 0; num--)
		{
			Object.DestroyImmediate(buffGoList_[num]);
			buffGoList_[num] = null;
		}
	}
}
