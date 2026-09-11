using System;
using System.Collections.Generic;
using LuaInterface;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Jobs;

public class QWorldBubbleManager
{
	private struct CollectInteractInfoJob : IJobParallelForTransform
	{
		public Vector3 playerPosition;

		public Vector3 playerForward;

		public void Execute(int idx, TransformAccess transform)
		{
			if (QwLodMgr.lodObjects[idx] is QWorldMapEntity entity)
			{
				_interactEnterResults[idx] = IsPointInRange(entity, ref transform);
			}
		}

		[NoToLua]
		public bool IsPointInRange(QWorldMapEntity entity, ref TransformAccess transform)
		{
			QWBubbleBehvaiour bubbleBehvaiour = entity.bubbleBehvaiour;
			if (bubbleBehvaiour == null)
			{
				return false;
			}
			ref QwLodData lodData = ref entity.GetLodData();
			float boundSphereRadius = lodData.boundSphereRadius;
			float checkBubbleRange = entity.GetCheckBubbleRange();
			Vector3 position = transform.position;
			float sqrMagnitude = (playerPosition - position).sqrMagnitude;
			float num = boundSphereRadius + checkBubbleRange;
			if (sqrMagnitude > num * num)
			{
				return false;
			}
			Vector3 playerLocalPosition = transform.worldToLocalMatrix.MultiplyPoint3x4(playerPosition);
			bool flag = (double)boundSphereRadius < 0.01 || GetPointSdf(playerLocalPosition, ref lodData.bounds) <= checkBubbleRange;
			if (bubbleBehvaiour.isNeedLookAt)
			{
				if (flag)
				{
					if (Mathf.Abs(Vector3.Angle((position - playerPosition).normalized, playerForward)) < QWBubbleBehvaiour.LookAtRadius)
					{
						return true;
					}
					return false;
				}
				return false;
			}
			return flag;
		}

		private float GetPointSdf(Vector3 playerLocalPosition, ref Bounds bounds)
		{
			float3 float5 = bounds.extents;
			float3 x = math.abs(playerLocalPosition) - float5;
			return math.length(math.max(x, 0f)) + math.min(math.max(x.x, math.max(x.y, x.z)), 0f);
		}
	}

	private const string GetBubblePrefabFunction = "GetQWorldBubblePrefab";

	public string bubblePath = "QWorld/UI/SubtitleBubble";

	public int lastId = 1;

	private Queue<QWorldUIBubble> bubbleQueue;

	private HashSet<QWorldUIBubble> bubbleWaitReturn;

	private HashSet<QWBubbleBehvaiour> entitys;

	private bool isHide;

	private JobHandle _jobCollectInteractInfo;

	private static bool[] _interactEnterResults;

	public void Init()
	{
		object[] array = LuaHelper.CallFunction("GetQWorldBubblePrefab");
		bubblePath = array[0].ToString();
		bubbleQueue = new Queue<QWorldUIBubble>();
		entitys = new HashSet<QWBubbleBehvaiour>();
		bubbleWaitReturn = new HashSet<QWorldUIBubble>();
		isHide = false;
		_interactEnterResults = new bool[32];
	}

	public void RegisterBubbleEntity(QWBubbleBehvaiour entity)
	{
		entitys.Add(entity);
	}

	public void RemoveBubbleEntity(QWBubbleBehvaiour entity)
	{
		entitys.Remove(entity);
	}

	public void ReturnOnWait(QWorldUIBubble bubble)
	{
		bubbleWaitReturn.Add(bubble);
	}

	public void ReuseBubble(QWorldUIBubble bubble)
	{
		bubbleWaitReturn.Remove(bubble);
	}

	public void Return(QWorldUIBubble bubble)
	{
		bubble.OnReturn();
		bubbleQueue.Enqueue(bubble);
	}

	public QWorldUIBubble GetBubble()
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.mWorldUI != null)
		{
			if (bubbleQueue.Count == 0)
			{
				GameObject gameObject = Asset.Instantiate(bubblePath);
				gameObject.transform.parent = qWorldScene.mWorldUI.bubbleCanvas;
				gameObject.transform.localScale = Vector3.one;
				gameObject.transform.localPosition = Vector3.zero;
				return gameObject.GetComponent<QWorldUIBubble>();
			}
			return bubbleQueue.Dequeue();
		}
		return null;
	}

	public void StartBubble()
	{
		isHide = false;
	}

	public void HideBubble()
	{
		isHide = true;
		ForceReturnAllBubble();
	}

	public bool IsInHide()
	{
		return isHide;
	}

	public void ForceReturnAllBubble()
	{
		if (entitys == null)
		{
			return;
		}
		foreach (QWBubbleBehvaiour entity in entitys)
		{
			if (entity.isShowBubble)
			{
				entity.isShowBubble = false;
				entity.OnReturunBubble(force: true);
			}
		}
	}

	public void StartJobCollectInteractInfo(QWCharacterAgent agent)
	{
		if (_interactEnterResults.Length < QwLodMgr.lodObjects.Count)
		{
			Array.Resize(ref _interactEnterResults, QwLodMgr.lodObjects.Count);
		}
		CollectInteractInfoJob jobData = new CollectInteractInfoJob
		{
			playerPosition = agent.transform.position,
			playerForward = agent.transform.forward
		};
		_jobCollectInteractInfo = jobData.ScheduleReadOnly(QwLodMgr.transformAccessArray, 16);
		QwLodMgr.jobCompleAccess = _jobCollectInteractInfo.IsCompleted;
	}

	public void Tick(QWCharacterAgent agent)
	{
		if (IsInHide() || entitys == null)
		{
			return;
		}
		_jobCollectInteractInfo.Complete();
		foreach (QWBubbleBehvaiour entity2 in entitys)
		{
			QWorldMapEntity entity = entity2.Entity;
			bool flag = _interactEnterResults[entity.GetLodData().lodObjectIndex];
			if (entity2.isShowBubble && !flag)
			{
				entity2.isShowBubble = false;
				entity2.OnReturunBubble(force: false);
				QWorldLuaBridge.OnEntityExitInteractRange(entity);
			}
			else if (!entity2.isShowBubble & flag)
			{
				entity2.isShowBubble = true;
				if (!entity2.mAgent.Blackboard.IsInSeeking)
				{
					QWorldLuaBridge.OnEntityEnterInteractRange(entity);
					entity2.OnCreateBubble();
				}
			}
			else
			{
				if (!(entity2.isShowBubble & flag))
				{
					continue;
				}
				if (entity2.mAgent.Blackboard.IsInSeeking)
				{
					if (entity2.HasBubble())
					{
						entity2.OnReturunBubble(force: false);
					}
				}
				else if (!entity2.HasBubble())
				{
					entity2.OnCreateBubble();
				}
			}
		}
		foreach (QWorldUIBubble item in bubbleWaitReturn)
		{
			item.CheckCanReturn();
		}
		foreach (QWorldUIBubble item2 in bubbleQueue)
		{
			if (item2.CheckCurFrameReturn())
			{
				bubbleWaitReturn.Remove(item2);
			}
		}
	}

	public void Disopse()
	{
		_interactEnterResults = null;
	}
}
