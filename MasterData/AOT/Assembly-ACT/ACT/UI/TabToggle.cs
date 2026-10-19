using System.Collections.Generic;
using ACT.Sound;
using Bamboo.ImageCenter;
using FMODUnity;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TabToggle : Toggle
{
	[Header("TabToggle 独有")]
	public RectTransform normalRoot;

	public RectTransform selectRoot;

	public GameObject SelectBox;

	public RectTransform selectIconTransform;

	public Animator iconAnimator;

	public Animation rootAnimation;

	public BetterAnimation betterAnimation;

	[Header("NormalIcon")]
	public Image normalIconImage;

	public BImage normalIconBImage;

	public List<Sprite> normalIconList;

	[Header("SelectIcon")]
	public BImage selectIconImage;

	[Header("name")]
	public LocalizeStringEvent tabName;

	public LocalizeStringEvent disableTabName;

	public TextMeshProUGUI txtTabName;

	public Color tabNameSelected;

	public Color tabNameNormal;

	[Header("旋转子节点 Prefab")]
	public List<GameObject> selectIconPrefabList;

	public bool canPointerClick = true;

	public bool oldValue;

	private UnityAction<int> pointerClickAction;

	public TabToggleParam param;

	public EventReference normalReference;

	public AudioEventReference audioNormalReference;

	public EventReference forbideClickReference;

	public AudioEventReference audioForbideClickReference;

	public bool IsSelected { get; set; }

	public void InitToggle(bool isSelect, UnityAction<int> pointerClickAction = null, TabToggleParam param = null)
	{
		onValueChanged.RemoveAllListeners();
		if (normalIconImage != null && normalIconImage.sprite == null)
		{
			normalIconImage.sprite = normalIconList[0];
		}
		if (param != null)
		{
			if (param.iconId != -1)
			{
				ImageAssetStation station = GetComponentInParent<IBaseUIView>().Station;
				station.LoadImage(110, param.iconId, normalIconBImage);
				station.LoadImage(111, param.iconId, selectIconImage);
			}
			if (param.localTextId != -1)
			{
				tabName.SetTable("shortcommon");
				tabName.StringReference.TableEntryReference = param.localTextId;
				if (disableTabName != null)
				{
					disableTabName.SetTable("shortcommon");
					disableTabName.StringReference.TableEntryReference = param.localTextId;
				}
			}
		}
		if (isSelect)
		{
			SetSelect();
		}
		else
		{
			SetNormal();
		}
		IsSelected = isSelect;
		this.pointerClickAction = pointerClickAction;
		this.param = param;
		oldValue = isSelect;
		isOn = isSelect;
	}

	public void UnInitToggle()
	{
		oldValue = false;
		pointerClickAction = null;
		param = null;
		isOn = false;
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Normal").Play();
		}
		else if (iconAnimator != null && iconAnimator.gameObject.activeInHierarchy)
		{
			iconAnimator.SetBool("Normal", value: true);
		}
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (canPointerClick)
		{
			if (audioNormalReference.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Tab_Click");
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(audioNormalReference);
			}
			base.OnPointerClick(eventData);
			pointerClickAction?.Invoke(param?.pointerClickActionParam ?? 0);
		}
		else if (param != null && param.sound != "")
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(param.sound);
		}
		else if (audioForbideClickReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Tab_Click");
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioForbideClickReference);
		}
	}

	public void BindOnValueChanged()
	{
		onValueChanged.AddListener(EnterExitIsOn);
	}

	private void EnterExitIsOn(bool newValue)
	{
		if (newValue != oldValue)
		{
			if (newValue)
			{
				SetSelect();
			}
			else
			{
				SetSelectHide();
			}
			oldValue = newValue;
		}
	}

	public void SetSelect()
	{
		canPointerClick = false;
		normalRoot.gameObject.SetActive(value: false);
		selectRoot.gameObject.SetActive(value: true);
		if ((bool)SelectBox)
		{
			SelectBox.SetActive(value: true);
		}
		PlayShowAnimation();
		if (txtTabName != null)
		{
			txtTabName.color = tabNameSelected;
		}
		if (normalIconImage != null)
		{
			normalIconImage.color = tabNameSelected;
		}
		IsSelected = true;
	}

	public void SetNormal()
	{
		canPointerClick = true;
		selectRoot.gameObject.SetActive(value: false);
		normalRoot.gameObject.SetActive(value: true);
		if ((bool)SelectBox)
		{
			SelectBox.SetActive(value: false);
		}
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Normal").Play();
		}
		else
		{
			if (iconAnimator != null && iconAnimator.gameObject.activeInHierarchy)
			{
				iconAnimator.SetBool("Normal", value: true);
			}
			if (rootAnimation != null && rootAnimation.isActiveAndEnabled)
			{
				rootAnimation.Play("Normal");
			}
		}
		if (txtTabName != null)
		{
			txtTabName.color = tabNameNormal;
		}
		if (normalIconImage != null)
		{
			normalIconImage.color = tabNameNormal;
		}
		IsSelected = false;
	}

	public void SetSelectHide()
	{
		canPointerClick = true;
		if (rootAnimation != null && rootAnimation.isActiveAndEnabled)
		{
			rootAnimation.Play("SelectedHide");
		}
	}

	public void PlayShowAnimation()
	{
		if (iconAnimator != null && iconAnimator.isActiveAndEnabled)
		{
			iconAnimator.Play("Show");
			iconAnimator.SetBool("Normal", value: false);
		}
		if (rootAnimation != null && rootAnimation.isActiveAndEnabled)
		{
			rootAnimation.Play("Selected");
		}
	}

	private void FindIconAnimation()
	{
		iconAnimator = Object.Instantiate(selectIconPrefabList[0], selectIconTransform).GetComponent<Animator>();
	}
}
