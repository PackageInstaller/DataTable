using System;
using ACT.Config;
using ACT.Model;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PhaseItem : MonoBehaviour
{
	public enum State
	{
		Normal = 1,
		Locked = 4,
		Selected = 8,
		Completed = 0x10
	}

	[SerializeField]
	private Image ImgStateNormal;

	[SerializeField]
	private Image ImgStateHighlight;

	[SerializeField]
	private Image ImgStateLocked;

	[SerializeField]
	private Image ImgStateSelected;

	[SerializeField]
	private Image ImgStateComplete;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private RedDotItem redDotItem;

	public Action<PhaseItem> OnItemClickAction;

	private State _showState;

	private ActivityChallengeGroup _staticInfo;

	private Button Btn;

	public ActivityChallengeGroup StaticInfo => _staticInfo;

	public void SetSelected(bool flag)
	{
		if (flag)
		{
			SetState(_showState | State.Selected);
		}
		else
		{
			SetState(_showState & (State)(-9));
		}
	}

	public State GetState()
	{
		return _showState;
	}

	public void SetState(State state)
	{
		_showState = state;
		if ((_showState & State.Normal) != 0)
		{
			text.gameObject.SetActive(value: true);
			ImgStateNormal.gameObject.SetActive(value: true);
			ImgStateLocked.gameObject.SetActive(value: false);
			if ((_showState & State.Completed) != 0)
			{
				ImgStateComplete.gameObject.SetActive(value: true);
			}
			else
			{
				ImgStateComplete.gameObject.SetActive(value: false);
			}
			if ((_showState & State.Selected) != 0)
			{
				ImgStateSelected.gameObject.SetActive(value: true);
				if ((_showState & State.Completed) == 0)
				{
					ImgStateHighlight.gameObject.SetActive(value: true);
					ImgStateNormal.gameObject.SetActive(value: false);
				}
			}
			else
			{
				ImgStateHighlight.gameObject.SetActive(value: false);
				ImgStateSelected.gameObject.SetActive(value: false);
				ImgStateNormal.gameObject.SetActive(value: true);
			}
		}
		else if ((_showState & State.Locked) != 0)
		{
			text.gameObject.SetActive(value: false);
			ImgStateNormal.gameObject.SetActive(value: false);
			ImgStateLocked.gameObject.SetActive(value: true);
			if ((_showState & State.Selected) != 0)
			{
				ImgStateSelected.gameObject.SetActive(value: true);
			}
			else
			{
				ImgStateSelected.gameObject.SetActive(value: false);
			}
		}
	}

	public void Init(string txt, ActivityExploreChallengeModel.ChallengePhaseInfo info)
	{
		_staticInfo = info.ActivityChallengeGroupData;
		text.text = txt;
		if (info.UnLocked)
		{
			SetState(State.Normal);
		}
		else
		{
			SetState(State.Locked);
		}
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
	}

	public void OnItemClick()
	{
		OnItemClickAction?.Invoke(this);
	}

	public void Awake()
	{
		Btn = GetComponent<Button>();
	}

	public void Start()
	{
		Btn.SetBtnClick(OnItemClick, "event:/UI/Interface/Plan/List/Choice");
	}
}
