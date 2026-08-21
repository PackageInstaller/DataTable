using System;
using System.Collections.Generic;
using UnityEngine;

namespace WaterPipeGame;

public class WaterPipeHeroManager : MonoBehaviour
{
	[SerializeField]
	private WaterPipeGameManager gameManager;

	private List<int> movePathList;

	private int moveIndex;

	[SerializeField]
	private Animator heroAni;

	[SerializeField]
	private GameObject signObj;

	private Dictionary<DIR, Vector3> dirOffsetPos = new Dictionary<DIR, Vector3>
	{
		{
			DIR.UP,
			new Vector3(0f, 80f, 0f)
		},
		{
			DIR.RIGHT,
			new Vector3(80f, 0f, 0f)
		},
		{
			DIR.DOWN,
			new Vector3(0f, -80f, 0f)
		},
		{
			DIR.LEFT,
			new Vector3(-80f, 0f, 0f)
		}
	};

	private LTDescr moveTween;

	public void InitPos(Vector3 enterPos)
	{
		heroAni.Play("UI_HeroNormal");
		base.transform.localPosition = enterPos + new Vector3(-30f, -44f, 0f);
		signObj.SetActive(value: false);
	}

	public void InitMovePathList(List<int> movePathList)
	{
		Invoke("CallLuaToPlayPerformancePop", 0.7f);
		moveIndex = 0;
		this.movePathList = movePathList;
		this.movePathList.Reverse();
	}

	public void CallLuaToPlayPerformancePop()
	{
		LuaHelper.CallFunction("BeginWaterPipePerformance");
	}

	public void BeginMove()
	{
		heroAni.Play("UI_HeroMove");
		Invoke("Move", 0.5f);
	}

	public bool IsMeetStopType(WaterPipeMapEntity entity)
	{
		if (entity != null && entity.pipeType >= PipeType.BOX && entity.pipeType <= PipeType.NPC)
		{
			return true;
		}
		return false;
	}

	public Vector3 GetNextPos(int beginIndex, int endIndex)
	{
		WaterPipeMapEntity mapEntityByIndex = gameManager.pipeItemManager.GetMapEntityByIndex(endIndex);
		if (IsMeetStopType(mapEntityByIndex))
		{
			DIR key = DIR.UP;
			foreach (DIR value in Enum.GetValues(typeof(DIR)))
			{
				if (WaterPipeTools.GetLinkDirIndex(value, endIndex) == beginIndex)
				{
					key = value;
					break;
				}
			}
			return mapEntityByIndex.transform.localPosition + dirOffsetPos[key];
		}
		return mapEntityByIndex.transform.localPosition;
	}

	public void Move()
	{
		int num = movePathList[moveIndex];
		int endIndex = movePathList[moveIndex + 1];
		Vector3 beginPos;
		if (moveIndex == 0)
		{
			beginPos = base.transform.localPosition;
		}
		else
		{
			beginPos = gameManager.pipeItemManager.GetMapEntityByIndex(num).transform.localPosition;
		}
		Vector3 nextPos;
		if (moveIndex + 1 == movePathList.Count - 1)
		{
			nextPos = Vector3.Lerp(beginPos, GetNextPos(num, endIndex), 0.4f);
		}
		else
		{
			nextPos = GetNextPos(num, endIndex);
		}
		signObj.SetActive(value: true);
		moveTween = LeanTween.value(0f, 1f, 0.5f).setOnUpdate(delegate(float value)
		{
			base.transform.localPosition = Vector3.Lerp(beginPos, nextPos, value);
		}).setOnComplete((Action)delegate
		{
			base.transform.localPosition = nextPos;
			moveIndex++;
			MoveEnd();
		})
			.setEase(LeanTweenType.linear);
	}

	public void MoveEnd()
	{
		WaterPipeMapEntity mapEntityByIndex = gameManager.pipeItemManager.GetMapEntityByIndex(movePathList[moveIndex]);
		WaterPipeEventEntity mapEventByIndex = gameManager.pipeItemManager.GetMapEventByIndex(movePathList[moveIndex]);
		if (IsMeetStopType(mapEntityByIndex))
		{
			signObj.SetActive(value: false);
			mapEventByIndex.PlayIngShow();
			float time = 0.5f;
			if (mapEntityByIndex.pipeType == PipeType.NPC)
			{
				time = 1f;
			}
			Invoke("MoveRemain", time);
		}
		else
		{
			if (mapEventByIndex != null)
			{
				mapEventByIndex.UpdateState(isFinish: true);
			}
			if (moveIndex < movePathList.Count - 1)
			{
				Move();
			}
			else
			{
				Invoke("FinishMove", 1f);
			}
		}
	}

	private void FinishMove()
	{
		LuaHelper.CallFunction("FinishWaterPipeGame");
	}

	public void MoveRemain()
	{
		WaterPipeEventEntity mapEventByIndex = gameManager.pipeItemManager.GetMapEventByIndex(movePathList[moveIndex]);
		mapEventByIndex.UpdateState(isFinish: true);
		Vector3 beginPos = base.transform.localPosition;
		Vector3 targetPos = mapEventByIndex.transform.localPosition;
		moveTween = LeanTween.value(0f, 1f, 0.3f).setOnUpdate(delegate(float value)
		{
			base.transform.localPosition = Vector3.Lerp(beginPos, targetPos, value);
		}).setOnComplete((Action)delegate
		{
			base.transform.localPosition = targetPos;
			Move();
		})
			.setEase(LeanTweenType.linear);
	}

	private void RemoveTween()
	{
		if (moveTween != null)
		{
			moveTween.setOnUpdate((Action<float>)delegate
			{
			});
			LeanTween.cancel(moveTween.id);
			moveTween = null;
		}
	}

	public void ExitGame()
	{
		RemoveTween();
	}
}
