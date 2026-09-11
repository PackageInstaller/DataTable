using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardStateUIBase : MonoBehaviour
{
	public virtual void Init()
	{
		Debug.Log("RogueCardStateU没有重写Init()");
	}

	public virtual void OnEnter()
	{
		base.transform.SetActive(bActive: true);
	}

	public virtual void OnExit()
	{
		base.transform.SetActive(bActive: false);
	}

	public virtual void RefreshUI()
	{
	}

	protected void AddBtnListener(Button button, UnityAction func)
	{
		button.onClick.RemoveAllListeners();
		button.onClick.AddListener(delegate
		{
			if (!RogueCardGameMain.CheckDisableInput())
			{
				func();
			}
		});
	}

	protected void AddForceBtnListener(Button button, UnityAction func)
	{
		button.onClick.RemoveAllListeners();
		button.onClick.AddListener(func);
	}
}
