using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.ECS.System;
using ACT.Battle.ECS.System.SystemBubble;
using ACT.Rendering;
using ACT.Sound;
using ACT.World;
using Fundamental;

namespace ACT;

public class GameManager : Singleton<GameManager>
{
	private readonly List<IUpdateableManager> _managers = new List<IUpdateableManager>();

	private WorldManager _worldManager;

	private AudioManager _audioManager;

	private ECSManager _ecsManager;

	private ClawManager _clawManager;

	private CharacterHDShadowManager _characterHDShadowManager;

	private ExplorePosManager _explorePosManager;

	private bool m_Running;

	private bool m_NeedChange;

	private bool m_RunningTarget;

	private bool m_CouldPause;

	public override ContextType ContextType => ContextType.GLOBAL;

	public WorldManager worldManager => GetAndInitManager(ref _worldManager);

	public AudioManager audioManager => GetAndInitManager(ref _audioManager);

	internal ECSManager ecsManager => GetAndInitManager(ref _ecsManager);

	public ClawManager clawManager => GetAndInitManager(ref _clawManager);

	public CharacterHDShadowManager characterHDShadowManager => GetAndInitManager(ref _characterHDShadowManager);

	public static IEntities entities => Singleton<GameManager>.instance.ecsManager;

	public bool Running
	{
		get
		{
			return m_Running;
		}
		protected set
		{
			if (!m_CouldPause)
			{
				m_Running = true;
				timeSystem.ChangeLogicSpeed(pause: false);
			}
			else if (value != m_RunningTarget)
			{
				if (value == m_Running)
				{
					m_NeedChange = false;
				}
				else
				{
					m_NeedChange = true;
				}
				m_RunningTarget = value;
				timeSystem.ChangeLogicSpeed(!m_RunningTarget);
			}
		}
	}

	public static SystemRogue rogueSystem => Singleton<GameManager>.instance.ecsManager.systemRogue;

	public static SystemEntityScope entityScopeSystem => Singleton<GameManager>.instance.ecsManager.systemEntityScope;

	public static SystemBloodBottleRecoverUseCount bloodBottleRecoverUseCountSystem => Singleton<GameManager>.instance.ecsManager.systemBloodBottleRecoverUseCount;

	public static SystemInput inputSystem => Singleton<GameManager>.instance.ecsManager.systemInput;

	public static SystemHandleInput handleInputSystem => Singleton<GameManager>.instance.ecsManager.systemHandleInput;

	public static SystemTime timeSystem => Singleton<GameManager>.instance.ecsManager.systemTime;

	public static SystemAI aiSystem => Singleton<GameManager>.instance.ecsManager.systemAI;

	public static SystemTeleportMove teleportMoveSystem => Singleton<GameManager>.instance.ecsManager.systemTeleportMove;

	public static SystemBehave behaveSystem => Singleton<GameManager>.instance.ecsManager.systemBehave;

	public static SystemAssist assistSystem => Singleton<GameManager>.instance.ecsManager.systemAssist;

	public static SystemAnimPlayable animPlayableSystem => Singleton<GameManager>.instance.ecsManager.systemAnimPlayable;

	public static SystemMotionDie motionDieSystem => Singleton<GameManager>.instance.ecsManager.systemMotionDie;

	public static SystemPhysics physicsSystem => Singleton<GameManager>.instance.ecsManager.systemPhysics;

	public static SystemFollow followSystem => Singleton<GameManager>.instance.ecsManager.systemFollow;

	public static SystemSpotLightBuffer spotLightBufferSystem => Singleton<GameManager>.instance.ecsManager.systemSpotLightBuffer;

	public static SystemAbility abilitySystem => Singleton<GameManager>.instance.ecsManager.systemAbility;

	public static SystemEffect effectSystem => Singleton<GameManager>.instance.ecsManager.systemEffect;

	public static SystemGas gasSystem => Singleton<GameManager>.instance.ecsManager.systemGas;

	public static SystemLaser laserSystem => Singleton<GameManager>.instance.ecsManager.systemLaser;

	public static SystemCamera cameraSystem => Singleton<GameManager>.instance.ecsManager.systemCamera;

	public static SystemMonster monsterSystem => Singleton<GameManager>.instance.ecsManager.systemMonster;

	public static SystemHatred hatredSystem => Singleton<GameManager>.instance.ecsManager.systemHatred;

	public static SystemApc apcSystem => Singleton<GameManager>.instance.ecsManager.systemApc;

	public static SystemComboCount comboCountSystem => Singleton<GameManager>.instance.ecsManager.systemComboCount;

	public static SystemNpc npcSystem => Singleton<GameManager>.instance.ecsManager.systemNpc;

	public static SystemBubble bubbleSystem => Singleton<GameManager>.instance.ecsManager.systemBubble;

	public static SystemTrajectory trajectorySystem => Singleton<GameManager>.instance.ecsManager.systemTrajectory;

	public static SystemProduct productSystem => Singleton<GameManager>.instance.ecsManager.systemProduct;

	public static SystemGameStateCheck gameStateCheckSystem => Singleton<GameManager>.instance.ecsManager.systemGameStateCheck;

	public static SystemTheOtherWorld SystemTheOtherWorld => Singleton<GameManager>.instance.ecsManager.systemTheOtherWorld;

	public static SystemEntityTickLOD entityTickLodSystem => Singleton<GameManager>.instance.ecsManager.systemEntityTickLOD;

	private T GetAndInitManager<T>(ref T manager) where T : IUpdateableManager, new()
	{
		if (manager == null)
		{
			manager = RegisterManager<T>();
		}
		IUpdateableManager updateableManager = manager;
		if (updateableManager.State == ContextState.Reset)
		{
			updateableManager.Initialize();
		}
		return manager;
	}

	private T RegisterManager<T>() where T : IUpdateableManager, new()
	{
		T val = new T();
		_managers.Add(val);
		return val;
	}

	public override void Init()
	{
		base.Init();
		InitManagers();
		ContextManager.OnContextTypeReset = (Action<ContextType>)Delegate.Combine(ContextManager.OnContextTypeReset, new Action<ContextType>(OnContextTypeReset));
	}

	private void InitManagers()
	{
		RegisterManager<ExplorePosManager>();
	}

	public override void UnInit()
	{
		base.UnInit();
		ContextManager.OnContextTypeReset = (Action<ContextType>)Delegate.Remove(ContextManager.OnContextTypeReset, new Action<ContextType>(OnContextTypeReset));
	}

	private void OnContextTypeReset(ContextType type)
	{
		foreach (IUpdateableManager manager in _managers)
		{
			if (manager.ContextType == type)
			{
				manager.Reset();
			}
		}
	}

	private void OnDrawGizmos(GizmosDrawType flag)
	{
		if (flag == GizmosDrawType.None)
		{
			return;
		}
		foreach (IUpdateableManager manager in _managers)
		{
			if ((flag & manager.GizmosDrawType) > GizmosDrawType.None)
			{
				manager.DrawGizmos();
			}
		}
	}

	private void OnUpdate()
	{
		foreach (IUpdateableManager manager in _managers)
		{
			manager.Update();
		}
	}

	private void OnFixedUpdate()
	{
		foreach (IUpdateableManager manager in _managers)
		{
			manager.FixedUpdate();
		}
	}

	private void OnFixedLateUpdate()
	{
		foreach (IUpdateableManager manager in _managers)
		{
			manager.FixedLateUpdate();
		}
	}

	private void OnLateUpdate()
	{
		foreach (IUpdateableManager manager in _managers)
		{
			manager.LateUpdate();
		}
	}

	public static void Update()
	{
		Singleton<GameManager>.instance.OnUpdate();
	}

	public static void LateUpdate()
	{
		Singleton<GameManager>.instance.OnLateUpdate();
	}

	public static void FixedUpdate()
	{
		Singleton<GameManager>.instance.OnFixedUpdate();
	}

	public static void LateFixedUpdate()
	{
		Singleton<GameManager>.instance.OnFixedLateUpdate();
	}
}
