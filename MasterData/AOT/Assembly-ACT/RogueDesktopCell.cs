using System;
using ACT.Config;
using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class RogueDesktopCell : MonoBehaviour
{
	public GameObject GoCurrent;

	public BImage ImageDesktopIcon;

	public LocalizeStringEvent TextDes;

	public GameObject GoLocked;

	public GameObject GoSelect;

	public Action FunClick;

	public int TableEffectId;

	private void Start()
	{
	}

	public void OnClick()
	{
		FunClick?.Invoke();
	}

	private void Update()
	{
	}

	public void Init(RogueTableStageCard data)
	{
		TableEffectId = data.id;
		GoCurrent.SetActive(Model<RoGueModel>.Interface._RogueTableStageEffectId == data.id);
		TextDes.StringReference.TableEntryReference = data.stageCardDesc;
	}
}
