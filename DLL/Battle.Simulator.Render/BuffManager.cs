using System.Collections.Generic;
using Config;
using UnityEngine;

public class BuffManager : IGameModule
{
	public struct BuffEffect
	{
		public GameObject gameObject;

		public int entityID;

		public int effectID;

		public int buffID;
	}

	private Dictionary<int, List<BuffState>> buffRuntimeArray = new Dictionary<int, List<BuffState>>(new IntComparer());

	public OnVoidRefHandler<BuffState, int> mBuffAddedHandler;

	public OnVoidRefHandler<BuffState, int> mBuffRemovedHandler;

	public OnVoidRefHandler<BuffState, int> mBuffTickHandler;

	private bool isGameOver;

	public List<BuffEffect> buffEffects = new List<BuffEffect>();

	public Dictionary<int, CameraCraneShotClip> runningCameraCraneShotClip = new Dictionary<int, CameraCraneShotClip>(new IntComparer());

	private Stack<CameraCraneShotClip> cameraCraneShotClipPool = new Stack<CameraCraneShotClip>();

	public Dictionary<int, CameraDepthOfFieldClip> runningCameraDepthOfFieldClip = new Dictionary<int, CameraDepthOfFieldClip>(new IntComparer());

	private Stack<CameraDepthOfFieldClip> cameraDepthOfFieldClipPool = new Stack<CameraDepthOfFieldClip>();

	public Dictionary<int, CameraDollyShotClip> runningCameraDollyShotClip = new Dictionary<int, CameraDollyShotClip>(new IntComparer());

	private Stack<CameraDollyShotClip> cameraDollyShotClipPool = new Stack<CameraDollyShotClip>();

	public Dictionary<int, CameraFOVClip> runningCameraFOVClip = new Dictionary<int, CameraFOVClip>(new IntComparer());

	private Stack<CameraFOVClip> cameraFOVClipPool = new Stack<CameraFOVClip>();

	public Dictionary<int, CameraRotateClip> runningCameraRotateClip = new Dictionary<int, CameraRotateClip>(new IntComparer());

	private Stack<CameraRotateClip> cameraRotateClipPool = new Stack<CameraRotateClip>();

	public Dictionary<int, RadialBlurClip> runningRadialBlurClip = new Dictionary<int, RadialBlurClip>(new IntComparer());

	private Stack<RadialBlurClip> radialBlurClipPool = new Stack<RadialBlurClip>();

	public Dictionary<int, DarkCornerClip> runningDarkCornerClip = new Dictionary<int, DarkCornerClip>(new IntComparer());

	private Stack<DarkCornerClip> darkCornerClipPool = new Stack<DarkCornerClip>();

	public void Initialize()
	{
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntityDespawnedEvent>(OnUnitDespawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<SimGameOverEvent>(OnGameStopHandler);
	}

	private void OnGameStopHandler(SimGameOverEvent eventReceived)
	{
		if (eventReceived.state != GameOverState.end)
		{
			return;
		}
		Dictionary<int, List<BuffState>>.Enumerator enumerator = buffRuntimeArray.GetEnumerator();
		while (enumerator.MoveNext())
		{
			List<BuffState> value = enumerator.Current.Value;
			if (value != null && value.Count > 0)
			{
				for (int num = value.Count - 1; num >= 0; num--)
				{
					RemoveAndPostBuffRenderEvent(num, value);
				}
				value.Clear();
			}
		}
		isGameOver = true;
	}

	private void OnUnitDespawnedInSim(EntityDespawnedEvent ev)
	{
		if (buffRuntimeArray.TryGetValue(ev.DestroyedEntity, out var value) && value != null && value.Count > 0)
		{
			for (int num = value.Count - 1; num >= 0; num--)
			{
				RemoveAndPostBuffRenderEvent(num, value);
			}
			value.Clear();
		}
	}

	private int GetEffectID(ref BuffState buffState)
	{
		if (buffState.mBuffConfigID == 0)
		{
			return -1;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(buffState.mBuffConfigID, out var config))
		{
			return config.EffectId;
		}
		return -1;
	}

	private int GetTargetEffectIdNumber(List<BuffState> renderStateList, int targetEffectID)
	{
		int num = 0;
		for (int i = 0; i < renderStateList.Count; i++)
		{
			BuffState buffState = renderStateList[i];
			int effectID = GetEffectID(ref buffState);
			if (effectID >= 0 && effectID == targetEffectID)
			{
				num++;
			}
		}
		return num;
	}

	private void CompareAndDeleteBuff(List<BuffState> logicState, List<BuffState> renderState)
	{
		for (int num = renderState.Count - 1; num >= 0; num--)
		{
			bool flag = true;
			if (logicState != null)
			{
				for (int i = 0; i < logicState.Count; i++)
				{
					if (renderState[num].mBuffID == logicState[i].mBuffID)
					{
						flag = false;
						renderState[num] = logicState[i];
						break;
					}
				}
			}
			if (flag)
			{
				RemoveAndPostBuffRenderEvent(num, renderState);
			}
		}
	}

	private void CompareAndAddBuff(List<BuffState> logicState, List<BuffState> renderState)
	{
		for (int i = 0; i < logicState.Count; i++)
		{
			if (!ContainBuff(renderState, logicState[i].mBuffID))
			{
				AddAndPostBuffRenderEvent(logicState[i], renderState);
			}
		}
	}

	private void AddAndPostBuffRenderEvent(BuffState buffState, List<BuffState> renderState)
	{
		renderState.Add(buffState);
		if (mBuffAddedHandler == null)
		{
			return;
		}
		int effectID = GetEffectID(ref buffState);
		if (effectID >= 0)
		{
			if (GetTargetEffectIdNumber(renderState, effectID) == 1)
			{
				mBuffAddedHandler(ref buffState, effectID);
			}
		}
		else
		{
			mBuffAddedHandler(ref buffState, effectID);
		}
	}

	private void RemoveAndPostBuffRenderEvent(int buffStateIndex, List<BuffState> renderState)
	{
		if (mBuffRemovedHandler != null)
		{
			BuffState buffState = renderState[buffStateIndex];
			int effectID = GetEffectID(ref buffState);
			if (effectID >= 0)
			{
				if (GetTargetEffectIdNumber(renderState, effectID) == 1)
				{
					mBuffRemovedHandler(ref buffState, effectID);
				}
			}
			else
			{
				mBuffRemovedHandler(ref buffState, effectID);
			}
		}
		renderState.RemoveAt(buffStateIndex);
	}

	private void TickBuffRenderEvent(BuffState buffState, bool hide)
	{
		if (buffState.mBindLife == EBuffLife.Tick && mBuffTickHandler != null && !hide)
		{
			int effectID = GetEffectID(ref buffState);
			mBuffTickHandler(ref buffState, effectID);
		}
	}

	private void UpdatePerAgent(UnitState unitState)
	{
		List<BuffState> value = null;
		if (buffRuntimeArray.TryGetValue(unitState.EntityID, out value))
		{
			CompareAndDeleteBuff(unitState.mBuffArray, value);
			if (unitState.mBuffArray != null)
			{
				CompareAndAddBuff(unitState.mBuffArray, value);
				for (int i = 0; i < unitState.mBuffArray.Count; i++)
				{
					TickBuffRenderEvent(unitState.mBuffArray[i], unitState.mHide != E_EntityHideType.None);
				}
			}
			return;
		}
		List<BuffState> list = new List<BuffState>();
		buffRuntimeArray.Add(unitState.EntityID, list);
		for (int j = 0; j < unitState.mBuffArray.Count; j++)
		{
			AddAndPostBuffRenderEvent(unitState.mBuffArray[j], list);
		}
		for (int k = 0; k < unitState.mBuffArray.Count; k++)
		{
			TickBuffRenderEvent(unitState.mBuffArray[k], unitState.mHide != E_EntityHideType.None);
		}
	}

	private bool ContainBuff(List<BuffState> buffList, int buffID)
	{
		if (buffList == null)
		{
			return false;
		}
		for (int i = 0; i < buffList.Count; i++)
		{
			if (buffList[i].mBuffID == buffID)
			{
				return true;
			}
		}
		return false;
	}

	public void UpdateLogic(SimStateFrame stateFrame)
	{
		if (isGameOver)
		{
			return;
		}
		int count = stateFrame.AllEntityStates.Count;
		for (int i = 0; i < count; i++)
		{
			if (stateFrame.AllEntityStates[i] is UnitState)
			{
				UnitState unitState = stateFrame.AllEntityStates[i] as UnitState;
				if (unitState.mPredictionID <= 0)
				{
					UpdatePerAgent(unitState);
				}
			}
		}
	}

	public void Reset()
	{
	}

	public void Shutdown()
	{
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntityDespawnedEvent>(OnUnitDespawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<SimGameOverEvent>(OnGameStopHandler);
		buffRuntimeArray.Clear();
		mBuffAddedHandler = null;
		mBuffRemovedHandler = null;
		mBuffTickHandler = null;
		buffEffects.Clear();
		isGameOver = false;
		runningCameraCraneShotClip.Clear();
		cameraCraneShotClipPool.Clear();
		runningCameraDepthOfFieldClip.Clear();
		cameraDepthOfFieldClipPool.Clear();
		runningCameraFOVClip.Clear();
		cameraFOVClipPool.Clear();
		runningCameraRotateClip.Clear();
		cameraRotateClipPool.Clear();
		runningRadialBlurClip.Clear();
		radialBlurClipPool.Clear();
		runningCameraDollyShotClip.Clear();
		cameraDollyShotClipPool.Clear();
		runningDarkCornerClip.Clear();
		darkCornerClipPool.Clear();
	}

	public void FixedUpdate()
	{
	}

	public void LateUpdate()
	{
	}

	public void Update()
	{
	}

	public bool TryGetBuffListByAgentID(int agentID, out List<BuffState> buffList)
	{
		return buffRuntimeArray.TryGetValue(agentID, out buffList);
	}

	public bool TryGetBuffByAgentIDAndBuffID(int agentID, int buffID, out BuffState buffState)
	{
		if (buffRuntimeArray.TryGetValue(agentID, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i].mBuffID == buffID)
				{
					buffState = value[i];
					return true;
				}
			}
		}
		buffState = default(BuffState);
		return false;
	}

	public static BuffManager GetBuffManager()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetBuffManager();
	}

	public void AddBuffEffect(int buffID, int entityID, int effectID, GameObject effect)
	{
		buffEffects.Add(new BuffEffect
		{
			gameObject = effect,
			entityID = entityID,
			effectID = effectID,
			buffID = buffID
		});
	}

	public void RemoveBuffEffectByBuffID(int buffID)
	{
		for (int num = buffEffects.Count - 1; num >= 0; num--)
		{
			if (buffEffects[num].buffID == buffID)
			{
				if (buffEffects[num].gameObject != null)
				{
					PooledAsset.DestroyOrReturn(buffEffects[num].gameObject);
				}
				buffEffects.RemoveAt(num);
			}
		}
	}

	public void RemoveBuffEffectByEntityIDAndEffectID(int entityID, int effectID)
	{
		for (int num = buffEffects.Count - 1; num >= 0; num--)
		{
			if (buffEffects[num].entityID == entityID && buffEffects[num].effectID == effectID)
			{
				if (buffEffects[num].gameObject != null)
				{
					PooledAsset.DestroyOrReturn(buffEffects[num].gameObject);
				}
				buffEffects.RemoveAt(num);
			}
		}
	}

	public void RefreshBuffEffectByEntityID(int entityID, List<int> ignoreBuff)
	{
		if (!buffRuntimeArray.TryGetValue(entityID, out var value))
		{
			return;
		}
		for (int num = value.Count - 1; num >= 0; num--)
		{
			BuffState buffState = value[num];
			if (!ignoreBuff.Contains(buffState.mBuffClassID))
			{
				if (mBuffRemovedHandler != null)
				{
					int effectID = GetEffectID(ref buffState);
					if (effectID >= 0)
					{
						if (GetTargetEffectIdNumber(value, effectID) == 1)
						{
							mBuffRemovedHandler(ref buffState, effectID);
						}
					}
					else
					{
						mBuffRemovedHandler(ref buffState, effectID);
					}
				}
				value.RemoveAt(num);
			}
		}
	}

	public CameraCraneShotClip GetCameraCraneShotClip()
	{
		if (cameraCraneShotClipPool.Count > 0)
		{
			return cameraCraneShotClipPool.Pop();
		}
		return new CameraCraneShotClip();
	}

	public void ReturnCameraCraneShotClip(CameraCraneShotClip clip)
	{
		if (clip != null)
		{
			cameraCraneShotClipPool.Push(clip);
		}
	}

	public CameraDepthOfFieldClip GetCameraDepthOfFieldClip()
	{
		if (cameraCraneShotClipPool.Count > 0)
		{
			return cameraDepthOfFieldClipPool.Pop();
		}
		return new CameraDepthOfFieldClip();
	}

	public void ReturnCameraDepthOfFieldClip(CameraDepthOfFieldClip clip)
	{
		if (clip != null)
		{
			cameraDepthOfFieldClipPool.Push(clip);
		}
	}

	public CameraDepthOfFieldClip UpdateCameraDepthOfField()
	{
		CameraDepthOfFieldClip cameraDepthOfFieldClip = null;
		foreach (KeyValuePair<int, CameraDepthOfFieldClip> item in runningCameraDepthOfFieldClip)
		{
			if (cameraDepthOfFieldClip == null)
			{
				cameraDepthOfFieldClip = item.Value;
			}
			else if (cameraDepthOfFieldClip.mPriority < item.Value.mPriority)
			{
				cameraDepthOfFieldClip = item.Value;
			}
		}
		return cameraDepthOfFieldClip;
	}

	public CameraDollyShotClip GetCameraDollyShotClip()
	{
		if (cameraDollyShotClipPool.Count > 0)
		{
			return cameraDollyShotClipPool.Pop();
		}
		return new CameraDollyShotClip();
	}

	public void ReturnCameraDollyShotClip(CameraDollyShotClip clip)
	{
		if (clip != null)
		{
			cameraDollyShotClipPool.Push(clip);
		}
	}

	public CameraFOVClip GetCameraFOVClip()
	{
		if (cameraFOVClipPool.Count > 0)
		{
			return cameraFOVClipPool.Pop();
		}
		return new CameraFOVClip();
	}

	public void ReturnCameraFOVClip(CameraFOVClip clip)
	{
		if (clip != null)
		{
			cameraFOVClipPool.Push(clip);
		}
	}

	public CameraRotateClip GetCameraRotateClip()
	{
		if (cameraRotateClipPool.Count > 0)
		{
			return cameraRotateClipPool.Pop();
		}
		return new CameraRotateClip();
	}

	public void ReturnCameraRotateClip(CameraRotateClip clip)
	{
		if (clip != null)
		{
			cameraRotateClipPool.Push(clip);
		}
	}

	public RadialBlurClip GetCameraRadialBlurClip()
	{
		if (radialBlurClipPool.Count > 0)
		{
			return radialBlurClipPool.Pop();
		}
		return new RadialBlurClip();
	}

	public void ReturnCameraRadialBlurClip(RadialBlurClip clip)
	{
		if (clip != null)
		{
			radialBlurClipPool.Push(clip);
		}
	}

	public RadialBlurClip UpdateRadialBlur()
	{
		RadialBlurClip radialBlurClip = null;
		foreach (KeyValuePair<int, RadialBlurClip> item in runningRadialBlurClip)
		{
			if (radialBlurClip == null)
			{
				radialBlurClip = item.Value;
			}
			else if (radialBlurClip.Priority < item.Value.Priority)
			{
				radialBlurClip = item.Value;
			}
		}
		return radialBlurClip;
	}

	public DarkCornerClip GetCameraDarkCornerClip()
	{
		if (darkCornerClipPool.Count > 0)
		{
			return darkCornerClipPool.Pop();
		}
		return new DarkCornerClip();
	}

	public void ReturnCameraDarkCornerClip(DarkCornerClip clip)
	{
		if (clip != null)
		{
			darkCornerClipPool.Push(clip);
		}
	}

	public DarkCornerClip UpdateDarkCorner()
	{
		DarkCornerClip darkCornerClip = null;
		foreach (KeyValuePair<int, DarkCornerClip> item in runningDarkCornerClip)
		{
			if (darkCornerClip == null)
			{
				darkCornerClip = item.Value;
			}
			else if (darkCornerClip.priority < item.Value.priority)
			{
				darkCornerClip = item.Value;
			}
		}
		return darkCornerClip;
	}
}
