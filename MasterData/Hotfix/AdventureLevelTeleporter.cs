using System;
using System.Collections;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Gizmo/Level Teleporter")]
public class AdventureLevelTeleporter : LogicEntity, IDeterministicCollisionListener
{
	[Serializable]
	public struct NextLevelData
	{
		public bool enterSettlementState;

		public bool isCurScene;

		public string bornID;

		[HideInInspector]
		public HotfixEnum.fixedRoguelikePortDir enterExitPortDirection;

		[HideInInspector]
		public bool levelSuccess;

		public float fadeTime;

		public string videoName;
	}

	public enum OpenCondition
	{
		MonsterCleared,
		None,
		Order
	}

	public enum State
	{
		Close,
		Open
	}

	public GameObject obstacle;

	public GameObject effect;

	[HideInInspector]
	public Collider collider;

	public NextLevelData nextLevelData = new NextLevelData
	{
		enterSettlementState = true
	};

	public OpenCondition openCondition;

	[SerializeField]
	protected InteractiveTeleporter ani;

	[SerializeField]
	protected TriggerCom taskTriggerCom;

	[SerializeField]
	protected bool isRepeated = true;

	public Action<NextLevelData> onTriggerTeleporterCallback;

	public DeterministicCollider dtCollider { get; protected set; }

	public int x { get; protected set; } = -1;

	public int y { get; protected set; } = -1;

	public State state { get; protected set; }

	public void RegisterTeleporterCallback(Action<NextLevelData> callback)
	{
		onTriggerTeleporterCallback = callback;
	}

	public void UnRegisterTeleporterCallbak()
	{
		onTriggerTeleporterCallback = null;
	}

	public void Active(bool active)
	{
		if (null == ani)
		{
			_logger.LogError("【门】的模型为空！");
		}
		else if (active)
		{
			ani.SetProcessState(InteractiveManager.processState.active0, () =>
			{
				_logger.LogInfo("open");
			});
		}
		else
		{
			ani.SetProcessState(InteractiveManager.processState.deactive0, () =>
			{
				_logger.LogInfo("close");
			});
		}
	}

	protected override void OnInit()
	{
		DeterministicCollider deterministicCollider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		if (dtCollider != null)
		{
			dtCollider.collisionListener = this;
		}
		gameObject.layer = 10;
		if (dtCollider != null)
		{
			dtCollider.gameObject.layer = 10;
		}
		dtCollider.priority = 4;
		_logger = Singleton<LogManager>.Instance.get_Item("AdventureLevelTeleporter");
	}

	protected override void OnActive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			instance.AddEventListener("ADVENTURE_LEVEL_START", OnLevelStart);
			instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", OnMonsterAllDied);
			instance.AddEventListener("LUA2CSHARP_ROGUELIKE_OPENTELEPORTER", Lua2CSharp_OpenTeleporter);
			if (null != ani)
			{
				ani.completeEventForTeleporter = OnAniComplete;
				ani.setStateEventForTeleporter = OnSetStateCallback;
			}
		}
	}

	private void OnSetStateCallback(InteractiveManager.processState state)
	{
		if (state == InteractiveManager.processState.state1)
		{
			FP delayHidePlayerTime = ani.delayHidePlayerTime;
			if (delayHidePlayerTime > 0)
			{
				StartCoroutine(Delay(delayHidePlayerTime));
			}
			else
			{
				SceneSingleton<AdventurePlayerController>.Instance.TeleporterForceHide();
			}
			ani.setStateEventForTeleporter = null;
			SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = false;
		}
	}

	protected void OnAniComplete()
	{
		if (ani._interactiveState == InteractiveManager.interactiveState.active1)
		{
			Open();
			TeleporterTriggerd();
			ani.completeEventForTeleporter = null;
			taskTriggerCom?.Initialize(-1, -1, iInteractive: true);
		}
	}

	public void UpdatePortDropShow(int nextRoomType, bool isFinalLevel = false, bool sceneDoMir = false)
	{
		Transform transform = ani.transform.Find("---- RoomTypeIconNode ----");
		if (null != transform)
		{
			transform.Find("icon_ground")?.gameObject.SetActive(value: false);
		}
		if (null == ani)
		{
			_logger.LogError("传送门缺失门模型");
			return;
		}
		Transform transform2 = ani.transform.Find("---- DropIconNode ----");
		if (null == transform2)
		{
			_logger.LogError("【门】上没有找到【---- DropIconNode ----】节点!");
			return;
		}
		Transform transform3 = transform2.Find("icon_item");
		if (null == transform3)
		{
			_logger.LogError("【门】上没有找到【icon_head】节点!");
			transform3.gameObject.SetActive(value: false);
			return;
		}
		if (sceneDoMir)
		{
			Vector3 localScale = transform3.transform.localScale;
			transform3.transform.localScale = new Vector3(0f - localScale.x, localScale.y, localScale.z);
		}
		MeshRenderer doorRenderer = transform3.GetComponent<MeshRenderer>();
		if (null == doorRenderer)
		{
			_logger.LogError("节点" + transform3.name + "上没有找到【MeshRenderer】渲染器组件!");
			transform3.gameObject.SetActive(value: false);
			return;
		}
		string iconPath = "";
		if (isFinalLevel)
		{
			iconPath = "intdoor_awd_00";
		}
		else
		{
			switch (nextRoomType)
			{
			case 0:
				iconPath = "intdoor_rmtype_03";
				break;
			case 1:
				iconPath = "intdoor_rmtype_04";
				break;
			case 2:
			case 3:
				iconPath = "intdoor_rmtype_05";
				break;
			case 6:
				iconPath = "intdoor_rmtype_07";
				break;
			case 7:
				iconPath = "intdoor_rmtype_09";
				break;
			case 15:
				iconPath = "intdoor_rmtype_03";
				break;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
		if (string.IsNullOrEmpty(iconPath))
		{
			transform3.gameObject.SetActive(value: false);
			return;
		}
		BundleHandler.LoadAssetAsyncCallback callback = (UnityEngine.Object asset) =>
		{
			if (null == asset)
			{
				_logger.LogError("固定rog:错误的头像Icon路径" + iconPath);
			}
			else
			{
				Texture2D value = asset as Texture2D;
				MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
				materialPropertyBlock.SetTexture("_MainTex", value);
				doorRenderer.SetPropertyBlock(materialPropertyBlock);
				materialPropertyBlock.Clear();
			}
		};
		if (null != doorRenderer)
		{
			string assetName = "Assets/AssetBundles/Environment/Common/Icon/Textures/" + iconPath + ".png";
			GameResourceLoader.LoadAssetAsync(GameResourceLoader.ResourceType.Env, assetName, typeof(Texture), callback);
		}
	}

	protected IEnumerator Delay(FP duration)
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.inputEnabled)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		}
		yield return new WaitForSeconds((float)duration);
		SceneSingleton<AdventurePlayerController>.Instance.TeleporterForceHide();
	}

	protected override void OnDeactive()
	{
		onTriggerTeleporterCallback = null;
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			instance.RemoveEventListener("ADVENTURE_LEVEL_START", OnLevelStart);
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", OnMonsterAllDied);
			instance.RemoveEventListener("LUA2CSHARP_ROGUELIKE_OPENTELEPORTER", Lua2CSharp_OpenTeleporter);
		}
	}

	public void SetPosition(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	private void OnLevelStart(IEvent evt)
	{
		Close();
		if (openCondition == OpenCondition.None && state == State.Close)
		{
			_logger.LogInfo("无条件开门");
			Open();
		}
	}

	private void OnMonsterAllDied(IEvent evt)
	{
		if (openCondition == OpenCondition.MonsterCleared && state == State.Close)
		{
			_logger.LogInfo("战斗胜利开门");
			Open();
		}
	}

	private void Lua2CSharp_OpenTeleporter(IEvent ievent)
	{
		if (openCondition == OpenCondition.MonsterCleared && state == State.Close)
		{
			_logger.LogInfo("战斗胜利开门");
			Open();
		}
	}

	public void OrderOpen()
	{
		if (openCondition == OpenCondition.Order && state == State.Close)
		{
			_logger.LogInfo("指令开门");
			Open();
		}
	}

	public void UpdateTrans()
	{
		if (!(null == tsTransform))
		{
			tsTransform.Position = new TSVector2(transform.position.x, transform.position.z);
			tsTransform.PositionY = transform.position.y;
			if (transform.eulerAngles.x >= 0f)
			{
				tsTransform.Rotation = 0f - transform.eulerAngles.y;
			}
			else
			{
				tsTransform.Rotation = transform.eulerAngles.y + 180f;
			}
		}
	}

	public void Close()
	{
		state = State.Close;
		dtCollider.IgnoreCollision = true;
		if (obstacle != null)
		{
			obstacle.SetActive(value: true);
		}
		if (effect != null)
		{
			effect.SetActive(value: false);
		}
	}

	public void Open()
	{
		state = State.Open;
		dtCollider.IgnoreCollision = false;
		tsTransform.Dirty = true;
		if (obstacle != null)
		{
			obstacle.SetActive(value: false);
		}
		if (effect != null)
		{
			effect.SetActive(value: true);
		}
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		if (other.Entity is PlayerAdventureActor && null == ani)
		{
			TeleporterTriggerd();
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
	}

	public void TeleporterTriggerd_Order()
	{
		Open();
		TeleporterTriggerd();
	}

	public void TeleporterTriggerd()
	{
		if (state == State.Open)
		{
			if (onTriggerTeleporterCallback != null)
			{
				onTriggerTeleporterCallback(nextLevelData);
			}
			if (!isRepeated)
			{
				onTriggerTeleporterCallback = null;
			}
		}
	}
}
