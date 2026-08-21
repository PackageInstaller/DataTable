using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class InteractiveBtn : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	public Image icon;

	public HeroSkillTypeEnum optionType;

	[HideInInspector]
	public UnityEventInput onPointerUp;

	[HideInInspector]
	public UnityEventInput onPointerDown;

	public CanvasGroup CanvasGroupComp;

	public Image ClickImage;

	public Image FillImage;

	public Image RayCastTarget;

	private HeroSkill viewMode;

	private bool isInit;

	private Tween canvasGroupTween;

	public TextMeshProUGUI NameText;

	public float InteractiveTime;

	private bool isPressDown;

	public void Init(HeroSkill heroSkill)
	{
		viewMode = heroSkill;
		BindingSet<InteractiveBtn, HeroSkill> bindingSet = this.CreateBindingSet(heroSkill);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((HeroSkill vm) => vm.IconBattle)
			.WithConversion("ItemIcon");
		bindingSet.Bind(FillImage).For((Image v) => v.fillAmount).To((HeroSkill vm) => vm.InteractionCooling);
		bindingSet.Bind(RayCastTarget).For((Image v) => v.raycastTarget).ToExpression((HeroSkill vm) => vm.InteractionCooling == 0f);
		bindingSet.Build();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (onPointerDown != null)
		{
			onPointerDown.Invoke(optionType);
			DOTweenModuleUI.DOFade(ClickImage, 1f, 0.1f);
			isPressDown = true;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (onPointerUp != null)
		{
			onPointerUp.Invoke(optionType);
			isPressDown = false;
		}
	}

	public void RefreshInteractionInfo(float time, string interName)
	{
		InteractiveTime = time;
		((TMP_Text)NameText).text = interName;
	}

	public void RefreshData(HeroSkill heroSkill)
	{
		if (!isInit)
		{
			Init(heroSkill);
			isInit = true;
		}
		else
		{
			viewMode = heroSkill;
			this.SetDataContext(heroSkill);
		}
	}

	private void OnEnable()
	{
		SetBtnAlphaTween(isShow: true);
	}

	private void OnDisable()
	{
		if (isPressDown && onPointerUp != null)
		{
			onPointerUp.Invoke(optionType);
			isPressDown = false;
		}
	}

	public void SetBtnAlphaTween(bool isShow)
	{
		if (canvasGroupTween != null)
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
	}

	public void SetBtnAlpha(bool isShow)
	{
		if (canvasGroupTween != null)
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
	}
}
