using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

namespace WaterPipeGame;

public class WaterPipeEventEntity : SerializedMonoBehaviour
{
	public Image normalImg;

	public Image passImg;

	public Image orderImg;

	[HideInInspector]
	public PipeType pipeType;

	private Animator animator;

	private string spriteName;

	private IUIController controller;

	private bool isLink;

	private int order;

	public void Awake()
	{
		controller = base.transform.GetComponent<IUIController>();
		animator = base.transform.GetComponent<Animator>();
		UpdateAnimatorState(isPlay: false);
	}

	public void UpdateAnimatorState(bool isPlay)
	{
		if (!(animator == null))
		{
			animator.enabled = isPlay;
		}
	}

	public void InitData(WaterPipeItemSaveData saveData)
	{
		pipeType = saveData.pipeType;
		spriteName = saveData.spriteName;
		isLink = false;
		orderImg.gameObject.SetActive(value: false);
		UpdateState(isFinish: false);
		UpdateImg();
	}

	public void SetLink(bool isLink)
	{
		this.isLink = isLink;
	}

	public bool GetLink()
	{
		return isLink;
	}

	public void PlayIngShow()
	{
		if (controller != null)
		{
			controller.SetSelectedState("ing");
		}
		UpdateAnimatorState(isPlay: true);
		if (pipeType == PipeType.BOX)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_event01", useStream: false);
		}
		else if (pipeType == PipeType.NPC)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_event02", useStream: false);
		}
		else if (pipeType == PipeType.EVENT)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_event03", useStream: false);
		}
	}

	public void UpdateState(bool isFinish)
	{
		if (controller != null)
		{
			controller.SetSelectedState(isFinish ? "pass" : "normal");
		}
		if (isFinish && pipeType == PipeType.END)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_finish", useStream: false);
		}
		UpdateAnimatorState(isFinish);
	}

	public void UpdateImg()
	{
		string spritePath = WaterPipeTools.GetSpritePath(spriteName, pipeType);
		normalImg.sprite = AtlasManager.GetSpriteWithoutAtlas(spritePath);
		string spritePath2 = WaterPipeTools.GetSpritePath(spriteName, pipeType, PipeState.FINISH);
		passImg.sprite = AtlasManager.GetSpriteWithoutAtlas(spritePath2);
	}

	public void SetOrder(int order)
	{
		if (!(orderImg == null))
		{
			if (order == -1)
			{
				orderImg.gameObject.SetActive(value: false);
			}
			else
			{
				orderImg.gameObject.SetActive(value: true);
				orderImg.sprite = AtlasManager.GetSpriteWithoutAtlas(WaterPipeTools.GetOrderSpritePath(order + 1));
			}
			this.order = order;
		}
	}

	public int GetOrder()
	{
		return order;
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
