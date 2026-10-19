using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace ACT.UI;

public class UpdateSortingLayer : MonoBehaviour
{
	[NonSerialized]
	private IBaseUIView _view;

	public List<Canvas> canvasList = new List<Canvas>();

	public List<SortingGroup> sortingGroupList = new List<SortingGroup>();

	public void UpdateLayer()
	{
		if (_view == null)
		{
			_view = GetComponentInParent<IBaseUIView>();
		}
		if (_view == null || _view.ContentCanvas == null)
		{
			Debug.LogWarning("UpdateSortingLayer: Cannot find BaseUIView or its ContentCanvas. Please check your hierarchy.", gameObject);
			return;
		}
		string sortingLayerName = _view.ContentCanvas.sortingLayerName;
		foreach (Canvas canvas in canvasList)
		{
			if (canvas != null)
			{
				canvas.overrideSorting = true;
				canvas.sortingLayerName = sortingLayerName;
			}
		}
		foreach (SortingGroup sortingGroup in sortingGroupList)
		{
			if (sortingGroup != null)
			{
				sortingGroup.sortingLayerName = sortingLayerName;
			}
		}
	}
}
