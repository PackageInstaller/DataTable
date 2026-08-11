using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class SkillTimeLineSystem : BaseSystem
{
	private int _serialId = 1;

	private SkillTimeLineAssetsFactory _skillTimeLineAssetsFactory;

	private Dictionary<int, SkillTimeLineData> _executeSkillTimelineAssetDic = new Dictionary<int, SkillTimeLineData>();

	private Dictionary<int, IObjectPool<GameObject>> _skillTimeLinePools = new Dictionary<int, IObjectPool<GameObject>>();

	private List<int> _waitStopSkillTimeLine = new List<int>();

	protected override bool IsLogicSystem => true;

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		foreach (SkillTimeLineData value in _executeSkillTimelineAssetDic.Values)
		{
			value?.Execute(deltaTime);
		}
	}

	public async Task<int> ExecuteSkillTimeLine(int skillTimeLineId, BaseEntity baseEntity)
	{
		GameObject gameObject = await GetSkillTimeLineObj(skillTimeLineId);
		if (gameObject == null)
		{
			return -1;
		}
		SkillTimelineLauncher component = gameObject.GetComponent<SkillTimelineLauncher>();
		if (component == null)
		{
			return -1;
		}
		_serialId++;
		SkillTimeLineData skillTimeLineData = ReferencePool.Acquire<SkillTimeLineData>();
		skillTimeLineData.Init(_serialId, baseEntity, gameObject, component);
		_executeSkillTimelineAssetDic.Add(_serialId, skillTimeLineData);
		return _serialId;
	}

	public void ExecuteSkillTimeLine(int serialId)
	{
		_executeSkillTimelineAssetDic.TryGetValue(serialId, out var value);
		value?.RefreshInitState();
	}

	public void StopSkillTimeLine(int skillTimeLineExecuteId)
	{
		_executeSkillTimelineAssetDic.TryGetValue(skillTimeLineExecuteId, out var value);
		value?.Stop();
	}

	public void PauseSkillTimeLine(int skillTimeLineExecuteId, bool isPause)
	{
		_executeSkillTimelineAssetDic.TryGetValue(skillTimeLineExecuteId, out var value);
		value?.Pause(isPause);
	}

	public PlayableStateEnum GetSkillTimelineState(int serialId)
	{
		_executeSkillTimelineAssetDic.TryGetValue(serialId, out var value);
		return value?.ExecuteState() ?? PlayableStateEnum.Error;
	}

	private async Task<GameObject> GetSkillTimeLineObj(int skillId)
	{
		_skillTimeLinePools.TryGetValue(skillId, out var value);
		if (value == null)
		{
			DRSkillTimeLine dataRow = GameEntry.DataTable.GetDataRow<DRSkillTimeLine>(skillId);
			if (dataRow == null)
			{
				return null;
			}
			string fullPath = AssetUtility.GetSkillTimeLineAsset(dataRow.AssetPath);
			GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(fullPath);
			if (gameObject == null)
			{
				return null;
			}
			if (!_skillTimeLinePools.ContainsKey(skillId))
			{
				value = new ObjectPool<GameObject>(new SkillTimeLineFactory(fullPath, gameObject, world.ParadoxRoot), 1);
				_skillTimeLinePools.Add(skillId, value);
			}
			else
			{
				_skillTimeLinePools.TryGetValue(skillId, out value);
			}
		}
		if (value != null)
		{
			GameObject gameObject2 = value.Allocate();
			gameObject2.SetActive(value: true);
			return gameObject2;
		}
		return null;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (_skillTimeLinePools != null)
		{
			foreach (KeyValuePair<int, IObjectPool<GameObject>> skillTimeLinePool in _skillTimeLinePools)
			{
				skillTimeLinePool.Value.Dispose();
			}
			_skillTimeLinePools.Clear();
		}
		if (_skillTimeLineAssetsFactory != null)
		{
			_skillTimeLineAssetsFactory.ClearCache();
			Object.Destroy(_skillTimeLineAssetsFactory.gameObject);
			_skillTimeLineAssetsFactory = null;
		}
		if (_executeSkillTimelineAssetDic != null)
		{
			foreach (SkillTimeLineData value in _executeSkillTimelineAssetDic.Values)
			{
				if (value != null)
				{
					ReferencePool.Release(value);
				}
			}
			_executeSkillTimelineAssetDic.Clear();
		}
		if (_waitStopSkillTimeLine != null)
		{
			_waitStopSkillTimeLine.Clear();
		}
		_waitStopSkillTimeLine = null;
	}
}
