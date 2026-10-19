using UnityEngine;
using UnityEngine.EventSystems;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public class SelectionWatcher
{
	public delegate void NewObjectSelectedDelegate(GameObject lastGO, GameObject newGO);

	public bool Enabled { get; set; }

	private GameObject LastSelectedObject { get; set; }

	public event NewObjectSelectedDelegate NewObjectSelected;

	public void OnUpdate()
	{
		CheckNewObjectSelection();
	}

	private bool CheckNewObjectSelection()
	{
		GameObject lastSelectedObject = LastSelectedObject;
		if (!Enabled)
		{
			LastSelectedObject = null;
			return lastSelectedObject != LastSelectedObject;
		}
		GameObject currentlySelectedObject = GetCurrentlySelectedObject();
		if (!currentlySelectedObject)
		{
			LastSelectedObject = null;
			return lastSelectedObject != LastSelectedObject;
		}
		if (LastSelectedObject != currentlySelectedObject)
		{
			if ((bool)currentlySelectedObject)
			{
				OnNewObjectSelected(currentlySelectedObject);
			}
			LastSelectedObject = currentlySelectedObject;
			return true;
		}
		return false;
	}

	private GameObject GetCurrentlySelectedObject()
	{
		if (!EventSystem.current)
		{
			return null;
		}
		return EventSystem.current.currentSelectedGameObject;
	}

	private void OnNewObjectSelected(GameObject curSelected)
	{
		NewObjectSelected(LastSelectedObject, curSelected);
	}
}
