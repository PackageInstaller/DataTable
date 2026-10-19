using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Drama;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Manager;
using ACT.MissionSystem;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Net;
using ACT.Sound;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.ECS;
using Bamboo.NumberString;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Newtonsoft.Json.Linq;
using Pb;
using Runtime.Battle.ChaseBattle;
using Runtime.Model;
using Runtime.Utility;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Playables;
using bamboosdk;

namespace ACT.BluePrint;

[DisallowMultipleComponent]
public class BPCommon : MonoBehaviour
{
	public ScriptMachine machine;

	protected List<Entity> m_SpawnMonsters;

	protected List<Entity> m_DestroyByBPMonsters;

	protected List<BPTriggerField> m_TriggerFields;

	protected List<AssetLoadHandle> m_Handles;

	protected List<GameObject> m_Objects;

	protected CancellationTokenSource m_CTS;

	protected StringBuilder m_StringBuilder;

	protected List<InteractObjectState> m_ServiceSaveEvents;

	protected bool m_HasAddHitListener;

	protected bool m_needDestroyByBP;

	private GameObject m_BpAsset;

	private bool m_TeamLoadCompleted;

	private HashSet<YooAssetReference> m_preloadTimelines;

	protected Dictionary<int, Entity> m_AssistNpcs;

	private const string _monsterAllWeakEvtName = "MonsterAllWeak";

	private Looper _monsterAllWeakLooper;

	private const string _monsterAllDieEvtName = "MonsterAllDie";

	private Looper _monsterAllDieLooper;

	private bool attackCharging;

	private bool skillCharging;

	private bool m_AttackSpeicalCharging;

	private float cdTemp;

	private int baseValue;

	protected float m_timerTime;

	protected int m_timerCount;

	protected bool m_timerOn;

	protected float m_countDownTime;

	protected bool m_timerCountDownOn;

	protected bool m_abyssTimerOn;

	protected float m_abyssTime;

	protected int m_abyssTimeCount;

	protected bool m_teamTeachingTimerOn;

	protected float m_teamTeachingTime;

	protected int m_teamTeachingTimeCount;

	private const float CharacterTeamTutorialInteractTargetHoldSeconds = 0.5f;

	public Action OnDestroyBluePrint { get; set; }

	private static float dt => GameManager.timeSystem.debugSpeed * Time.fixedDeltaTime;

	private void OnValidate()
	{
		if (!machine)
		{
			machine = GetComponent<ScriptMachine>();
		}
	}

	protected void Awake()
	{
		m_SpawnMonsters = Fundamental.ListPool<Entity>.Get();
		m_DestroyByBPMonsters = Fundamental.ListPool<Entity>.Get();
		m_TriggerFields = Fundamental.ListPool<BPTriggerField>.Get();
		m_Handles = Fundamental.ListPool<AssetLoadHandle>.Get();
		m_CTS = new CancellationTokenSource();
		m_StringBuilder = new StringBuilder();
		m_ServiceSaveEvents = Fundamental.ListPool<InteractObjectState>.Get();
		m_Objects = Fundamental.ListPool<GameObject>.Get();
		m_AssistNpcs = Fundamental.DictionaryPool<int, Entity>.Get();
		m_preloadTimelines = Fundamental.HashSetPool<YooAssetReference>.Get();
		m_HasAddHitListener = false;
		m_needDestroyByBP = false;
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, OnServiceStateEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Player_Respawn, OnPlayerRespawn);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Input_Down, OnInputStateChangeEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_TaskTraceEvt, OnTraceMissionEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_TaskUnTraceEvt, OnUnTraceMissionEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, WorldChangeEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, BattleTpEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeOvertime, ChallengeOvertimeEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeCollect, ChallengeCollectEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeExit, ChallengeExitEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ComboChallengeCount, RefreshComboCount);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeProtectionHpChange, ChallengeProtectionHpChangeEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.SubItemCommit, SubitemCommitEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeTreasureMapGetitem, ChallengeTreasureMapGetitemEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_LoadComplete, OnTeamLoadCompleted);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.PushPause, PushPauseEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.PopPause, PopPauseEvent);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_ProcessFinish, OnCharacterTutorialProcessFinish);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, BattleCharacterChange);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.SubmissionClose, OnSubmissionClose);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_Finish, OnSNSFinish);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Character_HpLower, OnHpLower);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnRefreshMosterDie);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Recall, OnRecall);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Chase_Fail, OnChaseBattleFailed);
		OnAwake();
	}

	private void OnRecall(BaseEventContent obj)
	{
		if (obj is RecallEvt recallEvt)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("Recall").ToString(), recallEvt.checkPointUID);
		}
	}

	private void OnChaseBattleFailed(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("ChaseBattleFailed").ToString());
	}

	private void OnRefreshMosterDie(BaseEventContent obj)
	{
		EntityDieEvt entityDieEvt = (EntityDieEvt)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("MosterDie").ToString(), entityDieEvt.entity.GetCompMonster().id);
	}

	private void OnHpLower(BaseEventContent obj)
	{
		HpLower hpLower = (HpLower)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("HpLower").ToString(), hpLower.id);
	}

	private void OnSNSFinish(BaseEventContent obj)
	{
		SNSFinish sNSFinish = (SNSFinish)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("SNSFinish").ToString(), sNSFinish.id);
	}

	private void BattleCharacterChange(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("CharacterChange").ToString());
	}

	private void OnSubmissionClose(BaseEventContent obj)
	{
		SubmissionClose submissionClose = (SubmissionClose)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("SubmissionClose").ToString(), submissionClose.id);
	}

	protected void Start()
	{
		OnStart();
	}

	protected async void OnEnable()
	{
		await PrepareTimelineResource();
		EventBus.Trigger(new EventHook("OnResourcePrepared", machine));
	}

	protected void FixedUpdate()
	{
		CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
		if (attackCharging)
		{
			compAbility.ModifyNormalEnergy(compAbility.EnergyValue + 50f * dt);
		}
		if (skillCharging)
		{
			compAbility.CurrentUltimateSkillValue += 50f * dt;
			CharacterUltraEnergyUpdateEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<CharacterUltraEnergyUpdateEvt>();
			evt.entity = MonoECS.instance.mainEntity;
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CharacterEnergyChange, evt);
			Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		if (m_AttackSpeicalCharging)
		{
			compAbility.ModifySpecialEnergy(compAbility.SpecialEnergyValue + 50f * dt);
		}
		UpdateTimer();
		UpdateAbyssTimer();
		UpdateTeamTeachingTimer();
		UpdateCountDownTimer();
	}

	protected void OnDestroy()
	{
		Destroy();
		OnDestroyBluePrint?.Invoke();
	}

	protected virtual void OnAwake()
	{
	}

	protected virtual async void OnStart()
	{
		WorldManager worldManager = Fundamental.Singleton<GameManager>.instance.worldManager;
		SceneChangeEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<SceneChangeEvt>();
		evt.enterWorldId = worldManager.ActiveWorldId;
		evt.leaveWorldId = worldManager.LastWorldId;
		WorldChangeEvent(evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	protected virtual void Destroy()
	{
		Release();
	}

	protected virtual void Release()
	{
		if ((bool)m_BpAsset)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_BpAsset);
		}
		m_CTS.Cancel();
		for (int i = 0; i < m_SpawnMonsters.Count; i++)
		{
			Entity entity = m_SpawnMonsters[i];
			if (entity.IsValid && entity.CanRemove() && !entity.IsOnRemove())
			{
				MonoECS.instance?.TryRemoveBehave(entity);
				if (m_DestroyByBPMonsters.Contains(entity))
				{
					m_DestroyByBPMonsters.Remove(entity);
				}
			}
		}
		for (int j = 0; j < m_DestroyByBPMonsters.Count; j++)
		{
			Entity entity2 = m_DestroyByBPMonsters[j];
			if (entity2.IsValid && !entity2.IsOnRemove())
			{
				entity2.GetRoot()?.SetActive(value: false);
				MonoECS.instance?.TryRemoveBehave(entity2);
			}
		}
		foreach (KeyValuePair<int, Entity> assistNpc in m_AssistNpcs)
		{
			Entity value = assistNpc.Value;
			if (value.IsValid && value.CanRemove() && !value.IsOnRemove())
			{
				MonoECS.instance?.TryRemoveBehave(value);
			}
		}
		m_AssistNpcs.Clear();
		m_SpawnMonsters.Clear();
		m_DestroyByBPMonsters.Clear();
		Fundamental.ListPool<Entity>.Release(m_DestroyByBPMonsters);
		Fundamental.ListPool<Entity>.Release(m_SpawnMonsters);
		for (int k = 0; k < m_TriggerFields.Count; k++)
		{
			if (m_TriggerFields[k] != null)
			{
				UnityEngine.Object.Destroy(m_TriggerFields[k].gameObject);
			}
		}
		Fundamental.ListPool<BPTriggerField>.Release(m_TriggerFields);
		for (int l = 0; l < m_Handles.Count; l++)
		{
			if (AssetLoadHandleExtensions.IsValid(m_Handles[l]))
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles[l]);
			}
		}
		for (int m = 0; m < m_Objects.Count; m++)
		{
			if ((bool)m_Objects[m])
			{
				UnityEngine.Object.Destroy(m_Objects[m]);
			}
		}
		Fundamental.ListPool<AssetLoadHandle>.Release(m_Handles);
		Fundamental.ListPool<InteractObjectState>.Release(m_ServiceSaveEvents);
		Fundamental.ListPool<GameObject>.Release(m_Objects);
		Fundamental.DictionaryPool<int, Entity>.Release(m_AssistNpcs);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, OnServiceStateEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Player_Respawn, OnPlayerRespawn);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Input_Down, OnInputStateChangeEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_TaskTraceEvt, OnTraceMissionEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_TaskUnTraceEvt, OnUnTraceMissionEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, WorldChangeEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, BattleTpEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeOvertime, ChallengeOvertimeEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeCollect, ChallengeCollectEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeExit, ChallengeExitEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ComboChallengeCount, RefreshComboCount);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeProtectionHpChange, ChallengeProtectionHpChangeEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SubItemCommit, SubitemCommitEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeTreasureMapGetitem, ChallengeTreasureMapGetitemEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PushPause, PushPauseEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PopPause, PopPauseEvent);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_LoadComplete, OnTeamLoadCompleted);
		if (m_HasAddHitListener)
		{
			Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleOnHit, OnHit);
		}
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_ProcessFinish, OnCharacterTutorialProcessFinish);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, BattleCharacterChange);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SubmissionClose, OnSubmissionClose);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_Finish, OnSNSFinish);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Character_HpLower, OnHpLower);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnRefreshMosterDie);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Recall, OnRecall);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Chase_Fail, OnChaseBattleFailed);
		FinishCheckMonsterDie();
		FinishCheckMonsterWeak();
		ReleaseTimelineResource();
	}

	protected async UniTask PrepareTimelineResource()
	{
		if (!machine || machine.graph == null)
		{
			return;
		}
		List<PrecacheHandle> precacheItems = Fundamental.ListPool<PrecacheHandle>.Get();
		foreach (VariableDeclaration variable in machine.graph.variables)
		{
			if (variable.name.ToUpper().StartsWith("TIMELINE") && variable.value is BpTimelineData bpTimelineData && m_preloadTimelines.Add(bpTimelineData.assetReference))
			{
				PrecacheHandle precacheHandle = PrecacheManager.Instance.Preload(bpTimelineData.assetReference.GUID);
				if (precacheHandle != null)
				{
					precacheItems.Add(precacheHandle);
				}
			}
		}
		await UniTask.WaitUntil(() =>
		{
			foreach (PrecacheHandle item in precacheItems)
			{
				if (!item.IsDone)
				{
					return false;
				}
			}
			return true;
		});
		Fundamental.ListPool<PrecacheHandle>.Release(precacheItems);
	}

	protected void ReleaseTimelineResource()
	{
		HashSet<YooAssetReference> preloadTimelines = m_preloadTimelines;
		if (preloadTimelines != null && preloadTimelines.Count > 0)
		{
			foreach (YooAssetReference preloadTimeline in m_preloadTimelines)
			{
				PrecacheManager.Instance.ReleasePreload(preloadTimeline.GUID);
			}
		}
		if (m_preloadTimelines != null)
		{
			Fundamental.HashSetPool<YooAssetReference>.Release(m_preloadTimelines);
			m_preloadTimelines = null;
		}
	}

	private async UniTask SpawnMonster(List<SpawnMonsterPoint> p, List<Entity> monsterList, CancellationToken cancellationToken)
	{
		List<float> list = new List<float>(GameLoader.meta.pathOffsetChangeArray);
		list.RandomSort(0, list.Count - 1);
		List<UniTask> tasks = Fundamental.ListPool<UniTask>.Get();
		for (int i = 0; i < p.Count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = p[i].GetSpawnMonsterParams();
			Entity eb = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			tasks.Add(ServerSpawnMonster(p[i], spawnMonsterParams, eb, monsterList, cancellationToken, list, i));
		}
		await UniTask.WhenAll(tasks);
		Fundamental.ListPool<UniTask>.Release(tasks);
	}

	private async UniTask ServerSpawnMonster(SpawnMonsterPoint smp, SpawnMonsterParams param, Entity eb, List<Entity> monsterList, CancellationToken cancellationToken, List<float> pathIndexList, int curPathIndex)
	{
		await MonoECS.instance.CoServerSpawnMonster(eb, param);
		if (smp.buffList != null)
		{
			AddBuff(eb, smp.buffList);
		}
		if (smp.usePathOffsetChange && eb.GetEntityType() == EntityType.Monster && eb.GetConfig().MonsterAttackType != MonsterAttackType.support)
		{
			smp.pathOffset = new Vector3(0f, 0f, pathIndexList[curPathIndex % pathIndexList.Count]);
		}
		else
		{
			smp.pathOffset = Vector3.zero;
		}
		eb.GetCompPhysics().SetPathOffset(smp.pathOffset);
		if (cancellationToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
			return;
		}
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.onDie += new Action<Entity>(MonsterDie);
		compAbility.onHPChange += new Action<int, int>(MonsterHpChange);
		monsterList?.Add(eb);
		if (m_needDestroyByBP)
		{
			m_DestroyByBPMonsters.Add(eb);
		}
	}

	public async UniTask TaskSpawnMonsterWithCallback(List<SpawnMonsterPoint> p, string callbackEventName)
	{
		await TaskSpawnMonster(p);
		CustomEvent.Trigger(gameObject, callbackEventName);
	}

	public async UniTask TaskSpawnMonsterByGroupWithCallback(SpawnMonsterPointGroup p, string callbackEventName)
	{
		await TaskSpawnMonsterByGroup(p);
		CustomEvent.Trigger(gameObject, callbackEventName);
	}

	public async UniTask TaskSpawnMonster(List<SpawnMonsterPoint> p)
	{
		await SpawnMonster(p, m_SpawnMonsters, m_CTS.Token);
	}

	public async UniTask TaskSpawnMonsterByGroup(SpawnMonsterPointGroup p)
	{
		await SpawnMonster(p.GetSpawnMonsterPoints(), m_SpawnMonsters, m_CTS.Token);
	}

	public async UniTask TaskSpawnMonster(List<SpawnMonsterPoint> p, int level)
	{
		foreach (SpawnMonsterPoint item in p)
		{
			item.level = level;
		}
		await SpawnMonster(p, m_SpawnMonsters, m_CTS.Token);
	}

	public async UniTask TaskSpawnMonster(List<SpawnMonsterParams> p)
	{
		await SpawnMonster(p, m_SpawnMonsters, m_CTS.Token);
	}

	private async UniTask SpawnMonster(List<SpawnMonsterParams> p, List<Entity> monsterList, CancellationToken cancellationToken)
	{
		List<float> list = new List<float>(GameLoader.meta.pathOffsetChangeArray);
		list.RandomSort(0, list.Count - 1);
		List<UniTask> tasks = Fundamental.ListPool<UniTask>.Get();
		for (int i = 0; i < p.Count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = (SpawnMonsterParams)p[i].Clone();
			Entity eb = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			tasks.Add(ServerSpawnMonster(spawnMonsterParams, eb, monsterList, cancellationToken, list, i));
		}
		await UniTask.WhenAll(tasks);
		Fundamental.ListPool<UniTask>.Release(tasks);
	}

	private async UniTask ServerSpawnMonster(SpawnMonsterParams param, Entity eb, List<Entity> monsterList, CancellationToken cancellationToken, List<float> pathIndexList, int curPathIndex)
	{
		await MonoECS.instance.CoServerSpawnMonster(eb, param);
		if (param.buffList != null)
		{
			AddBuff(eb, param.buffList);
		}
		CompPhysics compPhysics = eb.GetCompPhysics();
		CompAbility compAbility = eb.GetCompAbility();
		ConfigCharacter config = eb.GetConfig();
		if (param.usePathOffsetChange && eb.GetEntityType() == EntityType.Monster && config.MonsterAttackType != MonsterAttackType.support && compPhysics.overlapEntityMode != OverlapEntityMode.Uncrossable)
		{
			param.pathOffset = new Vector3(0f, 0f, pathIndexList[curPathIndex % pathIndexList.Count]);
		}
		else
		{
			param.pathOffset = Vector3.zero;
		}
		compPhysics.SetPathOffset(param.pathOffset);
		if (cancellationToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
			return;
		}
		compAbility.onDie += new Action<Entity>(MonsterDie);
		compAbility.onHPChange += new Action<int, int>(MonsterHpChange);
		monsterList.Add(eb);
		if (m_needDestroyByBP)
		{
			m_DestroyByBPMonsters.Add(eb);
		}
	}

	public async UniTask SpawnMonsterRandomly(List<SpawnMonsterPoint> p, Vector3[] positions, int count)
	{
		for (int i = 0; i < count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = p[i].GetSpawnMonsterParams();
			int index = UnityEngine.Random.Range(0, p.Count);
			Entity eb = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			await MonoECS.instance.CoServerSpawnMonster(eb, spawnMonsterParams);
			if (p[i].buffList != null)
			{
				AddBuff(eb, p[i].buffList);
			}
			if (p[index].isHaveBornEffect)
			{
				FireEffect(eb, p[index].pos);
			}
			eb.GetCompAbility().onDie += new Action<Entity>(MonsterDie);
			m_SpawnMonsters.Add(eb);
		}
	}

	public async UniTask SpawnMonsterOrderly(List<SpawnMonsterPoint> p, int index, int count)
	{
		for (int i = 0; i < count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = p[i].GetSpawnMonsterParams();
			Entity eb = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			await MonoECS.instance.CoServerSpawnMonster(eb, spawnMonsterParams);
			if (p[index].buffList != null)
			{
				AddBuff(eb, p[index].buffList);
			}
			if (p[index].isHaveBornEffect)
			{
				FireEffect(eb, p[index].pos);
			}
			eb.GetCompAbility().onDie += new Action<Entity>(MonsterDie);
			m_SpawnMonsters.Add(eb);
		}
	}

	public IEnumerator CoSpawnMonsters(List<SpawnMonsterPoint> p)
	{
		for (int i = 0; i < p.Count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = p[i].GetSpawnMonsterParams();
			Entity entity = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			MonoECS.instance.CoServerSpawnMonster(entity, spawnMonsterParams).Forget();
			if (p[i].buffList != null)
			{
				AddBuff(entity, p[i].buffList);
			}
			if (entity.IsValid)
			{
				entity.GetCompAbility().onDie += new Action<Entity>(MonsterDie);
				m_SpawnMonsters.Add(entity);
				yield return null;
			}
		}
	}

	public string StringAppend(string str1, string str2)
	{
		return m_StringBuilder.Clear().Append(str1).Append(str2)
			.ToString();
	}

	public async UniTask UniSpawnMonsters(List<SpawnMonsterPoint> input, List<EntityId> output)
	{
		for (int i = 0; i < input.Count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = input[i].GetSpawnMonsterParams();
			Entity eb = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			await MonoECS.instance.CoServerSpawnMonster(eb, spawnMonsterParams);
			if (input[i].buffList != null)
			{
				AddBuff(eb, input[i].buffList);
			}
			if (input[i].isHaveBornEffect)
			{
				FireEffect(eb, input[i].pos);
			}
			if (eb.IsValid)
			{
				eb.GetCompAbility().onDie += new Action<Entity>(MonsterDie);
				if (i == 0)
				{
					output.Clear();
				}
				m_SpawnMonsters.Add(eb);
				output.Add(eb.Id);
			}
		}
	}

	public void AddHitListener()
	{
		if (!m_HasAddHitListener)
		{
			m_HasAddHitListener = true;
			Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleOnHit, OnHit);
		}
	}

	public void RemoveHitListener()
	{
		if (m_HasAddHitListener)
		{
			m_HasAddHitListener = false;
			Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleOnHit, OnHit);
		}
	}

	private void OnHit(BaseEventContent obj)
	{
		if (obj is HitEvt hitEvt)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(hitEvt.target).Append("_hited")
				.ToString());
		}
	}

	private void FireEffect(Entity eb, Vector3 pos)
	{
		YooAssetReference bornEffectAssetID = eb.GetConfig().bornEffectAssetID;
		if (bornEffectAssetID.RuntimeKeyIsValid())
		{
			FireNoOwnerEffect(bornEffectAssetID, eb.GetModelTrans().position);
		}
	}

	public IEnumerator CoWaitDie(int remainCount)
	{
		while (m_SpawnMonsters.Count > remainCount)
		{
			yield return null;
		}
	}

	public IEnumerator CoWaitMonsterWeak()
	{
		if (m_SpawnMonsters.Count == 0)
		{
			yield break;
		}
		while (m_SpawnMonsters.Count > 0)
		{
			bool flag = true;
			foreach (Entity spawnMonster in m_SpawnMonsters)
			{
				if (!spawnMonster.GetCompAbility().IsWeak)
				{
					flag = false;
					break;
				}
			}
			if (!flag)
			{
				yield return null;
				continue;
			}
			break;
		}
	}

	public void StartCheckMonsterWeak()
	{
		_monsterAllWeakLooper = Bamboo.Chronos.UpdateTimer.Default.LoopFrame(1, () =>
		{
			bool flag = true;
			if (m_SpawnMonsters.Count > 0)
			{
				foreach (Entity spawnMonster in m_SpawnMonsters)
				{
					if (!spawnMonster.GetCompAbility().IsWeak)
					{
						flag = false;
						break;
					}
				}
			}
			if (flag)
			{
				CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("MonsterAllWeak").ToString());
			}
		});
	}

	public void FinishCheckMonsterWeak()
	{
		if (_monsterAllWeakLooper.IsValid())
		{
			_monsterAllWeakLooper.Cancel();
		}
	}

	public string GetMonsterAllWeakEvtName()
	{
		return "MonsterAllWeak";
	}

	public void StartCheckMonsterDie()
	{
		_monsterAllDieLooper = Bamboo.Chronos.UpdateTimer.Default.LoopFrame(1, () =>
		{
			if (m_SpawnMonsters.Count == 0)
			{
				CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("MonsterAllDie").ToString());
			}
		});
	}

	public void FinishCheckMonsterDie()
	{
		if (_monsterAllDieLooper.IsValid())
		{
			_monsterAllDieLooper.Cancel();
		}
	}

	public string GetMonsterAllDieEvtName()
	{
		return "MonsterAllDie";
	}

	public IEnumerator CoWaitCharactersDie(int remainCount)
	{
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		List<Entity> ebs = new List<Entity>();
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				ebs.Add(teamCharacter);
			}
		}
		int aliveCount = 3;
		while (aliveCount > remainCount)
		{
			aliveCount = 0;
			for (int j = 0; j < ebs.Count; j++)
			{
				if (ebs[j].IsAlive())
				{
					aliveCount++;
				}
			}
			yield return null;
		}
	}

	public void RemoveSpawnedMonster(Entity er)
	{
		m_SpawnMonsters?.Remove(er);
	}

	public static GameObject CreateBpAsset(YooAssetReference asset, Transform parent)
	{
		GameObject gameObject = AssetStationManager.BattleStation.Instantiate(asset, parent).AsGameObject();
		gameObject.GetComponent<BPCommon>().m_BpAsset = gameObject;
		return gameObject;
	}

	private void BattleTpEvent(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("BattleTp").ToString());
	}

	private void ChallengeOvertimeEvent(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("ChallengeOvertime").ToString());
	}

	private void WorldChangeEvent(BaseEventContent obj)
	{
		SceneChangeEvt sceneChangeEvt = (SceneChangeEvt)obj;
		if (sceneChangeEvt.newScene != SceneStatus.Main)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("LeaveMainWorld").ToString());
		}
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(sceneChangeEvt.enterWorldId.ToString()).Append("_world_enter")
			.ToString());
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(sceneChangeEvt.leaveWorldId.ToString()).Append("_world_exit")
			.ToString());
	}

	private void ChallengeIdChange(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("InteractOtherChallenge").ToString());
	}

	public void RespawnCharacters()
	{
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				if (!teamCharacter.IsAlive())
				{
					Fundamental.Singleton<RespawnManager>.instance.LocalEntityReborn(teamCharacter);
					continue;
				}
				CompAbility? compAbility = teamCharacter.GetCompAbility();
				compAbility.ServerSetHP(compAbility.maxHP);
				compAbility.ModifyNormalEnergy(0f);
				compAbility.ModifySpecialEnergy(0f);
				compAbility.CurrentUltimateSkillValue = 0f;
			}
		}
	}

	public void CoUnloadMonster()
	{
		for (int i = 0; i < m_SpawnMonsters.Count; i++)
		{
			Entity eb = m_SpawnMonsters[i];
			MonoECS.instance.TryRemoveBehave(eb);
		}
		m_SpawnMonsters.Clear();
		m_DestroyByBPMonsters.Clear();
	}

	private void MonsterDie(Entity dieEB)
	{
		m_SpawnMonsters.Remove(dieEB);
		CustomEvent.Trigger(gameObject, "MonsterDie", m_SpawnMonsters.Count);
	}

	private void MonsterHpChange(int before, int after)
	{
		CustomEvent.Trigger(gameObject, "MonsterHpChange", null);
	}

	public void TestArray(List<int> a)
	{
	}

	public Entity GetPlayerCharacter(int playerId, int characterId)
	{
		if (MonoECS.instance.localPlayer.TryGetTeamCharacter(characterId, out var entity))
		{
			return entity;
		}
		return default;
	}

	public bool GetRoleIsExistInBag(int roleId)
	{
		Entity entity;
		return MPPlayer.local.TryGetTeamCharacter(roleId, out entity);
	}

	public bool IsEntityReferenceValid(Entity er)
	{
		return er.IsValid;
	}

	public void CreateTriggerField(string name, Vector3 center, Vector3 size)
	{
		GameObject gameObject = new GameObject();
		gameObject.transform.position = center;
		gameObject.layer = 0;
		BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
		boxCollider.size = size;
		boxCollider.isTrigger = true;
		BPTriggerField bPTriggerField = gameObject.AddComponent<BPTriggerField>();
		bPTriggerField.triggerName = name;
		bPTriggerField.onEnter = OnBPTriggerEnter;
		bPTriggerField.onExit = OnBPTriggerExit;
		m_TriggerFields.Add(bPTriggerField);
	}

	public void CreateTriggerField(string name, BoxCollider collider)
	{
		GameObject gameObject = new GameObject();
		gameObject.transform.position = collider.transform.position;
		gameObject.transform.rotation = collider.transform.rotation;
		gameObject.transform.localScale = collider.transform.lossyScale;
		gameObject.layer = 0;
		BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
		boxCollider.center = collider.center;
		boxCollider.size = collider.size;
		boxCollider.isTrigger = true;
		BPTriggerField bPTriggerField = gameObject.AddComponent<BPTriggerField>();
		bPTriggerField.triggerName = name;
		bPTriggerField.onEnter = OnBPTriggerEnter;
		bPTriggerField.onExit = OnBPTriggerExit;
		m_TriggerFields.Add(bPTriggerField);
	}

	private void OnBPTriggerEnter(string name)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(name).Append("_enter")
			.ToString(), null);
	}

	private void OnBPTriggerExit(string name)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(name).Append("_exit")
			.ToString(), null);
	}

	public void CreateSingleUseTriggerField(string name, Vector3 center, Vector3 size)
	{
		GameObject gameObject = new GameObject();
		gameObject.transform.position = center;
		gameObject.layer = 0;
		BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
		boxCollider.size = size;
		boxCollider.isTrigger = true;
		BPTriggerField bPTriggerField = gameObject.AddComponent<BPTriggerField>();
		bPTriggerField.triggerName = name;
		bPTriggerField.onEnter = OnBPSingleTriggerEnter;
		bPTriggerField.onExit = OnBPTriggerExit;
		m_TriggerFields.Add(bPTriggerField);
	}

	private void OnBPSingleTriggerEnter(string name)
	{
		m_TriggerFields.Find((BPTriggerField f) => f.triggerName.Equals(name));
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(name).Append("_enter")
			.ToString(), null);
	}

	public void DestroyPrefab(GameObject o)
	{
		UnityEngine.Object.Destroy(o);
	}

	public AssetLoadHandle LoadPrefabAsync(YooAssetReference assetReference, Vector3 pos)
	{
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(assetReference, pos, Quaternion.identity, (AssetLoadHandle result) =>
		{
		});
		m_Handles.Add(assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle LoadPrefabAsync(YooAssetReference assetReference, Vector3 pos, Quaternion rotation)
	{
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(assetReference, pos, rotation, (AssetLoadHandle result) =>
		{
		});
		m_Handles.Add(assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle LoadPrefabAsync(YooAssetReference assetReference)
	{
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(assetReference, Vector3.back, Quaternion.identity, (AssetLoadHandle result) =>
		{
		});
		m_Handles.Add(assetLoadHandle);
		return assetLoadHandle;
	}

	public void UnloadPrefabAsync(AssetLoadHandle tar)
	{
		if (AssetLoadHandleExtensions.IsValid(tar))
		{
			AssetStationManager.BattleStation.ReleaseInstance(tar);
		}
	}

	public void ShowBossBloodBar(Entity boss)
	{
		if (!boss.IsValid && LuminApplication.LogEnabled)
		{
			Debug.LogError($"当前boss{boss}不可用");
		}
	}

	public Entity GetEntity(int id)
	{
		return m_SpawnMonsters.Find((Entity e) => e.GetCompMonster().id == id);
	}

	public bool CheckBluePrintBossHpPercent(float targetPercent, int bossId, Compare type)
	{
		Entity entity = GetEntity(bossId);
		if (!entity.IsValid)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		float hpPercent = entity.GetCompAbility().HpPercent;
		return type switch
		{
			Compare.Equal => Mathf.Approximately(hpPercent, targetPercent), 
			Compare.NotEqual => !Mathf.Approximately(hpPercent, targetPercent), 
			Compare.Greater => hpPercent > targetPercent, 
			Compare.Less => hpPercent < targetPercent, 
			Compare.GreaterAndEqual => hpPercent >= targetPercent, 
			Compare.LessAndEqual => hpPercent <= targetPercent, 
			_ => throw new NotImplementedException(), 
		};
	}

	public Entity GetSpawnMonsters(int index)
	{
		if (index >= m_SpawnMonsters.Count)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("索引超限或任务已结束");
			}
			return m_SpawnMonsters[0];
		}
		return m_SpawnMonsters[index];
	}

	private void OnTeamLoadCompleted(BaseEventContent obj)
	{
		m_TeamLoadCompleted = true;
	}

	public void ChangeTeam(int index)
	{
		int[] array = new int[3];
		_ = G.localPlayer.teamInfo.MainTeamIdx;
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[index].Clone();
		RepeatedField<int> characterIds = presetTeam.CharacterIds;
		_ = presetTeam.Name;
		for (int i = 0; i < characterIds.Count; i++)
		{
			array[i] = characterIds[i];
		}
		Model<TeamModel>.Interface.BattleTeamIndexChange(index);
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
	}

	public void AddChatacterToBattleTeam(int id, int index)
	{
		int[] array = new int[3];
		int[] array2 = new int[3];
		int mainTeamIdx = G.localPlayer.teamInfo.MainTeamIdx;
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[mainTeamIdx].Clone();
		RepeatedField<int> characterIds = presetTeam.CharacterIds;
		_ = presetTeam.Name;
		for (int i = 0; i < characterIds.Count; i++)
		{
			array2[i] = characterIds[i];
			array[i] = array2[i];
		}
		if (array[index] == 0)
		{
			array[index] = id;
		}
		else
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"当前出战队伍第{index}位置已经有人无法添加");
			}
			for (int j = 0; j < array.Length; j++)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(array[j]);
				}
			}
		}
		Model<TeamModel>.Interface.ServerTeamInfoChange(presetTeam, mainTeamIdx, ProfileChangeType.Characters, TeamProfileSource.World, null);
	}

	public async void AddCeceToBattleTeamForTutorial(int ceceId)
	{
		int num = 1;
		int[] array = new int[3];
		int mainTeamIdx = G.localPlayer.teamInfo.MainTeamIdx;
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[mainTeamIdx].Clone();
		RepeatedField<int> characterIds = presetTeam.CharacterIds;
		_ = presetTeam.Name;
		for (int i = 0; i < characterIds.Count; i++)
		{
			array[i] = characterIds[i];
		}
		if (array[0] == 10101 && array[1] == 0 && array[2] == 0)
		{
			array[0] = 10101;
			presetTeam.CharacterIds[0] = 10101;
			array[num] = 10201;
			presetTeam.CharacterIds[num] = 10201;
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("cece入队前，队伍状态不对，不是只有一个且第一个为bebe");
		}
		_ = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		Model<TeamModel>.Interface.ServerTeamInfoChange(presetTeam, mainTeamIdx, ProfileChangeType.Characters, TeamProfileSource.World, null);
		await UniTask.WaitUntil(() => m_TeamLoadCompleted);
		m_TeamLoadCompleted = false;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
	}

	public async UniTask WaitMotionTagComplete(MotionTag_backUp tag)
	{
		await UniTask.WaitUntil(() => !MonoECS.instance.mainEntity.InTag(tag));
	}

	public async void ResetBattleTeamForTutorial()
	{
		int[] array = new int[3];
		int mainTeamIdx = G.localPlayer.teamInfo.MainTeamIdx;
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[mainTeamIdx].Clone();
		_ = presetTeam.CharacterIds;
		_ = presetTeam.Name;
		array[0] = 10101;
		array[1] = 0;
		array[2] = 0;
		presetTeam.CharacterIds[0] = 10101;
		presetTeam.CharacterIds[1] = 0;
		presetTeam.CharacterIds[2] = 0;
		Model<TeamModel>.Interface.ServerTeamInfoChange(presetTeam, mainTeamIdx, ProfileChangeType.Characters, TeamProfileSource.World, null);
		await UniTask.WaitUntil(() => m_TeamLoadCompleted);
		m_TeamLoadCompleted = false;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
	}

	public void PushInput()
	{
		MonoECS.instance.PushPauseInput();
	}

	public void PopInput()
	{
		MonoECS.instance.PopPauseInput();
	}

	public void ChangeCharacterModel(int[] newCharactersId, int lastTeamIndex, int nowTeamIndex)
	{
		RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[lastTeamIndex].CharacterIds;
		int[] array = new int[3];
		for (int i = 0; i < characterIds.Count; i++)
		{
			array[i] = characterIds[i];
		}
		ChangeTeam(array, newCharactersId, isBattle: true).Forget();
	}

	[Obsolete]
	private bool IsInArray(int[] array, int value)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] == value)
			{
				return true;
			}
		}
		return false;
	}

	[Obsolete]
	private async UniTaskVoid ChangeTeam(int[] before, int[] after, bool isBattle)
	{
		if (!isBattle)
		{
			return;
		}
		for (int i = 0; i < 3; i++)
		{
			if (before[i] != 0 && !IsInArray(after, before[i]))
			{
				CoRemoveTeamCharacter(before[i], i);
			}
		}
		for (int j = 0; j < 3; j++)
		{
			if (after[j] != 0 && !IsInArray(before, after[j]))
			{
				await CoSpawnTeamCharacter(after[j], j);
			}
		}
		ChangeTeamEntities(after);
	}

	[Obsolete]
	private void ChangeTeamEntities(int[] characters)
	{
		EntityId[] array = new EntityId[3];
		for (int i = 0; i < characters.Length; i++)
		{
			if (characters[i] != 0)
			{
				Character character = G.localPlayer.GetCharacter(characters[i]);
				array[i] = (EntityHelper.TryGetBattleEntityByCharacter(character, out var entity) ? entity.Id : EntityId.Invalid);
			}
			else
			{
				array[i] = EntityId.Invalid;
			}
		}
		MonoECS.instance.localPlayer.SetTeamCharacters(array);
	}

	[Obsolete]
	private void CoRemoveTeamCharacter(int beforeId, int index)
	{
		Character character = G.localPlayer.GetCharacter(beforeId);
		if (character != null && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			if (index == 0 && !MonoECS.instance.IsNotInMain)
			{
				MonoECS.instance.SyncGameInfos();
			}
			GameManager.cameraSystem.DestroyCharacterVCam(entity.Id);
			MonoECS.instance.ReleaseCharacterBattleEntity(entity);
		}
	}

	[Obsolete]
	private async UniTask CoSpawnTeamCharacter(int id, int index, Vector3 pos = default(Vector3))
	{
		if (id != 0)
		{
			switch (index)
			{
			case 0:
				await MonoECS.instance.SpawnOwnerCharacter(MPEntityType.Character, id, 0, null, left: false, pos).ToCoroutine();
				break;
			case 1:
				await MonoECS.instance.SpawnOwnerCharacter(MPEntityType.Character, id, 1, null, left: false, pos).ToCoroutine();
				break;
			case 2:
				await MonoECS.instance.SpawnOwnerCharacter(MPEntityType.Character, id, 2, null, left: false, pos).ToCoroutine();
				break;
			}
		}
	}

	public void PauseInput(bool pause)
	{
		if (pause)
		{
			MonoECS.instance.PushPauseAllInput();
		}
		else
		{
			MonoECS.instance.PopPauseAllInput();
		}
	}

	public void SetSwitchCharacterBtnEffect(SwitchCharacter key, bool value)
	{
		SwitchCharacterBtnEffectEvent evt = Fundamental.Singleton<EventManager>.instance.GetEvt<SwitchCharacterBtnEffectEvent>();
		evt.characterBtnIndex = key;
		evt.isActive = value;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_SwitchCharacterBtnEffect, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SetInteractBtnEffect(bool value)
	{
		InteractGuideEffectActive evt = Fundamental.Singleton<EventManager>.instance.GetEvt<InteractGuideEffectActive>();
		evt.active = value;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_InteractGuideEffectActive, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void OpenGuideTip(int localizeId)
	{
		Fundamental.Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_GUIDE, new GuideTipData
		{
			localizeId = localizeId
		});
	}

	public void OpenMissionTip(int localizeId, float duration)
	{
		Fundamental.Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_MISSION, new MissionTipData
		{
			localizeId = localizeId,
			duration = duration
		});
	}

	public void CloseGuideTip()
	{
		if (GuideTip.guideTipInstance != null)
		{
			Fundamental.Singleton<TipManager>.instance.OnTipClose(GuideTip.guideTipInstance);
		}
	}

	public void SetInputActive(InputKey key, bool value)
	{
		MonoECS.instance.InputActive(key, value);
	}

	public void SetBtnEffect(InputKey key, bool value)
	{
		CustomUICompType customUICompType = CustomUICompType.None;
		switch (key)
		{
		case InputKey.joyStick:
		{
			JoyStickEffectBtnEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<JoyStickEffectBtnEvt>();
			evt.active = value;
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_JoyStickBtn_UpdateBtnEffectActive, evt);
			Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
			return;
		}
		case InputKey.regularAttack:
			customUICompType = CustomUICompType.AttackBtn;
			break;
		case InputKey.heavyAttack:
			customUICompType = CustomUICompType.SpAttackBtn;
			break;
		case InputKey.vibrate:
			customUICompType = CustomUICompType.UltraBtn;
			break;
		case InputKey.jump:
			customUICompType = CustomUICompType.JumpBtn;
			break;
		case InputKey.dodge:
			customUICompType = CustomUICompType.DodgeBtn;
			break;
		case InputKey.interactClaw:
			customUICompType = CustomUICompType.HookBtn;
			break;
		}
		MonoECS.instance.DispatchUpdateOperateEffectBtnEvt(customUICompType, value);
	}

	public Vector3 GetCurrentPosition()
	{
		if (MonoECS.instance.localPlayer.battleEntity.IsValid)
		{
			return MonoECS.instance.localPlayer.battleEntity.GetCompTransform().physicsPosition;
		}
		throw new Exception("当前无法获取位置");
	}

	public void GetRaidReward(int id)
	{
		ACT.Game.Data.Raid curChallengeRaidInfo = Model<RaidModel>.Interface.CurChallengeRaidInfo;
		if (curChallengeRaidInfo != null && curChallengeRaidInfo.EnterByGM)
		{
			return;
		}
		if (curChallengeRaidInfo != null && curChallengeRaidInfo.CleanNum != 0)
		{
			Fundamental.Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONWORLDSUCCESS, new CommonWorldSuccessView.CommonWorldSuccessData());
			return;
		}
		G.service.GetRaidRewardInfo(1, async (bool r, RepeatedField<UniversalItem> ack) =>
		{
			if (r)
			{
				await Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(ack));
			}
		});
	}

	public void RaidComplete()
	{
		Model<RaidModel>.Interface.RaidSettlement();
	}

	public void AbyssComplete()
	{
		Model<AbyssModel>.Interface.CacheSettlementTime();
		G.service.AbyssCompleteSubStage(Model<AbyssModel>.Interface.CurLayerTime, (bool r, bool completeAll, bool unlock, AbyssStage abyssStage, RepeatedField<UniversalItem> rewards) =>
		{
			if (r)
			{
				if (!completeAll)
				{
					Fundamental.Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Abyss);
				}
				else
				{
					Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.WorldSuccess, null);
					Fundamental.Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(rewards));
					Model<ActivityCenterModel>.Interface.RefreshActivityAbyssRedDotState();
				}
			}
		});
	}

	public void TeamChallengeComplete()
	{
		Model<TeamTeachingModel>.Interface.MarkCurrentChallengeCompleted();
		Model<RaidModel>.Interface.RaidSettlement();
	}

	public void PlayBGM(AudioEventReference eventName)
	{
	}

	public void SetCamera()
	{
		GameObject cams = UnityEngine.Object.Instantiate(GameLoader.meta.dialogResources.cinemachinePresets[0]);
		Entity mainEntity = MonoECS.instance.mainEntity;
		GameManager.cameraSystem.StartCinemachineMovement(cams, GameLoader.meta.dialogResources.dialogVmBlends, mainEntity.GetRootTransform());
	}

	public void SetActiveAreaCameras(List<AreaCameraParams> areaCameraParams)
	{
		foreach (AreaCameraParams areaCameraParam in areaCameraParams)
		{
			areaCameraParam.areaCamera.gameObject.SetActive(areaCameraParam.active);
		}
	}

	public void SetActiveAreaCamera(AreaCamera areaCamera, bool active)
	{
		areaCamera.gameObject.SetActive(active);
	}

	public void SetVCamPriority(AreaCamera areaCamera, int priority)
	{
		areaCamera.conditionalCamera.vCamera.Priority = priority;
		areaCamera.conditionalCamera.cameraPriority = priority;
	}

	public async UniTask RuntimeDramaEntry(List<int> dramaId)
	{
		int num = dramaId[0];
		switch (RuntimeConfigs.data.dramaDatas[num].type)
		{
		case 1:
		case 3:
			await RunTimeDramaTimeline(num);
			break;
		case 2:
			Fundamental.Singleton<ConversationManager>.instance.ConversationStart(dramaId[0]);
			await UniTask.WaitUntil(() => Fundamental.Singleton<ConversationManager>.instance.isOver);
			break;
		}
	}

	public UniTask RuntimeDramaAside(List<int> dramaId)
	{
		AsideManager.instance.BeginAsideBatch(dramaId);
		return UniTask.CompletedTask;
	}

	public UniTask runtimeDramaConversation(List<int> dramaId)
	{
		Fundamental.Singleton<ConversationManager>.instance.ConversationStart(dramaId[0]);
		return UniTask.CompletedTask;
	}

	public async UniTask RunTimeDramaTimeline(int dramaId)
	{
		if (!(await Fundamental.Singleton<TimelineConversationManager>.instance.PlayTimeline(dramaId)))
		{
			throw new ArgumentException($"timeline播放失败，{dramaId}");
		}
	}

	public async UniTask RunTimeDramaTimeline(int dramaId, Vector3 position)
	{
		if (!(await Fundamental.Singleton<TimelineConversationManager>.instance.PlayTimeline(dramaId, position)))
		{
			throw new ArgumentException($"timeline播放失败，{dramaId}");
		}
	}

	public async UniTask RuntimeDramaTimeline(int dramaId, Vector3 position, bool blackScreenLoading)
	{
		if (!(await Fundamental.Singleton<TimelineConversationManager>.instance.PlayTimeline(dramaId, position, new PlayTimelineConfig
		{
			BlackScreenLoading = blackScreenLoading,
			Controlable = false
		})))
		{
			throw new ArgumentException($"timeline播放失败，{dramaId}");
		}
	}

	public async UniTask RuntimeDialogue(int dialogueStoryGroupId)
	{
		await Fundamental.Singleton<ConversationManager>.instance.BeginConversation(dialogueStoryGroupId);
	}

	public async UniTask PlayTimeline(BpTimelineData timelineData)
	{
		PlayableDirector director = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(timelineData.assetReference);
		director.Play();
		await UniTask.WaitUntil(() => director.state == UnityEngine.Playables.PlayState.Paused);
		Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(timelineData.assetReference);
	}

	public bool CheckKeyPoint(int optionId)
	{
		return Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(optionId);
	}

	public bool CheckTimelineOverPlayed(int timelineId)
	{
		return Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(timelineId);
	}

	public bool CheckAsideOverPlayed(int asideId)
	{
		return Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(asideId);
	}

	public async UniTask AWaitKeyPoint(int optionId)
	{
		if (!Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(optionId))
		{
			await UniTask.WaitUntil(() => Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(optionId));
		}
	}

	public async UniTask AWaitTimelineOverPlayed(int timelineId)
	{
		if (!Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(timelineId))
		{
			await UniTask.WaitUntil(() => Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(timelineId));
		}
	}

	public async UniTask AWaitAsideOverPlayed(int asideId)
	{
		if (!Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(asideId))
		{
			await UniTask.WaitUntil(() => Fundamental.Singleton<ConversationManager>.instance.HaveKeyPoint(asideId));
		}
	}

	public void InitChallengeInfo(string eventName)
	{
		StageChallengeManager.InitEntity = (Action<ChallengeActOn>)Delegate.Combine(StageChallengeManager.InitEntity, (Action<ChallengeActOn>)((ChallengeActOn actOn) =>
		{
			CustomEvent.Trigger(gameObject, eventName, actOn);
		}));
	}

	public void InitBattleInfo(string eventName, Action<ChallengeActOn> action)
	{
		StageChallengeManager.StartBattle = (Action<ChallengeActOn>)Delegate.Combine(StageChallengeManager.StartBattle, (Action<ChallengeActOn>)((ChallengeActOn actOn) =>
		{
			CustomEvent.Trigger(gameObject, eventName, actOn);
		}));
	}

	public void SetHp(Entity entity, int hp)
	{
		if (entity.IsValid)
		{
			CompAbility compAbility = entity.GetCompAbility();
			int value = ((hp <= compAbility.maxHP) ? hp : compAbility.maxHP);
			compAbility.ServerSetHP(value);
		}
	}

	public void AddBuff(Entity entity, string[] names)
	{
		if (!entity.IsValid)
		{
			return;
		}
		entity.GetCompAbility().AddAbilities(names, AbilitySource.BluePrint);
		if (entity == MonoECS.instance.mainEntity)
		{
			foreach (string item in names)
			{
				StageChallengeManager.localChallengeBuff.Add(item);
			}
		}
	}

	public void RemoveBuff(EntityReference entityRef, string[] names)
	{
		if (!entityRef.IsValid)
		{
			return;
		}
		CompAbility compAbility = Entity_Extensions.GetCompAbility(entityRef);
		string[] array = names;
		foreach (string text in array)
		{
			compAbility.RemoveAbility(text);
		}
		if (!(entityRef == MonoECS.instance.mainEntity))
		{
			return;
		}
		array = names;
		foreach (string item in array)
		{
			List<string> localChallengeBuff = StageChallengeManager.localChallengeBuff;
			if (localChallengeBuff.Contains(item))
			{
				localChallengeBuff.Remove(item);
			}
		}
	}

	public bool MainEntityHasAbility(string name)
	{
		return MonoECS.instance.mainEntity.GetCompAbility().HasAbility(name);
	}

	public bool AnyOneTeamEntityHasAbility(string name)
	{
		int mainTeamIdx = G.localPlayer.teamInfo.MainTeamIdx;
		RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[mainTeamIdx].CharacterIds;
		for (int i = 0; i < characterIds.Count; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.GetCompAbility().HasAbility(name))
			{
				return true;
			}
		}
		return false;
	}

	public void AddAllStatus(ChallengeActOn actOn)
	{
		StageChallengeManager.InitEntity?.Invoke(actOn);
		Fundamental.Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_STAGESECRET);
	}

	public void FinishChallenge(bool IsBossDie)
	{
		StageChallengeManager.Instance.RemoveChallengeBuff();
		StageChallengeManager.Instance.RestInitAndBattleAction();
	}

	public async UniTask AwaitUIState(UI_TYPE uiType, UIViewState state)
	{
		UIState uiState = state switch
		{
			UIViewState.Load => UIState.Loading, 
			UIViewState.Hidden => UIState.Closed, 
			UIViewState.Opening => UIState.Opening, 
			UIViewState.Normal => UIState.Opened, 
			UIViewState.Closing => UIState.Closing, 
			_ => throw new ArgumentOutOfRangeException("state", state, null), 
		};
		await UniTask.WaitUntil(() =>
		{
			IBaseUIView baseUIView = Fundamental.Singleton<NewUIManager>.instance.FindUIViewByUIType(uiType);
			return baseUIView != null && baseUIView.UIController.State == uiState;
		});
	}

	public async UniTask AwaitUIHidden(UI_TYPE uiType)
	{
		await UniTask.WaitUntil(() =>
		{
			if (Fundamental.Singleton<NewUIManager>.instance.QueueContains(uiType))
			{
				return false;
			}
			UIState firstUIState = Fundamental.Singleton<NewUIManager>.instance.GetFirstUIState(uiType);
			return (firstUIState == UIState.None || firstUIState == UIState.Closed) ? true : false;
		});
	}

	public void SetUINeedPop(bool val)
	{
		Fundamental.Singleton<NewUIManager>.instance.NeedPop = val;
	}

	public async UniTask OpenUIView(UI_TYPE uiType)
	{
		await Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(uiType);
	}

	public async UniTask OpenCharacterGetView(int characterId)
	{
		await Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CHARACTERGET, new MonoCharacterGetViewData
		{
			characterId = characterId
		});
	}

	public UniTask OpenMapView(List<int> roomId)
	{
		Fundamental.Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP);
		return UniTask.CompletedTask;
	}

	[Obsolete]
	public void SetUICanvas(UI_TYPE type, bool value)
	{
	}

	public void SetCommonUIState(UIMode mode, bool state)
	{
		if (Model<BattleMainModel>.Interface != null)
		{
			Model<BattleMainModel>.Interface.RefreshUIModuleState(mode);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public async UniTask SetBlackScreenActive(bool active)
	{
		await (active ? Fundamental.Singleton<NewUIManager>.instance.BlackScreen.Enable() : Fundamental.Singleton<NewUIManager>.instance.BlackScreen.Disable());
	}

	public void UnlockAllLightHouse()
	{
		List<int> allUnlockLightHouseId = MapUtility.GetAllUnlockLightHouseId();
		ACT.World.Asset.StateChangeInfo[] array = new ACT.World.Asset.StateChangeInfo[allUnlockLightHouseId.Count];
		for (int i = 0; i < allUnlockLightHouseId.Count; i++)
		{
			array[i] = new ACT.World.Asset.StateChangeInfo
			{
				uid = allUnlockLightHouseId[i],
				stateId = -2
			};
		}
		MonoECS.instance.ruleManager.SharedChangeStates(array);
		WorldManager worldManager = Fundamental.Singleton<GameManager>.instance.worldManager;
		foreach (int item in allUnlockLightHouseId)
		{
			foreach (LightHouseInteracts interactIcon in ((LightHouseData)worldManager.GetWorldStateAssetDataBySGOID(item)).interactIcons)
			{
				Model<MapModel>.Interface.AddUnlockInteractObjId(MonoECS.instance.ruleManager.GetStateWorldAssetMapLayer(interactIcon.uid), interactIcon.uid);
			}
		}
	}

	public void UnlockAllTransfer()
	{
		List<int> allUnlockTransferId = MapUtility.GetAllUnlockTransferId();
		ACT.World.Asset.StateChangeInfo[] array = new ACT.World.Asset.StateChangeInfo[allUnlockTransferId.Count];
		for (int i = 0; i < allUnlockTransferId.Count; i++)
		{
			array[i] = new ACT.World.Asset.StateChangeInfo
			{
				uid = allUnlockTransferId[i],
				stateId = -2
			};
		}
		MonoECS.instance.ruleManager.SharedChangeStates(array);
	}

	public GameObject CreateAirWall(Vector3 position, Bounds bounds, int layer)
	{
		GameObject gameObject = new GameObject($"{base.gameObject}_AirWall");
		gameObject.layer = layer;
		gameObject.transform.position = position;
		BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
		boxCollider.center = bounds.center;
		boxCollider.size = bounds.size;
		m_Objects.Add(gameObject);
		return gameObject;
	}

	public void DestroyAirWall(GameObject airWall)
	{
		m_Objects.Remove(airWall);
		UnityEngine.Object.Destroy(airWall);
	}

	public void StartGuide(int guideId)
	{
		if (Model<GuideModel>.HasInstance())
		{
			Model<GuideModel>.Interface.StartGuide(guideId);
		}
	}

	public void TriggerTutorial(int tutorialId, int triggerType, bool needPopUpTips = true)
	{
		if (triggerType != 1 && triggerType != 2)
		{
			triggerType = 1;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("教程触发方式类型没填,或者填了非法的类型！！！！，先改成倒计时触发，检查蓝图！！！");
			}
		}
		if (!Model<TutorialModel>.HasInstance() || !Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialId) || CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			return;
		}
		G.service.TriggerTutorial(tutorialId, (bool b) =>
		{
			if (needPopUpTips && b)
			{
				switch (triggerType)
				{
				case 1:
				{
					TriggerGuideTutorial evt = Fundamental.Singleton<EventManager>.instance.GetEvt<TriggerGuideTutorial>();
					evt.triggerTutorialId = tutorialId;
					evt.duration = 5f;
					Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.Trigger_Tutorial, evt);
					Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
					break;
				}
				case 2:
					Fundamental.Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
					{
						tutorialId = tutorialId
					});
					break;
				}
			}
		});
	}

	public void PlaySpecialBGM(string bgmName)
	{
		Fundamental.Singleton<BGMManager>.instance.SetBGM(BGMType.Special, bgmName);
		Fundamental.Singleton<GameManager>.instance.audioManager.SetGlobalParameter("Special_Music_Change", 0);
	}

	public void SetSpecialBGMState(int state)
	{
		Fundamental.Singleton<GameManager>.instance.audioManager.SetGlobalParameter("Special_Music_Change", state);
	}

	public void AttackChargingSwitch(bool Switch)
	{
		attackCharging = Switch;
	}

	public void AttackSpecialChargingSwitch(bool charging)
	{
		m_AttackSpeicalCharging = charging;
	}

	public void ResetSpecialSKillCd()
	{
		CompMotion? compMotion = MonoECS.instance.mainEntity.GetCompMotion();
		ACT.Battle.Skill skill = compMotion.skills.Find((ACT.Battle.Skill e) => e.config.name == "specialAttackCD");
		if (skill != null)
		{
			skill.SetSkillCount(skill.MaxCount);
			skill.SetSkillCd(0f, exceeds: false);
		}
		ACT.Battle.Skill skill2 = compMotion.skills.Find((ACT.Battle.Skill e) => e.config.name == "specialSkillCD");
		if (skill2 != null)
		{
			skill2.SetSkillCount(skill2.MaxCount);
			skill2.SetSkillCd(0f, exceeds: false);
		}
		ACT.Battle.Skill skill3 = compMotion.skills.Find((ACT.Battle.Skill e) => e.config.name == "skillCD_B");
		if (skill3 != null)
		{
			skill3.SetSkillCount(skill3.MaxCount);
			skill3.SetSkillCd(0f, exceeds: false);
		}
	}

	public void SkillChargingSwitch(float cd, bool Switch)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.GetCompMotion().skillLookup.TryGetValue("ground_U_start", out var value))
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		ConfigCharacter config = mainEntity.GetConfig();
		skillCharging = Switch;
		if (skillCharging)
		{
			value.SetSkillCd(cd, exceeds: false);
			for (int i = 0; i < config.skills.Length; i++)
			{
				if (!(config.skills[i].name != "skillCD"))
				{
					cdTemp = config.skills[i].CD;
					config.skills[i].CD = cd;
				}
			}
			return;
		}
		value.SetSkillCd(cdTemp, exceeds: false);
		for (int j = 0; j < config.skills.Length; j++)
		{
			if (!(config.skills[j].name != "skillCD"))
			{
				config.skills[j].CD = cdTemp;
			}
		}
	}

	public void ForceChangeMainEntityMotion(string motionName)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid)
		{
			return;
		}
		CompMotion compMotion = mainEntity.GetCompMotion();
		if (compMotion == null || compMotion.layer0Peak.state.value.name == motionName)
		{
			return;
		}
		foreach (StateLayer childrenStateLayer in compMotion.moveController.childrenStateLayers)
		{
			foreach (State state in childrenStateLayer.states)
			{
				if (!(state.value.name != motionName))
				{
					GameManager.behaveSystem.ForcedChangeToMotionState(mainEntity, state);
					return;
				}
			}
		}
		foreach (StateLayer childrenStateLayer2 in compMotion.attackController.childrenStateLayers)
		{
			foreach (State state2 in childrenStateLayer2.states)
			{
				if (!(state2.value.name != motionName))
				{
					GameManager.behaveSystem.ForcedChangeToMotionState(mainEntity, state2);
					return;
				}
			}
		}
	}

	public void TriggerMainEntityAbility(string abilityName)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			GameManager.abilitySystem.TriggerAbility(mainEntity, mainEntity, abilityName);
		}
	}

	public void DoAction(ConfigAction[] actions)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			SystemAbility.DoActionsToSelf(mainEntity, actions);
		}
	}

	public void ResetSkillCD(string name)
	{
		ACT.Battle.Skill skill = MonoECS.instance.mainEntity.GetCompMotion()?.skills.Find((ACT.Battle.Skill e) => e.config.name == name) ?? null;
		if (skill != null)
		{
			skill.SetSkillCd(skill.ConfigCd, exceeds: false);
			skill.SetSkillCount(skill.MaxCount);
		}
	}

	public bool CheckMainEntityCanDodgeGuide()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			CompMotion compMotion = mainEntity.GetCompMotion();
			if (compMotion != null && !compMotion.InTag(MotionTag_backUp.ForbidDodgeAndGrab))
			{
				CompEffect compEffect = mainEntity.GetCompEffect();
				if (compEffect.myTimeLines.Count > 0)
				{
					return false;
				}
				if (compEffect.bInUltraTimeline)
				{
					return false;
				}
				if (compMotion.parameters.TryGetValue("ButtonU", out var value) && value.defaultBool)
				{
					return false;
				}
				if (compMotion.parameters.TryGetValue("Skill", out var value2) && value2.defaultBool)
				{
					return false;
				}
				if (compMotion.parameters.TryGetValue("changeCharacter0", out var value3) && value3.defaultBool)
				{
					Debug.LogError("changeCharacter0");
					return false;
				}
				if (compMotion.parameters.TryGetValue("changeCharacter1", out var value4) && value4.defaultBool)
				{
					Debug.LogError("changeCharacter1");
					return false;
				}
				if (compMotion.parameters.TryGetValue("changeCharacter2", out var value5) && value5.defaultBool)
				{
					Debug.LogError("changeCharacter2");
					return false;
				}
				return true;
			}
		}
		return false;
	}

	public bool CheckMainEntityCanDodgeAttackGuide()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid)
		{
			return false;
		}
		CompEffect compEffect = mainEntity.GetCompEffect();
		if (compEffect.myTimeLines.Count > 0 || compEffect.bInUltraTimeline)
		{
			return false;
		}
		return true;
	}

	public void TeamAttackCharging(float val = float.MaxValue)
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				teamCharacter.GetCompAbility().ModifyNormalEnergy(val);
			}
		}
	}

	public void TeamAttackSpecialCharging(float val = float.MaxValue)
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				teamCharacter.GetCompAbility().ModifySpecialEnergy(val);
			}
		}
	}

	public IEnumerator IsMainEntity(int id)
	{
		CompCharacter compCharacter = MonoECS.instance.mainEntity.GetCompCharacter();
		while (compCharacter == null || compCharacter.characterSource.Id() != id)
		{
			yield return null;
		}
	}

	public void SwitchMainEntity(int id)
	{
		MPPlayer local = MPPlayer.local;
		Entity entity = local.IdOfTeamCharacter(id);
		if (!entity.IsValid)
		{
			_ = LuminApplication.LogEnabled;
		}
		else
		{
			MonoECS.instance.ChangeCharacter(local.IndexOfTeamCharacter(entity));
		}
	}

	public bool GetInteractObjectState(int stateId, int uid)
	{
		return MonoECS.instance.ruleManager.SharedGetState(uid) == stateId;
	}

	public async UniTask ChangeSceneTP(Vector3 pos, int worldId, int chunkId)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = pos,
			faceLeft = false,
			forceToFloor = false,
			revive = false
		};
		await TeleportUtility.SceneChangeTpWithLoader(chunkId, worldId, teleportParams);
	}

	public async UniTask AwaitInteractObjectState(InteractObjectState[] interactObjects)
	{
		RuleManager systemWorld = MonoECS.instance.ruleManager;
		await UniTask.WaitUntil(() =>
		{
			InteractObjectState[] array = interactObjects;
			foreach (InteractObjectState interactObjectState in array)
			{
				if (systemWorld.SharedGetState(interactObjectState.uid) != interactObjectState.stateId)
				{
					return false;
				}
			}
			return true;
		}, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
	}

	public async UniTask AwaitInteractObjectState(int swid, int stateId)
	{
		RuleManager systemWorld = MonoECS.instance.ruleManager;
		await UniTask.WaitUntil(() => systemWorld.SharedGetState(swid) == stateId, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
	}

	public async UniTask AwaitInteractObjectIsNotState(int swid, int stateId)
	{
		RuleManager systemWorld = MonoECS.instance.ruleManager;
		await UniTask.WaitUntil(() => systemWorld.SharedGetState(swid) != stateId, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
	}

	public UniTask AddStateChangeEventListener(List<InteractObjectState> states)
	{
		foreach (InteractObjectState state in states)
		{
			if (!m_ServiceSaveEvents.Contains(state))
			{
				m_ServiceSaveEvents.Add(state);
			}
		}
		return UniTask.CompletedTask;
	}

	private void OnServiceStateEvent(BaseEventContent e)
	{
		if (!(e is ServiceStateRefresh serviceStateRefresh))
		{
			return;
		}
		for (int num = m_ServiceSaveEvents.Count - 1; num >= 0; num--)
		{
			InteractObjectState interactObjectState = m_ServiceSaveEvents[num];
			if (serviceStateRefresh.swid == interactObjectState.uid && interactObjectState.stateId == serviceStateRefresh.stateId)
			{
				CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(interactObjectState.uid).Append("_")
					.Append(interactObjectState.stateId)
					.ToString());
			}
		}
	}

	private void OnInputStateChangeEvent(BaseEventContent e)
	{
		if (e is InputEvt inputEvt)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("input_").Append(inputEvt.inputKey)
				.ToString());
		}
	}

	private void OnTraceMissionEvent(BaseEventContent e)
	{
		if (e is SubMissionEvt subMissionEvt)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("trace_").Append(subMissionEvt.subID)
				.ToString());
		}
	}

	private void OnUnTraceMissionEvent(BaseEventContent e)
	{
		if (e is SubMissionEvt subMissionEvt)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("untrace_").Append(subMissionEvt.subID)
				.ToString());
		}
	}

	private void OnPlayerRespawn(BaseEventContent e)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("respawn").ToString());
	}

	public void EntitySetMaxHP(Entity entityReference)
	{
		if (entityReference.IsValid)
		{
			CompAbility? compAbility = entityReference.GetCompAbility();
			compAbility.ServerSetHP(compAbility.maxHP);
		}
	}

	public void TeamSetmaxHP()
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				CompAbility? compAbility = teamCharacter.GetCompAbility();
				compAbility.ServerSetHP(compAbility.maxHP);
			}
		}
	}

	public void EntityCharge(Entity entityReference)
	{
		if (entityReference.IsValid)
		{
			float skillEnergy = RuntimeConfigs.data.entityCharacterDatas[entityReference.GetCompCharacter().characterSource.Id()].skillEnergy;
			entityReference.GetCompAbility().CurrentUltimateSkillValue = skillEnergy;
		}
	}

	public void TeamCharge(bool resetCD)
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				float skillEnergy = RuntimeConfigs.data.entityCharacterDatas[teamCharacter.GetCompCharacter().characterSource.Id()].skillEnergy;
				teamCharacter.GetCompAbility().CurrentUltimateSkillValue = skillEnergy;
				if (resetCD && teamCharacter.GetCompMotion().skillLookup.TryGetValue("ground_U_start", out var value))
				{
					value.SetSkillCd(0f, exceeds: false);
				}
			}
		}
	}

	public bool MainEnergyIsFull()
	{
		if (RuntimeConfigs.data.entityCharacterDatas.TryGetValue(MonoECS.instance.mainEntity.GetCompCharacter().characterSource.Id(), out var value))
		{
			return MonoECS.instance.mainEntity.GetCompAbility().CurrentUltimateSkillValue >= value.skillEnergy;
		}
		return false;
	}

	public int RandomValue(int min, int max)
	{
		return UnityEngine.Random.Range(min, max + 1);
	}

	public int LookUpValue(int max, int step)
	{
		int result = ((baseValue > max) ? (baseValue % max) : baseValue);
		baseValue += step;
		return result;
	}

	public void DebugTest(string test)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(test);
		}
	}

	public void LockSystem(int systemId, bool isLock)
	{
		if (isLock)
		{
			Fundamental.Singleton<SystemUnlockManager>.instance.ClientLockSystem(systemId);
		}
		else
		{
			Fundamental.Singleton<SystemUnlockManager>.instance.ClientUnLockSystem(systemId);
		}
	}

	public void RogueIntoNextRoom()
	{
		if (Model<RoGueModel>.Interface != null)
		{
			Model<RoGueModel>.Interface.CurrentStepId++;
		}
	}

	public void SentRogueRoomChallengeEnd()
	{
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueRoomChallengeEnd, null);
	}

	public bool CheckRogueRoomIsFinshed()
	{
		return Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomStatus == RogueRoomStatus.Finished;
	}

	public void SetChaseBattleSpawnPosition(Vector3 position)
	{
		Fundamental.Singleton<ChaseBattleManager>.instance.SpawnPosition = position;
	}

	public async UniTask AwaitAnimMoveProgress(int swid, int tarProgress)
	{
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(swid, out var asset);
		if (asset.stateObjectBase is InteractBehaveAnimControl)
		{
			InteractBehaveAnimControl temp = asset.stateObjectBase as InteractBehaveAnimControl;
			await UniTask.WaitUntil(() => temp.behave.currProgressRate > (float)tarProgress || temp.behave.fail, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
		}
		else if (asset.stateObjectBase is InteractBehaveAnimControlEx)
		{
			InteractBehaveAnimControlEx temp2 = asset.stateObjectBase as InteractBehaveAnimControlEx;
			await UniTask.WaitUntil(() => temp2.behave.fail, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
		}
	}

	public async UniTask AwaitAnimMoveFail(int swid)
	{
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(swid, out var asset);
		if (asset.stateObjectBase is InteractBehaveAnimControl)
		{
			InteractBehaveAnimControl temp = asset.stateObjectBase as InteractBehaveAnimControl;
			await UniTask.WaitUntil(() => temp.behave.fail, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
		}
		else if (asset.stateObjectBase is InteractBehaveAnimControlEx)
		{
			InteractBehaveAnimControlEx temp2 = asset.stateObjectBase as InteractBehaveAnimControlEx;
			await UniTask.WaitUntil(() => temp2.behave.fail, PlayerLoopTiming.FixedUpdate, m_CTS.Token);
		}
	}

	public bool CheckAnimMoveIsTarProgress(int swid, int tarProgress)
	{
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(swid, out var asset);
		if (asset.stateObjectBase is InteractBehaveAnimControl)
		{
			return (asset.stateObjectBase as InteractBehaveAnimControl).behave.currProgressRate > (float)tarProgress;
		}
		if (asset.stateObjectBase is InteractBehaveAnimControlEx)
		{
			_ = asset.stateObjectBase;
			return false;
		}
		return false;
	}

	public bool CheckAnimMoveIsFail(int swid)
	{
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(swid, out var asset);
		if (asset.stateObjectBase is InteractBehaveAnimControl)
		{
			return (asset.stateObjectBase as InteractBehaveAnimControl).behave.fail;
		}
		if (asset.stateObjectBase is InteractBehaveAnimControlEx)
		{
			return (asset.stateObjectBase as InteractBehaveAnimControlEx).behave.fail;
		}
		return false;
	}

	public void ShowRaidOpenTip()
	{
		ShowRaidOpenTip(null);
	}

	public void ShowRaidOpenTip(int titleLocalizeId, int descriptionLocalizeId)
	{
		ShowRaidOpenTip(new RaidOpeningPerformanceComponentData
		{
			titleLocalizeId = titleLocalizeId,
			descriptionLocalizeId = descriptionLocalizeId
		});
	}

	private void ShowRaidOpenTip(RaidOpeningPerformanceComponentData data)
	{
		OnHudCpEnqueue evt = Fundamental.Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.RaidOpeningPerformance;
		evt.uiData = data;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 4;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void TriggerCustomInteractEvent(int swid, string eventName)
	{
		G.service.TriggerCustomInteractEvent(swid, eventName, null);
	}

	public void SharedChangeState(int swid, int stateId, bool toClean = false)
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, stateId);
	}

	public void SharedChangeStates(List<InteractObjectState> interactObjectStates)
	{
		ACT.World.Asset.StateChangeInfo[] array = new ACT.World.Asset.StateChangeInfo[interactObjectStates.Count];
		for (int i = 0; i < interactObjectStates.Count; i++)
		{
			array[i] = new ACT.World.Asset.StateChangeInfo
			{
				uid = interactObjectStates[i].uid,
				stateId = interactObjectStates[i].stateId
			};
		}
		MonoECS.instance.ruleManager.SharedChangeStates(array);
	}

	public void TryInteract(int entry, int swid)
	{
		if (StateWorldAsset.TryGetWorldAssetBySwid(swid, out var stateWorldAsset))
		{
			stateWorldAsset.stateObjectBase.Interact(entry, MonoECS.instance.mainEntity, InteractAction.InteractSource.Player);
		}
	}

	public void SharedChangeState(InteractObjectState state, bool toClean = false)
	{
		MonoECS.instance.ruleManager.SharedChangeState(state.uid, state.stateId);
	}

	[Obsolete("使用TriggerCustomInteractEvent替代")]
	public void LocalChangeState(int swid, int stateId)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("LocalChangeState只用于测试");
		}
		int activeWorldId = Fundamental.Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		if (!CoreUtils.TryGetServiceSaveStateId(activeWorldId, swid, out var stateId2))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到交互物！！！{stateId2}");
			}
			return;
		}
		if (stateId2 < 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("不能修改服务器权限的状态");
			}
			return;
		}
		ServiceSaveStateNtf serviceSaveStateNtf = new ServiceSaveStateNtf
		{
			Wid = activeWorldId
		};
		serviceSaveStateNtf.Changes.Add(new ServiceSaveState
		{
			Uid = swid,
			StateId = stateId
		});
		Fundamental.Singleton<NetManager>.instance.LocalDispatch(4505, serviceSaveStateNtf);
	}

	public void ChangeBTree(Entity entity, string valueName, object value)
	{
		if (entity.IsValid)
		{
			entity.GetBTree().SetVariableValue(valueName, value);
		}
	}

	public void BPCloseLoderView()
	{
	}

	public void SyncGameInfos()
	{
		MonoECS.instance.SyncGameInfos();
	}

	public void SetConstZ(float z)
	{
		MonoECS.instance.mainEntity.GetCompPhysics().SetConstZ(z);
	}

	public void SetSpawnPos(Vector3 spawnPos, int chunkId)
	{
		SceneSpawnInfo spawnInfo = new SceneSpawnInfo
		{
			Pos = spawnPos.ToPB(),
			InteractionObjUID = -1,
			ChunkID = chunkId
		};
		Fundamental.Singleton<RespawnManager>.instance.RecordSpawnPos(spawnInfo, "蓝图设置复活点");
	}

	public void FireNoOwnerEffect(YooAssetReference pattern, Vector3 pos)
	{
		GameManager.effectSystem.FireEffect(pattern, pos, Quaternion.identity);
	}

	public async UniTask TaskWaitForGameStart()
	{
		await UniTask.WaitUntil(() => (bool)MonoECS.instance && MonoECS.instance.isStartWorld);
	}

	public void StartAbyssTime()
	{
		m_needDestroyByBP = true;
		m_abyssTimerOn = true;
		m_abyssTimeCount = 0;
		Model<AbyssModel>.Interface.ActiveTimer(active: true);
	}

	public void UpdateAbyssTimer()
	{
		if (m_abyssTimerOn)
		{
			m_abyssTime += GameManager.timeSystem.GetWorldRuntimeDeltaTime();
			if (m_abyssTime - (float)m_abyssTimeCount > 1f)
			{
				Model<AbyssModel>.Interface.UpdateTimer();
				m_abyssTimeCount = Model<AbyssModel>.Interface.CurLayerTime;
			}
		}
	}

	public void StopAbyssTime()
	{
		m_abyssTimerOn = false;
		Model<AbyssModel>.Interface.ActiveTimer(active: false);
	}

	public void StartTeamTeachingTime()
	{
		m_needDestroyByBP = true;
		m_teamTeachingTimerOn = true;
		m_teamTeachingTime = 0f;
		m_teamTeachingTimeCount = 0;
		Model<TeamTeachingModel>.Interface.BeginCurrentChallengeTracking();
		Model<TeamTeachingModel>.Interface.ActiveTimer(active: true);
	}

	public void UpdateTeamTeachingTimer()
	{
		if (m_teamTeachingTimerOn)
		{
			m_teamTeachingTime += GameManager.timeSystem.GetWorldRuntimeDeltaTime();
			if (m_teamTeachingTime - (float)m_teamTeachingTimeCount > 1f)
			{
				Model<TeamTeachingModel>.Interface.UpdateTimer();
				m_teamTeachingTimeCount = Model<TeamTeachingModel>.Interface.CurLayerTime;
			}
		}
	}

	public void StopTeamTeachingTime()
	{
		m_teamTeachingTimerOn = false;
		Model<TeamTeachingModel>.Interface.ActiveTimer(active: false);
	}

	public void StartTimer()
	{
		m_timerTime = GameManager.timeSystem.time;
		m_timerCount = 1;
		m_timerOn = true;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ShowTimer, null);
	}

	public void UpdateTimer()
	{
		if (m_timerOn && GameManager.timeSystem.time - m_timerTime > (float)m_timerCount)
		{
			ACT.Event.PassSubMission evt = Fundamental.Singleton<EventManager>.instance.GetEvt<ACT.Event.PassSubMission>();
			evt.from = m_timerCount / 60;
			evt.to = m_timerCount % 60;
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateTimer, evt);
			Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
			m_timerCount++;
		}
	}

	public IEnumerator Timeout(float time)
	{
		yield return new WaitUntil(() => GameManager.timeSystem.time - m_timerTime >= time);
	}

	public void StopTimer()
	{
		m_timerOn = false;
		m_timerCountDownOn = false;
	}

	public void HideTimer()
	{
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HideTimer, null);
	}

	public void StartCountDownTimer(float time)
	{
		m_timerTime = GameManager.timeSystem.time;
		m_countDownTime = time;
		m_timerCount = 1;
		m_timerCountDownOn = true;
		ACT.Event.PassSubMission evt = Fundamental.Singleton<EventManager>.instance.GetEvt<ACT.Event.PassSubMission>();
		evt.from = (int)(m_countDownTime / 60f);
		evt.to = (int)(m_countDownTime % 60f);
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateTimer, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void UpdateCountDownTimer()
	{
		if (m_timerCountDownOn && GameManager.timeSystem.time - m_timerTime > (float)m_timerCount)
		{
			ACT.Event.PassSubMission evt = Fundamental.Singleton<EventManager>.instance.GetEvt<ACT.Event.PassSubMission>();
			evt.from = (int)(m_countDownTime / 60f);
			evt.to = (int)(m_countDownTime % 60f);
			Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateTimer, evt);
			Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
			m_countDownTime--;
			m_timerCount++;
		}
	}

	public IEnumerator TimeCountDownOut(float time)
	{
		while (m_countDownTime != time)
		{
			yield return null;
		}
	}

	public bool IsPlayerAlive()
	{
		return Fundamental.Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal;
	}

	public int GetCharacterId()
	{
		return MonoECS.instance.mainEntity.GetCompCharacter().characterSource.Id();
	}

	public Entity GetMainEntity()
	{
		return MonoECS.instance.mainEntity;
	}

	public async UniTask GetHpLessOrEqual(Entity entity, float target)
	{
		if (entity.IsValid)
		{
			CompAbility compAbility = entity.GetCompAbility();
			await UniTask.WaitUntil(() => (float)compAbility.hp <= target * (float)compAbility.maxHP);
		}
	}

	public async UniTask GetHpLarger(Entity entity, float target)
	{
		if (entity.IsValid)
		{
			CompAbility compAbility = entity.GetCompAbility();
			await UniTask.WaitUntil(() => (float)compAbility.hp > target * (float)compAbility.maxHP);
		}
	}

	public void SendTrackStringEvent(string eventName, string propertyName, string content)
	{
		try
		{
			JObject jObject = new JObject();
			jObject.Add(propertyName, content);
			BamBooSdk.getInstance().taEvent(eventName, jObject.ToString());
			_ = LuminApplication.LogEnabled;
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning(message);
			}
		}
	}

	public void SendTrackIntEvent(string eventName, string propertyName, int content)
	{
		try
		{
			JObject jObject = new JObject();
			jObject.Add(propertyName, content);
			BamBooSdk.getInstance().taEvent(eventName, jObject.ToString());
			_ = LuminApplication.LogEnabled;
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning(message);
			}
		}
	}

	public void SendTrackBoolEvent(string eventName, string propertyName, bool content)
	{
		try
		{
			JObject jObject = new JObject();
			jObject.Add(eventName, content);
			BamBooSdk.getInstance().taEvent(eventName, jObject.ToString());
			_ = LuminApplication.LogEnabled;
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning(message);
			}
		}
	}

	public void SendTrackFloatEvent(string eventName, string propertyName, float content)
	{
		try
		{
			JObject jObject = new JObject();
			jObject.Add(eventName, content);
			BamBooSdk.getInstance().taEvent(eventName, jObject.ToString());
			_ = LuminApplication.LogEnabled;
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning(message);
			}
		}
	}

	public void ForbidCreateMonsterUntilUnload(int uid)
	{
		if (StateWorldAsset.TryGetWorldAssetBySwid(uid, out var stateWorldAsset))
		{
			((InteractMonster)stateWorldAsset.stateObjectBase).ForbidCreateMonster = true;
		}
	}

	public void ForbidCreateMonstersUntilUnload(int[] swids)
	{
		for (int i = 0; i < swids.Length; i++)
		{
			if (StateWorldAsset.TryGetWorldAssetBySwid(swids[i], out var stateWorldAsset))
			{
				((InteractMonster)stateWorldAsset.stateObjectBase).ForbidCreateMonster = true;
			}
		}
	}

	public void SendBigWordTimeEvent(ACT.Event.EventType _event, float remaining, float total)
	{
		BigWordTimeDate evt = Fundamental.Singleton<EventManager>.instance.GetEvt<BigWordTimeDate>();
		evt._Type = _event;
		evt._total = total;
		evt._remaining = remaining;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWordChangeTimer, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public bool IsInWorld(int worldId)
	{
		return Fundamental.Singleton<GameManager>.instance.worldManager.ActiveWorldId == worldId;
	}

	public void SendBigWorldSuccess()
	{
		ChallengeTipComponentData uiData = new ChallengeTipComponentData
		{
			challengeTipShowType = ChallengeTipShowType.Success
		};
		OnHudCpEnqueue evt = Fundamental.Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.ChallengeTip;
		evt.uiData = uiData;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 1;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SendBigWorldFail()
	{
		ChallengeTipComponentData uiData = new ChallengeTipComponentData
		{
			challengeTipShowType = ChallengeTipShowType.Failure
		};
		OnHudCpEnqueue evt = Fundamental.Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.ChallengeTip;
		evt.uiData = uiData;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 1;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SendFinishBigWorld(bool success)
	{
		Fundamental.Singleton<EventManager>.instance.EventDispatch(success ? ClientEvent.UI_BigWorldSuccess : ClientEvent.UI_BigWorldFail, null);
	}

	public void SetBigWorldProgressTitle(List<LocalizeStringEvent> list)
	{
		Model<BigWorldChallengeProgressModel>.Interface.StartChallenge(list);
	}

	public void SetBigWorldProgress(LocalizeStringEvent stringEvent, string count)
	{
		BigWordProgressData evt = Fundamental.Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
		evt.str = stringEvent;
		evt.value = count;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshBigWorldProgress, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void ChangeBigWorldTitleProgress(LocalizeStringEvent stringEvent, string count)
	{
		BigWordProgressData evt = Fundamental.Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
		evt.str = stringEvent;
		evt.value = count;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshBigWorldProgressTitle, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SetItemCostTips(int localizedid, int itemid)
	{
		GetTipsItemCostData evt = Fundamental.Singleton<EventManager>.instance.GetEvt<GetTipsItemCostData>();
		evt.localizedid = localizedid;
		evt.ItemId = itemid;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_GetItemCostTIp, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void ShowBattlePrompts(List<LocalizeStringEvent> list)
	{
		Model<ChallengePromptsModel>.Interface.SetEventList(list);
		Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CHALLENGEPROMPTS);
	}

	public void RefreshComboCount(BaseEventContent obj)
	{
		BigWordComboChallenge bigWordComboChallenge = (BigWordComboChallenge)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("Count").ToString(), bigWordComboChallenge.ComboCount);
	}

	public void ChallengeCollectEvent(BaseEventContent obj)
	{
		BigWordRunningPointChange bigWordRunningPointChange = (BigWordRunningPointChange)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("Collect").ToString(), bigWordRunningPointChange.count);
	}

	public void ChallengeExitEvent(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("ChallengeExit").ToString());
	}

	public void PopPauseEvent(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("PopPause").ToString());
	}

	public void PushPauseEvent(BaseEventContent obj)
	{
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("PushPause").ToString());
	}

	public void ChallengeProtectionHpChangeEvent(BaseEventContent obj)
	{
		BigWorldProtectionHpChange bigWorldProtectionHpChange = (BigWorldProtectionHpChange)obj;
		double num = (double)bigWorldProtectionHpChange.hp / (double)bigWorldProtectionHpChange.maxhp;
		string arg = num.ToString("0.%");
		string format = "<color=#{0}>{1}</color>";
		string text = "";
		if (num > 0.5)
		{
			text = "F0EAD7";
		}
		else
		{
			text = ((!(num > 0.3) || !(num <= 0.5)) ? "F56E71" : "F5B46E");
		}
		format = string.Format(format, text, arg);
		if (bigWorldProtectionHpChange.hp <= 0)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("ChallengeProtectionDie").ToString());
		}
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("ChallengeProtectionHpChange").ToString(), format);
	}

	public bool CheckItemByIdInBag(int itemid)
	{
		if (G.localPlayer.Inventory.GetItemCount(itemid) > 0)
		{
			return true;
		}
		return false;
	}

	public void SubitemCommitEvent(BaseEventContent obj)
	{
		SubItemCommit subItemCommit = (SubItemCommit)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("SubitemCommit").ToString(), subItemCommit.subid, subItemCommit.itemid);
	}

	public void ChallengeTreasureMapGetitemEvent(BaseEventContent obj)
	{
		ChallengeTreasureMapGetitem challengeTreasureMapGetitem = (ChallengeTreasureMapGetitem)obj;
		CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append("TreasureMapItemGet").ToString(), challengeTreasureMapGetitem.itemid);
	}

	public int GetCurrentWorldID()
	{
		return Fundamental.Singleton<GameManager>.instance.worldManager.ActiveWorldId;
	}

	public void StartCharacterTutorial(int characterTutorialId)
	{
		Model<CharacterTutorialModel>.Interface.StartCharacterTutorial(characterTutorialId);
	}

	public void StartCharacterTeamTutorial(int characterTutorialId)
	{
		Model<CharacterTutorialModel>.Interface.StartCharacterTeamTutorial(characterTutorialId);
	}

	public void FinishCharacterTutorial()
	{
		Model<CharacterTutorialModel>.Interface.FinishCharacterTutorial();
	}

	public void FinishCharacterTeamTutorial()
	{
		Model<CharacterTutorialModel>.Interface.FinishCharacterTeamTutorial();
	}

	public void FinishCharacterTrial()
	{
		Model<RaidModel>.Interface.RaidSettlement();
	}

	public void StartPromptProcess(int processId)
	{
		Model<CharacterTutorialModel>.Interface.StartPromptProcess(processId);
	}

	public void StartCharacterTeamPromptProcess(int processId)
	{
		StartCharacterTeamPromptProcessAsync(processId).Forget();
	}

	private async UniTaskVoid StartCharacterTeamPromptProcessAsync(int processId)
	{
		await Model<CharacterTutorialModel>.Interface.RefreshCharacterTeamTutorialInteractTarget(0.5f);
		Model<CharacterTutorialModel>.Interface.StartPromptProcess(processId);
	}

	public void FinishPromptProcess()
	{
		Model<CharacterTutorialModel>.Interface.FinishPromptProcess();
	}

	public void FinishCharacterTeamPromptProcess()
	{
		Model<CharacterTutorialModel>.Interface.FinishPromptProcess();
	}

	private void OnCharacterTutorialProcessFinish(BaseEventContent eventContent)
	{
		if (eventContent is CharacterTutorialProcessFinishEvt characterTutorialProcessFinishEvt)
		{
			CustomEvent.Trigger(gameObject, m_StringBuilder.Clear().Append(characterTutorialProcessFinishEvt.finishProcessId.FastToString()).ToString());
		}
	}

	public void DispatchEnemyDieEvent()
	{
		CharacterTutorialEnemyDieEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<CharacterTutorialEnemyDieEvt>();
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_EnemyDie, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void DispatchEnemyWeakEvent()
	{
		CharacterTutorialEnemyWeakEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<CharacterTutorialEnemyWeakEvt>();
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_EnemyWeak, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void EnterRaid(int raidId)
	{
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.BattleCharacterIdx = 0;
		teamUsage.EquipPotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
		foreach (Character curTeamCharacter in CharacterDataHelper.GetCurTeamCharacters())
		{
			TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
			teamCharacterUsage.CharacterId = curTeamCharacter.Id;
			teamUsage.CharacterUsage.Add(teamCharacterUsage);
		}
		G.service.RaidEnterInfo(raidId, teamUsage, async (bool r) =>
		{
			if (r)
			{
				MonoECS.instance.PushPause();
				await Fundamental.Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
				MonoECS.instance.PopPause();
			}
		});
	}

	public void LeaveRaid()
	{
		G.service.LeaveRaid((bool r) =>
		{
			if (r)
			{
				Fundamental.Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			}
		});
	}

	public void StartParkourRaid(int swid, int state)
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, state);
	}

	public void SendGlobalBattleEvent(string eventId)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtCustom evt = abilitySystem.GetEvt<EvtCustom>(MonoECS.instance.mainEntity, null);
		evt.eventId = eventId;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	public bool IsSubMissionRunning(int submissionId)
	{
		return Fundamental.Singleton<MissionManager>.instance.IsAccepted(submissionId);
	}

	public bool IsSubMissionFinished(int submissionId)
	{
		return Fundamental.Singleton<MissionManager>.instance.IsFinished(submissionId);
	}

	public void OpenSystemUnlockUi(int systemId)
	{
		CoreUtils.GetData(systemId, RuntimeConfigs.data.systemOpens);
		UiViewDataContent evt = Fundamental.Singleton<EventManager>.instance.GetEvt<UiViewDataContent>();
		evt.uiViewData = new PopupSystemUnlockViewData
		{
			systemId = systemId
		};
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Open_SystemUnlock, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public int GetRaidZoomLevel()
	{
		return MonoECS.instance.raidListenerManager.GetRaidZoomLevel();
	}

	[Obsolete("不该在蓝图节点中直接使用打开问卷")]
	public void OpenQuestionnaire(int id)
	{
	}

	public void CPEnterRaid(int raidId)
	{
		MonoECS.instance.SyncGameInfos();
		if (!GameUtility.gameLoader.IsCustomize)
		{
			return;
		}
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.BattleCharacterIdx = 0;
		teamUsage.EquipPotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
		foreach (Character curTeamCharacter in CharacterDataHelper.GetCurTeamCharacters())
		{
			TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
			teamCharacterUsage.CharacterId = curTeamCharacter.Id;
			teamUsage.CharacterUsage.Add(teamCharacterUsage);
		}
		G.service.RaidEnterInfo(raidId, teamUsage, async (bool r) =>
		{
			if (r)
			{
				MonoECS.instance.PushPause();
				await Fundamental.Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
				MonoECS.instance.PopPause();
			}
		});
	}

	public bool RaidIsComplete(int raidId)
	{
		return Model<RaidModel>.Interface.GetRaidCleanNum(raidId) != 0;
	}

	public async UniTask SpawnAssistNpc(SpawnMonsterPoint smp, int npcId)
	{
		if (!IsAssistNpc(npcId) || m_AssistNpcs.ContainsKey(npcId))
		{
			return;
		}
		Entity entity = GameManager.entities.factory.CreateAssistNpc();
		SpawnMonsterParams param = smp.GetSpawnMonsterParams();
		await MonoECS.instance.SpawnAssistNpc(entity, param, npcId);
		if (param.buffList != null)
		{
			AddBuff(entity, param.buffList);
		}
		if (m_CTS.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(entity);
			return;
		}
		entity.GetCompBehave().OnRelase += () =>
		{
			m_AssistNpcs.Remove(npcId);
		};
		m_AssistNpcs[npcId] = entity;
		ApcEvent evt = EventTrackSolver.Instance.GetEvt<ApcEvent>();
		evt.apcId = npcId;
		evt.status = 1;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void DeSpawnAssistNpc(int npcId)
	{
		if (m_AssistNpcs.TryGetValue(npcId, out var value) && value.IsValid && value.CanRemove() && !value.IsOnRemove())
		{
			MonoECS.instance.TryRemoveBehave(value);
		}
	}

	public bool IsAssistNpc(int npcId)
	{
		return Model<AssistNpcModel>.Interface.IsNpcAssist(npcId);
	}

	public void AssistNpcHelp(int npcId)
	{
		Model<AssistNpcModel>.Interface.AssistNpcHelp(npcId);
	}

	public void AssistNpcHelpFinish(int npcId)
	{
		Model<AssistNpcModel>.Interface.AssistNpcHelpFinish(npcId);
	}

	public void ChangeControllerState(int swid, int state)
	{
		ChangeControllerStateEvt evt = Fundamental.Singleton<EventManager>.instance.GetEvt<ChangeControllerStateEvt>();
		evt.swid = swid;
		evt.state = state;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.Controller_ChangeState, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SetSystemEntriesActive(bool active)
	{
		RefreshSystemEntriesInBossChaseBattle evt = Fundamental.Singleton<EventManager>.instance.GetEvt<RefreshSystemEntriesInBossChaseBattle>();
		evt.isActive = active;
		Fundamental.Singleton<EventManager>.instance.EventDispatch(ClientEvent.RefreshSystemEntriesInBossChaseBattle, evt);
		Fundamental.Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public async UniTask StartChaseBattle(List<SpawnMonsterPoint> hunterPoints)
	{
		List<Entity> hunters = Fundamental.ListPool<Entity>.Get();
		List<float> list = new List<float>(GameLoader.meta.pathOffsetChangeArray);
		list.RandomSort(0, list.Count - 1);
		List<UniTask> tasks = Fundamental.ListPool<UniTask>.Get();
		m_needDestroyByBP = true;
		for (int i = 0; i < hunterPoints.Count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = hunterPoints[i].GetSpawnMonsterParams();
			Entity entity = GameManager.entities.factory.CreateEnemy(spawnMonsterParams.id);
			hunters.Add(entity);
			tasks.Add(ServerSpawnMonster(hunterPoints[i], spawnMonsterParams, entity, null, m_CTS.Token, list, i));
		}
		foreach (Entity item in hunters)
		{
			Fundamental.Singleton<ChaseBattleManager>.instance.Hunter.Add(new RuntimeEntityArchive
			{
				Entity = item,
				Position = item.GetCompTransform().physicsPosition,
				ChunkID = Fundamental.Singleton<GameManager>.instance.worldManager.ActiveChunkId,
				HpPercent = 1f
			});
		}
		m_SpawnMonsters.AddRange(hunters);
		await UniTask.WhenAll(tasks);
		Fundamental.ListPool<UniTask>.Release(tasks);
		Fundamental.ListPool<Entity>.Release(hunters);
		Fundamental.Singleton<ChaseBattleManager>.instance.ChaseBattleBluePrint = this;
		Fundamental.Singleton<ChaseBattleManager>.instance.ChaseBattleID = hunterPoints.First().id;
	}

	public void FinishChaseBattle()
	{
		Fundamental.Singleton<ChaseBattleManager>.instance.ChaseBattleID = 0;
		foreach (RuntimeEntityArchive item in Fundamental.Singleton<ChaseBattleManager>.instance.Hunter)
		{
			if (item.Entity.IsValid)
			{
				MonoECS.instance.TryRemoveBehave(item.Entity);
				m_SpawnMonsters.Remove(item.Entity);
			}
		}
		Fundamental.Singleton<ChaseBattleManager>.instance.Hunter.Clear();
		Fundamental.Singleton<ChaseBattleManager>.instance.ChaseBattleBluePrint = null;
	}

	public void PassCheckPoint()
	{
		Fundamental.Singleton<ChaseBattleManager>.instance.PassCheckPoint();
	}

	public void BossPursuitCheckPoint(bool start, Vector3 characterPos, Entity monster, Vector3 monsterPos, int scrollId)
	{
		Dictionary<int, CharacterStatus> dictionary = Fundamental.DictionaryPool<int, CharacterStatus>.Get();
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MPPlayer.local.GetTeamCharacter(i);
			CompCharacter compCharacter = teamCharacter.GetCompCharacter();
			if (teamCharacter.IsValid && !((Character)compCharacter.characterSource).IsTrailCharacter)
			{
				CharacterStatus characterStatus = new CharacterStatus();
				CompAbility compAbility = teamCharacter.GetCompAbility();
				characterStatus.ExPower = compAbility.CurrentUltimateSkillValue;
				characterStatus.AssistPower = compAbility.AssistValue;
				characterStatus.EnergyPower = compAbility.EnergyValue;
				int hpSync = RuntimeConfigs.data.game.hpSync;
				characterStatus.Hp = Mathf.CeilToInt((float)compAbility.hp * 1f / (float)compAbility.maxHP * (float)hpSync);
				dictionary.Add(compCharacter.characterSource.Id(), characterStatus);
			}
		}
		Fundamental.DictionaryPool<int, CharacterStatus>.Release(dictionary);
	}

	public void FinishBossPursuit(bool reset, int scrollId)
	{
		Dictionary<int, CharacterStatus> dictionary = Fundamental.DictionaryPool<int, CharacterStatus>.Get();
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MPPlayer.local.GetTeamCharacter(i);
			CompCharacter compCharacter = teamCharacter.GetCompCharacter();
			if (teamCharacter.IsValid && !((Character)compCharacter.characterSource).IsTrailCharacter)
			{
				CharacterStatus characterStatus = new CharacterStatus();
				CompAbility compAbility = teamCharacter.GetCompAbility();
				characterStatus.ExPower = compAbility.CurrentUltimateSkillValue;
				characterStatus.AssistPower = compAbility.AssistValue;
				characterStatus.EnergyPower = compAbility.EnergyValue;
				int hpSync = RuntimeConfigs.data.game.hpSync;
				characterStatus.Hp = Mathf.CeilToInt((float)compAbility.hp * 1f / (float)compAbility.maxHP * (float)hpSync);
				dictionary.Add(compCharacter.characterSource.Id(), characterStatus);
			}
		}
	}

	public int GetGuideStepById(int GuideId)
	{
		if (Model<GuideModel>.HasInstance())
		{
			return Model<GuideModel>.Interface.GetGuideStepById(GuideId);
		}
		return 0;
	}

	public void PushPause()
	{
		MonoECS.instance.PushPause();
	}

	public void PopPause()
	{
		MonoECS.instance.PopPause();
	}

	public void PureBlackScreenTp(Vector3 pos, bool setConstZ, bool faceLeft, int chunkId, bool forceToFloor)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = pos,
			faceLeft = faceLeft,
			forceToFloor = forceToFloor,
			revive = false
		};
		TeleportUtility.TeleportWithPureBlackScreen(chunkId, teleportParams).Forget();
	}

	public async UniTask LoaderTp(int chunkId, Vector3 pos, bool setConstZ, bool faceLeft, bool forceToFloor)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = pos,
			faceLeft = faceLeft,
			forceToFloor = forceToFloor,
			revive = false
		};
		await TeleportUtility.TeleportWithLoader(chunkId, teleportParams);
		Fundamental.Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
	}

	public void ChangeStandardElevatorLayer(int swid, int layerIndex)
	{
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(swid, out var asset);
		if (asset != null && asset.data is StandardElevatorData standardElevatorData)
		{
			StateWorldUid lockFlag = standardElevatorData.layers[layerIndex].lockFlag;
			if (MonoECS.instance.ruleManager.SharedGetState(lockFlag) == 0)
			{
				(asset.stateObjectBase as InteractStandardElevator)?.RunElevator(layerIndex);
			}
		}
	}

	public void SetCharacterSpecialEnergyMax(int characterId)
	{
		foreach (KeyValuePair<int, Parameters> item in RuntimeConfigs.data.Parameterss)
		{
			if (item.Value.characterID == characterId)
			{
				CompMotion compMotion = MonoECS.instance.mainEntity.GetCompMotion();
				if (item.Value.TypeValueOne != 0)
				{
					compMotion?.SetInt(item.Value.name, item.Value.TypeValueOne);
				}
				else if (item.Value.TypeValueTwo != 0f)
				{
					compMotion?.SetFloat(item.Value.name, item.Value.TypeValueTwo);
				}
				else if (item.Value.TypeValueOne == 0 && item.Value.TypeValueTwo == 0f && item.Value.TypeValueThree)
				{
					compMotion?.SetBool(item.Value.name, item.Value.TypeValueThree);
				}
				else
				{
					compMotion?.SetTrigger(item.Value.name);
				}
			}
		}
	}

	public void SetCharacterSpecialEnergyMaxWithType(int characterId, object value)
	{
		foreach (KeyValuePair<int, Parameters> item in RuntimeConfigs.data.Parameterss)
		{
			if (item.Value.characterID != characterId)
			{
				continue;
			}
			CompMotion compMotion = MonoECS.instance.mainEntity.GetCompMotion();
			if (compMotion == null)
			{
				break;
			}
			if (!(value is int i))
			{
				if (!(value is float f))
				{
					if (!(value is bool b))
					{
						if (!(value is string trigger))
						{
							throw new ArgumentException($"Unsupported value type: {value?.GetType()}");
						}
						compMotion.SetTrigger(trigger);
					}
					else
					{
						compMotion.SetBool(item.Value.name, b);
					}
				}
				else
				{
					compMotion.SetFloat(item.Value.name, f);
				}
			}
			else
			{
				compMotion.SetInt(item.Value.name, i);
			}
		}
	}

	public void SetCharacterSpecialEnergyMaxWithTypeAndParamName(int characterId, object value, string paramName = null)
	{
		foreach (KeyValuePair<int, Parameters> item in RuntimeConfigs.data.Parameterss)
		{
			if (item.Value.characterID != characterId)
			{
				continue;
			}
			Parameters data = CoreUtils.GetData(characterId, RuntimeConfigs.data.Parameterss);
			CompMotion compMotion = MonoECS.instance.mainEntity.GetCompMotion();
			if (compMotion == null)
			{
				break;
			}
			string v = (string.IsNullOrEmpty(paramName) ? data.name : paramName);
			if (!(value is int i))
			{
				if (!(value is float f))
				{
					if (!(value is bool b))
					{
						if (!(value is string trigger))
						{
							throw new ArgumentException($"Unsupported value type: {value?.GetType()}");
						}
						compMotion.SetTrigger(trigger);
					}
					else
					{
						compMotion.SetBool(v, b);
					}
				}
				else
				{
					compMotion.SetFloat(v, f);
				}
			}
			else
			{
				compMotion.SetInt(v, i);
			}
		}
	}

	public bool CheckAbyssMonsterCanLoaded(InteractObjectState[] interactObjects)
	{
		if (Model<AbyssModel>.Interface.AbyssData != null && Model<AbyssModel>.Interface.CurAbyssSubStageId != -1)
		{
			List<ItemKv> spawnPoint = CoreUtils.GetData(CoreUtils.GetData(Model<AbyssModel>.Interface.CurAbyssSubStageId, RuntimeConfigs.data.subabyssDatas).sceneId, RuntimeConfigs.data.worldMonsterPoints).spawnPoint;
			WorldManager worldManager = Fundamental.Singleton<GameManager>.instance.worldManager;
			foreach (InteractObjectState interactObjectState in interactObjects)
			{
				if (!(worldManager.GetWorldStateAssetDataBySGOID(interactObjectState.uid) is WorldMonsterPointData worldMonsterPointData))
				{
					continue;
				}
				foreach (ItemKv item in spawnPoint)
				{
					if (item.id == worldMonsterPointData.uniqueIndex)
					{
						return true;
					}
				}
			}
		}
		else
		{
			Debug.LogError("当前不在深渊中或者获取深渊数据错误，查询深渊关卡怪物索引id失败");
		}
		return false;
	}

	public bool CheckRaidMonsterCanLoaded(InteractObjectState[] interactObjects)
	{
		if (Model<RaidModel>.Interface.CurrentRaidId > 0)
		{
			List<ItemKv> spawnPoint = CoreUtils.GetData(CoreUtils.GetData(Model<RaidModel>.Interface.CurrentRaidId, RuntimeConfigs.data.raids).sceneId, RuntimeConfigs.data.worldMonsterPoints).spawnPoint;
			WorldManager worldManager = Fundamental.Singleton<GameManager>.instance.worldManager;
			foreach (InteractObjectState interactObjectState in interactObjects)
			{
				if (!(worldManager.GetWorldStateAssetDataBySGOID(interactObjectState.uid) is WorldMonsterPointData worldMonsterPointData))
				{
					continue;
				}
				foreach (ItemKv item in spawnPoint)
				{
					if (item.id == worldMonsterPointData.uniqueIndex)
					{
						return true;
					}
				}
			}
		}
		else
		{
			Debug.LogError("当前不在副本中，查询副本关卡怪物索引id失败");
		}
		return false;
	}

	public void SetMotionTriggerParam(Entity entity, string variableName)
	{
		if (entity.IsValid)
		{
			entity.SetTrigger(variableName);
		}
	}

	public Entity GetLastSpawnMonster()
	{
		if (m_SpawnMonsters.Count > 0)
		{
			List<Entity> spawnMonsters = m_SpawnMonsters;
			return spawnMonsters[spawnMonsters.Count - 1];
		}
		return default;
	}
}
