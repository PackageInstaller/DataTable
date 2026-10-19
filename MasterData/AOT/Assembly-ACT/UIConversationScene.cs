using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading;
using ACT;
using ACT.Battle;
using ACT.Conversation;
using ACT.Core;
using ACT.DialogueSystem;
using ACT.LipSync;
using ACT.Rendering;
using ACT.UI;
using ACT.Utility;
using ACT.VolumeControl;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using DG.Tweening.Core.Easing;
using Fundamental;
using RootMotion.FinalIK;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class UIConversationScene : BaseUIScene
{
	[Serializable]
	public class ActorsPointConfig
	{
		public int configId;

		public string configName;

		[Header("Y保持为0就行")]
		public ActorPointConfig[] points = new ActorPointConfig[3];
	}

	[Serializable]
	public struct ActorPointConfig
	{
		public Vector3 position;

		public Vector3 rotation;

		public float scale;
	}

	public enum StageActorLookAtType
	{
		[InspectorName("保持")]
		Keep,
		[InspectorName("默认")]
		Default,
		Camera,
		Actor1,
		Actor2,
		Actor3,
		Actor4
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct StageData
	{
	}

	public class ActorInfo
	{
		public int id;

		public int index;

		public int lipSyncSpeakerId;

		public GameObject gameObject;

		public Transform transform;

		public Animator animator;

		public Dissolve2Control dissolve2Control;

		public DialogueCharacter dialogueCharacter;

		public string currentBodyAnimName = "idle";

		public StageActorLookAtType lookAtType;

		public bool hasPositionTarget;

		public Vector3 targetLocalPosition;

		public Quaternion targetLocalRotation;

		public Vector3 targetLocalScale;

		public StageActorState stageActorState;

		public bool usable;

		public ActorInfo(int id)
		{
			this.id = id;
		}

		public void Reset()
		{
		}
	}

	private sealed class DepthOfFieldEffect
	{
		public string Name;

		public float FarStart;

		public float FarEnd;

		public Tweener Tweener;

		public AssetLoadHandle Handle;

		public GameObject Instance;

		public Volume Volume;

		public TemporalDepthOfField Override;
	}

	public enum DepthOfFieldMode
	{
		None,
		Bg,
		Roles
	}

	public enum BgMotionEase
	{
		[InspectorName("匀速")]
		Linear,
		[InspectorName("慢到快")]
		InCubic,
		[InspectorName("快到慢")]
		OutCubic
	}

	private List<ActorInfo> m_UnloadingActors = new List<ActorInfo>();

	private ConversationSceneDefaultBg m_DefaultBg;

	private ConversationSceneDefaultBg m_DefaultsSceneBg;

	private ConversationSceneDefaultBg m_Mask;

	private LinkedList<ConversationSceneBg> m_CurrentBgs = new LinkedList<ConversationSceneBg>();

	private List<ConversationSceneBg> m_HidingBgs = new List<ConversationSceneBg>();

	public GameObject characters;

	public float bgBaseZ = 25f;

	public float bgStepZ = 1f;

	[Header("背景")]
	public MeshRenderer defaultBg;

	public MeshRenderer defaultSceneBg;

	public MeshRenderer bg;

	public Transform spineBgParent;

	public MeshRenderer mask;

	[Header("效果")]
	public Animation redWarning;

	public GameObject whiteFlash;

	public GameObject fog;

	public GameObject sparkle;

	[Header("站位")]
	public float[] footOffset = new float[3];

	public ActorsPointConfig[] actorsPointConfigs = new ActorsPointConfig[3];

	[Header("站位移动")]
	public float actorPositionTweenDuration = 0.2f;

	public AnimationCurve actorPositionTweenCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	private float m_BaseFov;

	private Vector3 m_BaseCameraLocalPosition;

	private Vector3 m_BaseCameraPosition;

	private Quaternion m_BaseCameraRotation;

	private float m_BaseActorBottomY;

	private Vector2Int m_BaseActorScreenSize;

	private bool m_Pause;

	private int m_StageMode = 1;

	private Dictionary<int, ActorInfo> m_ActorDict = new Dictionary<int, ActorInfo>();

	private Dictionary<int, ActorInfo> m_ActorDictByIndex = new Dictionary<int, ActorInfo>();

	private bool m_MainBattleRestoredForTransition;

	private const string DepthOfFieldAssetKey = "DepthOfField_AVG";

	private const float EnabledDepthOfFieldBlurIntensity = 3.5f;

	private readonly DepthOfFieldEffect m_RolesDepthOfField = new DepthOfFieldEffect
	{
		Name = "DepthOfField_Roles",
		FarStart = 0.6f,
		FarEnd = 1f
	};

	private readonly DepthOfFieldEffect m_BgDepthOfField = new DepthOfFieldEffect
	{
		Name = "DepthOfField_Bg",
		FarStart = 6.6f,
		FarEnd = 7f
	};

	private int m_effectId = -1;

	private GameObject m_effect;

	private static readonly int BaseColorId = Shader.PropertyToID("_BaseColor");

	private Tweener m_BgMaskTweener;

	private MaterialPropertyBlock m_BgMaskPropertyBlock;

	private Color m_BgMaskColor;

	private bool m_HasBgMaskColor;

	private Tweener m_BgMotionTweener;

	private Tweener m_CameraMotionTweener;

	private Vector2 m_CameraPivotOffset;

	private Tweener m_BgShakeTweener;

	public static UIConversationScene Instance => Singleton<UISceneManager>.instance.GetScene<UIConversationScene>();

	public bool TryGetActorHeadTransform(int actorIndex, out Transform headTransform)
	{
		headTransform = null;
		if (!m_ActorDictByIndex.TryGetValue(actorIndex, out var value) || value.dialogueCharacter == null)
		{
			return false;
		}
		headTransform = value.dialogueCharacter.head;
		return headTransform != null;
	}

	private void SetActorPosition(ActorInfo actorInfo, StageActorState stageActorState, bool immediate = false)
	{
		if (actorInfo == null || !actorInfo.transform)
		{
			return;
		}
		ActorPointConfig point = GetPoint(actorInfo.index);
		Vector3 position = point.position;
		position.y += m_BaseActorBottomY;
		if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(actorInfo.id, out var value))
		{
			position.y += footOffset[value.bodySize];
		}
		position += stageActorState.positionOffset;
		Quaternion quaternion = Quaternion.Euler(point.rotation);
		quaternion *= Quaternion.Euler(new Vector3(0f, stageActorState.rotationYOffset, 0f));
		Vector3 vector = Vector3.one * point.scale;
		vector *= 1f + stageActorState.scaleOffset;
		Transform transform = actorInfo.transform;
		if (immediate)
		{
			DOTween.Kill(actorInfo);
			transform.localPosition = position;
			transform.localRotation = quaternion;
			transform.localScale = vector;
			actorInfo.hasPositionTarget = true;
			actorInfo.targetLocalPosition = position;
			actorInfo.targetLocalRotation = quaternion;
			actorInfo.targetLocalScale = vector;
		}
		else if (!actorInfo.hasPositionTarget || !(actorInfo.targetLocalPosition == position) || !(actorInfo.targetLocalRotation == quaternion) || !(actorInfo.targetLocalScale == vector))
		{
			DOTween.Kill(actorInfo);
			actorInfo.hasPositionTarget = true;
			actorInfo.targetLocalPosition = position;
			actorInfo.targetLocalRotation = quaternion;
			actorInfo.targetLocalScale = vector;
			transform.DOLocalMove(position, actorPositionTweenDuration).SetEase(actorPositionTweenCurve).SetId(actorInfo);
			transform.DOLocalRotateQuaternion(quaternion, actorPositionTweenDuration).SetEase(actorPositionTweenCurve).SetId(actorInfo);
			transform.DOScale(vector, actorPositionTweenDuration).SetEase(actorPositionTweenCurve).SetId(actorInfo);
			if (m_Pause)
			{
				DOTween.Pause(actorInfo);
			}
		}
	}

	private void LateUpdateActors()
	{
		if (!m_Pause)
		{
			foreach (ActorInfo value in m_ActorDict.Values)
			{
				if (!value.gameObject || !value.dialogueCharacter || !value.dialogueCharacter.headIK)
				{
					continue;
				}
				LookAtIK headIK = value.dialogueCharacter.headIK;
				bool flag = false;
				Vector3 vector = headIK.solver.IKPosition;
				Vector3 iKPosition = headIK.solver.IKPosition;
				switch (value.lookAtType)
				{
				case StageActorLookAtType.Default:
					vector = Vector3.zero;
					break;
				case StageActorLookAtType.Camera:
					flag = true;
					vector = uiSceneCamera.transform.position;
					break;
				case StageActorLookAtType.Actor1:
				case StageActorLookAtType.Actor2:
				case StageActorLookAtType.Actor3:
				case StageActorLookAtType.Actor4:
				{
					int num = 0;
					switch (value.lookAtType)
					{
					case StageActorLookAtType.Actor1:
						num = 0;
						break;
					case StageActorLookAtType.Actor2:
						num = 1;
						break;
					case StageActorLookAtType.Actor3:
						num = 2;
						break;
					case StageActorLookAtType.Actor4:
						num = 3;
						break;
					}
					if (num == value.index)
					{
						flag = false;
						vector = Vector3.zero;
						break;
					}
					ActorInfo valueOrDefault = m_ActorDictByIndex.GetValueOrDefault(num);
					if (valueOrDefault == null)
					{
						flag = false;
						vector = Vector3.zero;
					}
					else if (valueOrDefault.dialogueCharacter == null)
					{
						flag = false;
						vector = Vector3.zero;
					}
					else if (valueOrDefault.dialogueCharacter == null)
					{
						flag = false;
						vector = Vector3.zero;
					}
					else if (valueOrDefault.dialogueCharacter.head == null)
					{
						flag = false;
						vector = Vector3.zero;
					}
					else
					{
						flag = true;
						vector = valueOrDefault.dialogueCharacter.head.position + new Vector3(0f, 0.15f, 0f);
					}
					break;
				}
				}
				if (flag)
				{
					headIK.solver.StoreDefaultLocalState();
					if (headIK.solver.IKPositionWeight == 0f)
					{
						headIK.solver.SetIKPosition(vector);
					}
					else
					{
						Vector3 iKPosition2 = Vector3.MoveTowards(iKPosition, vector, Time.deltaTime * 5f);
						headIK.solver.SetIKPosition(iKPosition2);
					}
					float lookAtWeight = Mathf.MoveTowards(headIK.solver.IKPositionWeight, 1f, Time.deltaTime * 2f);
					headIK.solver.SetLookAtWeight(lookAtWeight);
				}
				else
				{
					float lookAtWeight2 = Mathf.MoveTowards(headIK.solver.IKPositionWeight, 0f, Time.deltaTime * 2f);
					headIK.solver.SetLookAtWeight(lookAtWeight2);
					if (headIK.solver.IKPositionWeight == 0f)
					{
						headIK.solver.StoreDefaultLocalState();
					}
				}
			}
		}
		foreach (KeyValuePair<int, ActorInfo> item in m_ActorDict)
		{
			item.Value.dialogueCharacter?.headIK?.solver?.IKUpdate();
		}
		foreach (ActorInfo unloadingActor in m_UnloadingActors)
		{
			unloadingActor.dialogueCharacter?.headIK?.solver?.IKUpdate();
		}
	}

	private void PauseActors()
	{
		foreach (ActorInfo value in m_ActorDict.Values)
		{
			if ((bool)value.animator)
			{
				value.animator.speed = 0f;
			}
			DOTween.Pause(value);
		}
	}

	private void ResumeActors()
	{
		foreach (ActorInfo value in m_ActorDict.Values)
		{
			if ((bool)value.animator)
			{
				value.animator.speed = 1f;
			}
			DOTween.Play(value);
		}
	}

	public async UniTask HideAllActorsAsync(CancellationToken token)
	{
		List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
		ActorInfo[] array = m_ActorDict.Values.ToArray();
		foreach (ActorInfo actorInfo in array)
		{
			m_ActorDict.Remove(actorInfo.id);
			m_ActorDictByIndex.Remove(actorInfo.index);
			tasks.Add(UnloadActor(actorInfo, token));
		}
		await UniTask.WhenAll(tasks).SuppressCancellationThrow();
		CollectionPool<List<UniTask>, UniTask>.Release(tasks);
	}

	public void RestoreMainBattleForTransition()
	{
		if (!m_MainBattleRestoredForTransition)
		{
			m_MainBattleRestoredForTransition = true;
			GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
			MonoECS.instance.PopPause();
			GameUtility.mainCamera?.gameObject.SetActive(value: true);
			(uiSceneCamera?.GetUniversalAdditionalCameraData())?.cameraStack.Remove(GameUtility.uiCamera);
			gameObject.SetActive(value: false);
		}
	}

	public async UniTask ActorsTask(int stageMode, StageActorState[] stageActorStates, CancellationToken token)
	{
		if (stageMode > 0)
		{
			m_StageMode = stageMode;
		}
		int stageActorCount = actorsPointConfigs[m_StageMode].points.Length;
		foreach (ActorInfo value4 in m_ActorDict.Values)
		{
			value4.usable = false;
		}
		for (int i = 0; i < stageActorCount; i++)
		{
			StageActorState stageActorState = stageActorStates[i];
			if (stageActorState.actor != 0 && m_ActorDict.TryGetValue(stageActorState.actor, out var value))
			{
				value.usable = true;
			}
		}
		List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
		ActorInfo[] array = m_ActorDict.Values.ToArray();
		foreach (ActorInfo actorInfo in array)
		{
			if (!actorInfo.usable)
			{
				m_ActorDict.Remove(actorInfo.id);
				m_ActorDictByIndex.Remove(actorInfo.index);
				tasks.Add(UnloadActor(actorInfo, token));
			}
		}
		await UniTask.WhenAll(tasks);
		tasks.Clear();
		if (token.IsCancellationRequested)
		{
			return;
		}
		for (int k = 0; k < stageActorCount; k++)
		{
			StageActorState stageActorState2 = stageActorStates[k];
			if (stageActorState2.actor != 0)
			{
				if (!m_ActorDict.TryGetValue(stageActorState2.actor, out var value2))
				{
					value2 = new ActorInfo(stageActorState2.actor);
					value2.index = k;
					m_ActorDict.Add(stageActorState2.actor, value2);
					tasks.Add(LoadActor(value2, stageActorState2));
				}
				else
				{
					value2.index = k;
				}
				value2.stageActorState = stageActorState2;
			}
		}
		m_ActorDictByIndex.Clear();
		foreach (ActorInfo value5 in m_ActorDict.Values)
		{
			m_ActorDictByIndex.Add(value5.index, value5);
		}
		await UniTask.WhenAll(tasks);
		tasks.Clear();
		if (token.IsCancellationRequested)
		{
			return;
		}
		CollectionPool<List<UniTask>, UniTask>.Release(tasks);
		foreach (ActorInfo value6 in m_ActorDict.Values)
		{
			SetActorPosition(value6, stageActorStates[value6.index]);
		}
		for (int l = 0; l < stageActorCount; l++)
		{
			StageActorState stageActorState3 = stageActorStates[l];
			if (stageActorState3.actor == 0 || !m_ActorDict.TryGetValue(stageActorState3.actor, out var value3))
			{
				continue;
			}
			value3.lookAtType = stageActorState3.lookAtType;
			string actorAnimName = stageActorState3.actorAnimName;
			string text = stageActorState3.actorFaceName;
			string currentBodyAnimName = value3.currentBodyAnimName;
			string currentBodyAnimName2 = (string.IsNullOrEmpty(actorAnimName) ? currentBodyAnimName : actorAnimName);
			actorAnimName = (value3.currentBodyAnimName = currentBodyAnimName2);
			if (!value3.animator)
			{
				continue;
			}
			AnimatorClipInfo[] currentAnimatorClipInfo = value3.animator.GetCurrentAnimatorClipInfo(0);
			bool flag = false;
			AnimatorClipInfo[] array2 = currentAnimatorClipInfo;
			foreach (AnimatorClipInfo animatorClipInfo in array2)
			{
				flag = animatorClipInfo.clip.name.Contains("idle");
				if (flag)
				{
					break;
				}
			}
			value3.animator.SetBool("inIdle", flag);
			string trigger = "body_" + actorAnimName;
			if (value3.currentBodyAnimName != currentBodyAnimName)
			{
				if (value3.currentBodyAnimName == "idle")
				{
					value3.animator?.SetTrigger("body_" + currentBodyAnimName + "_end");
				}
				else
				{
					value3.animator?.SetTrigger(trigger);
				}
			}
			if (string.IsNullOrEmpty(text))
			{
				text = LuminDialogueFlowProcessor.GetFaceSpecialStateName(value3.id, actorAnimName);
			}
			string text2 = "face_" + text;
			AnimatorControllerParameter[] parameters = value3.animator.parameters;
			foreach (AnimatorControllerParameter animatorControllerParameter in parameters)
			{
				if (animatorControllerParameter.name.StartsWith("face") && animatorControllerParameter.type == AnimatorControllerParameterType.Bool)
				{
					value3.animator?.SetBool(animatorControllerParameter.name, animatorControllerParameter.name == text2);
				}
			}
		}
	}

	public void RegisterLipSyncBySpeaker(int speakerId)
	{
		if (speakerId <= 0 || !TryGetSpeakerLipSyncActor(speakerId, out var actorInfo))
		{
			return;
		}
		NewFMODLipSyncBakeDataPlayer component = actorInfo.gameObject.GetComponent<NewFMODLipSyncBakeDataPlayer>();
		if ((bool)component && actorInfo.lipSyncSpeakerId != speakerId)
		{
			UnregisterSpeakerLipSyncAlias(actorInfo);
			if (actorInfo.id != speakerId)
			{
				Singleton<ULipSyncManager>.instance.RegisterCharacter(speakerId, component);
			}
			actorInfo.lipSyncSpeakerId = speakerId;
		}
	}

	private bool TryGetSpeakerLipSyncActor(int speakerId, out ActorInfo actorInfo)
	{
		actorInfo = null;
		if (m_ActorDict.TryGetValue(speakerId, out var value) && value != null && (bool)value.gameObject)
		{
			actorInfo = value;
			return true;
		}
		if (RuntimeConfigs.data == null || !RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(speakerId, out var value2) || string.IsNullOrEmpty(value2.model))
		{
			return false;
		}
		foreach (ActorInfo value4 in m_ActorDict.Values)
		{
			if (value4 != null && (bool)value4.gameObject && RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(value4.id, out var value3) && string.Equals(value3.model, value2.model, StringComparison.Ordinal))
			{
				actorInfo = value4;
				return true;
			}
		}
		return false;
	}

	private static void UnregisterSpeakerLipSyncAlias(ActorInfo actorInfo)
	{
		if (actorInfo == null || actorInfo.lipSyncSpeakerId <= 0 || actorInfo.lipSyncSpeakerId == actorInfo.id)
		{
			if (actorInfo != null)
			{
				actorInfo.lipSyncSpeakerId = 0;
			}
			return;
		}
		NewFMODLipSyncBakeDataPlayer newFMODLipSyncBakeDataPlayer = (actorInfo.gameObject ? actorInfo.gameObject.GetComponent<NewFMODLipSyncBakeDataPlayer>() : null);
		if ((bool)newFMODLipSyncBakeDataPlayer)
		{
			Singleton<ULipSyncManager>.instance.UnregisterCharacter(actorInfo.lipSyncSpeakerId, newFMODLipSyncBakeDataPlayer);
		}
		actorInfo.lipSyncSpeakerId = 0;
	}

	private async UniTask LoadActor(ActorInfo actorInfo, StageActorState stageActorState)
	{
		if (!RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(actorInfo.id, out var value) || string.IsNullOrEmpty(value.model))
		{
			return;
		}
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(value.model, characters.transform);
		await handle;
		GameObject gameObject = handle.AsGameObject();
		if ((bool)base.gameObject)
		{
			(gameObject.GetComponent<CharacterHDShadow>() ?? gameObject.AddComponent<CharacterHDShadow>()).SetObjectType(CharacterHDShadowObjectType.UnBattle);
			actorInfo.gameObject = gameObject;
			actorInfo.transform = gameObject.transform;
			SetActorPosition(actorInfo, stageActorState, immediate: true);
			actorInfo.animator = gameObject.GetComponent<Animator>();
			actorInfo.dissolve2Control = gameObject.GetComponent<Dissolve2Control>();
			actorInfo.dialogueCharacter = gameObject.GetComponent<DialogueCharacter>();
			NewFMODLipSyncBakeDataPlayer component = gameObject.GetComponent<NewFMODLipSyncBakeDataPlayer>();
			if ((bool)component)
			{
				Singleton<ULipSyncManager>.instance.RegisterCharacter(actorInfo.id, component);
			}
		}
	}

	private async UniTask UnloadActor(ActorInfo actorInfo, CancellationToken token)
	{
		try
		{
			m_UnloadingActors.Add(actorInfo);
			DOTween.Kill(actorInfo);
			if ((bool)actorInfo.animator)
			{
				actorInfo.animator.SetBool("Show", value: false);
				await UniTask.WaitUntil(() => actorInfo.dissolve2Control == null || actorInfo.dissolve2Control._DitherValue == 0f, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		try
		{
			m_UnloadingActors.Remove(actorInfo);
			UnregisterSpeakerLipSyncAlias(actorInfo);
			Singleton<ULipSyncManager>.instance.UnregisterCharacter(actorInfo.id);
			if ((bool)actorInfo.gameObject)
			{
				AssetStationManager.BattleStation.ReleaseInstance(actorInfo.gameObject);
			}
			actorInfo.Reset();
		}
		catch (Exception exception2)
		{
			Debug.LogException(exception2);
		}
	}

	private ActorPointConfig GetPoint(int positionIndex)
	{
		ActorPointConfig result = actorsPointConfigs[m_StageMode].points[positionIndex];
		result.rotation.y += 180f;
		return result;
	}

	public bool HasActor()
	{
		foreach (ActorInfo value in m_ActorDict.Values)
		{
			if (value != null && (bool)value.transform)
			{
				return true;
			}
		}
		return false;
	}

	private void InitBg()
	{
		Rect realGameRect = GetRealGameRect();
		m_DefaultBg = new ConversationSceneDefaultBg(defaultBg.transform, defaultBg);
		m_DefaultsSceneBg = new ConversationSceneDefaultBg(defaultSceneBg.transform, defaultSceneBg);
		m_Mask = new ConversationSceneDefaultBg(mask.transform, mask);
		m_DefaultsSceneBg.SetOriginalScale(new Vector3(realGameRect.width, realGameRect.height, 1f));
		m_DefaultsSceneBg.SetOriginalSize(new Vector3(realGameRect.width, realGameRect.height, 1f));
		m_DefaultBg.Update(uiSceneCamera, m_BaseFov);
		m_DefaultsSceneBg.Update(uiSceneCamera, m_BaseFov);
		m_Mask.Update(uiSceneCamera, m_BaseFov);
	}

	private void UpdateBg()
	{
		m_DefaultBg.OriginalZOffset = bgBaseZ;
		m_DefaultsSceneBg.OriginalZOffset = bgBaseZ;
		m_Mask.OriginalZOffset = bgBaseZ;
		foreach (ConversationSceneBg currentBg in m_CurrentBgs)
		{
			currentBg.OriginalZOffset = bgBaseZ;
		}
		for (int i = 0; i < m_HidingBgs.Count; i++)
		{
			m_HidingBgs[i].OriginalZOffset = bgBaseZ;
		}
		m_DefaultBg.SetOrder(-100);
		m_DefaultsSceneBg.SetOrder(-99);
		m_Mask.SetOrder(100);
		int num = 0;
		foreach (ConversationSceneBg currentBg2 in m_CurrentBgs)
		{
			currentBg2.SetOrder(num--);
		}
		int num2 = 1;
		for (int num3 = m_HidingBgs.Count - 1; num3 >= 0; num3--)
		{
			m_HidingBgs[num3].SetOrder(num2++);
		}
		m_DefaultBg.Update(uiSceneCamera, m_BaseFov);
		m_DefaultsSceneBg.Update(uiSceneCamera, m_BaseFov);
		m_Mask.Update(uiSceneCamera, m_BaseFov);
		foreach (ConversationSceneBg currentBg3 in m_CurrentBgs)
		{
			currentBg3.Update(uiSceneCamera, m_BaseFov);
		}
		foreach (ConversationSceneBg hidingBg in m_HidingBgs)
		{
			hidingBg.Update(uiSceneCamera, m_BaseFov);
		}
	}

	public ConversationSceneBg GetCurrentBg()
	{
		if (m_CurrentBgs.First == null)
		{
			return null;
		}
		return m_CurrentBgs.First.Value;
	}

	public bool HasBg()
	{
		return m_CurrentBgs.First != null;
	}

	public void OpenSceneBg()
	{
		m_DefaultsSceneBg.Show();
	}

	public async UniTask ChangeBg(int bgId)
	{
		ConversationSceneBg currentBg = GetCurrentBg();
		if (currentBg == null || currentBg.BgId != bgId)
		{
			FinishBgMotion();
			await AddBg(bgId, 1f, Vector2.zero);
			HideAllBg(1);
		}
	}

	public async UniTask AddBg(int bgId, float initScale, Vector2 initOffset)
	{
		RuntimeConfigs.data.dialogueBackgroundDatas.TryGetValue(bgId, out var value);
		ConversationSceneBg bg = null;
		switch (value?.type ?? 0)
		{
		case 0:
		{
			MeshRenderer component = UnityEngine.Object.Instantiate(this.bg.gameObject, this.bg.transform.parent, worldPositionStays: true).GetComponent<MeshRenderer>();
			bg = ConversationSceneImageBg.Create(bgId, component);
			bg.OriginalZOffset = bgBaseZ;
			break;
		}
		case 1:
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(spineBgParent.gameObject, spineBgParent.transform.parent, worldPositionStays: true);
			bg = ConversationSceneSpineBg.Create(bgId, gameObject.transform);
			bg.OriginalZOffset = bgBaseZ;
			break;
		}
		}
		if (bg != null)
		{
			bg.PivotOffset = initOffset;
			bg.ScaleFactor = initScale;
			m_CurrentBgs.AddLast(bg);
			await bg.Show();
			bg.Update(uiSceneCamera, m_BaseFov);
		}
	}

	public void HideAllBg(int reserveCount = 0)
	{
		LinkedListNode<ConversationSceneBg> linkedListNode = m_CurrentBgs.Last;
		while (reserveCount > 0)
		{
			linkedListNode = linkedListNode?.Previous;
			reserveCount--;
		}
		if (linkedListNode == null)
		{
			return;
		}
		while (m_CurrentBgs.First != null)
		{
			LinkedListNode<ConversationSceneBg> first = m_CurrentBgs.First;
			ConversationSceneBg value = first.Value;
			m_CurrentBgs.RemoveFirst();
			value.HideAndRelease();
			if (first == linkedListNode)
			{
				break;
			}
		}
	}

	public async UniTask HideCurrentBg(float duration = 0f, CancellationToken token = default(CancellationToken))
	{
		ConversationSceneBg currentBg = GetCurrentBg();
		if (currentBg == null)
		{
			return;
		}
		m_CurrentBgs.RemoveFirst();
		if (duration > 0f)
		{
			CancellationToken cancellationToken = (token.CanBeCanceled ? token : gameObject.GetCancellationTokenOnDestroy());
			m_HidingBgs.Add(currentBg);
			if (currentBg is IConversationSceneBgFade conversationSceneBgFade)
			{
				conversationSceneBgFade.FadeTo(0f, duration, cancellationToken).SuppressCancellationThrow().Forget();
				await UniTask.WaitForSeconds(duration, ignoreTimeScale: false, PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
			}
			if (!m_HidingBgs.Remove(currentBg))
			{
				return;
			}
		}
		currentBg.HideAndRelease();
	}

	public void FinishHidingBgs()
	{
		for (int i = 0; i < m_HidingBgs.Count; i++)
		{
			m_HidingBgs[i]?.HideAndRelease();
		}
		m_HidingBgs.Clear();
	}

	public override void Open()
	{
		m_MainBattleRestoredForTransition = false;
		GameRenderScene.Set(GameRenderScene.Scene.AVG);
		MonoECS.instance.PushPause();
		GameManager.effectSystem.SetAllUIEffectsVisible(visible: false);
		base.Open();
	}

	public override void Close()
	{
		ResetCameraMotion();
		ReleaseDepthOfFieldPrefab();
		if (!m_MainBattleRestoredForTransition)
		{
			GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
			MonoECS.instance.PopPause();
			GameManager.effectSystem.SetAllUIEffectsVisible(visible: true);
		}
		else
		{
			m_MainBattleRestoredForTransition = false;
		}
		foreach (ConversationSceneBg currentBg in m_CurrentBgs)
		{
			currentBg.HideAndRelease();
		}
		base.Close();
	}

	public override void OnRelease()
	{
		foreach (ActorInfo value in m_ActorDict.Values)
		{
			if (value != null && value.gameObject != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(value.gameObject);
			}
		}
		base.OnRelease();
	}

	private void Awake()
	{
		m_BaseFov = uiSceneCamera.fieldOfView;
		m_BaseCameraLocalPosition = uiSceneCamera.transform.localPosition;
		m_BaseCameraPosition = uiSceneCamera.transform.position;
		m_BaseCameraRotation = uiSceneCamera.transform.rotation;
		RefreshBaseActorBottomY();
		InitBg();
	}

	public override void OnLoadComplete()
	{
		base.OnLoadComplete();
		gameObject.SetActive(value: false);
	}

	private void Update()
	{
		UpdateBaseActorBottomYForScreenSize();
		UpdateBg();
	}

	private void LateUpdate()
	{
		LateUpdateActors();
	}

	public void Pause()
	{
		m_Pause = true;
		PauseEffects();
		PauseActors();
	}

	public void Resume()
	{
		m_Pause = false;
		ResumeEffects();
		ResumeActors();
	}

	public async UniTask SetDepthOfFields(DepthOfFieldMode mode, float duration, CancellationToken token)
	{
		await UniTask.WhenAll(GetDepthOfField(m_RolesDepthOfField, token), GetDepthOfField(m_BgDepthOfField, token));
		UniTask uniTask = TransitionDepthOfField(m_RolesDepthOfField, mode == DepthOfFieldMode.Roles, duration, token);
		UniTask uniTask2 = TransitionDepthOfField(m_BgDepthOfField, mode == DepthOfFieldMode.Bg, duration, token);
		await UniTask.WhenAll(uniTask, uniTask2);
	}

	private async UniTask GetDepthOfField(DepthOfFieldEffect effect, CancellationToken token)
	{
		if (effect.Override != null)
		{
			return;
		}
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync("DepthOfField_AVG", transform);
		await handle;
		if (token.IsCancellationRequested)
		{
			ReleaseDepthOfFieldHandle(handle);
			return;
		}
		GameObject gameObject = handle.AsGameObject();
		Volume volume = ((gameObject != null) ? gameObject.GetComponentInChildren<Volume>(includeInactive: true) : null);
		if (volume == null || volume.profile == null || !volume.profile.TryGet<TemporalDepthOfField>(out var component))
		{
			Debug.LogError("DepthOfField prefab 'DepthOfField_AVG' requires a Volume with a TemporalDepthOfField override.");
			ReleaseDepthOfFieldHandle(handle);
			return;
		}
		gameObject.name = effect.Name;
		volume.weight = 0f;
		volume.enabled = false;
		component.farStart.value = effect.FarStart;
		component.farEnd.value = effect.FarEnd;
		component.enabled.value = false;
		component.kernelScale.value = 3.5f;
		gameObject.SetActive(value: false);
		effect.Handle = handle;
		effect.Instance = gameObject;
		effect.Volume = volume;
		effect.Override = component;
	}

	private UniTask TransitionDepthOfField(DepthOfFieldEffect effect, bool targetEnabled, float duration, CancellationToken token)
	{
		if (effect.Override == null)
		{
			return UniTask.CompletedTask;
		}
		effect.Tweener?.Complete(withCallbacks: true);
		TemporalDepthOfField depthOfField = effect.Override;
		float fromWeight = effect.Volume.weight;
		float targetWeight = (targetEnabled ? 1f : 0f);
		float progress = 0f;
		if (targetEnabled)
		{
			effect.Instance.SetActive(value: true);
			effect.Volume.enabled = true;
			depthOfField.farStart.value = effect.FarStart;
			depthOfField.farEnd.value = effect.FarEnd;
			depthOfField.enabled.value = true;
			depthOfField.kernelScale.value = 3.5f;
		}
		if (duration <= 0f)
		{
			depthOfField.farStart.value = effect.FarStart;
			depthOfField.farEnd.value = effect.FarEnd;
			depthOfField.kernelScale.value = 3.5f;
			depthOfField.enabled.value = targetEnabled;
			effect.Volume.weight = targetWeight;
			effect.Volume.enabled = targetEnabled;
			effect.Instance.SetActive(targetEnabled);
			return UniTask.CompletedTask;
		}
		effect.Tweener = DOTween.To(() => progress, (float value) =>
		{
			progress = value;
			effect.Volume.weight = Mathf.Lerp(fromWeight, targetWeight, progress);
		}, 1f, duration).OnComplete(() =>
		{
			depthOfField.farStart.value = effect.FarStart;
			depthOfField.farEnd.value = effect.FarEnd;
			depthOfField.kernelScale.value = 3.5f;
			depthOfField.enabled.value = targetEnabled;
			effect.Volume.weight = targetWeight;
			effect.Volume.enabled = targetEnabled;
			effect.Instance.SetActive(targetEnabled);
			effect.Tweener = null;
		}).OnKill(() =>
		{
			effect.Tweener = null;
		})
			.SetEase(Ease.InOutSine);
		return effect.Tweener.ToUniTask(TweenCancelBehaviour.Kill, token);
	}

	private void ReleaseDepthOfFieldPrefab()
	{
		ReleaseDepthOfFieldEffect(m_RolesDepthOfField);
		ReleaseDepthOfFieldEffect(m_BgDepthOfField);
	}

	private static void ReleaseDepthOfFieldEffect(DepthOfFieldEffect effect)
	{
		effect.Tweener?.Kill();
		effect.Tweener = null;
		effect.Override = null;
		effect.Volume = null;
		effect.Instance = null;
		ReleaseDepthOfFieldHandle(effect.Handle);
		effect.Handle = default;
	}

	private static void ReleaseDepthOfFieldHandle(AssetLoadHandle handle)
	{
		if (handle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(handle);
		}
	}

	private void PauseEffects()
	{
		redWarning[redWarning.clip.name].speed = 0f;
	}

	private void ResumeEffects()
	{
		redWarning[redWarning.clip.name].speed = 1f;
	}

	public async UniTask EffectTask(int effectId, CancellationToken token)
	{
		if (token.IsCancellationRequested || effectId == m_effectId)
		{
			return;
		}
		if ((bool)m_effect)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_effect);
		}
		m_effectId = effectId;
		if (RuntimeConfigs.data.dialogueEffectDatas.TryGetValue(m_effectId, out var value))
		{
			string key = value.key;
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(key, transform);
			await handle;
			if (!token.IsCancellationRequested)
			{
				m_effect = handle.AsGameObject();
				m_effect.SetActive(value: true);
			}
		}
	}

	public void WhiteFlash()
	{
		whiteFlash?.SetActive(value: false);
		whiteFlash?.SetActive(value: true);
	}

	public void RedWarning(bool active)
	{
		if (active != redWarning.gameObject.activeSelf)
		{
			redWarning.gameObject.SetActive(active);
			if (active)
			{
				redWarning.Play();
			}
		}
	}

	public void Fog(bool active)
	{
		fog?.SetActive(active);
	}

	public void Sparkle(bool active)
	{
		sparkle?.SetActive(active);
	}

	private void UpdateBaseActorBottomYForScreenSize()
	{
		if (m_BaseActorScreenSize.x == Screen.width && m_BaseActorScreenSize.y == Screen.height)
		{
			return;
		}
		RefreshBaseActorBottomY();
		foreach (ActorInfo value in m_ActorDict.Values)
		{
			SetActorPosition(value, value.stageActorState);
		}
	}

	private void RefreshBaseActorBottomY()
	{
		m_BaseActorScreenSize = new Vector2Int(Screen.width, Screen.height);
		m_BaseActorBottomY = GetCameraBottomEdgePoint(m_BaseCameraPosition, m_BaseCameraRotation, m_BaseFov, characters.transform.localPosition.z).y;
	}

	private static Vector3 GetCameraBottomEdgePoint(Vector3 cameraPosition, Quaternion cameraRotation, float fov, float dist)
	{
		float num = 2f * dist * Mathf.Tan(fov * 0.5f * (MathF.PI / 180f));
		return cameraPosition + cameraRotation * Vector3.forward * dist - cameraRotation * Vector3.up * (num * 0.5f);
	}

	public static Rect GetRealGameRect(Camera mainCam = null)
	{
		if (mainCam == null)
		{
			mainCam = Camera.main;
		}
		Rect rect = mainCam.rect;
		float x = rect.x * (float)Screen.width;
		float y = rect.y * (float)Screen.height;
		float width = rect.width * (float)Screen.width;
		float height = rect.height * (float)Screen.height;
		return new Rect(x, y, width, height);
	}

	private Color GetBgMaskColor()
	{
		if (m_HasBgMaskColor)
		{
			return m_BgMaskColor;
		}
		return mask.sharedMaterial.GetColor(BaseColorId);
	}

	private void SetBgMaskColor(Color color)
	{
		if (m_BgMaskPropertyBlock == null)
		{
			m_BgMaskPropertyBlock = new MaterialPropertyBlock();
		}
		m_BgMaskPropertyBlock.SetColor(BaseColorId, color);
		mask.SetPropertyBlock(m_BgMaskPropertyBlock);
		m_BgMaskColor = color;
		m_HasBgMaskColor = true;
	}

	private async UniTask BgMaskHide(float fadeTime)
	{
		if (!m_Mask.IsShow)
		{
			return;
		}
		m_BgMaskTweener?.Kill(complete: true);
		if (!mask.gameObject.activeSelf)
		{
			await UniTask.CompletedTask;
			return;
		}
		if (fadeTime <= 0f)
		{
			mask.gameObject.SetActive(value: false);
			SetBgMaskColor(Color.clear);
			return;
		}
		Color startColor = GetBgMaskColor();
		Color endValue = startColor;
		endValue.a = 0f;
		m_BgMaskTweener = DOTween.To(() => startColor, SetBgMaskColor, endValue, fadeTime).OnStart(() =>
		{
			mask.gameObject.SetActive(value: true);
		}).OnComplete(() =>
		{
			m_BgMaskTweener = null;
			mask.gameObject.SetActive(value: false);
			SetBgMaskColor(Color.clear);
		});
		CancellationToken cancellationTokenOnDestroy = gameObject.GetCancellationTokenOnDestroy();
		await m_BgMaskTweener.ToUniTask(TweenCancelBehaviour.Kill, cancellationTokenOnDestroy);
	}

	private async UniTask BgMaskShow(float fadeTime, Color color)
	{
		m_BgMaskTweener?.Kill(complete: true);
		if (fadeTime <= 0f)
		{
			mask.gameObject.SetActive(value: true);
			SetBgMaskColor(color);
			return;
		}
		Color startColor = color;
		startColor.a = 0f;
		m_BgMaskTweener = DOTween.To(() => startColor, SetBgMaskColor, color, fadeTime).OnStart(() =>
		{
			mask.gameObject.SetActive(value: true);
			SetBgMaskColor(startColor);
		}).OnComplete(() =>
		{
			m_BgMaskTweener = null;
			SetBgMaskColor(color);
		});
		CancellationToken cancellationTokenOnDestroy = gameObject.GetCancellationTokenOnDestroy();
		await m_BgMaskTweener.ToUniTask(TweenCancelBehaviour.Kill, cancellationTokenOnDestroy);
	}

	public async UniTask UpdateBgMask(bool active, float fadeTime, Color color)
	{
		if (active)
		{
			await BgMaskShow(fadeTime, color);
		}
		else
		{
			await BgMaskHide(fadeTime);
		}
	}

	public void BgMotion(float bgScale, Vector3 bgOffset)
	{
		m_BgMotionTweener?.Complete(withCallbacks: true);
		ConversationSceneBg currentBg = GetCurrentBg();
		if (currentBg != null)
		{
			currentBg.PivotOffset = bgOffset;
			currentBg.ScaleFactor = bgScale;
		}
	}

	public async UniTask BgMotion(float bgScale, Vector2 bgOffset, float bgMotionDuration, BgMotionEase ease = BgMotionEase.Linear)
	{
		m_BgMotionTweener?.Complete(withCallbacks: true);
		ConversationSceneBg currentBg = GetCurrentBg();
		if (currentBg == null)
		{
			return;
		}
		Vector2 fromPosition = currentBg?.PivotOffset ?? Vector2.zero;
		float fromScaleFactor = currentBg?.ScaleFactor ?? 1f;
		Ease dgEase = Ease.Linear;
		switch (ease)
		{
		case BgMotionEase.Linear:
			dgEase = Ease.Linear;
			break;
		case BgMotionEase.InCubic:
			dgEase = Ease.InCubic;
			break;
		case BgMotionEase.OutCubic:
			dgEase = Ease.OutCubic;
			break;
		}
		float progress = 0f;
		m_BgMotionTweener = DOTween.To(() => progress, (float v) =>
		{
			progress = v;
			float t = EaseManager.ToEaseFunction(dgEase)(progress, 1f, 0f, 0f);
			float t2 = progress;
			foreach (ConversationSceneBg currentBg2 in m_CurrentBgs)
			{
				if (currentBg2 != null)
				{
					currentBg2.PivotOffset = Vector2.Lerp(fromPosition, bgOffset, t);
					currentBg2.ScaleFactor = Mathf.Lerp(fromScaleFactor, bgScale, t2);
				}
			}
		}, 1f, bgMotionDuration).OnStart(() =>
		{
			foreach (ConversationSceneBg currentBg3 in m_CurrentBgs)
			{
				if (currentBg3 != null)
				{
					currentBg3.PivotOffset = fromPosition;
					currentBg3.ScaleFactor = fromScaleFactor;
				}
			}
		}).OnComplete(() =>
		{
			m_BgMotionTweener = null;
			foreach (ConversationSceneBg currentBg4 in m_CurrentBgs)
			{
				if (currentBg4 != null)
				{
					currentBg4.PivotOffset = bgOffset;
					currentBg4.ScaleFactor = bgScale;
				}
			}
		});
		await m_BgMotionTweener.ToUniTask(TweenCancelBehaviour.Kill, gameObject.GetCancellationTokenOnDestroy());
	}

	public void FinishBgMotion()
	{
		m_BgMotionTweener?.Complete(withCallbacks: true);
	}

	public void CameraMotion(float fovScale, Vector2 cameraOffset)
	{
		m_CameraMotionTweener?.Complete(withCallbacks: true);
		SetCameraMotion(fovScale, cameraOffset);
	}

	public async UniTask CameraMotion(float fovScale, Vector2 cameraOffset, float duration, BgMotionEase ease = BgMotionEase.Linear)
	{
		m_CameraMotionTweener?.Complete(withCallbacks: true);
		float fromFovScale = m_BaseFov / uiSceneCamera.fieldOfView;
		Vector2 fromOffset = m_CameraPivotOffset;
		Ease dgEase = GetDgEase(ease);
		float progress = 0f;
		m_CameraMotionTweener = DOTween.To(() => progress, (float value) =>
		{
			progress = value;
			float t = EaseManager.ToEaseFunction(dgEase)(progress, 1f, 0f, 0f);
			SetCameraMotion(Mathf.Lerp(fromFovScale, fovScale, progress), Vector2.Lerp(fromOffset, cameraOffset, t));
		}, 1f, duration).OnStart(() =>
		{
			SetCameraMotion(fromFovScale, fromOffset);
		}).OnComplete(() =>
		{
			m_CameraMotionTweener = null;
			SetCameraMotion(fovScale, cameraOffset);
		});
		await m_CameraMotionTweener.ToUniTask(TweenCancelBehaviour.Kill, gameObject.GetCancellationTokenOnDestroy());
	}

	public void FinishCameraMotion()
	{
		m_CameraMotionTweener?.Complete(withCallbacks: true);
	}

	public void ResetCameraMotion()
	{
		FinishCameraMotion();
		SetCameraMotion(1f, Vector2.zero);
	}

	private static Ease GetDgEase(BgMotionEase ease)
	{
		return ease switch
		{
			BgMotionEase.InCubic => Ease.InCubic, 
			BgMotionEase.OutCubic => Ease.OutCubic, 
			_ => Ease.Linear, 
		};
	}

	private void SetCameraMotion(float fovScale, Vector2 cameraOffset)
	{
		m_CameraPivotOffset = cameraOffset;
		uiSceneCamera.fieldOfView = Mathf.Clamp(m_BaseFov / Mathf.Max(fovScale, 0.01f), 1f, 179f);
		float num = Mathf.Abs(bgBaseZ);
		float num2 = 2f * num * Mathf.Tan(uiSceneCamera.fieldOfView * 0.5f * (MathF.PI / 180f));
		float num3 = num2 * uiSceneCamera.aspect;
		uiSceneCamera.transform.localPosition = m_BaseCameraLocalPosition + new Vector3(num3 * cameraOffset.x, num2 * cameraOffset.y, 0f);
	}

	public async UniTask Shake(Vector3 strength, float duration, int vibrato = 10)
	{
		FinishShake();
		m_BgShakeTweener = uiSceneCamera.transform.DOShakePosition(duration, strength, vibrato).OnComplete(() =>
		{
			m_BgShakeTweener = null;
			SetCameraMotion(m_BaseFov / uiSceneCamera.fieldOfView, m_CameraPivotOffset);
		});
		await (Tween)m_BgShakeTweener;
	}

	public void FinishShake()
	{
		m_BgShakeTweener?.Complete(withCallbacks: true);
	}
}
