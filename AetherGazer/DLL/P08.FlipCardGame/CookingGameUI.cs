using System.Collections;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class CookingGameUI : MonoBehaviour
{
	public Text stepCount;

	public Text stepName;

	public Text stepDesc;

	public Text stepNum;

	public Text popStepNum;

	public Text popStepDesc;

	public Animator stepAnim;

	public GameObject stepBoard;

	public GameObject smallComplete;

	public GameObject bigComplete;

	public GameObject dish;

	public Image dishImage;

	public Button btnSmallFinish;

	public Button btnBigFinish;

	public Button btnDish;

	public Text stepFinishDesc;

	public Text disDesc;

	public Text disBaseDesc;

	public GameObject guideTextGo;

	public Text guideText;

	private Coroutine autoCloseCoroutine;

	private void Awake()
	{
		btnSmallFinish.onClick.AddListener(delegate
		{
			smallComplete.SetActive(value: false);
			OnSmallStepPopClose();
		});
		btnBigFinish.onClick.AddListener(delegate
		{
			bigComplete.SetActive(value: false);
			CookingGameManager.Instance.FinishCook();
			dish.SetActive(value: true);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold04", useStream: true);
		});
		btnDish.onClick.AddListener(delegate
		{
			dish.SetActive(value: false);
			OnDishComplete();
		});
	}

	public void RefreshInfo()
	{
		SetStepBoardActive(flag: true);
		dishImage.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/CookingGame/mainGame/" + CookingGameManager.Instance.GetDishId());
	}

	public void SetStepInfo(string name, int nowIndex, int totalIndex)
	{
		stepCount.text = $"{nowIndex}/{totalIndex}";
		string text = ((LuaHelper.CallFunction("GetTips", name) != null) ? (LuaHelper.CallFunction("GetTips", name)[0] as string) : name);
		stepName.text = text;
	}

	public void SetStepProgress(CookingGameConst.ProgressData progressData)
	{
		stepDesc.text = progressData.desc + " " + $"{progressData.currentProgress}/{progressData.totalProgress}";
	}

	public void OnStepFinish(bool isLast)
	{
		if (isLast)
		{
			if (!bigComplete.gameObject.activeInHierarchy)
			{
				bigComplete.SetActive(value: true);
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_success02", useStream: true);
				SetStepBoardActive(flag: false);
				string text = (LuaHelper.CallFunction("GetCookCfg", int.Parse(CookingGameManager.Instance.GetDishId()))[0] as LuaTable)["food_name"].ToString();
				string text2 = I18NRuntimeManager.Instance.GetI18NText(text);
				if (string.IsNullOrEmpty(text2))
				{
					text2 = text;
				}
				disDesc.text = text2;
				disBaseDesc.text = text2;
				LuaHelper.CallFunction("FinishCook", int.Parse(CookingGameManager.Instance.GetDishId()), 1);
				if (autoCloseCoroutine != null)
				{
					StopCoroutine(autoCloseCoroutine);
				}
				autoCloseCoroutine = StartCoroutine(AutoCloseBigComplete(3f));
				LuaHelper.CallFunction("SetCookingWindowBar", false);
			}
		}
		else if (!smallComplete.gameObject.activeInHierarchy)
		{
			LuaHelper.CallFunction("SetCookingWindowBar", false);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_success01", useStream: true);
			smallComplete.SetActive(value: true);
			popStepNum.text = $"{CookingGameManager.Instance.curIndex}/{CookingGameManager.Instance.stepSequence.Count}";
			CookingGameConst.ProgressData progress = CookingGameManager.Instance.currentStep.GetProgress();
			popStepDesc.text = progress.desc;
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				popStepNum.text = $"{CookingGameManager.Instance.curIndex + 1}/{CookingGameManager.Instance.stepSequence.Count}";
			}, 1f, 1);
		}
	}

	private IEnumerator AutoCloseBigComplete(float delay)
	{
		yield return new WaitForSeconds(delay);
		if (bigComplete.activeSelf)
		{
			bigComplete.SetActive(value: false);
			CookingGameManager.Instance.FinishCook();
			dish.SetActive(value: true);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold04", useStream: true);
			LuaHelper.CallFunction("SetCookingWindowBar", false);
		}
	}

	public void SetStepBoardActive(bool flag)
	{
		stepBoard.SetActive(flag);
	}

	public void OnSmallStepPopClose()
	{
		CookingGameManager.Instance.ShowNextStep();
		LuaHelper.CallFunction("SetCookingWindowBar", true);
	}

	public void OnDishComplete()
	{
		LuaHelper.CallFunction("SummerCookGameView.OnFinishCook", CookingGameManager.Instance.GetDishId(), CookingGameManager.Instance.IsBattle());
	}

	public void SetStepFinishText(string textKey)
	{
		object[] array = LuaHelper.CallFunction("GetTips", textKey);
		if (array != null && array.Length != 0 && (string)array[0] != "")
		{
			stepFinishDesc.text = (string)array[0];
			stepFinishDesc.transform.parent.SetActive(bActive: true);
		}
		else
		{
			stepFinishDesc.transform.parent.SetActive(bActive: false);
		}
	}

	public void ShowGuideText(bool flag, string text)
	{
		guideTextGo.SetActive(flag);
		string text2 = ((LuaHelper.CallFunction("GetTips", text) != null) ? (LuaHelper.CallFunction("GetTips", text)[0] as string) : null);
		text = ((text2 == null) ? text : text2);
		guideText.text = text;
	}
}
