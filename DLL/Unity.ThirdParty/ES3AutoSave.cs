using System.Collections.Generic;
using ES3Internal;
using UnityEngine;

public class ES3AutoSave : MonoBehaviour, ISerializationCallbackReceiver
{
	public bool saveLayer = true;

	public bool saveTag = true;

	public bool saveName = true;

	public bool saveHideFlags = true;

	public bool saveActive = true;

	public bool saveChildren;

	private bool isQuitting;

	public List<Component> componentsToSave = new List<Component>();

	public void Reset()
	{
		saveLayer = false;
		saveTag = false;
		saveName = false;
		saveHideFlags = false;
		saveActive = false;
		saveChildren = false;
	}

	public void Awake()
	{
		if (ES3AutoSaveMgr.Current == null)
		{
			ES3Debug.LogWarning("<b>No GameObjects in this scene will be autosaved</b> because there is no Easy Save 3 Manager. To add a manager to this scene, exit playmode and go to Assets > Easy Save 3 > Add Manager to Scene.", this);
		}
		else
		{
			ES3AutoSaveMgr.AddAutoSave(this);
		}
	}

	public void OnApplicationQuit()
	{
		isQuitting = true;
	}

	public void OnDestroy()
	{
		if (!isQuitting)
		{
			ES3AutoSaveMgr.RemoveAutoSave(this);
		}
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		componentsToSave.RemoveAll((Component c) => c == null || c.GetType() == typeof(Component));
	}
}
