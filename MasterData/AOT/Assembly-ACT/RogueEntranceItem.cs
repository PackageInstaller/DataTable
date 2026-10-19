using System.Collections.Generic;
using ACT.Config;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class RogueEntranceItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	public BetterAnimation betterAnimation;

	public BImage imageIcon;

	public TextMeshProUGUI TextNum;

	public LocalizeStringEvent textName;

	public ActButton BtnClick;

	public GameObject GoSelect;

	public GameObject GoLock;

	public ActButton BtnLock;

	public int modeId;

	public GameObject GoStar;

	public GameObject GOFinshStar;

	private bool islock;

	private Selectable Selectable;

	private RogueMode Data;

	public void Init(RogueMode data)
	{
		BtnLock.SetBtnClick(OnLockClick);
		Data = data;
		Selectable = GetComponent<Selectable>();
		modeId = data.id;
		textName.StringReference.TableEntryReference = data.name;
		G.detailUserInfo.Attributes.TryGetValue(90, out var value);
		islock = ((data.unlockRequiredRogueModeId == 0) ? (value < data.unlockRequiredPlayerLevel) : (!Model<RogueNewModel>.Interface.Info.ClearedMode.Contains(data.unlockRequiredRogueModeId) || value < data.unlockRequiredPlayerLevel));
		GoLock.SetActive(islock);
		BtnLock.gameObject.SetActive(islock);
		TextNum.color = (islock ? ColorParseUtility.HexToColor("#939393") : ColorParseUtility.HexToColor("#FFF8AC"));
		textName.GetComponent<TextMeshProUGUI>().color = (islock ? ColorParseUtility.HexToColor("#939393") : ColorParseUtility.HexToColor("#ffffff"));
		Selectable.enabled = true;
		GoStar.SetActive(!islock);
		GOFinshStar.SetActive(Model<RogueNewModel>.Interface.Info.ClearedMode.Contains(data.id));
		SetSelect(isSelect: false);
		betterAnimation.GetSequence("Show").Play();
	}

	public void SetSelect(bool isSelect, bool needAni = false)
	{
		GoSelect.SetActive(isSelect);
		TextMeshProUGUI component = textName.GetComponent<TextMeshProUGUI>();
		Color color;
		if (isSelect)
		{
			color = ColorParseUtility.HexToColor("#11110F");
		}
		else
		{
			color = (islock ? ColorParseUtility.HexToColor("#939393") : ColorParseUtility.HexToColor("#ffffff"));
		}
		component.color = color;
		if (needAni)
		{
			if (isSelect)
			{
				betterAnimation.GetSequence("Select").Play();
			}
			else
			{
				betterAnimation.GetSequence("Normal").Play();
			}
		}
	}

	private void OnLockClick()
	{
		List<string> list = new List<string>();
		int unlockRequiredPlayerLevel = Data.unlockRequiredPlayerLevel;
		list.Add(unlockRequiredPlayerLevel.ToString());
		GameUtility.OpenToolTip(2743, "Common", list);
	}

	private void Update()
	{
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (GoLock.activeSelf)
		{
			OnLockClick();
		}
		else
		{
			BtnClick.OnClick?.Invoke();
		}
	}
}
