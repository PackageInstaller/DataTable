using System;
using System.Collections.Generic;
using Ase;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

public class SkillDeriveData : ViewModelBase
{
	private int _skillId;

	private BaseEntity _baseEntity;

	private bool _isDeriveSkill;

	private int _currentDeriveNumber;

	private float _deriveTime;

	private float _initDeriveTime;

	private float _currentDeriveTime;

	private List<int> _deriveSkillList;

	private int _originalSkill;

	private int _recodeOriginalSkillDeriveId;

	private bool _deriveWindowOpen;

	private bool isStateDerive;

	private bool _restoreDeriveTime;

	private float _progress;

	private HeroSkillTypeEnum _heroSkillTypeEnum;

	private bool _isPause;

	public float DeriveTime
	{
		get
		{
			return _deriveTime;
		}
		private set
		{
			Set(ref _deriveTime, value, "DeriveTime");
		}
	}

	public float CurrentDeriveTime
	{
		get
		{
			return _currentDeriveTime;
		}
		private set
		{
			Set(ref _currentDeriveTime, value, "CurrentDeriveTime");
		}
	}

	public float Progress
	{
		get
		{
			return _progress;
		}
		private set
		{
			Set(ref _progress, value, "Progress");
		}
	}

	public bool IsDeriving
	{
		get
		{
			return _deriveWindowOpen;
		}
		private set
		{
			Set(ref _deriveWindowOpen, value, "IsDeriving");
		}
	}

	public bool IsStateDerive
	{
		get
		{
			return isStateDerive;
		}
		private set
		{
			Set(ref isStateDerive, value, "IsStateDerive");
		}
	}

	public bool IsDeriveSkill => _isDeriveSkill;

	public bool IsDerive => _deriveSkillList.Count != 0;

	public int OriginalSkillId => _originalSkill;

	public int OriginalDeriveSkillOriginalId => _recodeOriginalSkillDeriveId;

	public SkillDeriveData(DRHeroSKillConfig sKillConfig)
	{
		_isDeriveSkill = sKillConfig.IsDeriveSkill;
		DeriveTime = sKillConfig.DeriveSkillWindowTime;
		_initDeriveTime = sKillConfig.DeriveSkillWindowTime;
		CurrentDeriveTime = 0f;
		_skillId = sKillConfig.Id;
		_currentDeriveNumber = 0;
		_deriveSkillList = new List<int>();
	}

	public void SetDeriveWindowExecuteState(bool isPause)
	{
		_isPause = isPause;
	}

	public void DeriveDataRegisterEntity(BaseEntity baseEntity)
	{
		_baseEntity = baseEntity;
	}

	public void CultivateSkillEffect(DRCultivateSkillEffect cultivateSkillEffect)
	{
		DeriveTime += cultivateSkillEffect.DeriveSkillWindowTime;
		_initDeriveTime = DeriveTime;
	}

	public void FixedUpdate(float deltaTime)
	{
		if (_isPause || !_deriveWindowOpen)
		{
			return;
		}
		if (_currentDeriveTime > 0f)
		{
			float num = deltaTime;
			if (!isStateDerive && _baseEntity.FrozenSpeed != 1f && (_baseEntity.FrozenType == 1 || _baseEntity.FrozenType == 3))
			{
				num = deltaTime * _baseEntity.FrozenSpeed;
			}
			CurrentDeriveTime = Mathf.Clamp(_currentDeriveTime - num, 0f, _deriveTime);
			Progress = CurrentDeriveTime / DeriveTime;
		}
		if (CurrentDeriveTime <= 0f && Math.Abs(CurrentDeriveTime - -1f) > 0.001f)
		{
			OnDeriveWindowEnd();
		}
	}

	public bool RegisterDeriveSkillId(int deriveSkillId)
	{
		if (_deriveSkillList.Contains(deriveSkillId))
		{
			return false;
		}
		_deriveSkillList.Add(deriveSkillId);
		return true;
	}

	public void ExpendDriveNumber()
	{
		if (_isDeriveSkill)
		{
			_currentDeriveNumber--;
			if (_currentDeriveNumber == 0)
			{
				OnDeriveWindowEnd();
			}
		}
	}

	public void OnCreateDeriveSkillWindowEnd(int deriveSkillId)
	{
		if (_deriveSkillList.Contains(deriveSkillId))
		{
			_deriveSkillList.Remove(deriveSkillId);
		}
	}

	public void OpenDeriveWindow(float deriveTime, bool restoreDeriveTime, HeroSkillTypeEnum heroSkillTypeEnum, HeroSkillData originalSkillData, int deriveNumber, bool isStateDerive)
	{
		_deriveWindowOpen = true;
		this.isStateDerive = isStateDerive;
		_restoreDeriveTime = restoreDeriveTime;
		_heroSkillTypeEnum = heroSkillTypeEnum;
		_originalSkill = originalSkillData.Id;
		if (originalSkillData.IsDeriveSkill)
		{
			_recodeOriginalSkillDeriveId = originalSkillData.OriginalSkillId;
		}
		_currentDeriveNumber = deriveNumber;
		if (deriveTime != 0f)
		{
			CurrentDeriveTime = deriveTime;
			DeriveTime = deriveTime;
		}
		else
		{
			CurrentDeriveTime = _deriveTime;
		}
		Progress = CurrentDeriveTime / DeriveTime;
	}

	public void SetDeriveTime(float time, bool changeDriveTime)
	{
		if (changeDriveTime)
		{
			DeriveTime = time;
		}
		CurrentDeriveTime = Mathf.Clamp(time, 0f, DeriveTime);
		Progress = CurrentDeriveTime / DeriveTime;
	}

	public void ChangeDeriveTime(float addTime, bool changeDriveTime)
	{
		if ((addTime > 0f) & changeDriveTime)
		{
			DeriveTime += addTime;
		}
		CurrentDeriveTime = Mathf.Clamp(CurrentDeriveTime + addTime, 0f, DeriveTime);
		Progress = CurrentDeriveTime / DeriveTime;
	}

	public void HideSkillDeriveWindow()
	{
		OnDeriveWindowEnd();
	}

	private void OnDeriveWindowEnd()
	{
		if (_restoreDeriveTime)
		{
			DeriveTime = _initDeriveTime;
			_restoreDeriveTime = false;
		}
		_baseEntity.GetComponent<SkillComponent>().OnDeriveWindowEnd(_originalSkill, _skillId, _heroSkillTypeEnum);
		_deriveWindowOpen = false;
		isStateDerive = false;
		_originalSkill = 0;
		_heroSkillTypeEnum = HeroSkillTypeEnum.None;
		_currentDeriveNumber = 0;
		Progress = 0f;
	}

	public int GetLatestDeriveSkillId()
	{
		if (_deriveSkillList.Count == 0)
		{
			return 0;
		}
		List<int> deriveSkillList = _deriveSkillList;
		int index = deriveSkillList.Count - 1;
		return deriveSkillList[index];
	}

	public void Clear()
	{
		_baseEntity = null;
	}
}
