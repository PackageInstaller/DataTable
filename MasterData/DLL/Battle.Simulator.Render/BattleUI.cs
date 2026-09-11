using System;
using P08.Gamepad;
using UnityEngine;

public class BattleUI : MonoBehaviour
{
	public GradeUI GradeUI;

	public BossInfoUI BossInfoUI;

	public PlayerInfoUI PlayerInfoUI;

	public BattleTalkPanel BattleTalkPanel;

	public PartBreakUI PartBreakUI;

	public P08JoystickController joystickController;

	public P08BattleUICameraCtrl cameraCtrl;

	public TargetIndicatorUI TragetIndicatorUI;

	public CanvasGroup canvasGroupRoot;

	public CanvasGroup canvasGroupStick;

	public BattleUIAdapter adapter;

	public LockButton lockButton;

	public HighFPSMonitor fpsMonitor;

	public Action<bool> onBattleUIActiveEvent;

	private bool isActive;

	public void ShowDamageTestUI()
	{
		DamageInfoUI.CreateDamageInfoUI(BossInfoUI.transform.parent);
	}

	private void Awake()
	{
		AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Combine(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler));
		InitUILogic();
	}

	public void InitUILogic()
	{
		if (joystickController != null)
		{
			joystickController.Init(Vector3.zero, 0f, new P08StickControllerGameLogic());
		}
		if (cameraCtrl != null)
		{
			cameraCtrl.Init(new P08CameraCtrlGameLogic());
		}
	}

	private void OnDestroy()
	{
		AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Remove(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler));
		onBattleUIActiveEvent = null;
	}

	private void OnSpawnUnitRenderEventHandler(NAgent nAgent, EntitySpawnedEvent eventReceived)
	{
		BattleTalkPanel.OnPlayerSpawn(nAgent, eventReceived.mRolePosition);
		if (eventReceived.mIsPlayer)
		{
			GradeUI.OnMainPlayerUpdate(nAgent);
			PlayerInfoUI.OnMainPlayerUpdate(nAgent);
		}
	}

	public static void BattleUIActive(bool flag)
	{
		BattleUI battleUI = GetBattleUI();
		if (!(battleUI == null))
		{
			battleUI.SetBattleUIActive(flag);
		}
	}

	public static bool GetBattleUIIsActive()
	{
		BattleUI battleUI = GetBattleUI();
		if (battleUI != null)
		{
			return battleUI.isActive;
		}
		return false;
	}

	public static BattleUI GetBattleUI()
	{
		if (SceneDirector.Instance == null)
		{
			return null;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
		if (battlePanelGameObject == null)
		{
			return null;
		}
		return battlePanelGameObject.GetComponent<BattleUI>();
	}

	public void SetBattleUIActive(bool flag)
	{
		if (canvasGroupRoot != null)
		{
			canvasGroupRoot.alpha = (flag ? 1 : 0);
			canvasGroupRoot.interactable = flag;
			canvasGroupRoot.blocksRaycasts = flag;
		}
		if (canvasGroupStick != null)
		{
			canvasGroupStick.alpha = (flag ? 1 : 0);
			canvasGroupStick.interactable = true;
			canvasGroupStick.blocksRaycasts = true;
			canvasGroupStick.ignoreParentGroups = true;
		}
		if (onBattleUIActiveEvent != null)
		{
			onBattleUIActiveEvent(flag);
		}
		if (flag)
		{
			CreateHighFpsMonitor();
		}
		isActive = flag;
		Component[] componentsInChildren = GetComponentsInChildren(typeof(HIDInputPage));
		if (componentsInChildren == null)
		{
			return;
		}
		Component[] array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] is HIDInputPage hIDInputPage)
			{
				hIDInputPage.enabled = flag;
			}
		}
	}

	public void CreateHighFpsMonitor()
	{
		if (BattleSimulatorSystem.sTargetRenderFrameRate >= 120 && fpsMonitor == null)
		{
			GameObject go = Asset.InstantiateWithoutCache("UI/Common/HighFPSMonitor", base.transform);
			fpsMonitor = U3DUtil.Get<HighFPSMonitor>(go);
		}
	}

	public void DestoryHighFpsMonitor()
	{
		if (fpsMonitor != null)
		{
			PooledAsset.DestroyOrReturn(fpsMonitor.gameObject);
		}
	}
}
