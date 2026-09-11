using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace civilization;

public class CivilizationGameUI : MonoBehaviour
{
	public Text foodTxt;

	public Text expTxt;

	public Text rockTxt;

	public Text turnTxt;

	public Text skillInfo;

	public Slider turnSlider;

	public Text expStateTxt;

	public GameObject[] hexGo = new GameObject[3];

	public Text[] hexTxt = new Text[3];

	public Animator[] hexAnimator = new Animator[3];

	public GameObject[] hexLoopGo = new GameObject[3];

	[HideInInspector]
	public CivilizationMain main;

	public Queue<Action> luaPageQueue = new Queue<Action>();

	[HideInInspector]
	public bool isOpenLuaPage;

	public void Reset()
	{
		luaPageQueue.Clear();
		isOpenLuaPage = false;
		for (int i = 0; i < hexAnimator.Length; i++)
		{
			hexAnimator[i].Play("Default");
			hexGo[i].SetActive(value: false);
			hexTxt[i].text = "0";
			hexLoopGo[i].SetActive(value: false);
		}
	}

	public void UpdateSourceText()
	{
		foodTxt.text = $"{main.source[1]}(-{main.foodCost})";
		if (main.source[1] <= 10)
		{
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.ShowFoodShort", true);
		}
		else
		{
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.ShowFoodShort", false);
		}
		if (main.IsLastState())
		{
			expTxt.text = main.source[2] + "/ -";
		}
		else
		{
			expTxt.text = main.source[2] + "/" + main.nextLevelTech;
		}
		rockTxt.text = main.source[3].ToString();
		expStateTxt.text = (main.curTechState + 1).ToString("00") + "/" + (CivilizationCfg.techCost.Count + 1).ToString("00");
	}

	public void UpdateTimeText()
	{
		turnTxt.text = CalTime();
	}

	private string CalTime()
	{
		string result = "";
		if (main.lastYear)
		{
			object[] array = LuaHelper.CallFunction("GetTips", "GODEATER_CIVILIZATION_GAME_TIMEOUT");
			if (array != null && array.Length != 0)
			{
				result = (string)array[0];
			}
			turnSlider.value = 1f;
		}
		else
		{
			int num = main.curTime % 1440;
			int num2 = num / 60;
			int num3 = num % 60;
			result = string.Format("{0} : {1}", num2.ToString("00"), num3.ToString("00"));
			turnSlider.value = (float)num / 1440f;
		}
		return result;
	}

	public void UpdateUpGradeUI(int curTechState)
	{
		Action item = delegate
		{
			int[] canChooseFactor = main.GetCanChooseFactor(curTechState);
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.OpenChooseSkill", canChooseFactor);
		};
		luaPageQueue.Enqueue(item);
	}

	public void UpdateHexUI(int heroIndex, int heroID)
	{
		int[] canUsedTechs = CivilizationCfg.GetCanChooseHex(heroIndex, heroID);
		Action item = delegate
		{
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.OpenChooseHex", canUsedTechs, heroIndex);
		};
		luaPageQueue.Enqueue(item);
	}

	public void UpdateStageUI(int curAge, int lastAge)
	{
		Action item = delegate
		{
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.OpenStagePop", curAge, lastAge);
		};
		luaPageQueue.Enqueue(item);
	}

	public void ChangeValueUpdate(int type, int count)
	{
		switch (type)
		{
		}
		UpdateSourceText();
	}

	public void UpdateHexAni(int techID, int numParam)
	{
		switch (techID)
		{
		case 1002:
			if (numParam > 0)
			{
				hexAnimator[0].Play("UI_skill_loop");
				hexGo[0].SetActive(value: true);
				hexTxt[0].text = numParam.ToString();
			}
			else
			{
				hexAnimator[0].Play("Default");
				hexGo[0].SetActive(value: false);
				hexTxt[0].text = "0";
				hexLoopGo[0].SetActive(value: false);
			}
			break;
		case 1003:
		case 2002:
		case 2003:
			hexAnimator[0].Play("UI_skill_shandong");
			break;
		case 2004:
			hexAnimator[1].Play("UI_skill_shandong");
			break;
		case 2006:
			hexAnimator[2].Play("UI_skill_shandong");
			break;
		case 1004:
			if (numParam > 0)
			{
				hexAnimator[1].Play("UI_skill_loop");
				hexGo[1].SetActive(value: true);
				hexTxt[1].text = numParam.ToString();
			}
			else
			{
				hexAnimator[1].Play("Default");
				hexGo[1].SetActive(value: false);
				hexTxt[1].text = "0";
				hexLoopGo[1].SetActive(value: false);
			}
			break;
		case 1006:
		case 2007:
			if (numParam > 0)
			{
				hexAnimator[2].Play("UI_skill_loop");
				hexGo[2].SetActive(value: true);
				hexTxt[2].text = numParam.ToString();
			}
			else
			{
				hexAnimator[2].Play("Default");
				hexGo[2].SetActive(value: false);
				hexTxt[2].text = "0";
				hexLoopGo[2].SetActive(value: false);
			}
			break;
		}
	}

	public void OnCloseLuaPage()
	{
		isOpenLuaPage = false;
	}

	public void UpdateLuaPop()
	{
		if (luaPageQueue.Count > 0 && !isOpenLuaPage)
		{
			Action action = luaPageQueue.Dequeue();
			if (action != null)
			{
				isOpenLuaPage = true;
				action();
			}
		}
	}
}
