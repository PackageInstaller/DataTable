using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class PostureBarMultiGroup : PostureBarBase
{
	[SerializeField]
	private PostureBarMulti prefab;

	[SerializeField]
	private GameObject _split;

	private List<PostureBarMulti> _parts = new List<PostureBarMulti>();

	private List<GameObject> _splits = new List<GameObject>();

	private float[] _partsVal;

	private int _curPartsIndex;

	[SerializeField]
	protected string enterWeakAnimation;

	[SerializeField]
	protected string exitWeakAnimation;

	[SerializeField]
	protected string enterPostureAnimation;

	[SerializeField]
	protected string exitPostureAnimation;

	public override void Init(EntityUIInfo entityUIInfo, bool playInitAnimation = true)
	{
		base.Init(entityUIInfo, playInitAnimation);
		_partsVal = EntityUIInfo.PosturePartsVal;
		int num = _partsVal.Length;
		int num2 = num - 1;
		while (_parts.Count < num)
		{
			PostureBarMulti component = Object.Instantiate(prefab.gameObject, prefab.transform.parent).GetComponent<PostureBarMulti>();
			component.gameObject.SetActive(value: true);
			_parts.Add(component);
		}
		while (_splits.Count < num2)
		{
			GameObject gameObject = Object.Instantiate(_split, prefab.transform.parent);
			gameObject.SetActive(value: true);
			_splits.Add(gameObject);
		}
		for (int i = 0; i < _parts.Count; i++)
		{
			_parts[i].gameObject.SetActive(i < num);
		}
		for (int j = 0; j < _splits.Count; j++)
		{
			_splits[j].SetActive(j < num2);
		}
		for (int k = 0; k < num; k++)
		{
			_parts[k].transform.SetAsLastSibling();
			if (k < num2)
			{
				_splits[k].transform.SetAsLastSibling();
			}
		}
		prefab.gameObject.SetActive(value: false);
		_split.gameObject.SetActive(value: false);
		for (int l = 0; l < _partsVal.Length; l++)
		{
			_parts[l].SetIndex(l);
			_parts[l].Init(EntityUIInfo, playInitAnimation);
		}
		_curPartsIndex = EntityUIInfo.CurPartsIndex;
		if (EntityUIInfo.InPosture)
		{
			if (EntityUIInfo.InWeak)
			{
				PlayInitAnimation(enterWeakAnimation, playInitAnimation);
			}
			else
			{
				PlayInitAnimation(enterPostureAnimation, playInitAnimation);
			}
		}
		else
		{
			PlayInitAnimation(exitPostureAnimation, playInitAnimation);
		}
	}

	public override void OnPostureValChange()
	{
		base.OnPostureValChange();
		if (_curPartsIndex != EntityUIInfo.CurPartsIndex)
		{
			for (int i = 0; i < _parts.Count; i++)
			{
				if (i > EntityUIInfo.CurPartsIndex)
				{
					_parts[i].InitBarVal(0f);
				}
				else
				{
					_parts[i].InitBarVal(1f);
				}
			}
		}
		_curPartsIndex = EntityUIInfo.CurPartsIndex;
		_parts[EntityUIInfo.CurPartsIndex].OnPostureValChange();
	}

	public override void OnEnterWeak()
	{
		for (int i = EntityUIInfo.CurPartsIndex + 1; i <= EntityUIInfo.OldPartsIndex; i++)
		{
			_parts[i].OnEnterWeak();
		}
		for (int j = 0; j < _parts.Count; j++)
		{
			_parts[j].SetFrontLocked(locked: true);
		}
		mainAnimation?.GetSequence(enterWeakAnimation)?.Play();
	}

	public override void OnExitWeak()
	{
		base.OnExitWeak();
		for (int i = 0; i < _parts.Count; i++)
		{
			_parts[i].SetFrontLocked(locked: false);
		}
		mainAnimation?.GetSequence(exitWeakAnimation)?.Play();
	}

	public void UnInit()
	{
		foreach (PostureBarMulti part in _parts)
		{
			part.gameObject.SetActive(value: false);
		}
		foreach (GameObject split in _splits)
		{
			split.SetActive(value: false);
		}
	}

	public override void OnEnterPosture()
	{
		base.OnEnterPosture();
		gameObject.SetActive(value: true);
		mainAnimation?.GetSequence(enterPostureAnimation)?.Play();
	}

	public override void OnExitPosture()
	{
		base.OnExitPosture();
		mainAnimation?.GetSequence(exitPostureAnimation)?.Play();
	}
}
