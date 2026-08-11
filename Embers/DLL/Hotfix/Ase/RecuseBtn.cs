using Ase.ECS;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class RecuseBtn : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	public CircleImage icon;

	public HeroSkillTypeEnum optionType;

	[HideInInspector]
	public UnityEventInput onPointerUp;

	[HideInInspector]
	public UnityEventInput onPointerDown;

	private Tween canvasGroupTween;

	public CanvasGroup CanvasGroupComp;

	private BattleHeroData viewMode;

	private bool isInit;

	private bool isCanClick = true;

	public void Init(BattleHeroData battleHero)
	{
		viewMode = battleHero;
		BindingSet<RecuseBtn, BattleHeroData> bindingSet = this.CreateBindingSet(battleHero);
		if (optionType == HeroSkillTypeEnum.Rescue1)
		{
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleHeroData vm) => vm.WaitRecuseHeroId1 != 0);
			bindingSet.Bind(icon).For((CircleImage v) => v.sprite).ToExpression((BattleHeroData vm) => $"UserHead{vm.WaitRecuseHeroId1}")
				.WithConversion("ItemIcon");
		}
		else
		{
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleHeroData vm) => vm.WaitRecuseHeroId2 != 0);
			bindingSet.Bind(icon).For((CircleImage v) => v.sprite).ToExpression((BattleHeroData vm) => $"UserHead{vm.WaitRecuseHeroId2}")
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (isCanClick && onPointerDown != null)
		{
			onPointerDown.Invoke(optionType);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (isCanClick && onPointerUp != null)
		{
			onPointerUp.Invoke(optionType);
		}
	}

	public void RefreshData(BattleHeroData battleHero)
	{
		if (!isInit)
		{
			Init(battleHero);
			isInit = true;
		}
		else
		{
			viewMode = battleHero;
			this.SetDataContext(battleHero);
		}
	}

	public void SetBtnAlphaTween(bool isShow)
	{
		if (canvasGroupTween != null && canvasGroupTween.IsPlaying())
		{
			canvasGroupTween.Kill();
			canvasGroupTween = null;
		}
		if (isShow)
		{
			CanvasGroupComp.alpha = 0f;
			canvasGroupTween = DOTweenModuleUI.DOFade(CanvasGroupComp, 1f, 0.3f).OnComplete(delegate
			{
				canvasGroupTween = null;
			});
		}
		else
		{
			CanvasGroupComp.alpha = 1f;
			canvasGroupTween = DOTweenModuleUI.DOFade(CanvasGroupComp, 0f, 0.3f).OnComplete(delegate
			{
				canvasGroupTween = null;
			});
		}
		isCanClick = isShow;
	}

	public void SetBtnAlpha(bool isShow)
	{
		if (canvasGroupTween != null && canvasGroupTween.IsPlaying())
		{
			canvasGroupTween.Kill();
			canvasGroupTween = null;
		}
		if (isShow)
		{
			CanvasGroupComp.alpha = 1f;
		}
		else
		{
			CanvasGroupComp.alpha = 0f;
		}
		isCanClick = isShow;
	}
}
