using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.UI;

public class MonoCommsChatItems : MonoBehaviour
{
	public enum CommsChatPosition
	{
		[InspectorName("上方")]
		Top,
		[InspectorName("中间")]
		Center,
		[InspectorName("下方")]
		Bottom
	}

	public MonoCommsChatItem template;

	[Header("位置预设（相对各自锚点）")]
	public Vector2 topPosition = new Vector2(0f, -180f);

	public Vector2 centerPosition = Vector2.zero;

	public Vector2 bottomPosition = new Vector2(0f, 180f);

	private readonly Dictionary<long, MonoCommsChatItem> m_ActiveItems = new Dictionary<long, MonoCommsChatItem>();

	private ObjectPool<MonoCommsChatItem> m_ItemPool;

	public async UniTask ShowItem(long itemId, int contentId, CommsChatPosition position, Vector2 offset, bool immediate, CancellationToken token)
	{
		EnsurePool();
		if (m_ItemPool != null)
		{
			if (m_ActiveItems.TryGetValue(itemId, out var value))
			{
				m_ActiveItems.Remove(itemId);
				ReleaseItem(value);
			}
			MonoCommsChatItem monoCommsChatItem = m_ItemPool.Get();
			ApplyPosition(monoCommsChatItem, position, offset);
			m_ActiveItems[itemId] = monoCommsChatItem;
			if (immediate)
			{
				monoCommsChatItem.SetContent(contentId);
				monoCommsChatItem.gameObject.SetActive(value: true);
			}
			else
			{
				await monoCommsChatItem.PlayShowAnimation(contentId, token);
			}
		}
	}

	public async UniTask HideItem(long itemId, bool immediate, CancellationToken token)
	{
		if (m_ActiveItems.TryGetValue(itemId, out var item))
		{
			m_ActiveItems.Remove(itemId);
			if (!immediate)
			{
				await item.PlayHideAnimation(token);
			}
			ReleaseItem(item);
		}
	}

	public void HideItemImmediate(long itemId)
	{
		if (m_ActiveItems.TryGetValue(itemId, out var value))
		{
			m_ActiveItems.Remove(itemId);
			ReleaseItem(value);
		}
	}

	private void EnsurePool()
	{
		if (m_ItemPool == null && !(template == null))
		{
			m_ItemPool = new ObjectPool<MonoCommsChatItem>(CreateItem, OnGetItem, OnReleaseItem, OnDestroyItem);
		}
	}

	private MonoCommsChatItem CreateItem()
	{
		MonoCommsChatItem monoCommsChatItem = Object.Instantiate(template, transform, worldPositionStays: false);
		monoCommsChatItem.name = template.name + " (Pooled)";
		monoCommsChatItem.Initialize();
		monoCommsChatItem.gameObject.SetActive(value: false);
		return monoCommsChatItem;
	}

	private static void OnGetItem(MonoCommsChatItem item)
	{
		item.gameObject.SetActive(value: false);
	}

	private static void OnReleaseItem(MonoCommsChatItem item)
	{
		item.HideImmediate();
	}

	private static void OnDestroyItem(MonoCommsChatItem item)
	{
		if (item != null)
		{
			Object.Destroy(item.gameObject);
		}
	}

	private void ReleaseItem(MonoCommsChatItem item)
	{
		if (!(item == null))
		{
			item.HideImmediate();
			m_ItemPool?.Release(item);
		}
	}

	private void OnDestroy()
	{
		foreach (MonoCommsChatItem value in m_ActiveItems.Values)
		{
			value.HideImmediate();
		}
		m_ActiveItems.Clear();
		m_ItemPool?.Clear();
		m_ItemPool = null;
	}

	private void ApplyPosition(MonoCommsChatItem item, CommsChatPosition position, Vector2 offset)
	{
		switch (position)
		{
		case CommsChatPosition.Top:
			item.SetPosition(new Vector2(0.5f, 1f), new Vector2(0.5f, 1f), topPosition + offset);
			break;
		case CommsChatPosition.Center:
			item.SetPosition(new Vector2(0.5f, 0.5f), new Vector2(0.5f, 0.5f), centerPosition + offset);
			break;
		default:
			item.SetPosition(new Vector2(0.5f, 0f), new Vector2(0.5f, 0f), bottomPosition + offset);
			break;
		}
	}
}
