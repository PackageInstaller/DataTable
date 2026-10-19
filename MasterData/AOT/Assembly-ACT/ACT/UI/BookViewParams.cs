using System;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class BookViewParams : BaseParams
{
	public RectTransform[] bookItemChapterPrefabs;

	public RectTransform[] bookItemSystemPrefabs;

	public RectTransform[] bookItemLevelPrefabs;

	public RectTransform[] bookItemMissionPrefabs;

	public RectTransform[] bookEndPrefabs;

	public RectTransform[] bookEmptyPrefabs;

	public override void InitIfNeeded(IOSA iAdapter)
	{
		base.InitIfNeeded(iAdapter);
	}
}
