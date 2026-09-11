using System;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

namespace WaterPipeGame;

public class WaterPipeMapEntity : SerializedMonoBehaviour
{
	public int eventID;

	public Image img;

	public PipeType pipeType;

	public DIR dir;

	private WaterPipeItemSaveData pipeData;

	private bool isRotating;

	private bool isLink;

	private PipeState pipeState;

	private int pipeIndex;

	private void ChangePipeType()
	{
		if (Application.isPlaying)
		{
			ChangePipeNormalType();
		}
		else
		{
			ChangePipeEditorType();
		}
	}

	private void ChangePipeEditorType()
	{
		if (pipeType == PipeType.NONE)
		{
			img.enabled = false;
			return;
		}
		img.enabled = true;
		if (pipeData != null && pipeData.spriteName != "")
		{
			WaterPipeTools.GetSpritePath(pipeData.spriteName, pipeType);
			return;
		}
		if (pipeState == (PipeState)0)
		{
			pipeState = PipeState.NORMAL;
		}
		WaterPipeTools.GetRouteSpritePath(pipeType, pipeState);
	}

	private void ChangePipeNormalType()
	{
		if (pipeType == PipeType.NONE || pipeType == PipeType.ENTER || pipeType == PipeType.END)
		{
			img.enabled = false;
			return;
		}
		img.enabled = true;
		string text = (text = WaterPipeTools.GetRouteSpritePath(pipeType, pipeState));
		if (text != null)
		{
			img.sprite = AtlasManager.GetSpriteWithoutAtlas(text);
		}
	}

	public void ChangeDIR()
	{
		base.transform.eulerAngles = WaterPipeConst.dirDic[dir];
	}

	public WaterPipeItemSaveData GetSaveData()
	{
		WaterPipeItemSaveData waterPipeItemSaveData = new WaterPipeItemSaveData();
		waterPipeItemSaveData.pipeType = pipeType;
		waterPipeItemSaveData.dir = dir;
		waterPipeItemSaveData.eventID = eventID;
		if (pipeType == PipeType.EVENT || pipeType == PipeType.NPC || pipeType == PipeType.BOX)
		{
			waterPipeItemSaveData.spriteName = GetSpriteName();
		}
		return waterPipeItemSaveData;
	}

	public string GetSpriteName()
	{
		return img.sprite.name;
	}

	public void InitData(WaterPipeItemSaveData saveData, int pipeIndex)
	{
		dir = saveData.dir;
		pipeType = saveData.pipeType;
		pipeData = saveData;
		eventID = saveData.eventID;
		pipeState = PipeState.NORMAL;
		this.pipeIndex = pipeIndex;
		ChangePipeType();
		ChangeDIR();
	}

	private void Awake()
	{
		base.transform.GetComponent<Button>().onClick.AddListener(delegate
		{
			RotatePipe();
		});
	}

	public bool IsCanRotate()
	{
		if (WaterPipeGameManager.Instance.gameState == GameState.SHOWING)
		{
			return false;
		}
		if (isRotating)
		{
			return false;
		}
		if (pipeType == PipeType.I_PIPE || pipeType == PipeType.L_PIPE || pipeType == PipeType.T_PIPE)
		{
			return true;
		}
		return false;
	}

	public void RotatePipe()
	{
		if (IsCanRotate())
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_rotate", useStream: false);
			dir = WaterPipeTools.RotateDir(dir);
			Vector3 beginAngle = base.transform.eulerAngles;
			Vector3 targetAngle = beginAngle - new Vector3(0f, 0f, 90f);
			isRotating = true;
			LeanTween.value(0f, 1f, 0.1f).setOnUpdate(delegate(float value)
			{
				base.transform.eulerAngles = Vector3.Lerp(beginAngle, targetAngle, value);
			}).setOnComplete((Action)delegate
			{
				base.transform.eulerAngles = targetAngle;
				isRotating = false;
				WaterPipeGameManager.Instance.pipeItemManager.CheckStageFinish(pipeIndex);
			})
				.setEase(LeanTweenType.easeOutQuad);
		}
	}

	public void ChangeState(bool isRightLink)
	{
		PipeState pipeState = ((!isRightLink || !isLink) ? PipeState.NORMAL : PipeState.RIGHTLINK);
		if (pipeState != this.pipeState)
		{
			this.pipeState = pipeState;
			ChangePipeType();
		}
	}

	public void SetLink(bool isLink)
	{
		this.isLink = isLink;
		if (!isLink)
		{
			ChangeState(isLink);
		}
	}

	public WaterPipeItemSaveData GetPipeData()
	{
		return pipeData;
	}

	public bool IsLink()
	{
		return isLink;
	}

	public int GetEventID()
	{
		return eventID;
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			UnityEngine.Object.DestroyImmediate(base.gameObject);
		}
	}
}
