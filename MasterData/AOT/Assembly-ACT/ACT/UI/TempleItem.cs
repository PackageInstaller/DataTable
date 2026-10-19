using System;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleItem : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, ISelectHandler, IDeselectHandler
{
	public enum State
	{
		Normal = 1,
		Locked = 4,
		Selected = 8,
		Completed = 0x10,
		UnKnown = 0x20,
		Hover = 0x40
	}

	[SerializeField]
	private Image imgBgNormal;

	[SerializeField]
	private GameObject goStateNormal;

	[SerializeField]
	private Image imgBgSelected;

	[SerializeField]
	private TextMeshProUGUI txtTempleName;

	[SerializeField]
	private Image imgBgSelectedDone;

	[SerializeField]
	private Image imgBgNormalDone;

	[SerializeField]
	private GameObject goLock;

	[SerializeField]
	private GameObject goUnknown;

	[SerializeField]
	private Image imgXuranFu;

	[SerializeField]
	private LocalizeStringEvent txtName;

	[SerializeField]
	private Image[] imgStarList;

	[SerializeField]
	private BetterAnimation betterAnimation;

	private const string txtTempleNameColorSelected = "#ffffff";

	private const string txtTempleNameColor = "#ffffff";

	private TempleData _templeData;

	private State _showState;

	private Button Btn;

	public Action<TempleItem> OnItemClickAction;

	public TempleData TempleData => _templeData;

	public State GetState()
	{
		return _showState;
	}

	public void SetState(State state)
	{
		_showState = state;
		if ((_showState & State.Normal) != 0)
		{
			if ((_showState & State.Hover) != 0)
			{
				imgXuranFu.gameObject.SetActive(value: true);
			}
			else if ((_showState & State.Selected) != 0)
			{
				imgXuranFu.gameObject.SetActive(value: false);
				imgBgSelected.gameObject.SetActive(value: true);
				ColorUtility.TryParseHtmlString("#ffffff", out var color);
				txtTempleName.color = color;
				imgBgSelectedDone.gameObject.SetActive((_showState & State.Completed) != 0);
			}
			else
			{
				ColorUtility.TryParseHtmlString("#ffffff", out var color2);
				txtTempleName.color = color2;
				imgBgSelected.gameObject.SetActive(value: false);
				imgBgNormalDone.gameObject.SetActive((_showState & State.Completed) != 0);
				imgXuranFu.gameObject.SetActive(value: false);
			}
			goLock.SetActive(value: false);
			goUnknown.SetActive(value: false);
			goStateNormal.SetActive(value: true);
		}
		else if ((_showState & State.Locked) != 0)
		{
			imgXuranFu.gameObject.SetActive(value: false);
			goLock.SetActive(value: true);
			goUnknown.SetActive(value: false);
			goStateNormal.SetActive(value: false);
			imgBgSelected.gameObject.SetActive(value: false);
			imgBgSelectedDone.gameObject.SetActive(value: false);
			imgBgNormalDone.gameObject.SetActive(value: false);
			UnityEngine.Object.Destroy(transform.GetComponent<ACT.ViewControl.SelectableEx>());
		}
		else if ((_showState & State.UnKnown) != 0)
		{
			imgXuranFu.gameObject.SetActive(value: false);
			goUnknown.SetActive(value: true);
			goLock.SetActive(value: false);
			goStateNormal.SetActive(value: false);
			imgBgSelected.gameObject.SetActive(value: false);
			imgBgSelectedDone.gameObject.SetActive(value: false);
			imgBgNormalDone.gameObject.SetActive(value: false);
			UnityEngine.Object.Destroy(transform.GetComponent<ACT.ViewControl.SelectableEx>());
		}
	}

	public void SetSelected(bool flag)
	{
		if (flag)
		{
			SetState(_showState | State.Selected);
			betterAnimation.GetSequence("Select").Play();
			return;
		}
		if ((_showState & State.Selected) != 0 && (_showState & State.Normal) != 0)
		{
			betterAnimation.GetSequence("Normal").Play();
		}
		SetState(_showState & (State)(-9));
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		SetState(_showState | State.Hover);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		SetState(_showState & (State)(-65));
	}

	public override void Init(object param)
	{
		base.Init(param);
		TempleData templeData = (_templeData = param as TempleData);
		if (templeData.unLock)
		{
			State state = State.Normal;
			txtName.StringReference.TableEntryReference = templeData.staticData.name;
			if (templeData.isComplate)
			{
				SetState(state | State.Completed);
				for (int i = 0; i < imgStarList.Length; i++)
				{
					imgStarList[i].gameObject.SetActive(i < templeData.gotStars.Length && templeData.gotStars[i]);
				}
			}
			else
			{
				SetState(state);
				for (int j = 0; j < imgStarList.Length; j++)
				{
					imgStarList[j].gameObject.SetActive(j < templeData.gotStars.Length && templeData.gotStars[j]);
				}
			}
		}
		else if (!templeData.isExplored)
		{
			SetState(State.UnKnown);
		}
		else if (!templeData.unLock)
		{
			SetState(State.Locked);
		}
		if ((_showState & State.Selected) != 0)
		{
			betterAnimation.GetSequence("SelectedShow").Play();
		}
		else
		{
			betterAnimation.GetSequence("NormalShow").Play();
		}
	}

	protected void Awake()
	{
		Btn = GetComponent<Button>();
	}

	protected void Start()
	{
		Btn.SetBtnClick(OnItemClick, "event:/UI/Interface/Temple/Left_Click");
	}

	public void OnItemClick()
	{
		OnItemClickAction?.Invoke(this);
	}

	public void OnSelect(BaseEventData eventData)
	{
		SetState(_showState | State.Hover);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetState(_showState & (State)(-65));
	}
}
