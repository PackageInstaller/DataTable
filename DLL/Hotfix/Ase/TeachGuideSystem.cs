using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TeachGuideSystem : BaseSystem, IObserverHandler
{
	private BattleObserverSystem observerSystem;

	private TeachSkillTaskViewModel teachSkillTaskViewModel;

	private TeachSkillTaskWindow teachSkillTaskWindow;

	private TeachGuideViewModel teachGuideViewModel;

	private TeachGuideWindow teachGuideWindow;

	private TeachSkillComboViewModel teachSkillComboViewModel;

	private TeachSkillComboWindow teachSkillComboWindow;

	private TeachTimeTaskViewModel teachTimeTaskViewModel;

	private TeachTimeTaskWindow teachTimeTaskWindow;

	private float delayStartSkillGroup = -1f;

	private float delayShowTeachTime;

	private Window delayShowTeachWindow;

	private bool systemStart;

	private List<int> teachTaskGroups;

	private int teachingId;

	protected override bool IsLogicSystem => false;

	public override UniTask<bool> OnEnter(object data = null)
	{
		if (data is WorldData { TeachingId: not 0 } worldData && GameEntry.DataTable.GetDataRow<DRLevelTeachingConfig>(worldData.TeachingId) != null)
		{
			teachingId = worldData.TeachingId;
		}
		return base.OnEnter(data);
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		delayStartSkillGroup = 1f;
		observerSystem = GetSystem<BattleObserverSystem>();
		systemStart = true;
		TeachGuideSkillBtnSet();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (!systemStart)
		{
			return;
		}
		if (teachingId != 0 && delayStartSkillGroup > 0f)
		{
			delayStartSkillGroup -= deltaTime;
			if (delayStartSkillGroup <= 0f)
			{
				StartHeroTeaching(teachingId);
			}
		}
		SkillComboFixedUpdate(deltaTime);
		UpdateTeachDelayShow(deltaTime);
	}

	private void UpdateTeachDelayShow(float deltaTime)
	{
		if (!(delayShowTeachTime > 0f))
		{
			return;
		}
		delayShowTeachTime -= deltaTime;
		if (delayShowTeachTime <= 0f)
		{
			if (delayShowTeachWindow != null)
			{
				delayShowTeachWindow.Show();
			}
			SetCanReleaseSkill(isOpen: true);
		}
	}

	private Vector3 GetEntityPos(int type)
	{
		BaseEntity baseEntity = null;
		switch (type)
		{
		case 2:
			baseEntity = GetActorEntity();
			break;
		case 3:
			baseEntity = GetSystem<BattleSystem>().GetMonsterEntity();
			break;
		}
		return GetSystem<CameraSystem>().BattleCamera.WorldToScreenPoint(baseEntity.transform.position);
	}

	public void CreateTeachTaskGroupAndStart(List<int> taskGroup)
	{
		teachTaskGroups = new List<int>(taskGroup.Count);
		teachTaskGroups.AddRange(taskGroup);
		for (int i = 0; i < teachTaskGroups.Count; i++)
		{
			DRHeroTeachingInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroTeachingInfo>(teachTaskGroups[i]);
			if (dataRow != null && dataRow.Timing == 1)
			{
				StartTeachTaskGroup(dataRow.Id, finishTeachTaskGroup: false, 0f);
				break;
			}
		}
	}

	public void StartHeroTeaching(int id)
	{
		DRLevelTeachingConfig dataRow = GameEntry.DataTable.GetDataRow<DRLevelTeachingConfig>(id);
		if (dataRow != null)
		{
			ActorAddBuff(dataRow.EnterAddBuff, null);
			CreateTeachTaskGroupAndStart(dataRow.TeachingGroup);
		}
	}

	public async void StartTeachTaskGroup(int teachGuideId, bool finishTeachTaskGroup, float nextTeachDelayTime)
	{
		if (!finishTeachTaskGroup && (teachGuideViewModel != null || teachSkillComboViewModel != null || teachSkillTaskViewModel != null))
		{
			return;
		}
		DRHeroTeachingInfo heroTeachingInfo = GameEntry.DataTable.GetDataRow<DRHeroTeachingInfo>(teachGuideId);
		if (heroTeachingInfo == null)
		{
			return;
		}
		if (!finishTeachTaskGroup)
		{
			BattleSystem system = GetSystem<BattleSystem>();
			Action<BattleGMEnum> gmAction = null;
			if (system != null)
			{
				gmAction = system.OnBattleGMAction;
			}
			teachSkillTaskViewModel = new TeachSkillTaskViewModel(heroTeachingInfo, gmAction, TeachFinishGameSettlement);
			teachSkillTaskWindow = await GameEntry.UI.LoadWindow<TeachSkillTaskWindow>(AssetUtility.GetUIFormAsset("TeachSkillTask/TeachSkillTaskWindow"), "DEFAULT", teachSkillTaskViewModel);
			teachSkillTaskWindow.Show();
		}
		else if (teachSkillTaskWindow != null)
		{
			teachSkillTaskWindow.ShowEmptyMask();
		}
		await UniTask.WaitForSeconds(nextTeachDelayTime);
		await UniTask.WaitForFixedUpdate();
		if (finishTeachTaskGroup)
		{
			teachSkillTaskViewModel?.UpdateData(heroTeachingInfo);
		}
		if (this != null && teachSkillTaskViewModel != null)
		{
			if (teachSkillTaskWindow != null)
			{
				teachSkillTaskWindow.HideEmptyMask();
			}
			OpenATeachUI(teachSkillTaskViewModel.TeachTaskId, 0f);
			ActorSetPos();
			ActorSetProperty();
			SetBossState();
			ActorAddBuff(teachSkillTaskViewModel.CreateAddBuff, null);
		}
	}

	private void TeachFinishGameSettlement()
	{
		world.GameSettlement(GameSettlementType.MonsterDead);
	}

	private void OpenATeachUI(int teachId, float delayShowTime)
	{
		bool flag = delayShowTime > 0f;
		if (teachSkillTaskViewModel.TeachGroupType == 1 || teachSkillTaskViewModel.TeachGroupType == 2)
		{
			OpenTeachGuideWindow(teachId, flag);
		}
		else if (teachSkillTaskViewModel.TeachGroupType == 3)
		{
			StartSkillComboTeach(teachId, delayShowTime);
		}
		else if (teachSkillTaskViewModel.TeachGroupType == 4)
		{
			StartTimeTask(teachId, delayShowTime);
		}
		if (flag)
		{
			delayShowTeachTime = delayShowTime;
			if (teachSkillTaskViewModel.NextTeachBanInputSkill == 1)
			{
				SetCanReleaseSkill(isOpen: false);
			}
		}
	}

	private void ActorSetPos()
	{
		if (teachSkillTaskViewModel != null && teachSkillTaskViewModel.BornPoint.Count >= 3)
		{
			GetActorEntity().GetComponent<KinematicMoveComponent>()?.Teleport(teachSkillTaskViewModel.BornPoint.ToVector3());
		}
	}

	private void ActorSetProperty()
	{
		if (teachSkillTaskViewModel == null)
		{
			return;
		}
		BaseEntity actorEntity = GetActorEntity();
		if (actorEntity != null)
		{
			for (int i = 0; i < teachSkillTaskViewModel.SetPropertyName.Count; i++)
			{
				actorEntity.SetProperty(teachSkillTaskViewModel.SetPropertyName[i], teachSkillTaskViewModel.SetPropertyValue[i]);
			}
		}
	}

	private void ComboTaskOrTimeTaskFail()
	{
		ActorSetProperty();
		if (teachSkillComboViewModel != null)
		{
			ActorAddBuff(teachSkillComboViewModel.FailAddBuff, null);
		}
		if (teachTimeTaskViewModel != null)
		{
			ActorAddBuff(teachTimeTaskViewModel.FailAddBuff, null);
		}
	}

	private void TeachTaskFinish()
	{
		if (teachSkillTaskViewModel != null && teachSkillTaskViewModel.GetIsLastTeachTaskGroup())
		{
			ActorAddBuff(teachSkillTaskViewModel.FinshAddBuff, teachSkillTaskViewModel.FinshClearBuff);
		}
	}

	private void SetBossState()
	{
		if (teachSkillTaskViewModel == null)
		{
			return;
		}
		MonsterEntity monsterEntity = GetSystem<BattleSystem>().GetMonsterEntity();
		if (monsterEntity == null)
		{
			return;
		}
		if (teachSkillTaskViewModel.ChangeMonsterState)
		{
			monsterEntity.GetComponent<StateComponent>()?.AddState(teachSkillTaskViewModel.MonsterState, monsterEntity.Id);
		}
		if (teachSkillTaskViewModel.ChangeMonsterPhase)
		{
			MonsterPhaseComponent component = monsterEntity.GetComponent<MonsterPhaseComponent>();
			if (component != null && component.GetMonsterPhase() != teachSkillTaskViewModel.MonsterPhase)
			{
				component.SetMonsterPhase(teachSkillTaskViewModel.MonsterPhase);
			}
		}
	}

	private void ActorAddBuff(List<int> addBuffIds, List<int> clearBuffIds)
	{
		BaseEntity actorEntity = GetActorEntity();
		if (actorEntity == null)
		{
			return;
		}
		if (addBuffIds != null && addBuffIds.Count > 0)
		{
			foreach (int addBuffId in addBuffIds)
			{
				DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(addBuffId);
				if (dataRow != null)
				{
					GetSystem<BuffSystem>().AcquireBuff(actorEntity, actorEntity, dataRow);
				}
			}
		}
		if (clearBuffIds == null || clearBuffIds.Count <= 0)
		{
			return;
		}
		foreach (int clearBuffId in clearBuffIds)
		{
			GetSystem<BuffSystem>().FinishEntityBuff(actorEntity.Id, clearBuffId);
		}
	}

	private void FinishATeach()
	{
		if (teachSkillTaskViewModel != null)
		{
			if (teachSkillTaskViewModel.GetFinishTeachTaskGroup())
			{
				FinishTaskGroup();
			}
			else
			{
				OpenATeachUI(teachSkillTaskViewModel.TeachTaskId, teachSkillTaskViewModel.NextTeachDelayTime);
			}
		}
	}

	public void ForceFinshTaskGroup(int teachTaskGroupId)
	{
		if (teachSkillTaskViewModel != null && teachSkillTaskViewModel.TeachTaskGroupId == teachTaskGroupId)
		{
			CloseTeachGuide();
			CloseSkillComboTeach();
			FinishTaskGroup();
		}
	}

	public void StartNewTeach(int teachId, bool coverCurrentTeach)
	{
		if (teachSkillTaskViewModel == null)
		{
			StartTeachTaskGroup(teachId, finishTeachTaskGroup: false, 0f);
		}
		else if (coverCurrentTeach)
		{
			CloseAllTask();
			StartTeachTaskGroup(teachId, finishTeachTaskGroup: false, 0f);
		}
	}

	private void FinishTaskGroup()
	{
		if (teachTaskGroups != null)
		{
			teachTaskGroups.Remove(teachSkillTaskViewModel.TeachTaskGroupId);
		}
		if (teachSkillTaskViewModel.FinishLevel || (teachTaskGroups != null && teachTaskGroups.Count == 0))
		{
			teachSkillTaskViewModel.FinishLevelSet();
			GetSystem<BattleSystem>().HideSetWindowQuitBtn();
			return;
		}
		if (teachSkillTaskViewModel.NextTeachGroupId == 0)
		{
			CloseSkillTeachTask();
			return;
		}
		DRHeroTeachingInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroTeachingInfo>(teachSkillTaskViewModel.NextTeachGroupId);
		if (dataRow != null)
		{
			if (dataRow.Timing == 2 || dataRow.Timing == 1)
			{
				teachSkillTaskViewModel.Close();
			}
			else
			{
				StartTeachTaskGroup(dataRow.Id, finishTeachTaskGroup: true, dataRow.DelayTime);
			}
		}
	}

	public void CloseTeachTask()
	{
		CloseAllTask();
		if (teachTaskGroups != null)
		{
			teachTaskGroups.Clear();
			teachTaskGroups = null;
		}
	}

	public void CloseTeachTask(int teachTaskId)
	{
		if (teachSkillTaskViewModel != null && teachSkillTaskViewModel.TeachTaskGroupId == teachTaskId)
		{
			CloseAllTask();
		}
	}

	public async void OpenTeachGuideWindow(int teachGuideId, bool delayShow, Transform frameTrans = null, bool ignoreTeachFinish = false)
	{
		if (!ignoreTeachFinish && Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetIsTeachGuide(teachGuideId))
		{
			return;
		}
		if (teachGuideWindow != null)
		{
			teachGuideWindow.ForceCloseUI();
			teachGuideViewModel = null;
			teachGuideWindow = null;
			await UniTask.WaitForFixedUpdate();
		}
		teachGuideViewModel = new TeachGuideViewModel(teachGuideId, frameTrans, SetSkillTaskTrans);
		if (teachGuideViewModel.TeachConfig == null)
		{
			return;
		}
		TeachGuideViewModel obj = teachGuideViewModel;
		obj.ShowSkillBtnAction = (Action<int, bool>)Delegate.Combine(obj.ShowSkillBtnAction, new Action<int, bool>(OnShowSkillBtn));
		TeachGuideViewModel obj2 = teachGuideViewModel;
		obj2.CloseTeachGuideAction = (Action<int, float>)Delegate.Combine(obj2.CloseTeachGuideAction, new Action<int, float>(OnCloseTeachGuide));
		TeachGuideViewModel obj3 = teachGuideViewModel;
		obj3.GamePause = (Action)Delegate.Combine(obj3.GamePause, new Action(OnTeachGuideGamePause));
		TeachGuideViewModel obj4 = teachGuideViewModel;
		obj4.GameResume = (Action)Delegate.Combine(obj4.GameResume, new Action(OnTeachGuideGameResume));
		TeachGuideViewModel obj5 = teachGuideViewModel;
		obj5.GetTargetPosAction = (Func<int, Vector3>)Delegate.Combine(obj5.GetTargetPosAction, new Func<int, Vector3>(GetEntityPos));
		teachGuideWindow = await GameEntry.UI.LoadWindow<TeachGuideWindow>(AssetUtility.GetUIFormAsset("TeachGuide/TeachGuideWindow"), "DEFAULT", teachGuideViewModel);
		if (delayShow)
		{
			delayShowTeachWindow = teachGuideWindow;
			return;
		}
		if (!systemStart)
		{
			await UniTask.WaitUntil(() => systemStart);
			if (teachGuideWindow == null)
			{
				return;
			}
		}
		teachGuideWindow?.Show();
	}

	public bool GetIsTeachGuideId(int id)
	{
		if (teachGuideViewModel == null)
		{
			return false;
		}
		return teachGuideViewModel.TeachConfig.Id == id;
	}

	public void CloseTeachGuideWindow()
	{
		if (teachGuideWindow != null)
		{
			teachGuideWindow.ForceCloseUI();
		}
	}

	private void OnShowSkillBtn(int index, bool hide)
	{
		if (!MapDataHelper.TeachGuideCtrUIs.TryGetValue(index, out var value))
		{
			return;
		}
		if (value.Item2 == HeroSkillTypeEnum.None)
		{
			if (UIWindowHelper.UIControls.TryGetValue(value.Item1, out var value2))
			{
				value2.gameObject.SetActive(!hide);
			}
		}
		else
		{
			GetSystem<TouchSystem>().SetSkillBtnHide(value.Item2, hide);
		}
	}

	private async void OnCloseTeachGuide(int nextGuide, float delayTime)
	{
		TeachTaskFinish();
		if (teachGuideViewModel != null)
		{
			TeachGuideViewModel obj = teachGuideViewModel;
			obj.ShowSkillBtnAction = (Action<int, bool>)Delegate.Remove(obj.ShowSkillBtnAction, new Action<int, bool>(OnShowSkillBtn));
			TeachGuideViewModel obj2 = teachGuideViewModel;
			obj2.CloseTeachGuideAction = (Action<int, float>)Delegate.Remove(obj2.CloseTeachGuideAction, new Action<int, float>(OnCloseTeachGuide));
			TeachGuideViewModel obj3 = teachGuideViewModel;
			obj3.GamePause = (Action)Delegate.Remove(obj3.GamePause, new Action(OnTeachGuideGamePause));
			TeachGuideViewModel obj4 = teachGuideViewModel;
			obj4.GameResume = (Action)Delegate.Remove(obj4.GameResume, new Action(OnTeachGuideGameResume));
			teachGuideViewModel = null;
		}
		teachGuideWindow = null;
		ShowNextGuide(nextGuide, delayTime);
	}

	private void OnTeachGuideGamePause()
	{
		Singleton<AudioSystem>.Instance.SetHostingAudioPause(pause: true);
		world.GamePause();
	}

	private void OnTeachGuideGameResume()
	{
		Singleton<AudioSystem>.Instance?.SetHostingAudioPause(pause: false);
		world?.GameResume();
	}

	private async void ShowNextGuide(int nextGuide, float delayTime)
	{
		if (nextGuide != 0)
		{
			await UniTask.WaitForSeconds(delayTime);
			this?.OpenTeachGuideWindow(nextGuide, delayShow: false);
		}
		else
		{
			FinishATeach();
		}
	}

	public void TeachGuideSkillBtnSet()
	{
		GetSystem<SceneSystem>().GetTeachGuideBanSkillEnum();
		if (!GetSystem<SceneSystem>().GetIsInTeachGuideLevel())
		{
			return;
		}
		foreach (HeroSkillTypeEnum teachSkillSetTypeEnum in MapDataHelper.TeachSkillSetTypeEnums)
		{
			GetSystem<TouchSystem>().SetSkillBtnHide(teachSkillSetTypeEnum, hide: true);
		}
	}

	public async void StartTimeTask(int timeTaskId, float delayShowTime)
	{
		DRTimeTask dataRow = GameEntry.DataTable.GetDataRow<DRTimeTask>(timeTaskId);
		if (dataRow != null)
		{
			teachTimeTaskViewModel = new TeachTimeTaskViewModel(dataRow, ComboTaskOrTimeTaskFail, TeachTaskFinish, SetSkillTaskTrans);
			teachTimeTaskWindow = await GameEntry.UI.LoadWindow<TeachTimeTaskWindow>(AssetUtility.GetUIFormAsset("TeachTimeTask/TeachTimeTaskWindow"), "DEFAULT", teachTimeTaskViewModel);
			if (delayShowTime > 0f)
			{
				delayShowTeachWindow = teachTimeTaskWindow;
			}
			else
			{
				teachTimeTaskWindow.Show();
			}
		}
	}

	public void SetTimeTaskFinish(bool isSuccess)
	{
		if (teachTimeTaskViewModel != null)
		{
			if (isSuccess)
			{
				teachTimeTaskViewModel.SuccessTimeTask();
			}
			else
			{
				teachTimeTaskViewModel.FailTimeTask();
			}
		}
	}

	public async void StartSkillComboTeach(int skillComboId, float delayShowTime)
	{
		DRTeachingTask dataRow = GameEntry.DataTable.GetDataRow<DRTeachingTask>(skillComboId);
		if (dataRow != null)
		{
			teachSkillComboViewModel = new TeachSkillComboViewModel(dataRow, ComboTaskOrTimeTaskFail, TeachTaskFinish, TeachSkillBtnEffect, SetSkillTaskTrans);
			teachSkillComboWindow = await GameEntry.UI.LoadWindow<TeachSkillComboWindow>(AssetUtility.GetUIFormAsset("TeachSkillCombo/TeachSkillComboWindow"), "DEFAULT", teachSkillComboViewModel);
			if (delayShowTime > 0f)
			{
				delayShowTeachWindow = teachSkillComboWindow;
			}
			else
			{
				teachSkillComboWindow.Show();
			}
			if (observerSystem != null)
			{
				observerSystem.Attach(BattleObserverEventEnum.ReleaseSkill, this);
				observerSystem.Attach(BattleObserverEventEnum.SkillCancel, this);
			}
		}
	}

	private async void SetSkillTaskTrans()
	{
		await UniTask.WaitForEndOfFrame();
		if (!(teachSkillTaskWindow == null))
		{
			int siblingIndex = teachSkillTaskWindow.transform.GetSiblingIndex();
			if (teachTimeTaskWindow != null)
			{
				siblingIndex = teachTimeTaskWindow.transform.GetSiblingIndex();
			}
			if (teachSkillComboWindow != null)
			{
				siblingIndex = teachSkillComboWindow.transform.GetSiblingIndex();
			}
			if (teachGuideWindow != null)
			{
				siblingIndex = teachGuideWindow.transform.GetSiblingIndex();
			}
			teachSkillTaskWindow.transform.SetSiblingIndex(siblingIndex);
		}
	}

	private void TeachSkillBtnEffect(int skillId, bool isShow)
	{
		if (GetActorEntity() is HeroEntity heroEntity)
		{
			heroEntity.GetComponent<SkillComponent>()?.GetSkillData(skillId)?.SetTeachSkillEffect(isShow);
		}
	}

	public void CloseSkillComboTeach()
	{
		if (teachSkillComboViewModel != null)
		{
			teachSkillComboViewModel.Close();
			teachSkillComboWindow = null;
			teachSkillComboViewModel = null;
		}
		if (observerSystem != null)
		{
			observerSystem.Detach(BattleObserverEventEnum.ReleaseSkill, this);
			observerSystem.Detach(BattleObserverEventEnum.SkillCancel, this);
		}
	}

	public void CloseTimeTask()
	{
		if (teachTimeTaskViewModel != null)
		{
			teachTimeTaskViewModel.Close();
			teachTimeTaskWindow = null;
			teachTimeTaskViewModel = null;
		}
	}

	private void CloseTeachGuide()
	{
		if (teachGuideViewModel != null)
		{
			teachGuideViewModel.Close();
			teachGuideViewModel = null;
			teachGuideWindow = null;
		}
	}

	private void CloseSkillTeachTask()
	{
		if (teachSkillTaskViewModel != null)
		{
			teachSkillTaskViewModel.Close();
			teachSkillTaskViewModel = null;
			teachSkillTaskWindow = null;
		}
	}

	private void SkillComboFixedUpdate(float delateTime)
	{
		if (teachSkillComboViewModel != null)
		{
			if (teachSkillComboViewModel.SkillComboState == SkillComboState.Close)
			{
				CloseSkillComboTeach();
				FinishATeach();
				return;
			}
			teachSkillComboViewModel.OnTimeElapse(delateTime);
		}
		if (teachTimeTaskViewModel != null)
		{
			if (teachTimeTaskViewModel.TimeTaskState == TimeTaskState.Close)
			{
				CloseTimeTask();
				FinishATeach();
			}
			else
			{
				teachTimeTaskViewModel.OnTimeElapse(delateTime);
			}
		}
	}

	private BaseEntity GetActorEntity()
	{
		if (world == null)
		{
			return null;
		}
		return GetSystem<EntitySystem>()?.GetEntity(world.ActorId);
	}

	private void SetCanReleaseSkill(bool isOpen)
	{
		BaseEntity actorEntity = GetActorEntity();
		if (actorEntity != null)
		{
			SkillComponent component = actorEntity.GetComponent<SkillComponent>();
			component.SetSkillCanRelease(HeroSkillTypeEnum.Roll, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.Attack, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.Skill1, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.Skill2, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.Skill3, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.Skill4, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.PropSkill, isOpen);
			component.SetSkillCanRelease(HeroSkillTypeEnum.DeputyPropSkill, isOpen);
		}
	}

	private void CloseAllTask()
	{
		CloseTeachGuide();
		CloseSkillComboTeach();
		CloseTimeTask();
		CloseSkillTeachTask();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		CloseAllTask();
	}

	public void OnNotify(IObserverParams param)
	{
		if (delayShowTeachTime <= 0f)
		{
			if (param.ObserverEventType == BattleObserverEventEnum.ReleaseSkill)
			{
				OnStatReleaseSkill(param as ObserverReleaseSkillParams);
			}
			else if (param.ObserverEventType == BattleObserverEventEnum.SkillCancel)
			{
				OnStateSkillCanel(param as ObserverSkillCanelParams);
			}
		}
	}

	private void OnStatReleaseSkill(ObserverReleaseSkillParams observerReleaseSkillParams)
	{
		if (teachSkillComboViewModel == null)
		{
			return;
		}
		BaseEntity entity = observerReleaseSkillParams.ReleaseEntity;
		if (!entity.IsActorEntity)
		{
			return;
		}
		if (observerReleaseSkillParams.ExecuteState == SkillExecuteState.SkillRelease)
		{
			teachSkillComboViewModel.GetSkillRelease(observerReleaseSkillParams.SkillId);
		}
		else
		{
			if (observerReleaseSkillParams.ExecuteState != SkillExecuteState.SkillStart)
			{
				return;
			}
			DRHeroSKillInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSKillInfo data) => data.HeroId == entity.EntityId);
			for (int num = 0; num < dataRows.Length; num++)
			{
				if (dataRows[num].CommandBindSkillGroup.Contains(observerReleaseSkillParams.SkillId))
				{
					teachSkillComboViewModel.SetSkillStart(dataRows[num].CommandBindSkillGroup);
					break;
				}
			}
		}
	}

	private void OnStateSkillCanel(ObserverSkillCanelParams observerSkillCanelParams)
	{
		if (teachSkillComboViewModel != null && observerSkillCanelParams.Trigger.IsActorEntity)
		{
			teachSkillComboViewModel.SetSkillCanel(observerSkillCanelParams.SkillId);
		}
	}

	public void ForceCurrentSkillComboFail()
	{
		if (teachSkillComboViewModel != null)
		{
			teachSkillComboViewModel.ForceSkillComboFail();
		}
	}
}
