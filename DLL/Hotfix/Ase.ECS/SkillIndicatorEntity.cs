using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class SkillIndicatorEntity : IReference
{
	private int indicatorId;

	private SkillIndicatorView rangeView;

	private SkillIndicatorView directionView;

	private SkillIndicatorData indicatorData;

	private bool indicatorEnd;

	private BaseEntity bindEntity;

	private float indicatorAngle;

	private bool cancelRelease;

	public SkillIndicatorData IndicatorData => indicatorData;

	public BaseEntity BindEntity => bindEntity;

	public int IndicatorId => indicatorId;

	public void InitData(int id, SkillIndicatorData data, BaseEntity entity)
	{
		indicatorId = id;
		indicatorData = data;
		bindEntity = entity;
	}

	public void AddSkillRangeIndicator(SkillIndicatorView rangeIndicatorView)
	{
		rangeView = rangeIndicatorView;
		rangeView.gameObject.SetActive(value: false);
		rangeView.InitScale(indicatorData);
	}

	public void AddSkillDirectionIndicator(SkillIndicatorView directionIndicatorView)
	{
		directionView = directionIndicatorView;
		directionView.InitScale(indicatorData);
	}

	public void Show(Vector3? angleDir)
	{
		Transform transform = bindEntity.GetEntityObject().transform;
		Vector3 position = bindEntity.GetEntityObject().transform.position;
		Vector3 eulerAngles = bindEntity.GetEntityObject().transform.rotation.eulerAngles;
		if (rangeView != null)
		{
			rangeView.Init(position, eulerAngles, transform);
		}
		if (directionView != null)
		{
			directionView.Init(position, eulerAngles, transform);
			directionView.Show();
		}
		indicatorEnd = false;
		cancelRelease = false;
		if (angleDir.HasValue)
		{
			UpdateAngle(angleDir.Value);
		}
	}

	public void UpdateAngle(Vector3 angle)
	{
		if (rangeView != null && !rangeView.gameObject.activeSelf)
		{
			rangeView.Show();
		}
		directionView?.UpdateIndicatorDirection(angle);
	}

	public void OnUpdate(float deltaTime)
	{
		if (indicatorEnd)
		{
			return;
		}
		if (bindEntity == null || !bindEntity.IsSurvival)
		{
			indicatorEnd = true;
			return;
		}
		Vector3 position = bindEntity.transform.position;
		if (rangeView != null)
		{
			rangeView.OnUpdate(position, deltaTime, indicatorData.ChangeIndicatorData);
		}
		if (directionView != null)
		{
			directionView.OnUpdate(position, deltaTime, indicatorData.ChangeIndicatorData);
			directionView.UpdateIndicatorDirection();
		}
	}

	public void OnFixedUpdate(float deltaTime)
	{
		if (rangeView != null)
		{
			rangeView.OnFixedUpdate(deltaTime, indicatorData.ChangeIndicatorData);
		}
		if (directionView != null)
		{
			directionView.OnFixedUpdate(deltaTime, indicatorData.ChangeIndicatorData);
		}
		indicatorData.ChangeIndicatorData.ChangeAngleTime = Mathf.Clamp(indicatorData.ChangeIndicatorData.ChangeAngleTime - 1f, 0f, indicatorData.ChangeIndicatorData.ChangeAngleTime);
		indicatorData.ChangeIndicatorData.ChangeRangeTime = Mathf.Clamp(indicatorData.ChangeIndicatorData.ChangeRangeTime - 1f, 0f, indicatorData.ChangeIndicatorData.ChangeRangeTime);
		indicatorData.ChangeIndicatorData.ChangeWidthTime = Mathf.Clamp(indicatorData.ChangeIndicatorData.ChangeWidthTime - 1f, 0f, indicatorData.ChangeIndicatorData.ChangeWidthTime);
	}

	public void DeleteChangeIndicatorData()
	{
		if (indicatorData != null)
		{
			indicatorData.ChangeIndicatorData.ChangeDataReset();
		}
	}

	public void RestoreColor()
	{
		if (cancelRelease)
		{
			if (rangeView != null)
			{
				rangeView.RestoreColor();
			}
			if (directionView != null)
			{
				directionView.RestoreColor();
			}
			cancelRelease = false;
		}
	}

	public void CancelReleaseChangeColor()
	{
		if (!cancelRelease)
		{
			if (rangeView != null)
			{
				rangeView.CancelReleaseChangeColor();
			}
			if (directionView != null)
			{
				directionView.CancelReleaseChangeColor();
			}
			cancelRelease = true;
		}
	}

	public void ShowCatingWindowChangeColor(bool showIndicator)
	{
		if (rangeView != null)
		{
			rangeView.ShowCastingWindowChangeColor(showIndicator);
		}
		if (directionView != null)
		{
			directionView.ShowCastingWindowChangeColor(showIndicator);
		}
	}

	public void Clear()
	{
		indicatorEnd = true;
		if (rangeView != null)
		{
			rangeView.FreeBack();
			rangeView = null;
		}
		if (directionView != null)
		{
			directionView.FreeBack();
			directionView = null;
			indicatorData = null;
		}
		bindEntity = null;
	}
}
