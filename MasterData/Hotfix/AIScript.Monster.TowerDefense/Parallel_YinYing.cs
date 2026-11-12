using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class Parallel_YinYing : TowerMonsterParalletBase
{
	private const string bulletEndEffectKey = "Weapon_50101YinYing_End_TD";

	private FP gridCheckRadius = 1.4;

	private FP maxTrackTime = 5;

	private AdventureBulletBase _trackBullet;

	private List<GridInfoData> _itemGrids;

	private readonly List<int> _hitCharacters = new List<int>();

	private CoroutineNode _corBulletTrack;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		StopCoroutine(ref _corBulletTrack);
		_trackBullet = null;
		_itemGrids = null;
		_hitCharacters.Clear();
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (evt is AdventureBulletBornEvent adventureBulletBornEvent && !(adventureBulletBornEvent.owner == null) && adventureBulletBornEvent.owner.Id == _actor.Id)
		{
			AdventureBulletBase adventureBulletBase = adventureBulletBornEvent.sender as AdventureBulletBase;
			if (!(adventureBulletBase == null) && !string.IsNullOrEmpty(adventureBulletBornEvent.tag) && !(adventureBulletBornEvent.tag != "YinYing_Dark"))
			{
				_trackBullet = adventureBulletBase;
				_itemGrids = null;
				_hitCharacters.Clear();
				StartCoroutine(ref _corBulletTrack, TrackBulletLoop());
			}
		}
	}

	private IEnumerator TrackBulletLoop()
	{
		FP startTime = _actor.LogicTime;
		while (_trackBullet != null && !_trackBullet.isFinished && _actor.LogicTime - startTime < maxTrackTime)
		{
			CheckBulletEnterItemGrid();
			CheckBulletHitCharacterGrid();
			yield return null;
		}
		_trackBullet = null;
	}

	private void CheckBulletEnterItemGrid()
	{
		if (_trackBullet == null || _trackBullet.isFinished)
		{
			return;
		}
		Dispatch_GetItemGridInfo((List<GridInfoData> grids) =>
		{
			_itemGrids = grids;
		});
		if (_itemGrids == null)
		{
			return;
		}
		TSVector2 position = _trackBullet.tsTransform.Position;
		for (int num = 0; num < _itemGrids.Count; num++)
		{
			GridInfoData gridInfoData = _itemGrids.get_Item(num);
			if (TSVector2.Distance(position, gridInfoData.position) <= gridCheckRadius)
			{
				Dispatch_DarkenItemGrid(gridInfoData.gridIndex);
			}
		}
	}

	private void CheckBulletHitCharacterGrid()
	{
		if (_trackBullet == null || _trackBullet.isFinished)
		{
			return;
		}
		TSVector2 position = _trackBullet.tsTransform.Position;
		Dispatch_GetGridInfoByPosition(position, (GridInfoData grid) =>
		{
			if (grid != null && grid.playerID != 0 && !_hitCharacters.Contains(grid.playerID))
			{
				TowerDefenseCharacterActor towerDefenseCharacterActor = FindCharacterByDataID(grid.playerID);
				if (!(towerDefenseCharacterActor == null))
				{
					_hitCharacters.Add(grid.playerID);
					towerDefenseCharacterActor.buffComponent.AddBuff(TowerDefenseConfig.buffId_RoleDarken, _actor);
					ILRuntimeAPI.PlayAreaEffect(_actor, "Weapon_50101YinYing_End_TD", grid.position, _actor.tsTransform.Rotation);
					Dispatch_DarkenRoleGrid(grid.playerID);
				}
			}
		});
	}

	private TowerDefenseCharacterActor FindCharacterByDataID(int dataID)
	{
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		if (dynamicActors == null)
		{
			return null;
		}
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			if (dynamicActors.get_Item(i) is TowerDefenseCharacterActor { IsActive: not false } towerDefenseCharacterActor && towerDefenseCharacterActor.dataID == dataID)
			{
				return towerDefenseCharacterActor;
			}
		}
		return null;
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner != _actor) && !string.IsNullOrEmpty(adventureBulletFinishEvent.tag) && !(adventureBulletFinishEvent.tag != "YinYing_Dark"))
		{
			StopCoroutine(ref _corBulletTrack);
		}
	}
}
