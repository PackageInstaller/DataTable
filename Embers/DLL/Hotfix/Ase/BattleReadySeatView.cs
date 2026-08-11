using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using DG.Tweening;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class BattleReadySeatView : UGuiView, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	public enum SeatState
	{
		Normal,
		Dragging,
		EndDrag
	}

	private SeatState seatState;

	public float fadeInTime = 0.3f;

	public float fadeOutTime = 0.3f;

	public float reduceScale = 0.8f;

	[SerializeField]
	private Button seatBtn;

	[SerializeField]
	private CanvasGroup heroPart;

	[SerializeField]
	private Transform roleOriginHead;

	[SerializeField]
	private GameObject roleGreyMask;

	[SerializeField]
	private GameObject roleInfo;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private Image attribute;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private GameObject captain;

	[SerializeField]
	private TextMeshProUGUI seatIndex;

	[SerializeField]
	private List<GameObject> fixPlayerIndex;

	[SerializeField]
	private GameObject emptyPart;

	[SerializeField]
	private GameObject addPart;

	[SerializeField]
	private Image heroRarity;

	[SerializeField]
	private Image destiny;

	[SerializeField]
	private Image cardFrame;

	[SerializeField]
	private GameObject practiceTag;

	[SerializeField]
	private GameObject heroTryTag;

	[SerializeField]
	private GameObject seatLockTag;

	[SerializeField]
	private GameObject configEnable;

	[SerializeField]
	private GameObject configDisable;

	private int seatId;

	private bool isCaptain;

	private BattleReadySeatViewModel _viewModel;

	private GameObject _fgimageObj;

	private Tweener tweener;

	private List<string> usedAssets = new List<string>();

	public BattleReadySeatViewModel ViewModel => _viewModel;

	public void Init(BattleReadySeatViewModel viewModel, int seatId, bool isCaptain)
	{
		this.seatId = seatId;
		this.isCaptain = isCaptain;
		_viewModel = viewModel;
		_viewModel.SetSeatData(seatId, isCaptain);
		BindingSet<BattleReadySeatView, BattleReadySeatViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		if (seatBtn != null)
		{
			bindingSet.Bind(seatBtn).For((Button v) => v.onClick).To((BattleReadySeatViewModel vm) => vm.OnSeatBtnClick);
			bindingSet.Bind(seatBtn).For((Button v) => v.enabled).ToExpression((BattleReadySeatViewModel vm) => !vm.ConfigDisable);
		}
		if ((UnityEngine.Object)(object)name != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleReadySeatViewModel vm) => vm.Data.Name);
		}
		if (attribute != null)
		{
			bindingSet.Bind(attribute).For((Image v) => v.sprite).To((BattleReadySeatViewModel vm) => vm.Attribute)
				.WithConversion("ItemIcon");
		}
		if (practiceTag != null)
		{
			bindingSet.Bind(practiceTag).For((GameObject v) => v.activeSelf).To((BattleReadySeatViewModel vm) => vm.PracticeTag);
		}
		if (heroTryTag != null)
		{
			bindingSet.Bind(heroTryTag).For((GameObject v) => v.activeSelf).ToExpression((BattleReadySeatViewModel vm) => !vm.Empty && vm.HeroTryTag);
		}
		if (seatLockTag != null)
		{
			bindingSet.Bind(seatLockTag).For((GameObject v) => v.activeSelf).To((BattleReadySeatViewModel vm) => vm.SeatLockTag);
		}
		if ((UnityEngine.Object)(object)level != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleReadySeatViewModel vm) => $"Lv.{vm.Data.Level}");
		}
		if (heroRarity != null)
		{
			bindingSet.Bind(heroRarity).For((Image v) => v.sprite).ToExpression((BattleReadySeatViewModel vm) => $"MultiRoom_Rarity_{vm.Data.Rarity}")
				.WithConversion("ItemIcon");
		}
		if (destiny != null)
		{
			bindingSet.Bind(destiny).For((Image v) => v.sprite).ToExpression((BattleReadySeatViewModel vm) => vm.Data.IsNullOrEmpty() ? "Hero_Seat_1" : $"Hero_Seat_{vm.Data.DestinyLevel}")
				.WithConversion("ItemIcon");
		}
		if (cardFrame != null)
		{
			bindingSet.Bind(cardFrame.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleReadySeatViewModel vm) => !string.IsNullOrEmpty(vm.CardFrame));
			bindingSet.Bind(cardFrame).For((Image v) => v.sprite).To((BattleReadySeatViewModel vm) => vm.CardFrame)
				.WithConversion("ItemIcon");
		}
		if (configEnable != null)
		{
			bindingSet.Bind(configEnable).For((GameObject v) => v.activeSelf).ToExpression((BattleReadySeatViewModel vm) => !vm.ConfigDisable);
		}
		if (configDisable != null)
		{
			bindingSet.Bind(configDisable).For((GameObject v) => v.activeSelf).To((BattleReadySeatViewModel vm) => vm.ConfigDisable);
		}
		bindingSet.Bind().For((BattleReadySeatView v) => v.OnHeroModelChanged).To((BattleReadySeatViewModel vm) => vm.OnHeroModelChangedRequest);
		bindingSet.Build();
		OnInit();
	}

	private void OnInit()
	{
		if (fixPlayerIndex != null)
		{
			for (int i = 0; i < fixPlayerIndex.Count; i++)
			{
				fixPlayerIndex[i].SetActive(i == seatId - 1);
			}
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		UpdateSeatData();
	}

	private void UpdateHeroPart()
	{
		bool flag = !_viewModel.Data.IsNullOrEmpty();
		if ((UnityEngine.Object)(object)heroPart != null)
		{
			((Component)(object)heroPart).gameObject.SetActive(flag);
		}
		if (emptyPart != null)
		{
			emptyPart.SetActive(!flag);
		}
	}

	private void UpdateAddPart()
	{
		if (!(addPart == null))
		{
			if (seatState == SeatState.Dragging || seatState == SeatState.EndDrag)
			{
				addPart.SetActive(value: false);
			}
			else
			{
				addPart.SetActive(_viewModel.Data.IsNullOrEmpty());
			}
		}
	}

	public void UpdateState(SeatState newState)
	{
		if (!seatState.Equals(newState))
		{
			seatState = newState;
			UpdateAddPart();
			base.transform.localScale = ((newState == SeatState.Dragging) ? (Vector3.one * reduceScale) : Vector3.one);
		}
	}

	private void OnHeroModelChanged(object sender, InteractionEventArgs e)
	{
		if (((HeroModel)e.Context).IsNullOrEmpty())
		{
			Func();
		}
		else
		{
			DoTween(show: false, Func);
		}
		void Func()
		{
			UpdateSeatData();
			if (!_viewModel.Data.IsNullOrEmpty())
			{
				DoTween(show: true);
			}
		}
	}

	private async void UpdateSeatData()
	{
		Clear();
		HeroModel data = _viewModel.Data;
		if (data.IsNullOrEmpty())
		{
			if (_viewModel.HeroTryTag)
			{
				heroTryTag.gameObject.SetActive(value: false);
			}
			UpdateHeroPart();
			UpdateAddPart();
			return;
		}
		if (!usedAssets.Contains(data.Original))
		{
			usedAssets.Add(data.Original);
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(data.Original), roleOriginHead);
		if (gameObject != null)
		{
			_fgimageObj = gameObject;
			Transform transform = _fgimageObj.transform.Find("HeadPos");
			if (transform != null)
			{
				float x = transform.GetComponent<RectTransform>().anchoredPosition.x;
				float y = transform.GetComponent<RectTransform>().anchoredPosition.y;
				_fgimageObj.GetComponent<Transform>().SetLocalPositionX(0f - x);
				_fgimageObj.GetComponent<Transform>().SetLocalPositionY(0f - y);
			}
			SkeletonGraphic val = _fgimageObj.transform.GetChild(0)?.GetComponent<SkeletonGraphic>();
			if ((UnityEngine.Object)(object)val != null)
			{
				((Graphic)(object)val).raycastTarget = false;
			}
			StreamerMode.ApplySpineSkin(gameObject, roleOriginHead);
		}
		if (_viewModel.HeroTryTag)
		{
			heroTryTag.gameObject.SetActive(_viewModel.HeroTryTag);
		}
		UpdateHeroPart();
		UpdateAddPart();
	}

	public void UpdateSeatData(int heroId)
	{
		if (_viewModel.Data.Id == heroId)
		{
			UpdateSeatData();
		}
	}

	private void DoTween(bool show, Action completeAction = null)
	{
		float startAlpha = ((!show) ? 1 : 0);
		float endValue = (show ? 1 : 0);
		float duration = (show ? fadeInTime : fadeOutTime);
		if (tweener != null)
		{
			tweener.Kill();
			tweener = null;
		}
		tweener = DOTween.To(() => heroPart.alpha, delegate(float x)
		{
			heroPart.alpha = x;
		}, endValue, duration).OnStart(delegate
		{
			heroPart.alpha = startAlpha;
		}).OnComplete(delegate
		{
			tweener = null;
			completeAction?.Invoke();
		})
			.SetAutoKill()
			.SetEase(Ease.Linear);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (seatState == SeatState.Dragging)
		{
			_viewModel.OnPointerEnter();
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (seatState == SeatState.Dragging)
		{
			_viewModel.OnPointerExit();
		}
	}

	public void Clear()
	{
		if (_fgimageObj != null)
		{
			UnityEngine.Object.DestroyImmediate(_fgimageObj);
			_fgimageObj = null;
		}
	}

	public void Dispose()
	{
		Clear();
		if (usedAssets != null && usedAssets.Count > 0)
		{
			for (int i = 0; i < usedAssets.Count; i++)
			{
				usedAssets[i] = null;
			}
		}
		tweener.Kill();
		tweener = null;
	}
}
