using System;
using System.Collections.Generic;
using UnityEngine;

namespace ControllerExSpace;

[Serializable]
public class ControllerState
{
	public string stateName = "";

	public List<ControllerClip> clips = new List<ControllerClip>();

	public ControllerState(string str)
	{
		stateName = str;
	}

	public void UpdateState(List<Property> properties, List<ControllerRootParams> cControl)
	{
		clips.Clear();
		int num = 0;
		foreach (Property property in properties)
		{
			GameObject gameObject = property.gameObject;
			uint tags = property.tags;
			if ((bool)gameObject)
			{
				ControllerClip controllerClip = new ControllerClip();
				bool flag = false;
				if (cControl != null)
				{
					for (int i = 0; i < cControl.Count; i++)
					{
						if (cControl[i].propertyIndex == num)
						{
							controllerClip.UpdateState(gameObject, tags, cControl[i].param);
							flag = true;
							break;
						}
					}
				}
				if (!flag)
				{
					controllerClip.UpdateState(gameObject, tags, null);
				}
				clips.Add(controllerClip);
			}
			num++;
		}
	}

	public void ApplyState(bool immediately, Dictionary<int, Dictionary<GearType, TweenParams>> propertieTweens = null)
	{
		for (int i = 0; i < clips.Count; i++)
		{
			if (propertieTweens != null && propertieTweens.ContainsKey(i))
			{
				clips[i].ApplyState(immediately, propertieTweens[i]);
			}
			else
			{
				clips[i].ApplyState(immediately);
			}
		}
	}

	public void SetTags(Property property)
	{
		foreach (ControllerClip clip in clips)
		{
			if (clip.owner == property.gameObject)
			{
				clip.SetTags(property.tags);
			}
		}
	}

	public void SetGameObject(GameObject oldGo, Property property)
	{
		for (int i = 0; i < clips.Count; i++)
		{
			if ((bool)oldGo && clips[i].owner.GetInstanceID() == oldGo.GetInstanceID())
			{
				clips.RemoveAt(i);
				break;
			}
		}
		if (null != property.gameObject)
		{
			ControllerClip controllerClip = new ControllerClip();
			controllerClip.UpdateState(property.gameObject, property.tags, null);
			clips.Add(controllerClip);
		}
	}

	public void RemoveGameObject(GameObject go)
	{
		for (int i = 0; i < clips.Count; i++)
		{
			if (clips[i].owner == go)
			{
				clips.RemoveAt(i);
				break;
			}
		}
	}
}
