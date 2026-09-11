using UnityEngine;

namespace RogueCard;

public class VisualRogueCard : VisualCardBase
{
	public RogueCardCommonView view;

	private Coroutine flyNumCorotine;

	[HideInInspector]
	public override bool CanSelect => true;

	public override void Initialize(RogueCard target, int index = 0)
	{
		base.Initialize(target, index);
	}

	public void ShowCardData(RogueCardData data)
	{
		if (data != null)
		{
			view.SetData(data);
		}
	}

	public override void SetSelect(bool isSelect)
	{
		view.SetSelect(isSelect);
	}

	public override void SetLookTips(bool isSelect)
	{
		view.SetLookTips(isSelect);
	}

	public void PlayFlyNum(string text, FlyNumberType type, bool speed = false)
	{
		if (flyNumCorotine != null)
		{
			StopCoroutine(flyNumCorotine);
		}
		view.flyNumber.HideText();
		flyNumCorotine = StartCoroutine(view.PlayFlyNum(text, type, speed));
	}

	public void PlayAnimation(string name, float speed = 1f)
	{
		view.PlayAnimation(name, speed);
	}
}
