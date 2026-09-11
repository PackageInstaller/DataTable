using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0BedGameSelectItem : MonoBehaviour
{
	private bool isSelect;

	private bool isLock;

	private ControllerExCollection controllerEx;

	private ControllerEx selectController;

	private ControllerEx lockController;

	private BedGameSelectBaseData itemData;

	private Button btn_;

	public Animation unlockAni_;

	public AnimationClip unlockAniClip_;

	public AnimationClip defaultAniClip_;

	private Action<int, BedSelectEnum> clickCallback;

	public void InitUI()
	{
		controllerEx = GetComponent<ControllerExCollection>();
		if ((bool)controllerEx)
		{
			selectController = controllerEx.GetController("select");
			lockController = controllerEx.GetController("lock");
		}
	}

	private void Awake()
	{
		AddBtnListeners();
	}

	public void AddBtnListeners()
	{
		if (btn_ == null)
		{
			btn_ = GetComponent<Button>();
			btn_.onClick.AddListener(delegate
			{
				OnClickBtn();
			});
		}
	}

	public void SetClickCallback(Action<int, BedSelectEnum> callback_)
	{
		clickCallback = callback_;
	}

	private void OnClickBtn()
	{
		if (!isLock)
		{
			clickCallback?.Invoke(itemData.selectID, itemData.selectType);
		}
	}

	public void SetSelectState(bool select_)
	{
		isSelect = select_;
		if (selectController != null)
		{
			if (isSelect)
			{
				selectController.SetSelectedState("select");
			}
			else
			{
				selectController.SetSelectedState("normal");
			}
		}
	}

	private void SetLockAniPlay(AnimationClip clip)
	{
		unlockAni_.clip = clip;
		if (unlockAni_.GetClip(clip.name) == null)
		{
			unlockAni_.AddClip(clip, clip.name);
		}
		unlockAni_.Stop();
		if (unlockAni_.playAutomatically)
		{
			unlockAni_.Play();
		}
	}

	public void SetLockState(bool isLock_)
	{
		if (lockController != null)
		{
			if (isLock_)
			{
				lockController.SetSelectedState("lock");
			}
			else
			{
				if (!isLock)
				{
					SetLockAniPlay(defaultAniClip_);
				}
				else
				{
					AudioManager.Instance.Play("effect", "ui_scene_104402", "ui_scene_104402_unlock", useStream: false);
					SetLockAniPlay(unlockAniClip_);
				}
				lockController.SetSelectedState("normal");
			}
		}
		isLock = isLock_;
	}

	public void SetData(BedGameSelectBaseData data)
	{
		itemData = data;
		SetLockState(isLock_: false);
		SetSelectState(select_: false);
	}

	public void Dispose()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}
}
