using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Event;
using ACT.UI;
using ACT.World;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Scripting;

namespace Unity.VisualScripting.Generated.Aot;

[Preserve]
public class AotStubs
{
	[Preserve]
	public static void ACT_BluePrint_BPMission_CreateTriggerField()
	{
		string text = null;
		Vector3 vector = default;
		Vector3 vector2 = default;
		((BPCommon)null).CreateTriggerField(text, vector, vector2);
		InstanceActionInvoker<BPCommon, string, Vector3, Vector3> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string, Vector3, Vector3>(null);
		instanceActionInvoker.Invoke(null, text, vector, vector2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_Debug_Log()
	{
		object obj = null;
		Debug.Log(obj);
		StaticActionInvoker<object> staticActionInvoker = new StaticActionInvoker<object>(null);
		staticActionInvoker.Invoke(null, obj);
		staticActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_GetSpawnMonsters()
	{
		int num = 0;
		((BPCommon)null).GetSpawnMonsters(num);
		InstanceFunctionInvoker<BPCommon, int, Entity> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, Entity>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CoWaitDie()
	{
		int num = 0;
		((BPCommon)null).CoWaitDie(num);
		InstanceFunctionInvoker<BPCommon, int, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_LocalChangeState()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).LocalChangeState(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AttackChargingSwitch()
	{
		bool flag = false;
		((BPCommon)null).AttackChargingSwitch(flag);
		InstanceActionInvoker<BPCommon, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SkillChargingSwitch()
	{
		float num = 0f;
		bool flag = false;
		((BPCommon)null).SkillChargingSwitch(num, flag);
		InstanceActionInvoker<BPCommon, float, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, float, bool>(null);
		instanceActionInvoker.Invoke(null, num, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SwitchMainEntity()
	{
		int num = 0;
		((BPCommon)null).SwitchMainEntity(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TeamSetmaxHP()
	{
		((BPCommon)null).TeamSetmaxHP();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_GetInteractObjectState()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).GetInteractObjectState(num, num2);
		InstanceFunctionInvoker<BPCommon, int, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num, num2);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_FinishMission()
	{
		((BPMission)null).FinishMission();
		InstanceActionInvoker<BPMission> instanceActionInvoker = new InstanceActionInvoker<BPMission>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_PassSubMission()
	{
		int num = 0;
		((BPMission)null).PassSubMission(num);
		InstanceActionInvoker<BPMission, int> instanceActionInvoker = new InstanceActionInvoker<BPMission, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SharedChangeState()
	{
		int num = 0;
		int num2 = 0;
		bool flag = false;
		((BPCommon)null).SharedChangeState(num, num2, flag);
		InstanceActionInvoker<BPCommon, int, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, num2, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartChaseBattle()
	{
		List<SpawnMonsterPoint> list = null;
		((BPCommon)null).StartChaseBattle(list);
		InstanceFunctionInvoker<BPCommon, List<SpawnMonsterPoint>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<SpawnMonsterPoint>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AwaitInteractObjectState()
	{
		InteractObjectState[] array = null;
		((BPCommon)null).AwaitInteractObjectState(array);
		InstanceFunctionInvoker<BPCommon, InteractObjectState[], UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, InteractObjectState[], UniTask>(null);
		object[] args = array;
		instanceFunctionInvoker.Invoke(null, args);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartTimer()
	{
		((BPCommon)null).StartTimer();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StopTimer()
	{
		((BPCommon)null).StopTimer();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_PlayTimeline()
	{
		BpTimelineData bpTimelineData = default;
		((BPCommon)null).PlayTimeline(bpTimelineData);
		InstanceFunctionInvoker<BPCommon, BpTimelineData, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, BpTimelineData, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, bpTimelineData);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_PassCheckPoint()
	{
		((BPCommon)null).PassCheckPoint();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TaskWaitForGameStart()
	{
		((BPCommon)null).TaskWaitForGameStart();
		InstanceFunctionInvoker<BPCommon, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, UniTask>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CreateTriggerField_0()
	{
		string text = null;
		BoxCollider boxCollider = null;
		((BPCommon)null).CreateTriggerField(text, boxCollider);
		InstanceActionInvoker<BPCommon, string, BoxCollider> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string, BoxCollider>(null);
		instanceActionInvoker.Invoke(null, text, boxCollider);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_FinishChaseBattle()
	{
		((BPCommon)null).FinishChaseBattle();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CoWaitDie()
	{
		int num = 0;
		((BPCommon)null).CoWaitDie(num);
		InstanceFunctionInvoker<BPCommon, int, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_RunTimeDramaTimeline()
	{
		int num = 0;
		((BPCommon)null).RunTimeDramaTimeline(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SharedChangeState()
	{
		int num = 0;
		int num2 = 0;
		bool flag = false;
		((BPCommon)null).SharedChangeState(num, num2, flag);
		InstanceActionInvoker<BPCommon, int, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, num2, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_FailSubMission()
	{
		((BPMission)null).FailSubMission();
		InstanceActionInvoker<BPMission> instanceActionInvoker = new InstanceActionInvoker<BPMission>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_RuntimeDialogue()
	{
		int num = 0;
		((BPCommon)null).RuntimeDialogue(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetVCamPriority()
	{
		AreaCamera areaCamera = null;
		int num = 0;
		((BPCommon)null).SetVCamPriority(areaCamera, num);
		InstanceActionInvoker<BPCommon, AreaCamera, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, AreaCamera, int>(null);
		instanceActionInvoker.Invoke(null, areaCamera, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AWaitTimelineOverPlayed()
	{
		int num = 0;
		((BPCommon)null).AWaitTimelineOverPlayed(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetActiveAreaCamera()
	{
		AreaCamera areaCamera = null;
		bool flag = false;
		((BPCommon)null).SetActiveAreaCamera(areaCamera, flag);
		InstanceActionInvoker<BPCommon, AreaCamera, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, AreaCamera, bool>(null);
		instanceActionInvoker.Invoke(null, areaCamera, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_MissionApplyItem()
	{
		int num = 0;
		((BPMission)null).MissionApplyItem(num);
		InstanceActionInvoker<BPMission, int> instanceActionInvoker = new InstanceActionInvoker<BPMission, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CheckItemByIdInBag()
	{
		int num = 0;
		((BPCommon)null).CheckItemByIdInBag(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AwaitInteractObjectState()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).AwaitInteractObjectState(num, num2);
		InstanceFunctionInvoker<BPCommon, int, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num, num2);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_FinishMissionBluePrint()
	{
		((BPMission)null).FinishMissionBluePrint();
		InstanceActionInvoker<BPMission> instanceActionInvoker = new InstanceActionInvoker<BPMission>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_RuntimeDramaAside()
	{
		List<int> list = null;
		((BPCommon)null).RuntimeDramaAside(list);
		InstanceFunctionInvoker<BPCommon, List<int>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<int>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SharedChangeStates()
	{
		List<InteractObjectState> list = null;
		((BPCommon)null).SharedChangeStates(list);
		InstanceActionInvoker<BPCommon, List<InteractObjectState>> instanceActionInvoker = new InstanceActionInvoker<BPCommon, List<InteractObjectState>>(null);
		instanceActionInvoker.Invoke(null, list);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AwaitInteractObjectState_0()
	{
		InteractObjectState[] array = null;
		((BPCommon)null).AwaitInteractObjectState(array);
		InstanceFunctionInvoker<BPCommon, InteractObjectState[], UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, InteractObjectState[], UniTask>(null);
		object[] args = array;
		instanceFunctionInvoker.Invoke(null, args);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TaskSpawnMonster()
	{
		List<SpawnMonsterPoint> list = null;
		((BPCommon)null).TaskSpawnMonster(list);
		InstanceFunctionInvoker<BPCommon, List<SpawnMonsterPoint>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<SpawnMonsterPoint>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_ForbidCreateMonstersUntilUnload()
	{
		int[] array = null;
		((BPCommon)null).ForbidCreateMonstersUntilUnload(array);
		InstanceActionInvoker<BPCommon, int[]> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int[]>(null);
		instanceActionInvoker.Invoke(null, array);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CheckTimelineOverPlayed()
	{
		int num = 0;
		((BPCommon)null).CheckTimelineOverPlayed(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_StartTimer()
	{
		((BPCommon)null).StartTimer();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_RespawnCharacters()
	{
		((BPCommon)null).RespawnCharacters();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CoWaitCharactersDie()
	{
		int num = 0;
		((BPCommon)null).CoWaitCharactersDie(num);
		InstanceFunctionInvoker<BPCommon, int, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CoUnloadMonster()
	{
		((BPCommon)null).CoUnloadMonster();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TaskWaitForGameStart()
	{
		((BPCommon)null).TaskWaitForGameStart();
		InstanceFunctionInvoker<BPCommon, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, UniTask>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TeamCharge()
	{
		bool flag = false;
		((BPCommon)null).TeamCharge(flag);
		InstanceActionInvoker<BPCommon, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_StopTimer()
	{
		((BPCommon)null).StopTimer();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_Timeout()
	{
		float num = 0f;
		((BPCommon)null).Timeout(num);
		InstanceFunctionInvoker<BPCommon, float, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, float, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CreateSingleUseTriggerField()
	{
		string text = null;
		Vector3 vector = default;
		Vector3 vector2 = default;
		((BPCommon)null).CreateSingleUseTriggerField(text, vector, vector2);
		InstanceActionInvoker<BPCommon, string, Vector3, Vector3> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string, Vector3, Vector3>(null);
		instanceActionInvoker.Invoke(null, text, vector, vector2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_Random_Range()
	{
		int num = 0;
		int num2 = 0;
		Random.Range(num, num2);
		StaticFunctionInvoker<int, int, int> staticFunctionInvoker = new StaticFunctionInvoker<int, int, int>(null);
		staticFunctionInvoker.Invoke(null, num, num2);
		staticFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void int_Equals()
	{
		int num = 0;
		int num2 = 0;
		num.Equals(num2);
		ReflectionInvoker reflectionInvoker = new ReflectionInvoker(null);
		reflectionInvoker.Invoke(0, num2);
		reflectionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SpawnAssistNpc()
	{
		SpawnMonsterPoint spawnMonsterPoint = null;
		int num = 0;
		((BPCommon)null).SpawnAssistNpc(spawnMonsterPoint, num);
		InstanceFunctionInvoker<BPCommon, SpawnMonsterPoint, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, SpawnMonsterPoint, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, spawnMonsterPoint, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AssistNpcHelp()
	{
		int num = 0;
		((BPCommon)null).AssistNpcHelp(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void int_ToString()
	{
		0.ToString();
		ReflectionInvoker reflectionInvoker = new ReflectionInvoker(null);
		reflectionInvoker.Invoke(0);
		reflectionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AddHitListener()
	{
		((BPCommon)null).AddHitListener();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StringAppend()
	{
		string text = null;
		string text2 = null;
		((BPCommon)null).StringAppend(text, text2);
		InstanceFunctionInvoker<BPCommon, string, string, string> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, string, string, string>(null);
		instanceFunctionInvoker.Invoke(null, text, text2);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TeamCharge()
	{
		bool flag = false;
		((BPCommon)null).TeamCharge(flag);
		InstanceActionInvoker<BPCommon, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CoWaitCharactersDie()
	{
		int num = 0;
		((BPCommon)null).CoWaitCharactersDie(num);
		InstanceFunctionInvoker<BPCommon, int, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CoUnloadMonster()
	{
		((BPCommon)null).CoUnloadMonster();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RespawnCharacters()
	{
		((BPCommon)null).RespawnCharacters();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_Timeout()
	{
		float num = 0f;
		((BPCommon)null).Timeout(num);
		InstanceFunctionInvoker<BPCommon, float, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, float, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_BPCloseLoderView()
	{
		((BPCommon)null).BPCloseLoderView();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AwaitUIState()
	{
		UI_TYPE uI_TYPE = UI_TYPE.UI_NONE;
		UIViewState uIViewState = UIViewState.Load;
		((BPCommon)null).AwaitUIState(uI_TYPE, uIViewState);
		InstanceFunctionInvoker<BPCommon, UI_TYPE, UIViewState, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, UI_TYPE, UIViewState, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, uI_TYPE, uIViewState);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetCommonUIState()
	{
		UIMode uIMode = UIMode.MiniMapMode;
		bool flag = false;
		((BPCommon)null).SetCommonUIState(uIMode, flag);
		InstanceActionInvoker<BPCommon, UIMode, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, UIMode, bool>(null);
		instanceActionInvoker.Invoke(null, uIMode, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CheckAsideOverPlayed()
	{
		int num = 0;
		((BPCommon)null).CheckAsideOverPlayed(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AWaitKeyPoint()
	{
		int num = 0;
		((BPCommon)null).AWaitKeyPoint(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetBtnEffect()
	{
		InputKey inputKey = InputKey.regularAttack;
		bool flag = false;
		((BPCommon)null).SetBtnEffect(inputKey, flag);
		InstanceActionInvoker<BPCommon, InputKey, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, InputKey, bool>(null);
		instanceActionInvoker.Invoke(null, inputKey, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_PopPause()
	{
		((BPCommon)null).PopPause();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_PushPause()
	{
		((BPCommon)null).PushPause();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetGuideStepById()
	{
		int num = 0;
		((BPCommon)null).GetGuideStepById(num);
		InstanceFunctionInvoker<BPCommon, int, int> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, int>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_DisableChaseMissionPoint()
	{
		int num = 0;
		((BPMission)null).DisableChaseMissionPoint(num);
		InstanceActionInvoker<BPMission, int> instanceActionInvoker = new InstanceActionInvoker<BPMission, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_EnableChaseMissionPoint()
	{
		int num = 0;
		MapArea mapArea = MapArea.None;
		int num2 = 0;
		bool flag = false;
		((BPMission)null).EnableChaseMissionPoint(num, mapArea, num2, flag);
		InstanceActionInvoker<BPMission, int, MapArea, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPMission, int, MapArea, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, mapArea, num2, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void string_Equals()
	{
		string text = null;
		((string)null).Equals(text);
		InstanceFunctionInvoker<string, string, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<string, string, bool>(null);
		instanceFunctionInvoker.Invoke(null, text);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TaskSpawnMonster()
	{
		List<SpawnMonsterPoint> list = null;
		((BPCommon)null).TaskSpawnMonster(list);
		InstanceFunctionInvoker<BPCommon, List<SpawnMonsterPoint>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<SpawnMonsterPoint>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AwaitUIState()
	{
		UI_TYPE uI_TYPE = UI_TYPE.UI_NONE;
		UIViewState uIViewState = UIViewState.Load;
		((BPCommon)null).AwaitUIState(uI_TYPE, uIViewState);
		InstanceFunctionInvoker<BPCommon, UI_TYPE, UIViewState, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, UI_TYPE, UIViewState, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, uI_TYPE, uIViewState);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_OpenMissionTip()
	{
		int num = 0;
		float num2 = 0f;
		((BPCommon)null).OpenMissionTip(num, num2);
		InstanceActionInvoker<BPCommon, int, float> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, float>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CheckBluePrintBossHpPercent()
	{
		float num = 0f;
		int num2 = 0;
		Compare compare = Compare.Equal;
		((BPCommon)null).CheckBluePrintBossHpPercent(num, num2, compare);
		InstanceFunctionInvoker<BPCommon, float, int, Compare, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, float, int, Compare, bool>(null);
		instanceFunctionInvoker.Invoke(null, num, num2, compare);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckKeyPoint()
	{
		int num = 0;
		((BPCommon)null).CheckKeyPoint(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AddStateChangeEventListener()
	{
		List<InteractObjectState> list = null;
		((BPCommon)null).AddStateChangeEventListener(list);
		InstanceFunctionInvoker<BPCommon, List<InteractObjectState>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<InteractObjectState>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetInputActive()
	{
		InputKey inputKey = InputKey.regularAttack;
		bool flag = false;
		((BPCommon)null).SetInputActive(inputKey, flag);
		InstanceActionInvoker<BPCommon, InputKey, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, InputKey, bool>(null);
		instanceActionInvoker.Invoke(null, inputKey, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CloseGuideTip()
	{
		((BPCommon)null).CloseGuideTip();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SendTrackStringEvent()
	{
		string text = null;
		string text2 = null;
		string text3 = null;
		((BPCommon)null).SendTrackStringEvent(text, text2, text3);
		InstanceActionInvoker<BPCommon, string, string, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string, string, string>(null);
		instanceActionInvoker.Invoke(null, text, text2, text3);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_OpenGuideTip()
	{
		int num = 0;
		((BPCommon)null).OpenGuideTip(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_FinishCharacterTutorial()
	{
		((BPCommon)null).FinishCharacterTutorial();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartCharacterTutorial()
	{
		int num = 0;
		((BPCommon)null).StartCharacterTutorial(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartPromptProcess()
	{
		int num = 0;
		((BPCommon)null).StartPromptProcess(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_EnableFixedAreaMissionPoint()
	{
		Vector3 vector = default;
		MapArea mapArea = MapArea.None;
		int num = 0;
		bool flag = false;
		((BPMission)null).EnableFixedAreaMissionPoint(vector, mapArea, num, flag);
		InstanceActionInvoker<BPMission, Vector3, MapArea, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPMission, Vector3, MapArea, int, bool>(null);
		instanceActionInvoker.Invoke(null, vector, mapArea, num, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_DisableFixedAreaMissionPoint()
	{
		Vector3 vector = default;
		((BPMission)null).DisableFixedAreaMissionPoint(vector);
		InstanceActionInvoker<BPMission, Vector3> instanceActionInvoker = new InstanceActionInvoker<BPMission, Vector3>(null);
		instanceActionInvoker.Invoke(null, vector);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void string_Equals_0()
	{
		string text = null;
		string text2 = null;
		string.Equals(text, text2);
		StaticFunctionInvoker<string, string, bool> staticFunctionInvoker = new StaticFunctionInvoker<string, string, bool>(null);
		staticFunctionInvoker.Invoke(null, text, text2);
		staticFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AddStateChangeEventListener()
	{
		List<InteractObjectState> list = null;
		((BPCommon)null).AddStateChangeEventListener(list);
		InstanceFunctionInvoker<BPCommon, List<InteractObjectState>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<InteractObjectState>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetVCamPriority()
	{
		AreaCamera areaCamera = null;
		int num = 0;
		((BPCommon)null).SetVCamPriority(areaCamera, num);
		InstanceActionInvoker<BPCommon, AreaCamera, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, AreaCamera, int>(null);
		instanceActionInvoker.Invoke(null, areaCamera, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AWaitTimelineOverPlayed()
	{
		int num = 0;
		((BPCommon)null).AWaitTimelineOverPlayed(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_LockSystem()
	{
		int num = 0;
		bool flag = false;
		((BPCommon)null).LockSystem(num, flag);
		InstanceActionInvoker<BPCommon, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetSwitchCharacterBtnEffect()
	{
		SwitchCharacter switchCharacter = SwitchCharacter.switch1Character;
		bool flag = false;
		((BPCommon)null).SetSwitchCharacterBtnEffect(switchCharacter, flag);
		InstanceActionInvoker<BPCommon, SwitchCharacter, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, SwitchCharacter, bool>(null);
		instanceActionInvoker.Invoke(null, switchCharacter, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CheckKeyPoint()
	{
		int num = 0;
		((BPCommon)null).CheckKeyPoint(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AddCeceToBattleTeamForTutorial()
	{
		int num = 0;
		((BPCommon)null).AddCeceToBattleTeamForTutorial(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ForceChangeMainEntityMotion()
	{
		string text = null;
		((BPCommon)null).ForceChangeMainEntityMotion(text);
		InstanceActionInvoker<BPCommon, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string>(null);
		instanceActionInvoker.Invoke(null, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RuntimeDramaAside()
	{
		List<int> list = null;
		((BPCommon)null).RuntimeDramaAside(list);
		InstanceFunctionInvoker<BPCommon, List<int>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<int>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_GetCurrentWorldID()
	{
		((BPCommon)null).GetCurrentWorldID();
		InstanceFunctionInvoker<BPCommon, int> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AWaitKeyPoint()
	{
		int num = 0;
		((BPCommon)null).AWaitKeyPoint(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetInteractBtnEffect()
	{
		bool flag = false;
		((BPCommon)null).SetInteractBtnEffect(flag);
		InstanceActionInvoker<BPCommon, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CreateTriggerField()
	{
		string text = null;
		BoxCollider boxCollider = null;
		((BPCommon)null).CreateTriggerField(text, boxCollider);
		InstanceActionInvoker<BPCommon, string, BoxCollider> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string, BoxCollider>(null);
		instanceActionInvoker.Invoke(null, text, boxCollider);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_RuntimeDramaEntry()
	{
		List<int> list = null;
		((BPCommon)null).RuntimeDramaEntry(list);
		InstanceFunctionInvoker<BPCommon, List<int>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<int>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetInteractObjectState()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).GetInteractObjectState(num, num2);
		InstanceFunctionInvoker<BPCommon, int, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num, num2);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_EnableNPCMissionPoint()
	{
		int num = 0;
		MapArea mapArea = MapArea.None;
		int num2 = 0;
		bool flag = false;
		((BPMission)null).EnableNPCMissionPoint(num, mapArea, num2, flag);
		InstanceActionInvoker<BPMission, int, MapArea, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPMission, int, MapArea, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, mapArea, num2, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_DisableNPCAreaMissionPoint()
	{
		int num = 0;
		((BPMission)null).DisableNPCAreaMissionPoint(num);
		InstanceActionInvoker<BPMission, int> instanceActionInvoker = new InstanceActionInvoker<BPMission, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_IsInWorld()
	{
		int num = 0;
		((BPCommon)null).IsInWorld(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_OpenCharacterGetView()
	{
		int num = 0;
		((BPCommon)null).OpenCharacterGetView(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_OpenSystemUnlockUi()
	{
		int num = 0;
		((BPCommon)null).OpenSystemUnlockUi(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_GetRoleIsExistInBag()
	{
		int num = 0;
		((BPCommon)null).GetRoleIsExistInBag(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_DisableInteractObjectAreaMissionPoint()
	{
		int num = 0;
		((BPMission)null).DisableInteractObjectAreaMissionPoint(num);
		InstanceActionInvoker<BPMission, int> instanceActionInvoker = new InstanceActionInvoker<BPMission, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_EnableInteractObjectMissionPoint()
	{
		int num = 0;
		MapArea mapArea = MapArea.None;
		int num2 = 0;
		bool flag = false;
		((BPMission)null).EnableInteractObjectMissionPoint(num, mapArea, num2, flag);
		InstanceActionInvoker<BPMission, int, MapArea, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPMission, int, MapArea, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, mapArea, num2, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CPEnterRaid()
	{
		int num = 0;
		((BPCommon)null).CPEnterRaid(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_RaidIsComplete()
	{
		int num = 0;
		((BPCommon)null).RaidIsComplete(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetMissionPointState()
	{
		int num = 0;
		bool flag = false;
		((BPMission)null).SetMissionPointState(num, flag);
		InstanceActionInvoker<BPMission, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPMission, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartAbyssTime()
	{
		((BPCommon)null).StartAbyssTime();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AbyssComplete()
	{
		((BPCommon)null).AbyssComplete();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StopAbyssTime()
	{
		((BPCommon)null).StopAbyssTime();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RuntimeDramaEntry()
	{
		List<int> list = null;
		((BPCommon)null).RuntimeDramaEntry(list);
		InstanceFunctionInvoker<BPCommon, List<int>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<int>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_DisableFixedAreaMissionPoint_0()
	{
		GameObject gameObject = null;
		((BPMission)null).DisableFixedAreaMissionPoint(gameObject);
		InstanceActionInvoker<BPMission, GameObject> instanceActionInvoker = new InstanceActionInvoker<BPMission, GameObject>(null);
		instanceActionInvoker.Invoke(null, gameObject);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_EnableFixedAreaMissionPoint_0()
	{
		GameObject gameObject = null;
		MapArea mapArea = MapArea.None;
		int num = 0;
		bool flag = false;
		((BPMission)null).EnableFixedAreaMissionPoint(gameObject, mapArea, num, flag);
		InstanceActionInvoker<BPMission, GameObject, MapArea, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPMission, GameObject, MapArea, int, bool>(null);
		instanceActionInvoker.Invoke(null, gameObject, mapArea, num, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_IsMainEntity()
	{
		int num = 0;
		((BPCommon)null).IsMainEntity(num);
		InstanceFunctionInvoker<BPCommon, int, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_Transform_position()
	{
		_ = ((Transform)null).position;
		((Transform)null).position = default;
		InstancePropertyAccessor<Transform, Vector3> instancePropertyAccessor = new InstancePropertyAccessor<Transform, Vector3>(null);
		instancePropertyAccessor.GetValue(null);
		instancePropertyAccessor.SetValue(null, default(Vector3));
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetBlackScreenActive()
	{
		bool flag = false;
		((BPCommon)null).SetBlackScreenActive(flag);
		InstanceFunctionInvoker<BPCommon, bool, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, bool, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, flag);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_OpenMapView()
	{
		List<int> list = null;
		((BPCommon)null).OpenMapView(list);
		InstanceFunctionInvoker<BPCommon, List<int>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<int>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetCommonUIState()
	{
		UIMode uIMode = UIMode.MiniMapMode;
		bool flag = false;
		((BPCommon)null).SetCommonUIState(uIMode, flag);
		InstanceActionInvoker<BPCommon, UIMode, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, UIMode, bool>(null);
		instanceActionInvoker.Invoke(null, uIMode, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TryInteract()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).TryInteract(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_PauseInput()
	{
		bool flag = false;
		((BPCommon)null).PauseInput(flag);
		InstanceActionInvoker<BPCommon, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_OpenUIView()
	{
		UI_TYPE uI_TYPE = UI_TYPE.UI_NONE;
		((BPCommon)null).OpenUIView(uI_TYPE);
		InstanceFunctionInvoker<BPCommon, UI_TYPE, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, UI_TYPE, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, uI_TYPE);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TriggerCustomInteractEvent()
	{
		int num = 0;
		string text = null;
		((BPCommon)null).TriggerCustomInteractEvent(num, text);
		InstanceActionInvoker<BPCommon, int, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, string>(null);
		instanceActionInvoker.Invoke(null, num, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_IsPlayerAlive()
	{
		((BPCommon)null).IsPlayerAlive();
		InstanceFunctionInvoker<BPCommon, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, bool>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_OpenCharacterGetView()
	{
		int num = 0;
		((BPCommon)null).OpenCharacterGetView(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AddHitListener()
	{
		((BPCommon)null).AddHitListener();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RemoveHitListener()
	{
		((BPCommon)null).RemoveHitListener();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_StringAppend()
	{
		string text = null;
		string text2 = null;
		((BPCommon)null).StringAppend(text, text2);
		InstanceFunctionInvoker<BPCommon, string, string, string> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, string, string, string>(null);
		instanceFunctionInvoker.Invoke(null, text, text2);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AwaitUIHidden()
	{
		UI_TYPE uI_TYPE = UI_TYPE.UI_NONE;
		((BPCommon)null).AwaitUIHidden(uI_TYPE);
		InstanceFunctionInvoker<BPCommon, UI_TYPE, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, UI_TYPE, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, uI_TYPE);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SetConstZ()
	{
		float num = 0f;
		((BPCommon)null).SetConstZ(num);
		InstanceActionInvoker<BPCommon, float> instanceActionInvoker = new InstanceActionInvoker<BPCommon, float>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_LeaveRaid()
	{
		((BPCommon)null).LeaveRaid();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_CreateAirWall()
	{
		Vector3 vector = default;
		Bounds bounds = default;
		int num = 0;
		((BPCommon)null).CreateAirWall(vector, bounds, num);
		InstanceFunctionInvoker<BPCommon, Vector3, Bounds, int, GameObject> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, Vector3, Bounds, int, GameObject>(null);
		instanceFunctionInvoker.Invoke(null, vector, bounds, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_Bounds_ctor()
	{
		new Bounds(default, default);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_DestroyAirWall()
	{
		GameObject gameObject = null;
		((BPCommon)null).DestroyAirWall(gameObject);
		InstanceActionInvoker<BPCommon, GameObject> instanceActionInvoker = new InstanceActionInvoker<BPCommon, GameObject>(null);
		instanceActionInvoker.Invoke(null, gameObject);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_OpenQuestionnaire()
	{
		int num = 0;
		((BPCommon)null).OpenQuestionnaire(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AwaitInteractObjectState_0()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).AwaitInteractObjectState(num, num2);
		InstanceFunctionInvoker<BPCommon, int, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num, num2);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_EnterRaid()
	{
		int num = 0;
		((BPCommon)null).EnterRaid(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_GameObject_SetActive()
	{
		bool flag = false;
		((GameObject)null).SetActive(flag);
		InstanceActionInvoker<GameObject, bool> instanceActionInvoker = new InstanceActionInvoker<GameObject, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_AddRecommendEntries()
	{
		int num = 0;
		((BPMission)null).AddRecommendEntries(num);
		InstanceActionInvoker<BPMission, int> instanceActionInvoker = new InstanceActionInvoker<BPMission, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_Component_SendMessage()
	{
		string text = null;
		((Component)null).SendMessage(text);
		InstanceActionInvoker<Component, string> instanceActionInvoker = new InstanceActionInvoker<Component, string>(null);
		instanceActionInvoker.Invoke(null, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetCharacterId()
	{
		((BPCommon)null).GetCharacterId();
		InstanceFunctionInvoker<BPCommon, int> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_ResetBattleTeamForTutorial()
	{
		((BPCommon)null).ResetBattleTeamForTutorial();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SharedChangeStates()
	{
		List<InteractObjectState> list = null;
		((BPCommon)null).SharedChangeStates(list);
		InstanceActionInvoker<BPCommon, List<InteractObjectState>> instanceActionInvoker = new InstanceActionInvoker<BPCommon, List<InteractObjectState>>(null);
		instanceActionInvoker.Invoke(null, list);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckAbyssMonsterCanLoaded()
	{
		InteractObjectState[] array = null;
		((BPCommon)null).CheckAbyssMonsterCanLoaded(array);
		InstanceFunctionInvoker<BPCommon, InteractObjectState[], bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, InteractObjectState[], bool>(null);
		object[] args = array;
		instanceFunctionInvoker.Invoke(null, args);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RaidComplete()
	{
		((BPCommon)null).RaidComplete();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_GameObject_Destroy()
	{
		Object obj = null;
		Object.Destroy(obj);
		StaticActionInvoker<Object> staticActionInvoker = new StaticActionInvoker<Object>(null);
		staticActionInvoker.Invoke(null, obj);
		staticActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TriggerTutorial()
	{
		int num = 0;
		int num2 = 0;
		bool flag = false;
		((BPCommon)null).TriggerTutorial(num, num2, flag);
		InstanceActionInvoker<BPCommon, int, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int, bool>(null);
		instanceActionInvoker.Invoke(null, num, num2, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetBigWorldProgress()
	{
		LocalizeStringEvent localizeStringEvent = null;
		string text = null;
		((BPCommon)null).SetBigWorldProgress(localizeStringEvent, text);
		InstanceActionInvoker<BPCommon, LocalizeStringEvent, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, LocalizeStringEvent, string>(null);
		instanceActionInvoker.Invoke(null, localizeStringEvent, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SendFinishBigWorld()
	{
		bool flag = false;
		((BPCommon)null).SendFinishBigWorld(flag);
		InstanceActionInvoker<BPCommon, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, bool>(null);
		instanceActionInvoker.Invoke(null, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SendBigWorldFail()
	{
		((BPCommon)null).SendBigWorldFail();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SendBigWordTimeEvent()
	{
		ACT.Event.EventType eventType = (ACT.Event.EventType)0;
		float num = 0f;
		float num2 = 0f;
		((BPCommon)null).SendBigWordTimeEvent(eventType, num, num2);
		InstanceActionInvoker<BPCommon, ACT.Event.EventType, float, float> instanceActionInvoker = new InstanceActionInvoker<BPCommon, ACT.Event.EventType, float, float>(null);
		instanceActionInvoker.Invoke(null, eventType, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetBigWorldProgressTitle()
	{
		List<LocalizeStringEvent> list = null;
		((BPCommon)null).SetBigWorldProgressTitle(list);
		InstanceActionInvoker<BPCommon, List<LocalizeStringEvent>> instanceActionInvoker = new InstanceActionInvoker<BPCommon, List<LocalizeStringEvent>>(null);
		instanceActionInvoker.Invoke(null, list);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SendBigWorldSuccess()
	{
		((BPCommon)null).SendBigWorldSuccess();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_TaskSpawnMonster_0()
	{
		List<SpawnMonsterParams> list = null;
		((BPCommon)null).TaskSpawnMonster(list);
		InstanceFunctionInvoker<BPCommon, List<SpawnMonsterParams>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<SpawnMonsterParams>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ShowBattlePrompts()
	{
		List<LocalizeStringEvent> list = null;
		((BPCommon)null).ShowBattlePrompts(list);
		InstanceActionInvoker<BPCommon, List<LocalizeStringEvent>> instanceActionInvoker = new InstanceActionInvoker<BPCommon, List<LocalizeStringEvent>>(null);
		instanceActionInvoker.Invoke(null, list);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ChangeBigWorldTitleProgress()
	{
		LocalizeStringEvent localizeStringEvent = null;
		string text = null;
		((BPCommon)null).ChangeBigWorldTitleProgress(localizeStringEvent, text);
		InstanceActionInvoker<BPCommon, LocalizeStringEvent, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, LocalizeStringEvent, string>(null);
		instanceActionInvoker.Invoke(null, localizeStringEvent, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TaskSpawnMonster_0()
	{
		List<SpawnMonsterParams> list = null;
		((BPCommon)null).TaskSpawnMonster(list);
		InstanceFunctionInvoker<BPCommon, List<SpawnMonsterParams>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<SpawnMonsterParams>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TeamAttackCharging()
	{
		float num = 0f;
		((BPCommon)null).TeamAttackCharging(num);
		InstanceActionInvoker<BPCommon, float> instanceActionInvoker = new InstanceActionInvoker<BPCommon, float>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ResetSpecialSKillCd()
	{
		((BPCommon)null).ResetSpecialSKillCd();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_DispatchEnemyDieEvent()
	{
		((BPCommon)null).DispatchEnemyDieEvent();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TeamAttackSpecialCharging()
	{
		float num = 0f;
		((BPCommon)null).TeamAttackSpecialCharging(num);
		InstanceActionInvoker<BPCommon, float> instanceActionInvoker = new InstanceActionInvoker<BPCommon, float>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetMainEntity()
	{
		((BPCommon)null).GetMainEntity();
		InstanceFunctionInvoker<BPCommon, Entity> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, Entity>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RemoveBuff()
	{
		EntityReference entityReference = default;
		string[] array = null;
		((BPCommon)null).RemoveBuff(entityReference, array);
		InstanceActionInvoker<BPCommon, EntityReference, string[]> instanceActionInvoker = new InstanceActionInvoker<BPCommon, EntityReference, string[]>(null);
		instanceActionInvoker.Invoke(null, entityReference, array);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetCharacterSpecialEnergyMaxWithTypeAndParamName()
	{
		int num = 0;
		object obj = null;
		string text = null;
		((BPCommon)null).SetCharacterSpecialEnergyMaxWithTypeAndParamName(num, obj, text);
		InstanceActionInvoker<BPCommon, int, object, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, object, string>(null);
		instanceActionInvoker.Invoke(null, num, obj, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetCharacterSpecialEnergyMax()
	{
		int num = 0;
		((BPCommon)null).SetCharacterSpecialEnergyMax(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_FinishCheckMonsterDie()
	{
		((BPCommon)null).FinishCheckMonsterDie();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartCheckMonsterDie()
	{
		((BPCommon)null).StartCheckMonsterDie();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_FinishCheckMonsterWeak()
	{
		((BPCommon)null).FinishCheckMonsterWeak();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_DispatchEnemyWeakEvent()
	{
		((BPCommon)null).DispatchEnemyWeakEvent();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CoWaitMonsterWeak()
	{
		((BPCommon)null).CoWaitMonsterWeak();
		InstanceFunctionInvoker<BPCommon, IEnumerator> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, IEnumerator>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartCheckMonsterWeak()
	{
		((BPCommon)null).StartCheckMonsterWeak();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetMonsterAllWeakEvtName()
	{
		((BPCommon)null).GetMonsterAllWeakEvtName();
		InstanceFunctionInvoker<BPCommon, string> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, string>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetMonsterAllDieEvtName()
	{
		((BPCommon)null).GetMonsterAllDieEvtName();
		InstanceFunctionInvoker<BPCommon, string> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, string>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetItemCostTips()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).SetItemCostTips(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckItemByIdInBag()
	{
		int num = 0;
		((BPCommon)null).CheckItemByIdInBag(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RuntimeDialogue()
	{
		int num = 0;
		((BPCommon)null).RuntimeDialogue(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_LoaderTp()
	{
		int num = 0;
		Vector3 vector = default;
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		((BPCommon)null).LoaderTp(num, vector, flag, flag2, flag3);
		InstanceFunctionInvoker<BPCommon, int, Vector3, bool, bool, bool, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, Vector3, bool, bool, bool, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num, vector, flag, flag2, flag3);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckTimelineOverPlayed()
	{
		int num = 0;
		((BPCommon)null).CheckTimelineOverPlayed(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetActiveAreaCamera()
	{
		AreaCamera areaCamera = null;
		bool flag = false;
		((BPCommon)null).SetActiveAreaCamera(areaCamera, flag);
		InstanceActionInvoker<BPCommon, AreaCamera, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, AreaCamera, bool>(null);
		instanceActionInvoker.Invoke(null, areaCamera, flag);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_RunTimeDramaTimeline()
	{
		int num = 0;
		((BPCommon)null).RunTimeDramaTimeline(num);
		InstanceFunctionInvoker<BPCommon, int, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ForbidCreateMonsterUntilUnload()
	{
		int num = 0;
		((BPCommon)null).ForbidCreateMonsterUntilUnload(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_PureBlackScreenTp()
	{
		Vector3 vector = default;
		bool flag = false;
		bool flag2 = false;
		int num = 0;
		bool flag3 = false;
		((BPCommon)null).PureBlackScreenTp(vector, flag, flag2, num, flag3);
		InstanceActionInvoker<BPCommon, Vector3, bool, bool, int, bool> instanceActionInvoker = new InstanceActionInvoker<BPCommon, Vector3, bool, bool, int, bool>(null);
		instanceActionInvoker.Invoke(null, vector, flag, flag2, num, flag3);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void int_Equals_0()
	{
		int num = 0;
		object obj = null;
		num.Equals(obj);
		ReflectionInvoker reflectionInvoker = new ReflectionInvoker(null);
		reflectionInvoker.Invoke(0, obj);
		reflectionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_DeSpawnAssistNpc()
	{
		int num = 0;
		((BPCommon)null).DeSpawnAssistNpc(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_AssistNpcHelpFinish()
	{
		int num = 0;
		((BPCommon)null).AssistNpcHelpFinish(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_IsSubMissionRunning()
	{
		int num = 0;
		((BPCommon)null).IsSubMissionRunning(num);
		InstanceFunctionInvoker<BPCommon, int, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int, bool>(null);
		instanceFunctionInvoker.Invoke(null, num);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_SendGlobalBattleEvent()
	{
		string text = null;
		((BPCommon)null).SendGlobalBattleEvent(text);
		InstanceActionInvoker<BPCommon, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string>(null);
		instanceActionInvoker.Invoke(null, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TriggerCustomInteractEvent()
	{
		int num = 0;
		string text = null;
		((BPCommon)null).TriggerCustomInteractEvent(num, text);
		InstanceActionInvoker<BPCommon, int, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, string>(null);
		instanceActionInvoker.Invoke(null, num, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_runtimeDramaConversation()
	{
		List<int> list = null;
		((BPCommon)null).runtimeDramaConversation(list);
		InstanceFunctionInvoker<BPCommon, List<int>, UniTask> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, List<int>, UniTask>(null);
		instanceFunctionInvoker.Invoke(null, list);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_IsPlayerAlive()
	{
		((BPCommon)null).IsPlayerAlive();
		InstanceFunctionInvoker<BPCommon, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, bool>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_ChangeControllerState()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).ChangeControllerState(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetSpawnPos()
	{
		Vector3 vector = default;
		int num = 0;
		((BPCommon)null).SetSpawnPos(vector, num);
		InstanceActionInvoker<BPCommon, Vector3, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, Vector3, int>(null);
		instanceActionInvoker.Invoke(null, vector, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPMission_GetMainEntity()
	{
		((BPCommon)null).GetMainEntity();
		InstanceFunctionInvoker<BPCommon, Entity> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, Entity>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ResetSkillCD()
	{
		string text = null;
		((BPCommon)null).ResetSkillCD(text);
		InstanceActionInvoker<BPCommon, string> instanceActionInvoker = new InstanceActionInvoker<BPCommon, string>(null);
		instanceActionInvoker.Invoke(null, text);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetRaidReward()
	{
		int num = 0;
		((BPCommon)null).GetRaidReward(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StopTeamTeachingTime()
	{
		((BPCommon)null).StopTeamTeachingTime();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartTeamTeachingTime()
	{
		((BPCommon)null).StartTeamTeachingTime();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetRaidZoomLevel()
	{
		((BPCommon)null).GetRaidZoomLevel();
		InstanceFunctionInvoker<BPCommon, int> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, int>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_FinishCharacterTrial()
	{
		((BPCommon)null).FinishCharacterTrial();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SentRogueRoomChallengeEnd()
	{
		((BPCommon)null).SentRogueRoomChallengeEnd();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckRogueRoomIsFinshed()
	{
		((BPCommon)null).CheckRogueRoomIsFinshed();
		InstanceFunctionInvoker<BPCommon, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, bool>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TeamChallengeComplete()
	{
		((BPCommon)null).TeamChallengeComplete();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_FinishCharacterTeamTutorial()
	{
		((BPCommon)null).FinishCharacterTeamTutorial();
		InstanceActionInvoker<BPCommon> instanceActionInvoker = new InstanceActionInvoker<BPCommon>(null);
		instanceActionInvoker.Invoke(null);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartCharacterTeamPromptProcess()
	{
		int num = 0;
		((BPCommon)null).StartCharacterTeamPromptProcess(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_StartCharacterTeamTutorial()
	{
		int num = 0;
		((BPCommon)null).StartCharacterTeamTutorial(num);
		InstanceActionInvoker<BPCommon, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int>(null);
		instanceActionInvoker.Invoke(null, num);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckRaidMonsterCanLoaded()
	{
		InteractObjectState[] array = null;
		((BPCommon)null).CheckRaidMonsterCanLoaded(array);
		InstanceFunctionInvoker<BPCommon, InteractObjectState[], bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, InteractObjectState[], bool>(null);
		object[] args = array;
		instanceFunctionInvoker.Invoke(null, args);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_TryInteract()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).TryInteract(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ChangeStandardElevatorLayer()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).ChangeStandardElevatorLayer(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_GetLastSpawnMonster()
	{
		((BPCommon)null).GetLastSpawnMonster();
		InstanceFunctionInvoker<BPCommon, Entity> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, Entity>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_ShowRaidOpenTip()
	{
		int num = 0;
		int num2 = 0;
		((BPCommon)null).ShowRaidOpenTip(num, num2);
		InstanceActionInvoker<BPCommon, int, int> instanceActionInvoker = new InstanceActionInvoker<BPCommon, int, int>(null);
		instanceActionInvoker.Invoke(null, num, num2);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_SetChaseBattleSpawnPosition()
	{
		Vector3 vector = default;
		((BPCommon)null).SetChaseBattleSpawnPosition(vector);
		InstanceActionInvoker<BPCommon, Vector3> instanceActionInvoker = new InstanceActionInvoker<BPCommon, Vector3>(null);
		instanceActionInvoker.Invoke(null, vector);
		instanceActionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckMainEntityCanDodgeGuide()
	{
		((BPCommon)null).CheckMainEntityCanDodgeGuide();
		InstanceFunctionInvoker<BPCommon, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, bool>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void ACT_BluePrint_BPCommon_CheckMainEntityCanDodgeAttackGuide()
	{
		((BPCommon)null).CheckMainEntityCanDodgeAttackGuide();
		InstanceFunctionInvoker<BPCommon, bool> instanceFunctionInvoker = new InstanceFunctionInvoker<BPCommon, bool>(null);
		instanceFunctionInvoker.Invoke(null);
		instanceFunctionInvoker.Invoke(null);
	}

	[Preserve]
	public static void UnityEngine_BoxCollider_ctor()
	{
		new BoxCollider();
	}

	[Preserve]
	public static void UnityEngine_GameObject_ctor()
	{
		new GameObject();
	}

	[Preserve]
	public static void System_Collections_Generic_List_ACT_BluePrint_SpawnMonsterPoint_ctor()
	{
		new List<SpawnMonsterPoint>();
	}

	[Preserve]
	public static void ACT_Battle_AreaCamera_ctor()
	{
		new AreaCamera();
	}

	[Preserve]
	public static void System_Collections_Generic_List_ACT_BluePrint_InteractObjectState_ctor()
	{
		new List<InteractObjectState>();
	}

	[Preserve]
	public static void System_Collections_Generic_List_int_ctor()
	{
		new List<int>();
	}

	[Preserve]
	public static void object_ctor()
	{
		new object();
	}

	[Preserve]
	public static void ACT_BluePrint_InteractObjectState_ctor()
	{
		new InteractObjectState();
	}

	[Preserve]
	public static void System_Collections_Generic_List_ACT_BluePrint_AreaCameraParams_ctor()
	{
		new List<AreaCameraParams>();
	}

	[Preserve]
	public static void UnityEngine_Object_ctor()
	{
		new Object();
	}

	[Preserve]
	public static void ACT_Battle_MonoGuideRoomField_ctor()
	{
		new MonoGuideRoomField();
	}

	[Preserve]
	public static void UnityEngine_Localization_Components_LocalizeStringEvent_ctor()
	{
		new LocalizeStringEvent();
	}

	[Preserve]
	public static void System_Collections_Generic_List_UnityEngine_Localization_Components_LocalizeStringEvent_ctor()
	{
		new List<LocalizeStringEvent>();
	}

	[Preserve]
	public static void ACT_BluePrint_SpawnMonsterPoint_ctor()
	{
		new SpawnMonsterPoint();
	}
}
