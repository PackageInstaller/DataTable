using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(CanvasRenderer))]
[RequireComponent(typeof(EmptyRaycast))]
public class BoardItem : MonoBehaviour, IBoardPart, IBoardPartContextSource, IBoardPartActionEntryProvider, IPointerClickHandler, IEventSystemHandler
{
	public List<string> aniName = new List<string>();

	private List<string> cacheAniNames = new List<string>();

	private readonly List<BoardPartActionEntry> actionEntries = new List<BoardPartActionEntry>();

	private string partId;

	public string PartId => partId;

	public IReadOnlyList<BoardPartActionEntry> ActionEntries => actionEntries;

	public IReadOnlyList<string> CacheAniNames => cacheAniNames;

	public bool CheckFrequentlyUsed => true;

	private ISpinePlayCommand playCommand => new SpinePlayCommand();

	public ISpinePlayCommand PlayCommand => playCommand;

	public event Action<BoardPartClickContext> OnPartClick;

	public event Action<BoardPartDragContext> OnPartDrag;

	public BoardItem SetBoneNames(List<string> boneNames)
	{
		aniName.Clear();
		foreach (string boneName in boneNames)
		{
			aniName.Add(boneName);
		}
		return this;
	}

	public void Init()
	{
		partId = ((base.gameObject != null) ? base.gameObject.name : string.Empty);
		RefreshActionEntries();
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		OnPartClick?.Invoke(new BoardPartClickContext
		{
			PartId = partId,
			CheckFrequentlyUsed = CheckFrequentlyUsed,
			PointerId = (eventData?.pointerId ?? (-1)),
			ScreenPos = (eventData?.position ?? Vector2.zero),
			LocalPos = Vector2.zero,
			ClickCount = (eventData?.clickCount ?? 1),
			Time = Time.unscaledTime,
			Source = base.gameObject,
			PlayCommand = playCommand
		});
	}

	[Obsolete("开发模式运行时缓存已迁移到 BoardPartState，此方法仅保留给旧流程兼容。")]
	public bool ReloadAniConfig()
	{
		cacheAniNames.Clear();
		cacheAniNames.AddRange(aniName);
		if (cacheAniNames.Count <= 0)
		{
			return false;
		}
		return true;
	}

	[Obsolete("开发模式运行时缓存已迁移到 BoardPartState，此方法仅保留给旧流程兼容。")]
	public bool RemoveCacheAni(string aniPlayed)
	{
		if (string.IsNullOrEmpty(aniPlayed))
		{
			return false;
		}
		if (cacheAniNames == null || cacheAniNames.Count == 0)
		{
			return false;
		}
		if (!cacheAniNames.Contains(aniPlayed))
		{
			return false;
		}
		return cacheAniNames.Remove(aniPlayed);
	}

	private void RefreshActionEntries()
	{
		actionEntries.Clear();
		if (aniName != null && aniName.Count != 0)
		{
			actionEntries.Add(new BoardPartActionEntry
			{
				PlayMode = BoardPartPlayMode.RandomFromList,
				Actions = new List<string>(aniName),
				Conditions = new List<BoardPartCondition>()
			});
		}
	}
}
