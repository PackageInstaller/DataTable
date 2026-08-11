using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using DG.Tweening;
using FMOD.Studio;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroGrowRarityView : HeroCultivateView
{
	[SerializeField]
	private List<int> configAudioIds = new List<int>();

	[SerializeField]
	private Image curRarityLittleIcon;

	[SerializeField]
	private TextMeshProUGUI curRarityName;

	[SerializeField]
	private TextMeshProUGUI curRarityDesc;

	[SerializeField]
	private Button curRarityBtn;

	[SerializeField]
	private GameObject curRarityIconSelected;

	[SerializeField]
	private GameObject littlePointFinishGo;

	[SerializeField]
	private GameObject midPointCanLightGo;

	[SerializeField]
	private List<HeroGrowRarityItem> items = new List<HeroGrowRarityItem>();

	[SerializeField]
	private List<GameObject> effectsWhenLayerLighted = new List<GameObject>();

	[SerializeField]
	private GameObject layerLightedEffect;

	[SerializeField]
	private Button btnLeftArrow;

	[SerializeField]
	private Button btnRightArrow;

	[SerializeField]
	private RectTransform moveRect;

	[SerializeField]
	private RectTransform viewCenter;

	[SerializeField]
	private GameObject alphaRoot;

	[SerializeField]
	private GameObject pointFinishEffect;

	[SerializeField]
	private SkeletonGraphic raritySpine;

	[Header("界面缩放最大值")]
	public float maxViewScale = 1.5f;

	[Header("界面移动时长")]
	public float moveTime = 0.5f;

	[Header("界面缩放时长")]
	public float scaleTime = 0.5f;

	[Header("点亮 point特效时长")]
	public float pointLightTime = 1f;

	[Header("point全部点亮 特效时长")]
	public float pointFinishEffectTime = 1.5f;

	[Header("图标移动距离")]
	public float moveDistance = 100f;

	[Header("图标移动时长")]
	public float changeTime = 0.5f;

	[Header("升冠特效时长")]
	public float effectUpTime = 2f;

	[Header("spine升冠时长")]
	public float spineUpTime = 2f;

	private int moveTweenId = 1;

	private int scaleTweenId = 2;

	private float rawMidIconPosX;

	private Tweener moveTween;

	private Tweener scaleTween;

	private HeroGrowRarityViewModel _viewModel;

	private int pointLighted;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroGrowRarityViewModel>(userData);
		showArrowPart = false;
		showHeroFimage = false;
		pointFinishEffect.SetActive(value: false);
		rawMidIconPosX = ((Component)(object)raritySpine).GetComponent<RectTransform>().anchoredPosition.x;
		BindingSet<HeroGrowRarityView, HeroGrowRarityViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(curRarityLittleIcon).For((Image v) => v.sprite).To((HeroGrowRarityViewModel vm) => vm.CurRarityLittleIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(curRarityName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityViewModel vm) => vm.CurRarityName);
		bindingSet.Bind(curRarityBtn).For((Button v) => v.onClick).To((HeroGrowRarityViewModel vm) => vm.OnMidRarityBtnClick);
		bindingSet.Bind(btnLeftArrow.gameObject).For((GameObject v) => v.activeSelf).To((HeroGrowRarityViewModel vm) => vm.ShowLeftArrow);
		bindingSet.Bind(btnRightArrow.gameObject).For((GameObject v) => v.activeSelf).To((HeroGrowRarityViewModel vm) => vm.ShowRightArrow);
		bindingSet.Bind(curRarityIconSelected.gameObject).For((GameObject v) => v.activeSelf).To((HeroGrowRarityViewModel vm) => vm.MidPointSelected);
		bindingSet.Bind(littlePointFinishGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityViewModel vm) => (int)vm.LayerState != 1);
		bindingSet.Bind(midPointCanLightGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityViewModel vm) => (int)vm.LayerState == 3);
		if (effectsWhenLayerLighted != null)
		{
			foreach (GameObject item in effectsWhenLayerLighted)
			{
				bindingSet.Bind(item).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityViewModel vm) => (int)vm.LayerState == 4);
			}
		}
		bindingSet.Bind().For((HeroGrowRarityView v) => v.OnCurLayerChanged).To((HeroGrowRarityViewModel vm) => vm.OnCurLayerChanged);
		bindingSet.Bind().For((HeroGrowRarityView v) => v.OnFocusItem).To((HeroGrowRarityViewModel vm) => vm.FocusPointRequest);
		bindingSet.Bind().For((HeroGrowRarityView v) => v.OnPointItemLighted).To((HeroGrowRarityViewModel vm) => vm.OnPointItemLighted);
		bindingSet.Bind().For((HeroGrowRarityView v) => v.OnMiddleItemLighted).To((HeroGrowRarityViewModel vm) => vm.OnMiddleItemLighted);
		bindingSet.Bind().For((HeroGrowRarityView v) => v.OnSpineAniChanged).To((HeroGrowRarityViewModel vm) => vm.OnSpineAniChanged);
		bindingSet.Build();
		btnLeftArrow.onClick.AddListener(delegate
		{
			StartLayerChangeTween(-1);
		});
		btnRightArrow.onClick.AddListener(delegate
		{
			StartLayerChangeTween(1);
		});
		for (int num = 0; num < items.Count; num++)
		{
			items[num].Init(new HeroGrowRarityItemData(_viewModel, _viewModel.IsSelf));
		}
	}

	public override void Show()
	{
		OnCurLayerChanged();
		OnSpineAniChanged();
		base.Show();
	}

	public override void Hide()
	{
		_viewModel.ResetCurLayer();
		base.Hide();
	}

	private void OnCurLayerChanged(object sender = null, InteractionEventArgs e = null)
	{
		DRHeroSeat dRHeroSeat = null;
		if (e == null)
		{
			if (_viewModel.HeroSeatConfigs.ContainsKey(_viewModel.CurLayer))
			{
				dRHeroSeat = _viewModel.HeroSeatConfigs[_viewModel.CurLayer];
			}
		}
		else
		{
			dRHeroSeat = (DRHeroSeat)e.Context;
		}
		if (dRHeroSeat == null)
		{
			curRarityBtn.enabled = false;
			items.ForEach(delegate(HeroGrowRarityItem p)
			{
				p.Visibility = false;
			});
			return;
		}
		if (dRHeroSeat.TargetSeat <= _viewModel.HeroModel.RawDestinyLevel)
		{
			curRarityBtn.enabled = false;
			items.ForEach(delegate(HeroGrowRarityItem p)
			{
				p.Visibility = false;
			});
		}
		else
		{
			curRarityBtn.enabled = true;
			int destinyLevel = _viewModel.HeroModel.DestinyLevel;
			List<int> destinyData = _viewModel.HeroModel.DestinyData;
			for (int num = 0; num < items.Count; num++)
			{
				items[num].RefreshData(num + 1, dRHeroSeat, destinyLevel, destinyData);
				items[num].Visibility = true;
			}
		}
		((TMP_Text)curRarityDesc).text = "<rotate=-90>" + dRHeroSeat.Desc + "</rotate>";
		((TMP_Text)curRarityDesc).text = ((TMP_Text)curRarityDesc).text.Replace("\\n", "\n");
		if (e != null)
		{
			alphaRoot.SetActive(value: false);
			alphaRoot.SetActive(value: true);
		}
		layerLightedEffect.gameObject.SetActive(_viewModel.LayerState == HeroGrowRarityItemData.ItemStateEnum.Lighted);
	}

	private void OnPointItemLighted(object sender, InteractionEventArgs e)
	{
		int num = (pointLighted = (int)e.Context);
		if (items.Count >= num)
		{
			items[num - 1].OnLighted();
			_viewModel.UpdateWindowMaskTime(pointLightTime);
			Invoke("Go2NextPoint", pointLightTime);
		}
	}

	private void Go2NextPoint()
	{
		if (items.Count > pointLighted)
		{
			items[pointLighted].RefreshItemState(_viewModel.HeroModel.DestinyLevel, _viewModel.HeroModel.DestinyData);
			return;
		}
		ShowPointFinishEffect();
		_viewModel.RefreshLayerState();
	}

	private void OnMiddleItemLighted(object sender, InteractionEventArgs e)
	{
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		if (configAudioIds.Count >= _viewModel.CurLayer)
		{
			EventInstance val = Singleton<AudioSystem>.Instance.CreateInstance(configAudioIds[_viewModel.CurLayer - 1], 1f);
			if (((EventInstance)(ref val)).isValid())
			{
				((EventInstance)(ref val)).start();
			}
		}
		layerLightedEffect.gameObject.SetActive(value: false);
		layerLightedEffect.gameObject.SetActive(value: true);
		if (_viewModel.CurLayer < _viewModel.MaxLayer)
		{
			_viewModel.UpdateWindowMaskTime(effectUpTime + spineUpTime);
			Invoke("PlaySpineAnimation", effectUpTime);
			Invoke("Go2NextLayer", effectUpTime + spineUpTime);
		}
		else
		{
			_viewModel.LayerState = HeroGrowRarityItemData.ItemStateEnum.Lighted;
		}
	}

	private void PlaySpineAnimation()
	{
		SetSpineAnimation($"Seat0{_viewModel.CurLayer + 1}", loop: false);
	}

	private void Go2NextLayer()
	{
		_viewModel.CurLayer++;
	}

	private void OnSpineAniChanged(object sender = null, InteractionEventArgs e = null)
	{
		string curSpineAniName = _viewModel.CurSpineAniName;
		if (!string.IsNullOrEmpty(curSpineAniName))
		{
			SetSpineAnimation(curSpineAniName, curSpineAniName.EndsWith("_idle"));
		}
	}

	private void OnFocusItem(object sender, InteractionEventArgs e)
	{
		int num = (int)e.Context;
		RectTransform targetItem = ((num > 0 && items.Count > num - 1) ? items[num - 1].RectTransform : null);
		FocusItem(targetItem);
	}

	public void FocusItem(RectTransform targetItem = null)
	{
		Vector3 vector = ((targetItem == null) ? Vector3.one : (Vector3.one * maxViewScale));
		Vector2 vector2 = ((targetItem == null) ? Vector2.zero : ((viewCenter.anchoredPosition - targetItem.anchoredPosition) * 1f));
		if (targetItem == null)
		{
			moveRect.SetPivotWithCurrentPosition(Vector2.one * 0.5f);
		}
		else
		{
			Vector2 sizeDelta = moveRect.sizeDelta;
			Vector2 anchoredPosition = targetItem.anchoredPosition;
			moveRect.SetPivotWithCurrentPosition(new Vector2((anchoredPosition.x + sizeDelta.x / 2f) / sizeDelta.x, (anchoredPosition.y + sizeDelta.y / 2f) / sizeDelta.y));
			vector2 += moveRect.anchoredPosition;
		}
		if (moveTween == null)
		{
			moveTween = DOTween.To(() => moveRect.anchoredPosition, delegate(Vector2 x)
			{
				moveRect.anchoredPosition = x;
			}, vector2, moveTime).SetEase(Ease.OutSine).OnKill(delegate
			{
				moveTween = null;
			})
				.SetAutoKill()
				.SetId(moveTweenId);
		}
		else
		{
			moveTween.ChangeEndValue(vector2, moveTime, snapStartValue: true);
		}
		if (scaleTween == null)
		{
			scaleTween = DOTween.To(() => moveRect.localScale, delegate(Vector3 x)
			{
				moveRect.localScale = x;
			}, vector, scaleTime).SetEase(Ease.OutSine).OnKill(delegate
			{
				scaleTween = null;
			})
				.SetAutoKill()
				.SetId(scaleTweenId);
		}
		else
		{
			scaleTween.ChangeEndValue(vector, scaleTime, snapStartValue: true);
		}
	}

	private void ShowPointFinishEffect()
	{
		pointFinishEffect.SetActive(value: false);
		pointFinishEffect.SetActive(value: true);
		Invoke("HidePointFinishEffect", pointFinishEffectTime);
	}

	private void HidePointFinishEffect()
	{
		pointFinishEffect.SetActive(value: false);
	}

	private void StartLayerChangeTween(int direction)
	{
		float endValue = ((direction > 0) ? (0f - moveDistance + rawMidIconPosX) : (moveDistance + rawMidIconPosX));
		float endValue2 = ((direction > 0) ? (moveDistance + rawMidIconPosX) : (0f - moveDistance + rawMidIconPosX));
		_viewModel.UpdateWindowMaskTime(changeTime * 2f);
		Sequence s = DOTween.Sequence();
		s.Append(((Component)(object)raritySpine).GetComponent<RectTransform>().DOLocalMoveX(endValue, changeTime));
		s.Append(((Component)(object)raritySpine).GetComponent<RectTransform>().DOLocalMoveX(endValue2, 0f));
		s.Append(((Component)(object)raritySpine).GetComponent<RectTransform>().DOLocalMoveX(rawMidIconPosX, changeTime));
		s.InsertCallback(changeTime, delegate
		{
			if (direction > 0)
			{
				_viewModel.CurLayer++;
			}
			else
			{
				_viewModel.CurLayer--;
			}
		});
	}

	private void SetSpineAnimation(string aniName, bool loop)
	{
		raritySpine.AnimationState.SetAnimation(0, aniName, loop);
	}

	public void SetInPreviewMode(bool inPreview)
	{
		for (int i = 0; i < items.Count; i++)
		{
			items[i].SetInPreviewMode(inPreview);
		}
	}

	protected override void OnDestroy()
	{
		moveTween?.Kill();
		moveTween = null;
		scaleTween?.Kill();
		scaleTween = null;
		base.OnDestroy();
	}
}
