using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class ProloguelevelMgr : LogicEntity
{
	protected static ProloguelevelMgr g_instance;

	public RefTool refTool;

	public CinemachineVirtualCamera PrologueVCam;

	public Transform npcTargetPos;

	public List<WorldOBB> edgeOBBs;

	public WorldOBB endOBB_1;

	public Transform preSlidePos;

	public WorldOBB runOBB;

	public WorldOBB monsterOBB;

	public Transform battle2StartPoint;

	public Transform climbStartPos;

	public WorldOBB sandstormOBB;

	public Transform climbEndPos;

	public List<WorldOBB> edgeOBBs_3;

	public WorldOBB climbOBB;

	public WorldOBB endOBB_3;

	public Transform EndPos;

	public CanvasGroup uiMask;

	private AIAdapter _aiAdapter;

	public static ProloguelevelMgr Instance
	{
		get
		{
			if (g_instance == null)
			{
				ProloguelevelMgr[] array = Object.FindObjectsOfType<ProloguelevelMgr>();
				if (array.Length == 1)
				{
					g_instance = array[0];
				}
				else if (array.Length > 1)
				{
					g_instance = array[0];
				}
			}
			return g_instance;
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
		refTool.Init();
		string typeString = "AIScript.Prologue.PrologueMgr";
		_aiAdapter = new AIAdapter();
		if (!_aiAdapter.Initialize(typeString, gameObject))
		{
			_aiAdapter = null;
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_READY", OnLevelStart);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_END", OnLevelStop);
		_aiAdapter?.Start();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_READY", OnLevelStart);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_END", OnLevelStop);
		_aiAdapter?.Disable();
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		_aiAdapter?.Update();
	}

	protected virtual void OnLevelStart(IEvent evt)
	{
		SortEntity();
		EnableLogicUpdate();
		_aiAdapter?.LevelStart();
	}

	protected virtual void OnLevelStop(IEvent evt)
	{
		_aiAdapter?.LevelEnd();
	}

	private void SortEntity()
	{
		List<LogicEntity> entities = ModuleController<AdventureModuleController>.Instance.entities;
		int num = entities.FindIndex((LogicEntity a) => a is ProloguelevelMgr);
		if (num != -1)
		{
			LogicEntity item = entities.get_Item(num);
			entities.RemoveAt(num);
			entities.Insert(0, item);
		}
	}

	public void SetVCamPriority(int value)
	{
		PrologueVCam.Priority = value;
	}

	public void SetGravity(Vector3 gravity)
	{
		Physics.gravity = gravity;
	}

	public Vector3 GetGravity()
	{
		return Physics.gravity;
	}
}
