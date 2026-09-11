using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class DynamicTimelineController : MonoBehaviour
{
	private static string CharBasePath = "Char/";

	private PlayableDirector director;

	[SerializeField]
	public List<TransformProxy> transforms;

	private Dictionary<string, DynamicHeroProxy> roles = new Dictionary<string, DynamicHeroProxy>();

	private void Awake()
	{
		director = GetComponent<PlayableDirector>();
	}

	public DynamicHeroProxy GetHero(string heroPath)
	{
		if (roles.TryGetValue(heroPath, out var value))
		{
			if (value != null)
			{
				return value;
			}
			roles.Remove(heroPath);
		}
		if (Application.isPlaying)
		{
			GameObject gameObject = Object.Instantiate(Asset.Load<GameObject>(CharBasePath + heroPath));
			roles.Add(heroPath, gameObject.GetComponent<DynamicHeroProxy>());
			return roles[heroPath];
		}
		return null;
	}

	public void ReleaseHero(string heroPath)
	{
		if (roles.TryGetValue(heroPath, out var value))
		{
			Object.DestroyImmediate(value);
			if (Application.isPlaying)
			{
				Asset.Unload(CharBasePath + heroPath);
			}
		}
	}

	public void PlayAnimation(string heroPath, string animName, float crossFade)
	{
		if (roles.TryGetValue(heroPath, out var value))
		{
			value.PlayAnimation(animName, crossFade);
		}
	}

	public void SetPlayerToTransform(string heroPath, Transform trans)
	{
		DynamicHeroProxy hero = GetHero(heroPath);
		hero.transform.position = trans.position;
		hero.transform.rotation = trans.rotation;
		hero.transform.localScale = trans.lossyScale;
	}

	public void StopTimeline()
	{
		director.Stop();
	}

	public void Restart()
	{
		director.Stop();
		director.Play();
	}

	public float GetDirectorLength()
	{
		return (float)director.duration;
	}

	public Transform GetTransform(string tag)
	{
		foreach (TransformProxy transform in transforms)
		{
			if (transform.transTag == tag)
			{
				return transform.trans;
			}
		}
		return null;
	}

	public List<string> GetTransTags()
	{
		List<string> list = new List<string>();
		foreach (TransformProxy transform in transforms)
		{
			list.Add(transform.transTag);
		}
		return list;
	}

	public void Dispose()
	{
		foreach (KeyValuePair<string, DynamicHeroProxy> role in roles)
		{
			Object.DestroyImmediate(role.Value.gameObject);
			if (Application.isPlaying)
			{
				Asset.Unload(CharBasePath + role.Key);
			}
		}
		roles.Clear();
	}

	private void OnDestroy()
	{
		Dispose();
	}
}
