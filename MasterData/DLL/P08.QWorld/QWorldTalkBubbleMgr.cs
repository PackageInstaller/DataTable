using System;
using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using Sirenix.Serialization;
using UnityEngine;

public class QWorldTalkBubbleMgr : QWorldEntityDataMono<QWorldBubbleMgrData>, ILODControlledLogic, ISerializationCallbackReceiver, ISupportsPrefabSerialization
{
	public struct BubbleContentCfg
	{
		private const float BUBBLE_LIFETIME_PER_WORD = 0.2f;

		public int charaIdx;

		public string content;

		public float duration;

		private static float CalcDefaultDuration(string content)
		{
			return 0.2f * (float)content.Length;
		}

		public BubbleContentCfg(int gourpID, int charaIdx, string content, float duration)
		{
			this.charaIdx = charaIdx;
			this.content = content;
			this.duration = ((duration == 0f) ? CalcDefaultDuration(content) : duration);
		}
	}

	private struct MsgBubble
	{
		public float time;

		public GameObject obj;

		public int rootIdx;

		public bool IsValid => obj;
	}

	public IBubbleHost host;

	private IEnumerator<BubbleContentCfg> getBubbleCcontent;

	private static Lazy<LuaFunction> pullCfg = new Lazy<LuaFunction>(() => LuaHelper.GetFunc("GetQWorldTalkBubbleCfg"));

	private float lastExit;

	private MsgBubble[] msgBubbles;

	private UpdateVisibleInternalLogic vsm;

	private bool hasNextContent;

	[SerializeField]
	[HideInInspector]
	private SerializationData serializationData;

	public Bounds Bounds
	{
		get
		{
			if (host == null)
			{
				return QWorldLODControlledLogicScheduler.INVALID_BOUNDS;
			}
			return host.Bounds;
		}
	}

	public bool Culled { get; set; }

	public int LOD { get; set; }

	public SerializationData SerializationData
	{
		get
		{
			return serializationData;
		}
		set
		{
			serializationData = value;
		}
	}

	protected override void OnAfterLoadState(QWorldBubbleMgrData loadData)
	{
		base.OnAfterLoadState(loadData);
		switch (data.bubbleHostType)
		{
		case QWorldBubbleMgrData.BubbleHostType.FromNpcList:
			host = new NpcListAsBubbleHost(entity_child_list);
			break;
		case QWorldBubbleMgrData.BubbleHostType.FromPassivePeopleGroup:
			host = QWorldScene.Scene.lodComScheduler.FindFirst<QWorldPopMsgPeopleGroup>(entity_child_list);
			break;
		}
	}

	private int FindAvailableBubbleIdx()
	{
		int result = 0;
		float num = float.MaxValue;
		for (int i = 0; i < msgBubbles.Length; i++)
		{
			ref MsgBubble reference = ref msgBubbles[i];
			if (!reference.IsValid || reference.time <= 0f)
			{
				return i;
			}
			if (reference.time < num)
			{
				num = reference.time;
				result = i;
			}
		}
		return result;
	}

	public void ClaimBubble(int bubbleIdx)
	{
		ref MsgBubble reference = ref msgBubbles[bubbleIdx];
		DestoryBubble(bubbleIdx);
		hasNextContent = getBubbleCcontent?.MoveNext() ?? false;
		if (!hasNextContent)
		{
			return;
		}
		BubbleContentCfg current = getBubbleCcontent.Current;
		if (!host.QueryBubbleRoot(current.charaIdx - 1, out var rootTrs, out var offset))
		{
			return;
		}
		reference.rootIdx = current.charaIdx;
		for (int i = 0; i < msgBubbles.Length; i++)
		{
			if (msgBubbles[i].rootIdx == current.charaIdx)
			{
				DestoryBubble(i);
			}
		}
		reference.obj = Asset.Instantiate(data.bubblePrefab);
		UpdateBubblePos(bubbleIdx, rootTrs, offset);
		reference.obj.GetComponentInChildren<QWorldTalkBubble>().text = current.content;
		reference.time = current.duration;
	}

	public void DestoryBubble(int bubbleIdx)
	{
		ref MsgBubble reference = ref msgBubbles[bubbleIdx];
		if ((bool)reference.obj)
		{
			PooledAsset.DestroyOrReturn(reference.obj);
		}
		reference.time = 0f;
	}

	private IEnumerator<BubbleContentCfg> CycleContent(BubbleContentCfg[] contents)
	{
		while (true)
		{
			for (int i = 0; i < contents.Length; i++)
			{
				yield return contents[i];
			}
		}
	}

	private IEnumerator<BubbleContentCfg> RandomContent(BubbleContentCfg[] contents)
	{
		int lastID = UnityEngine.Random.Range(0, contents.Length);
		yield return contents[lastID];
		List<int> ids = (from v in Enumerable.Range(0, contents.Length)
			where v != lastID
			select v).ToList();
		while (true)
		{
			int pick = UnityEngine.Random.Range(0, ids.Count);
			yield return contents[ids[pick]];
			int num = ids[pick];
			ids[pick] = lastID;
			lastID = num;
		}
	}

	private IEnumerator<BubbleContentCfg> SequentialContent(BubbleContentCfg[] contents)
	{
		for (int i = 0; i < contents.Length; i++)
		{
			yield return contents[i];
		}
	}

	private void InitContentGetter()
	{
		int cfgID = data.cfgID;
		BubbleContentCfg[] contentsFromCfgID = GetContentsFromCfgID(cfgID);
		if (contentsFromCfgID != null)
		{
			switch (data.getBubbleContentFunc)
			{
			case QWorldBubbleMgrData.BubbleFunc.Cycle:
				getBubbleCcontent = CycleContent(contentsFromCfgID);
				break;
			case QWorldBubbleMgrData.BubbleFunc.Random:
				getBubbleCcontent = RandomContent(contentsFromCfgID);
				break;
			case QWorldBubbleMgrData.BubbleFunc.Sequential:
				getBubbleCcontent = SequentialContent(contentsFromCfgID);
				break;
			}
		}
	}

	private BubbleContentCfg[] GetContentsFromCfgID(int contentCfg)
	{
		if (Application.IsPlaying(this) && pullCfg.Value.GetLuaState() != null)
		{
			return pullCfg.Value.Invoke<int, BubbleContentCfg[]>(contentCfg);
		}
		return null;
	}

	private void UpdateBubblePos(int handle, Transform linkTrs, Vector3 offset)
	{
		GameObject obj = msgBubbles[handle].obj;
		PositionAttachIsNotChild component = obj.GetComponent<PositionAttachIsNotChild>();
		if ((bool)component)
		{
			component.AttachTransform = linkTrs;
			component.PositionOffset = offset;
			if (linkTrs == null)
			{
				obj.transform.position = offset;
			}
		}
		else
		{
			if ((bool)linkTrs)
			{
				offset = linkTrs.TransformPoint(offset);
			}
			obj.transform.position = offset;
		}
	}

	public void OnVisible(float dt)
	{
		if (host == null)
		{
			return;
		}
		for (int i = 0; i < msgBubbles.Length; i++)
		{
			ref MsgBubble reference = ref msgBubbles[i];
			if (reference.IsValid && reference.time > 0f)
			{
				reference.time -= dt;
			}
			else if (hasNextContent)
			{
				ClaimBubble(i);
			}
		}
	}

	private void OnEnterVisible()
	{
		msgBubbles = new MsgBubble[data.limit];
		if (Time.realtimeSinceStartup - lastExit > data.restartInterval)
		{
			InitContentGetter();
			hasNextContent = true;
		}
		for (int i = 0; i < msgBubbles.Length; i++)
		{
			ClaimBubble(i);
		}
	}

	private void OnExitVisible()
	{
		for (int i = 0; i < msgBubbles.Length; i++)
		{
			DestoryBubble(i);
		}
		msgBubbles = null;
		lastExit = Time.realtimeSinceStartup;
	}

	public void UpdateLogic(float dt)
	{
		bool visible = host.Bounds.SqrDistance(QWorldScene.Scene.Agent.Position) <= data.displayBubbleRange * data.displayBubbleRange;
		vsm.UpdateVisible(visible, dt);
	}

	public void UpdateLogic(float dt, QWorldMapCull.QWorldCullResult _)
	{
		UpdateLogic(dt);
	}

	public void Init()
	{
		vsm = new UpdateVisibleInternalLogic
		{
			OnEnterVisible = OnEnterVisible,
			OnVisibleUpdate = OnVisible,
			OnExitVisible = OnExitVisible
		};
	}

	public void Shutdown()
	{
		vsm.UpdateVisible(visible: false, 0f);
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if ((bool)this && !base.isEditorData)
		{
			UnitySerializationUtility.DeserializeUnityObject(this, ref serializationData);
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if ((bool)this)
		{
			UnitySerializationUtility.SerializeUnityObject(this, ref serializationData);
		}
	}
}
