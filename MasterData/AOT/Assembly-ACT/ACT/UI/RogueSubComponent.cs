using System.Collections.Generic;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueSubComponent<T> : SubUIView<T>, IRogueSubComponent where T : class, ISubInputController, new()
{
	public ViewControlLayer controlLayer;

	public GamePadTipsComp gamePadGroup;

	protected bool m_canRightStickScroll;

	protected Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	protected List<GamePadTipsAction> _tipsActions;

	public GameObject GameObject => gameObject;

	public ViewControlLayer ControlLayer => controlLayer;

	public ScrollRect ScrollRect { get; protected set; }

	public RightStickScrollSupport RightStickScrollSupport { get; protected set; }

	public virtual void Bind()
	{
		OnGamePadInit();
		ReBindBtnPrompt();
		FocusIn();
	}

	public virtual void Unbind()
	{
		FocusOut();
	}

	protected virtual void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		};
	}

	public virtual void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup?.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup?.RegisterInputActions(_tipsActions);
	}

	public void BindScrollRect()
	{
		ScrollRect = EventSystemHelper.CurrentSelected?.GetComponentInChildren<ScrollRect>();
		RightStickScrollSupport = ScrollRect?.GetComponent<RightStickScrollSupport>();
	}

	public void RefreshRightStickScrollForbid()
	{
		ScrollRect scrollRect = ScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (rightStickScrollSupport == null || scrollRect == null)
		{
			m_canRightStickScroll = scrollRect != null && scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (scrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		}
		bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect scrollRect = ScrollRect;
			if (!(scrollRect == null))
			{
				scrollRect.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
		}
	}
}
