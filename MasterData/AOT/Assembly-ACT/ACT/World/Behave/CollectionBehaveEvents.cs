using System;
using System.Threading;
using ACT.Battle;
using ACT.Drama;
using ACT.Sound;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using EasyCharacterMovement;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/CollectionBehaveEvents")]
public class CollectionBehaveEvents : MonoBehaviour
{
	[NonSerialized]
	[HideInInspector]
	public InteractCollection interactCollection;

	[Tooltip("交互时播放交互动画？")]
	public bool openBoxAni;

	[Tooltip("交互方式")]
	public InteractType interactType;

	public Animator animator;

	[FormerlySerializedAs("commonInteractEntry")]
	public InteractEntry entry;

	public Transform dropTrans;

	public BoxCollider customBoxCollider;

	[HideInInspector]
	public int quality;

	private static float lastCollectTime = float.MinValue;

	[Header("小地图提示检测")]
	[Tooltip("是否需要开启小地图提示检测")]
	public bool needHintDetect;

	public HintDetect hintDetect;

	public GameObject unlockTimelineGameObject;

	[SerializeField]
	private GameObject _showTimelineGameObject;

	[SerializeField]
	private GameObject _modelObj;

	private Route m_Route;

	private Vector3 robotCenter
	{
		get
		{
			CharacterMovement characterMovement = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().characterMovement;
			return characterMovement.position + characterMovement.height / 2f * Vector3.up;
		}
	}

	private Vector3 charCenter
	{
		get
		{
			CharacterMovement characterMovement = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().characterMovement;
			return characterMovement.position + characterMovement.height / 2f * Vector3.up;
		}
	}

	public void InitModelRotate()
	{
		if (_modelObj != null)
		{
			interactCollection.transform.rotation = Quaternion.identity;
			_modelObj.transform.rotation = interactCollection.Data.initRotate;
		}
	}

	public void Close()
	{
		animator.SetInteger("state", 0);
	}

	public virtual void OnInteract(Entity eb)
	{
		interactCollection.NetEnterState(1).Forget();
	}

	public void Open()
	{
		animator.SetInteger("state", 1);
	}

	public void Break()
	{
		animator.SetInteger("state", 2);
	}

	public void Hide()
	{
		animator.SetInteger("state", -1);
	}

	public void Lock()
	{
		animator.SetInteger("state", -4);
	}

	public void Unlock()
	{
		animator.SetInteger("state", 4);
	}

	public async void UnlockAnimation(CancellationToken token)
	{
		try
		{
			if ((bool)unlockTimelineGameObject)
			{
				unlockTimelineGameObject.gameObject.SetActive(value: true);
				await Singleton<TimelineConversationManager>.instance.PlayTimeline(unlockTimelineGameObject, token);
				unlockTimelineGameObject.gameObject.SetActive(value: false);
				if (interactCollection.currentStateId != 0)
				{
					interactCollection.NetEnterState(0).Forget();
				}
			}
		}
		catch (Exception)
		{
		}
	}

	public async void ShowAnimation(CancellationToken token)
	{
		try
		{
			if ((bool)_showTimelineGameObject)
			{
				_showTimelineGameObject.gameObject.SetActive(value: true);
				await Singleton<TimelineConversationManager>.instance.PlayTimeline(_showTimelineGameObject, token);
				_showTimelineGameObject.gameObject.SetActive(value: false);
			}
		}
		catch (Exception)
		{
		}
	}

	public void GetOrDrop()
	{
		if (interactCollection.entity.GetCompStateObject().StateWorldAssetData is CollectionPointData collectionPointData)
		{
			Singleton<DropItemManager>.instance.RequestCollectionDrop(collectionPointData.stateWorldAssetUid, (dropTrans != null) ? dropTrans.position : transform.position, collectionPointData.stateObjectType, collectionPointData.DirectGet);
		}
	}

	public void BreakWithoutDrop()
	{
		interactCollection.NetEnterState(2).Forget();
	}

	public void FlyToRobot()
	{
		m_Route.startPos = transform.position;
		Flying().Forget();
	}

	private async UniTaskVoid Flying()
	{
		float cd = UnityEngine.Random.Range(GameLoader.meta.collectCD.x, GameLoader.meta.collectCD.y);
		float duration = UnityEngine.Random.Range(GameLoader.meta.collectDuration.x, GameLoader.meta.collectDuration.y);
		await UniTask.WaitUntil(() => Time.time - lastCollectTime > cd);
		lastCollectTime = Time.time;
		PostTailFMOD();
		SystemTime systemTime = GameManager.timeSystem;
		while (true)
		{
			float num = systemTime.globalSpeed * Time.deltaTime;
			m_Route.endPos = charCenter;
			m_Route.controlPos = (m_Route.startPos + m_Route.endPos) / 2f;
			m_Route.precent = InterpolationUtility.FixedLerp(m_Route.precent, 1f, num / duration);
			transform.position = m_Route.Evaluate(m_Route.precent);
			if (Mathf.Approximately(m_Route.precent, 1f))
			{
				break;
			}
			await UniTask.Yield();
		}
		animator.SetInteger("state", -1);
	}

	public void FireHideEffect()
	{
		YooAssetReference onceCollectionHideReferenceAssetID = GameLoader.meta.onceCollectionHideReferenceAssetID;
		if (MonoECS.instance.localPlayer.robotEntity.IsValid)
		{
			GameManager.effectSystem.FireEffect(onceCollectionHideReferenceAssetID, robotCenter, Quaternion.identity);
		}
	}

	public void PostIdleFMOD()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("Sound_Empire_Arsenal_Core_air", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
	}

	public void PostFitFMOD()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("Sound_Empire_Arsenal_Core_fit", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
	}

	public void PostTailFMOD()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("Sound_Empire_Arsenal_Core_tail", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
	}

	public void PostGetFMOD()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/Common/Scene/special_Got", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
	}

	public void SetColliderEnable(bool active)
	{
		hintDetect.SetColliderEnable(active);
	}

	public void PostOpenFMOD()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/Common/Scene/Box_Open", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
	}

	public virtual void OnSpawnAttackable(Entity behave)
	{
	}
}
