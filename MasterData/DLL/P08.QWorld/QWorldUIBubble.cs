using System;
using UnityEngine;
using UnityEngine.UI;

public class QWorldUIBubble : MonoBehaviour
{
	private IBubbleHolder bubbleHolder;

	public Animator animator;

	private Action<int> clickHandler;

	private int id;

	private int bubbleType;

	private float startReturnTime;

	private bool curFrameReturn;

	private bool isInUse;

	private static int BackPoolAnim = Animator.StringToHash("UI_SandPlay_ChoiceItem_01");

	private static int ShowAnim = Animator.StringToHash("UI_SandPlay_ChoiceItem");

	private static float BackPoolTime = 0.27f;

	public Button actionButton;

	public Text text;

	public Image icon;

	public void SetText(string content)
	{
		if (text != null)
		{
			text.text = content;
		}
	}

	public void SetIcon(string iconPath)
	{
		if (iconPath.IsNotNullOrEmpty() && iconPath != "")
		{
			AtlasManager.GetSpriteWithoutAtlas(icon, iconPath);
		}
		else
		{
			AtlasManager.GetSpriteWithoutAtlas(icon, "TextureConfig/SandPlay/MiniIcon/SandPlay_icon_00001");
		}
	}

	public void SetPosition()
	{
	}

	public void Init(int id, int bubbleType, IBubbleHolder bubbleHolder)
	{
		this.bubbleHolder = bubbleHolder;
		startReturnTime = 0f;
		base.gameObject.SetActive(value: true);
		this.id = id;
		this.bubbleType = bubbleType;
		actionButton.onClick.AddListener(delegate
		{
			OnClick();
		});
		OnCreate();
	}

	public void RegisterClick(Action<int> clickAction)
	{
		clickHandler = clickAction;
	}

	public void RemoveAllListener()
	{
		clickHandler = null;
	}

	public void Return(bool force)
	{
		if (isInUse)
		{
			startReturnTime = Time.time;
			curFrameReturn = true;
			isInUse = false;
			if (force)
			{
				Recycle();
				return;
			}
			animator?.CrossFade(BackPoolAnim, 0.05f, 0, 0f);
			QWorldScene.Scene.bubbleMgr.ReturnOnWait(this);
		}
	}

	public void CheckCanReturn()
	{
		if (Time.time - startReturnTime > BackPoolTime)
		{
			Recycle();
		}
	}

	private void Recycle()
	{
		RemoveAllListener();
		clickHandler = null;
		actionButton.onClick.RemoveAllListeners();
		bubbleHolder.OnBubbleRecycle(id, this);
		id = -1;
		bubbleHolder = null;
		QWorldScene.Scene.bubbleMgr.Return(this);
	}

	public bool CheckCurFrameReturn()
	{
		if (curFrameReturn)
		{
			curFrameReturn = false;
			return true;
		}
		return false;
	}

	public void OnClick()
	{
		if (clickHandler != null && isInUse)
		{
			clickHandler(id);
		}
	}

	public virtual void OnCreate()
	{
		curFrameReturn = false;
		isInUse = true;
		animator?.CrossFade(ShowAnim, 0.05f, 0, 0f);
	}

	public virtual void OnReturn()
	{
		base.gameObject.SetActive(value: false);
	}

	public int GetId()
	{
		return id;
	}

	public int GetBubbleType()
	{
		return bubbleType;
	}

	public void OnReuse()
	{
		isInUse = true;
		QWorldScene.Scene.bubbleMgr.ReuseBubble(this);
		animator?.CrossFade(ShowAnim, 0.05f, 0, 0f);
	}
}
