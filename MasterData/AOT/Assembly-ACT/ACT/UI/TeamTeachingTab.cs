using System;
using ACT.Config;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TeamTeachingTab : BaseTabToggle
{
	[SerializeField]
	private GameObject _normalRoot;

	[SerializeField]
	private GameObject _selectedRoot;

	[SerializeField]
	private TMP_Text[] _titleTexts;

	[SerializeField]
	private BImage normalImage;

	[SerializeField]
	private BImage selectImage;

	public SimulateTraining Data { get; private set; }

	protected override void AwakeImply()
	{
		base.AwakeImply();
		SetPointerEnterSound("event:/UI/Interface/ESC/Hover");
	}

	public void Bind(SimulateTraining data, Func<bool> canActive)
	{
		Data = data;
		TabIdentify = data.id;
		CanActive = canActive;
		string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", data.contentLv1name);
		if (_titleTexts == null)
		{
			return;
		}
		TMP_Text[] titleTexts = _titleTexts;
		foreach (TMP_Text tMP_Text in titleTexts)
		{
			if (tMP_Text != null)
			{
				tMP_Text.SetText(localizeString);
			}
		}
		Station.LoadImage(246, TabIdentify, normalImage);
		Station.LoadImage(247, TabIdentify, selectImage);
	}

	protected override void OnTabActive()
	{
		if (_normalRoot != null)
		{
			_normalRoot.SetActive(value: false);
		}
		if (_selectedRoot != null)
		{
			_selectedRoot.SetActive(value: true);
		}
		base.OnTabActive();
	}

	protected override void OnTabDeActive()
	{
		if (_normalRoot != null)
		{
			_normalRoot.SetActive(value: true);
		}
		if (_selectedRoot != null)
		{
			_selectedRoot.SetActive(value: false);
		}
		base.OnTabDeActive();
	}
}
