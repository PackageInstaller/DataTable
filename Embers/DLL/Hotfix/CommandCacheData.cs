using System.Collections.Generic;
using Ase;
using GameFramework;
using UnityEngine;

public class CommandCacheData : IReference
{
	private HeroSkillTypeEnum _heroSkillTypeEnum;

	private bool _down;

	private bool _up;

	private float _cacheTime;

	private float _currentDownCacheTime;

	private float _currentUpCacheTime;

	private bool _openCommandReceive;

	private float _initCacheTime;

	private List<HeroSkillTypeEnum> _breakSkillTypeEnumList;

	public bool IsReceive => _openCommandReceive;

	public bool IsDown => _down;

	public bool IsUp => _up;

	public void InitData(float cacheTime, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		_cacheTime = cacheTime;
		_initCacheTime = cacheTime;
		_heroSkillTypeEnum = heroSkillTypeEnum;
		_openCommandReceive = true;
		_breakSkillTypeEnumList = new List<HeroSkillTypeEnum>();
	}

	public void FixedUpdate(float deltaTime)
	{
		_currentDownCacheTime = Mathf.Clamp(_currentDownCacheTime -= deltaTime, 0f, _currentDownCacheTime);
		if (_currentDownCacheTime <= 0f)
		{
			_currentDownCacheTime = _cacheTime;
			_down = false;
		}
		_currentUpCacheTime = Mathf.Clamp(_currentUpCacheTime -= deltaTime, 0f, _currentUpCacheTime);
		if (_currentUpCacheTime <= 0f)
		{
			_currentUpCacheTime = _cacheTime;
			_up = false;
		}
	}

	public void RefreshTime(int skillState)
	{
		switch (skillState)
		{
		case 1:
			_currentDownCacheTime = _cacheTime;
			_down = true;
			break;
		case 3:
			_currentUpCacheTime = _cacheTime;
			_up = true;
			break;
		}
	}

	public void AmendCommandCacheTime(float cacheTime)
	{
		_cacheTime = cacheTime;
	}

	public void RestoreCacheTime()
	{
		_cacheTime = _initCacheTime;
	}

	public void ClearCommandCache()
	{
		_down = false;
		_up = false;
	}

	public void OpenCommandReceiveWindow(bool open)
	{
		_openCommandReceive = open;
	}

	public bool SetCommandBreak(List<HeroSkillTypeEnum> breakHeroSkillTypeEnumList, bool openBreak)
	{
		if (breakHeroSkillTypeEnumList == null || breakHeroSkillTypeEnumList.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < breakHeroSkillTypeEnumList.Count; i++)
		{
			HeroSkillTypeEnum item = breakHeroSkillTypeEnumList[i];
			if (openBreak)
			{
				if (!_breakSkillTypeEnumList.Contains(item))
				{
					_breakSkillTypeEnumList.Add(item);
				}
			}
			else if (_breakSkillTypeEnumList.Contains(item))
			{
				_breakSkillTypeEnumList.Remove(item);
			}
		}
		return true;
	}

	public bool CommandBreakWindowIsOpen(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		return _breakSkillTypeEnumList.Contains(heroSkillTypeEnum);
	}

	public void Clear()
	{
		_down = false;
		_up = false;
		_cacheTime = 0f;
		_currentDownCacheTime = 0f;
		_currentUpCacheTime = 0f;
		_breakSkillTypeEnumList.Clear();
		_breakSkillTypeEnumList = null;
	}
}
