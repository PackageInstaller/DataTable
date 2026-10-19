using System;
using System.Threading;
using ACT.Model;
using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class InteractBtn : Selectable, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler
{
	[Serializable]
	public class InteractBtnAniState
	{
		public float scale;

		public Color color;

		public CanvasGroup stateCanva;

		public CanvasGroup stateCanva2;
	}

	public Graphic[] graphics;

	public GameObject selectedEffect;

	public InteractBtnAniState normal;

	public InteractBtnAniState presssed;

	public InteractBtnAniState selected;

	protected InteractBtnAniState current;

	public Color disabledColor;

	public Button button;

	public TextMeshProUGUI text;

	public LocalizeStringEvent localizeStringEvent;

	public CancellationTokenSource CTS;

	public float duration = 0.2f;

	public RectTransform rectTransform;

	public Animator anim;

	private bool _isDisabling;

	public bool hasSelected { get; set; }

	public bool isFirstbtn { get; set; }

	public new bool interactable
	{
		get
		{
			return GetInteractable();
		}
		set
		{
			SetInteractable(value);
			UpdateBtn();
		}
	}

	public bool controlAllBtnAnim { get; set; }

	public event Action pointerClick;

	private new void Awake()
	{
		rectTransform = GetComponent<RectTransform>();
		Apply(normal);
	}

	private static void SetInteractBtnAniStateAlpha(InteractBtnAniState btnAniState, float alpha)
	{
		if (btnAniState != null)
		{
			SetCanvasGroupAlpha(btnAniState.stateCanva, alpha);
			SetCanvasGroupAlpha(btnAniState.stateCanva2, alpha);
		}
	}

	private static void SetCanvasGroupAlpha(CanvasGroup group, float alpha)
	{
		if (!(group == null))
		{
			group.alpha = alpha;
		}
	}

	public void Apply(InteractBtnAniState interactBtnAniState)
	{
		if (interactBtnAniState == null)
		{
			return;
		}
		if (interactBtnAniState == selected)
		{
			SetInteractBtnAniStateAlpha(selected, 1f);
			SetInteractBtnAniStateAlpha(presssed, 0f);
			SetInteractBtnAniStateAlpha(normal, 0f);
		}
		else if (interactBtnAniState == normal)
		{
			SetInteractBtnAniStateAlpha(selected, 0f);
			SetInteractBtnAniStateAlpha(presssed, 0f);
			SetInteractBtnAniStateAlpha(normal, 1f);
		}
		else if (interactBtnAniState == presssed)
		{
			SetInteractBtnAniStateAlpha(selected, 0f);
			SetInteractBtnAniStateAlpha(presssed, 1f);
			SetInteractBtnAniStateAlpha(normal, 0f);
		}
		KillTweens();
		ApplyScale(interactBtnAniState);
		if (graphics != null)
		{
			for (int i = 0; i < graphics.Length; i++)
			{
				Graphic graphic = graphics[i];
				if (graphic == null)
				{
					if (!LuminApplication.LogEnabled)
					{
					}
				}
				else
				{
					ApplyGraphicColor(graphic, GetInteractable() ? interactBtnAniState.color : disabledColor);
				}
			}
		}
		ApplyStateEffect(interactBtnAniState);
		current = interactBtnAniState;
	}

	private void ApplyScale(InteractBtnAniState interactBtnAniState)
	{
		Vector3 vector = Vector3.one * interactBtnAniState.scale;
		if (_isDisabling || !isActiveAndEnabled || !gameObject.activeInHierarchy)
		{
			transform.localScale = vector;
		}
		else
		{
			transform.DOScale(vector, duration).SetTarget(this).SetLink(gameObject, LinkBehaviour.KillOnDisable);
		}
	}

	private void ApplyGraphicColor(Graphic graphic, Color color)
	{
		if (_isDisabling || !isActiveAndEnabled || !gameObject.activeInHierarchy || !graphic.gameObject.activeInHierarchy)
		{
			graphic.color = color;
		}
		else
		{
			graphic.DOColor(color, duration).SetTarget(this).SetLink(graphic.gameObject, LinkBehaviour.KillOnDisable);
		}
	}

	private void KillTweens()
	{
		DOTween.Kill(this);
	}

	public virtual void ApplyStateEffect(InteractBtnAniState interactBtnAniState)
	{
		if (!(selectedEffect == null))
		{
			if (interactBtnAniState == selected)
			{
				selectedEffect.SetActive(value: true);
			}
			else
			{
				selectedEffect.SetActive(value: false);
			}
		}
	}

	public void UpdateBtn()
	{
		Apply(current);
	}

	public virtual bool GetInteractable()
	{
		if (!(button == null))
		{
			return button.interactable;
		}
		return true;
	}

	public virtual void SetInteractable(bool value)
	{
		if (!(button == null))
		{
			button.interactable = value;
		}
	}

	public new virtual void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			Apply(presssed);
		}
	}

	public new virtual void OnPointerUp(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			Model<InteractModel>.Interface.OnCommonBtnPointUp();
		}
	}

	public virtual void OnPointerClick(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			if (controlAllBtnAnim)
			{
				pointerClick?.Invoke();
			}
			else if ((bool)anim)
			{
				anim.Play("Hide");
			}
		}
	}

	public void DoTransition(Vector3 to)
	{
		rectTransform.anchoredPosition3D = to;
	}

	public InteractBtnAniState GetCurreBtnAniState()
	{
		return current;
	}

	protected override void OnDisable()
	{
		_isDisabling = true;
		KillTweens();
		Apply(normal);
		_isDisabling = false;
		pointerClick = null;
		controlAllBtnAnim = false;
		base.OnDisable();
	}

	protected override void OnDestroy()
	{
		KillTweens();
		base.OnDestroy();
	}
}
