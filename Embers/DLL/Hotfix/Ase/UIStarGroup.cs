#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UIStarGroup : MonoBehaviour
{
	[Serializable]
	public class PreShowStarToggle
	{
		public bool PreStarUpShow;

		public Transform PreStarRect;
	}

	public PreShowStarToggle preToggle = new PreShowStarToggle();

	[SerializeField]
	private Transform fullStarRect;

	[SerializeField]
	private bool changeMax;

	[SerializeField]
	private Transform fullStarBgRect;

	[SerializeField]
	private bool turnRight;

	[SerializeField]
	private bool showFromLeft;

	private int _curCount;

	private int _maxCount;

	private bool _isInit;

	private List<GameObject> fillStarBgList;

	private List<GameObject> fillStarList;

	private List<GameObject> preStarList;

	public Action starEffectAction;

	public int CurCount
	{
		get
		{
			return _curCount;
		}
		set
		{
			_curCount = value;
			RefreshCur();
		}
	}

	public int MaxCount
	{
		get
		{
			return _maxCount;
		}
		set
		{
			if (!changeMax)
			{
				Log.Error("星星组件配置异常，最大星级不可配置");
			}
			else if (fullStarBgRect == null)
			{
				Log.Error("星星组件配置异常，未挂背景父节点");
			}
			else if (_maxCount != value)
			{
				_maxCount = value;
				RefreshMax();
			}
		}
	}

	private void InitCur()
	{
		fillStarList = new List<GameObject>();
		for (int i = 0; i < fullStarRect.childCount; i++)
		{
			fillStarList.Add(fullStarRect.GetChild(i).gameObject);
		}
		if (preToggle.PreStarUpShow)
		{
			preStarList = new List<GameObject>();
			for (int j = 0; j < preToggle.PreStarRect.childCount; j++)
			{
				preStarList.Add(preToggle.PreStarRect.GetChild(j).gameObject);
			}
		}
		_isInit = true;
	}

	private void RefreshCur()
	{
		if (!_isInit)
		{
			InitCur();
		}
		for (int i = 0; i < fillStarList.Count; i++)
		{
			if (turnRight)
			{
				int num = fillStarList.Count - MaxCount;
				if (i < _curCount + num && i >= num)
				{
					fillStarList[i].SetActive(value: true);
				}
				else
				{
					fillStarList[i].SetActive(value: false);
				}
			}
			else if (showFromLeft)
			{
				if (i < _maxCount && i >= _maxCount - _curCount)
				{
					fillStarList[i].SetActive(value: true);
				}
				else
				{
					fillStarList[i].SetActive(value: false);
				}
			}
			else if (i < _curCount)
			{
				fillStarList[i].SetActive(value: true);
			}
			else
			{
				fillStarList[i].SetActive(value: false);
			}
		}
		if (!preToggle.PreStarUpShow)
		{
			return;
		}
		for (int j = 0; j < preStarList.Count; j++)
		{
			if (j == _curCount)
			{
				preStarList[j].SetActive(value: true);
			}
			else
			{
				preStarList[j].SetActive(value: false);
			}
		}
	}

	private void RefreshMax()
	{
		if (fillStarBgList == null)
		{
			fillStarBgList = new List<GameObject>();
			int childCount = fullStarBgRect.childCount;
			for (int i = 0; i < childCount; i++)
			{
				Transform child = fullStarBgRect.GetChild(i);
				fillStarBgList.Add(child.gameObject);
			}
		}
		if (_maxCount > fillStarBgList.Count)
		{
			Log.Error("星星组件配置异常，MaxCount 配置超出");
		}
		for (int j = 0; j < fillStarBgList.Count; j++)
		{
			if (j < _maxCount)
			{
				fillStarBgList[j].SetActive(value: true);
			}
			else
			{
				fillStarBgList[j].SetActive(value: false);
			}
		}
	}

	public void SetEffectToNewStar(AutoDispose effect)
	{
		for (int i = 0; i < fillStarList.Count; i++)
		{
			if (fillStarList[i].activeSelf)
			{
				Image component = fillStarList[i].GetComponent<Image>();
				if (component != null)
				{
					component.color = new Color(component.color.r, component.color.g, component.color.b, 0f);
				}
				effect.GetComponent<RectTransform>().anchoredPosition = component.rectTransform.anchoredPosition;
				effect.gameObject.SetActive(value: true);
				break;
			}
		}
	}

	public void SetAlpha(int a)
	{
		for (int num = fillStarList.Count - 1; num >= 0; num--)
		{
			if (fillStarList[num].activeSelf)
			{
				Image component = fillStarList[num].GetComponent<Image>();
				if (component != null)
				{
					component.color = new Color(component.color.r, component.color.g, component.color.b, 1f);
				}
			}
		}
	}

	public void AddEffectAction(Action action)
	{
		starEffectAction = (Action)Delegate.Combine(starEffectAction, action);
	}

	private void OnEnable()
	{
		if (base.gameObject.activeSelf)
		{
			starEffectAction?.Invoke();
		}
	}
}
