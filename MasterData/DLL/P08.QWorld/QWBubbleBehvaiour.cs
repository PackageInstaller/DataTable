using System;
using System.Collections.Generic;

public class QWBubbleBehvaiour : QWAgentBehaviour, IBubbleHolder
{
	private Dictionary<int, QWorldUIBubble> bubbleDict;

	private Dictionary<int, string> textDict;

	private Dictionary<int, string> iconDict;

	private HashSet<int> tags;

	private QWorldBubbleManager bubbleMgr;

	private QWorldMapEntity mapEntity;

	public Action<int> bubbleClick;

	public bool isNeedLookAt;

	public static float LookAtRadius = 90f;

	public QWorldMapEntity Entity => mapEntity;

	public bool isShowBubble { get; set; }

	public override void Initialize()
	{
		base.Initialize();
		InitBubble();
	}

	public void InitBubble()
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			bubbleMgr = qWorldScene.bubbleMgr;
		}
		bubbleDict = new Dictionary<int, QWorldUIBubble>();
		textDict = new Dictionary<int, string>();
		iconDict = new Dictionary<int, string>();
		tags = new HashSet<int>();
		bubbleMgr.RegisterBubbleEntity(this);
		mapEntity = GetComponent<QWorldMapEntity>();
		mapEntity.bubbleBehvaiour = this;
	}

	public void DisposeBubble()
	{
		OnReturunBubble(force: true);
		bubbleMgr.RemoveBubbleEntity(this);
		bubbleClick = null;
		mapEntity.bubbleBehvaiour = null;
	}

	public void AddBubbleTag(int tag, string text, string icon)
	{
		if (!tags.Contains(tag))
		{
			tags.Add(tag);
			if (!textDict.ContainsKey(tag))
			{
				textDict.Add(tag, text);
			}
			if (!iconDict.ContainsKey(tag))
			{
				iconDict.Add(tag, icon);
			}
			if (isShowBubble && !bubbleDict.ContainsKey(tag))
			{
				CreateBubble(tag);
			}
		}
	}

	public void RemoveBubbleTag(int tag)
	{
		if (tags.Contains(tag))
		{
			tags.Remove(tag);
			if (textDict.ContainsKey(tag))
			{
				textDict.Remove(tag);
			}
			if (iconDict.ContainsKey(tag))
			{
				iconDict.Remove(tag);
			}
			if (isShowBubble && bubbleDict.ContainsKey(tag) && NScene.GetCurrentScene() as QWorldScene != null)
			{
				bubbleDict.Remove(tag, out var value);
				value.Return(force: true);
			}
		}
	}

	public void OnCreateBubble()
	{
		foreach (int tag in tags)
		{
			CreateBubble(tag);
		}
	}

	private void CreateBubble(int tag)
	{
		if (!bubbleDict.ContainsKey(tag))
		{
			QWorldUIBubble bubble = bubbleMgr.GetBubble();
			bubble.Init(tag, 1, this);
			bubble.RegisterClick(OnBubbleClick);
			if (textDict.TryGetValue(tag, out var value))
			{
				bubble.SetText(value);
				bubble.SetIcon(iconDict[tag]);
			}
			else
			{
				bubble.SetText("");
				bubble.SetIcon("");
			}
			bubbleDict.Add(tag, bubble);
		}
		else
		{
			bubbleDict[tag].OnReuse();
		}
	}

	public void OnReturunBubble(bool force)
	{
		if (!(NScene.GetCurrentScene() as QWorldScene != null) || bubbleDict.Count <= 0)
		{
			return;
		}
		Span<int> span = stackalloc int[bubbleDict.Count];
		int num = 0;
		foreach (KeyValuePair<int, QWorldUIBubble> item in bubbleDict)
		{
			span[num] = item.Key;
			num++;
		}
		for (num = 0; num < bubbleDict.Count; num++)
		{
			bubbleDict[span[num]].Return(force);
		}
	}

	public bool HasBubble()
	{
		return bubbleDict.Count > 0;
	}

	protected virtual void OnBubbleClick(int tag)
	{
		bubbleClick?.Invoke(tag);
	}

	public void OnFirstBubbleClick()
	{
		if (tags.Count <= 0)
		{
			return;
		}
		using HashSet<int>.Enumerator enumerator = tags.GetEnumerator();
		if (enumerator.MoveNext())
		{
			int current = enumerator.Current;
			bubbleClick?.Invoke(current);
		}
	}

	public void OnBubbleRecycle(int tag, QWorldUIBubble bubble)
	{
		bubbleDict.Remove(tag);
	}
}
