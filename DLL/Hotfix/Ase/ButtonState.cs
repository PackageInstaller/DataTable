using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ButtonState : Button
{
	public bool stateActive;

	public bool stateNew;

	public List<GameObject> activeList = new List<GameObject>();

	public List<GameObject> disactiveList = new List<GameObject>();

	public List<GameObject> newList = new List<GameObject>();

	public bool StateActive
	{
		get
		{
			return stateActive;
		}
		set
		{
			stateActive = value;
			base.interactable = value;
			SetActive(value);
		}
	}

	public bool StateNew
	{
		get
		{
			return stateNew;
		}
		set
		{
			stateNew = value;
			SetNew(value);
		}
	}

	private void SetActive(bool val)
	{
		foreach (GameObject active in activeList)
		{
			active.SetActive(val);
		}
		foreach (GameObject disactive in disactiveList)
		{
			disactive.SetActive(!val);
		}
	}

	private void SetNew(bool val)
	{
		foreach (GameObject @new in newList)
		{
			@new.SetActive(val);
		}
	}
}
