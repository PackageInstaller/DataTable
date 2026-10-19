using ACT.Config;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EscShopBubbleItem : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler
{
	[SerializeField]
	private BImage _icon;

	[SerializeField]
	private LocalizeStringEvent _name;

	[SerializeField]
	private ActButton _button;

	[SerializeField]
	private Animator _animator;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
	}

	public void Refresh(BubbleSystem bubbleSystem, ImageAssetStation station)
	{
		if (bubbleSystem == null)
		{
			return;
		}
		station?.LoadImage(252, bubbleSystem.icon, _icon);
		_name.StringReference.TableEntryReference = bubbleSystem.bubblename;
		_button.SetBtnClick(() =>
		{
			if (bubbleSystem.jumpParam.Length != 0)
			{
				RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(bubbleSystem.jumpParam[0]);
				JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
				bool flag = jumpResult.ShowType == JumpResult.JumpShowType.CanJump;
				jumpResult.Release();
				if (flag)
				{
					Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
				}
			}
		});
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		_animator.Play("Above", 1);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		_animator.Play("Empty", 1);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_animator.Play("Click", 0);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_animator.Play("Normal", 0);
	}
}
