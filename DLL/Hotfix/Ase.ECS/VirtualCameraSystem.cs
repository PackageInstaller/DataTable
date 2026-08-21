using System;
using System.Collections.Generic;
using Ase.Paradox;
using Cinemachine;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class VirtualCameraSystem : BaseSystem
{
	private enum Direction
	{
		None,
		Horizontal,
		VerticalUp,
		VerticalDown,
		RightUp,
		LeftUp,
		LeftDown,
		RightDown,
		Center
	}

	private enum AdsorptionTransitionState
	{
		StartTransition2Adsorption,
		Adsorption,
		ExitAdsorption,
		FollowHero
	}

	private bool _isLerpStretch;

	private bool _isLerpLimit;

	private bool _isLerpRate;

	private bool _isLerpDeterminationDistance;

	private float _stretchTimer;

	private float _lerpStretchTimer;

	private AdsorptionTransitionState _adsorptionTransition;

	private Vector3 _startLerpPoint;

	private float _adsorptionStartCameraDis;

	private float _heroActivitiesRadius;

	private float _stretchDeterminationDistance;

	private float _startLerpStretchDeterminationDistance;

	private float _endLerpStretchDeterminationDistance;

	private float _stretchRate;

	private float _startLerpStretchRate;

	private float _endLerpStretchRate;

	private Vector3 _adsorptionOffsetPosition;

	private float _cameraDistanceBaseValue;

	private float _startLerpCameraDistanceBaseValue;

	private float _lerpDistanceTimer;

	private float _distanceTimer;

	private bool _isStartDistanceLerp;

	private float _endLerpCameraDistanceBaseValue;

	private float _cameraMinDistance;

	private float _startLerpCameraMinDistance;

	private float _endLerpCameraMinDistance;

	private float _cameraMaxDistance;

	private float _startLerpCameraMaxDistance;

	private float _endLerpCameraMaxDistance;

	private Line _monsterToHeroLine;

	private DrawScreenBound _drawScreenBound;

	private bool _isOpenCameraStretch;

	private float _dynamicStretchDistance;

	private int _executeTransitionTick;

	private bool startTran22AdsPosition;

	private bool startTran22AdsDis;

	private bool _isInitCamera;

	private HeroEntity _heroEntity;

	private MonsterEntity _monsterEntity;

	private CinemachineVirtualCamera _battleVirtualCamera;

	private CinemachineVirtualCamera _ultimateSkillVirtualCamera;

	private Camera _battleCamera;

	private Vector3 _centerOffset;

	private Vector3 _monsterCenter;

	private Vector3 _heroCenter;

	private float _startAdjustBoundRadius;

	private float _endAdjustBoundRadius;

	private float _adjustBoundTimer;

	private float _lerpTimer;

	private Vector3 _heroBoundOffset;

	private Vector3 _monsterBoundOffset;

	private Vector3 _startMonsterBoundOffset;

	private Vector3 _endMonsterBoundOffset;

	private Vector3 _monsterBoundAbsoluteOffset;

	private Vector3 _startMonsterBoundAbsoluteOffset;

	private Vector3 _endMonsterBoundAbsoluteOffset;

	private float _heroRadius3D;

	private float _monsterRadius3D;

	private bool _isLerpBound;

	private bool _isLerpRadius;

	private bool _isLerpOffset;

	private int _commandIndex;

	private float _adjustMinDistanceLimit;

	private float _adjustMaxDistanceLimit;

	private List<BaseAdjustDistanceData> _currentDistanceCommandList = new List<BaseAdjustDistanceData>();

	private float _adjustBattleCameraFov;

	private float _adjustUItimateCameraFov;

	private List<AdjustFOVData> _currentFovCommandList = new List<AdjustFOVData>();

	private int impulseUniqueIndex;

	private bool ActorIdIgnoreImpulse;

	private List<MakeImpulseSourceData> _makeImpulseSourceDatas;

	private List<CinemachineCustomImpulseListener> allListeners = new List<CinemachineCustomImpulseListener>(5);

	private CinemachineBrain _brain;

	private float _deltaTime;

	private float cameraSpeed = 1f;

	private IObjectPool<GameObject> _vCameraPool;

	private CinemachineVirtualCamera _levelTriggerVirtualCamera;

	private float _moveSpeed;

	private readonly List<TargetPointInfo> _targetPointList = new List<TargetPointInfo>();

	private Transform _tempCameraTargetPoint;

	private int _currentTargetPointIndex;

	private float _currentStayTime;

	private List<BaseAdjustOffsetData> _currentOffsetCommandList = new List<BaseAdjustOffsetData>();

	private List<AdjustRotateData> _currentRotateCommandList = new List<AdjustRotateData>();

	private bool _isCameraShakePause;

	private int cameraShakeIndex;

	private CinemachineBasicMultiChannelPerlinCtrlRandom _perlin;

	private CameraShakeData _currentActiveShakerData;

	private Dictionary<string, NoiseData> _battleCameraShakeData = new Dictionary<string, NoiseData>();

	private Dictionary<string, CurveData> _cameraIntensityCurveData = new Dictionary<string, CurveData>();

	private Dictionary<string, CurveData> _cameraFrequencyCurveData = new Dictionary<string, CurveData>();

	private Dictionary<string, CurveData> _impulseRangeCurveData = new Dictionary<string, CurveData>();

	protected override bool IsLogicSystem => false;

	public float CameraDistanceBaseValue => _cameraDistanceBaseValue;

	public int ImpulseUniqueIndex
	{
		get
		{
			impulseUniqueIndex++;
			return impulseUniqueIndex;
		}
	}

	public override bool NeedPauseSystem => false;

	public CinemachineVirtualCamera LevelCamera => _levelTriggerVirtualCamera;

	private void InitAdsorptionData()
	{
		if (SystemIsNeedExecute)
		{
			_adsorptionTransition = AdsorptionTransitionState.FollowHero;
			_isOpenCameraStretch = false;
			_heroBoundOffset = world.CameraConfig.heroBoundOffset;
			_monsterBoundOffset = world.CameraConfig.monsterBoundOffset;
			_centerOffset = world.CameraConfig.centerOffset;
			_adsorptionStartCameraDis = world.CameraConfig.battleCameraBaseData.cameraDistance;
			_startLerpPoint = world.CameraConfig.battleCameraBaseData.cameraOffset;
			_lerpTimer = 0f;
		}
	}

	public void OpenAdsorption()
	{
		if (_heroEntity != null && _monsterEntity != null && !(_battleCamera == null))
		{
			_executeTransitionTick = 0;
			_startLerpPoint = GetVirtualCameraOffset(CameraKey.BattleCamera);
			_adsorptionTransition = AdsorptionTransitionState.StartTransition2Adsorption;
			_isOpenCameraStretch = true;
			_adsorptionStartCameraDis = GetVirtualCameraDistance(CameraKey.BattleCamera);
			_dynamicStretchDistance = _monsterEntity.MonsterTypeConfig.AutoDistanceMin;
			startTran22AdsPosition = true;
			startTran22AdsDis = true;
			BaseAdjustOffsetData offsetCommand = GetOffsetCommand(CameraKey.BattleCamera);
			if (offsetCommand != null && offsetCommand.AdjustCameraState == AdjustCameraState.ReductionState)
			{
				_currentOffsetCommandList.Clear();
			}
			BaseAdjustDistanceData distanceCommand = GetDistanceCommand(CameraKey.BattleCamera);
			if (distanceCommand != null && distanceCommand.AdjustCameraState == AdjustCameraState.ReductionState)
			{
				_currentDistanceCommandList.Clear();
			}
		}
	}

	private void UpdateLerpStartData()
	{
		if (_isLerpStretch)
		{
			float num = 0f;
			if (_stretchTimer == 0f)
			{
				num = 1f;
			}
			else
			{
				_lerpStretchTimer += _deltaTime;
				num = _lerpStretchTimer / _stretchTimer;
			}
			if (_isLerpRate)
			{
				_stretchRate = Mathf.Lerp(_startLerpStretchRate, _endLerpStretchRate, num);
			}
			if (_isLerpDeterminationDistance)
			{
				_stretchDeterminationDistance = Mathf.Lerp(_startLerpStretchDeterminationDistance, _endLerpStretchDeterminationDistance, num);
			}
			if (_isLerpLimit)
			{
				_cameraMinDistance = Mathf.Lerp(_startLerpCameraMinDistance, _endLerpCameraMinDistance, num);
				_cameraMaxDistance = Mathf.Lerp(_startLerpCameraMaxDistance, _endLerpCameraMaxDistance, num);
			}
			if (num >= 1f)
			{
				_isLerpStretch = false;
				_isLerpLimit = false;
				_isLerpRate = false;
				_isLerpDeterminationDistance = false;
				_lerpStretchTimer = 0f;
			}
		}
	}

	private void LerpBaseDistance()
	{
		if (_isStartDistanceLerp)
		{
			float num = 0f;
			if (_lerpDistanceTimer == 0f)
			{
				num = 1f;
			}
			else
			{
				_distanceTimer += _deltaTime;
				num = _distanceTimer / _lerpDistanceTimer;
			}
			_cameraDistanceBaseValue = Mathf.Lerp(_startLerpCameraDistanceBaseValue, _endLerpCameraDistanceBaseValue, num);
			if (num >= 1f)
			{
				_isStartDistanceLerp = false;
				_distanceTimer = 0f;
			}
		}
	}

	public void HideAdsorption()
	{
		_executeTransitionTick = 0;
		_adsorptionTransition = AdsorptionTransitionState.ExitAdsorption;
		_isOpenCameraStretch = false;
		if (!world.IsStoryWorld)
		{
			_startLerpPoint = GetVirtualCameraOffset(CameraKey.BattleCamera);
		}
		if (_currentOffsetCommandList.Count > 0)
		{
			_currentOffsetCommandList.Clear();
		}
		if (_currentDistanceCommandList.Count > 0)
		{
			_currentDistanceCommandList.Clear();
		}
	}

	private void LerpTransitionAdsorptionState()
	{
		if (startTran22AdsPosition || startTran22AdsDis)
		{
			CurveOffsetLerpShowTime(world.CameraConfig.transitionTick, _startLerpPoint, _adsorptionOffsetPosition, out var progress, _adsorptionStartCameraDis, _dynamicStretchDistance, out var startAdsorptionCameraDis);
			if (startTran22AdsPosition)
			{
				AdjustVirtualCameraOffset(CameraKey.BattleCamera, progress);
			}
			if (startTran22AdsDis)
			{
				AdjustVirtualCameraDistance(CameraKey.BattleCamera, startAdsorptionCameraDis);
			}
			if (CheckVector3(GetVirtualCameraOffset(CameraKey.BattleCamera), _adsorptionOffsetPosition))
			{
				_adsorptionTransition = AdsorptionTransitionState.Adsorption;
				startTran22AdsPosition = false;
				startTran22AdsDis = false;
			}
		}
	}

	private void LerpTransitionNoAdsorptionState()
	{
		CurveOffsetLerpShowTime(world.CameraConfig.transitionTick, _startLerpPoint, GetCameraBaseData(CameraKey.BattleCamera).cameraOffset, out var progress, _adsorptionStartCameraDis, GetCameraBaseData(CameraKey.BattleCamera).cameraDistance, out var startAdsorptionCameraDis);
		AdjustVirtualCameraOffset(CameraKey.BattleCamera, progress);
		AdjustVirtualCameraDistance(CameraKey.BattleCamera, startAdsorptionCameraDis);
		if (CheckVector3(GetVirtualCameraOffset(CameraKey.BattleCamera), GetCameraBaseData(CameraKey.BattleCamera).cameraOffset))
		{
			_adsorptionTransition = AdsorptionTransitionState.FollowHero;
		}
	}

	private void UpdateAdsorptionPoint()
	{
		if (_battleCamera == null)
		{
			return;
		}
		UpdateTransitionState();
		if (_heroEntity != null && _monsterEntity != null)
		{
			UpdateEntityBoundData();
			ComputerAdsorptionPoint();
			if (_adsorptionTransition == AdsorptionTransitionState.Adsorption && IsCanAdsorptionStateAdjustmentCameraOffset())
			{
				AdjustVirtualCameraOffset(CameraKey.BattleCamera, _adsorptionOffsetPosition);
			}
			if (_adsorptionTransition == AdsorptionTransitionState.FollowHero && IsCanAdsorptionStateAdjustmentCameraOffset())
			{
				AdjustVirtualCameraOffset(CameraKey.BattleCamera, GetCameraBaseData(CameraKey.BattleCamera).cameraOffset);
			}
			LerpBaseDistance();
			UpdateLerpStartData();
			StretchCameraDistance();
			if (_drawScreenBound != null)
			{
				_drawScreenBound.UpdateBound(_heroCenter, _monsterCenter, _heroRadius3D, _monsterRadius3D, _heroActivitiesRadius, CurrentCameraCommentPoint(CameraKey.BattleCamera));
			}
		}
	}

	private void UpdateTransitionState()
	{
		if (_adsorptionTransition == AdsorptionTransitionState.StartTransition2Adsorption)
		{
			BaseAdjustOffsetData offsetCommand = GetOffsetCommand(CameraKey.BattleCamera);
			if (startTran22AdsPosition && offsetCommand != null && offsetCommand.AdjustCameraState != AdjustCameraState.ReductionState)
			{
				startTran22AdsPosition = false;
				_adsorptionTransition = AdsorptionTransitionState.Adsorption;
			}
			BaseAdjustDistanceData distanceCommand = GetDistanceCommand(CameraKey.BattleCamera);
			if (startTran22AdsDis && distanceCommand != null && distanceCommand.AdjustCameraState != AdjustCameraState.ReductionState)
			{
				startTran22AdsDis = false;
			}
		}
		LerpTransitionAdsorptionState();
		if (_adsorptionTransition == AdsorptionTransitionState.ExitAdsorption)
		{
			LerpTransitionNoAdsorptionState();
		}
	}

	private void StretchCameraDistance()
	{
		float num = (Vector3.Distance(_heroCenter, _monsterCenter) + _heroRadius3D + _monsterRadius3D - _stretchDeterminationDistance) * _stretchRate;
		float dynamicStretchDistance = Mathf.Clamp(_cameraDistanceBaseValue + num, _cameraMinDistance, _cameraMaxDistance);
		_dynamicStretchDistance = dynamicStretchDistance;
		if (_isOpenCameraStretch && IsCanAdsorptionStateStretchCamera() && _adsorptionTransition != AdsorptionTransitionState.StartTransition2Adsorption && _adsorptionTransition != AdsorptionTransitionState.ExitAdsorption)
		{
			AdjustVirtualCameraDistance(CameraKey.BattleCamera, _dynamicStretchDistance);
		}
	}

	private void ComputerAdsorptionPoint()
	{
		float num = Mathf.Min(_monsterToHeroLine.Length, _heroActivitiesRadius * 2f);
		_adsorptionOffsetPosition = _monsterToHeroLine.Direction * (num / 2f);
		_adsorptionOffsetPosition = new Vector3(_adsorptionOffsetPosition.x, GetCameraBaseData(CameraKey.BattleCamera).cameraOffset.y, _adsorptionOffsetPosition.z);
	}

	private void CurveOffsetLerpShowTime(float lerpTime, Vector3 startPosition, Vector3 targetPosition, out Vector3 progress, float startCameraDis, float targetCameraDis, out float startAdsorptionCameraDis)
	{
		_executeTransitionTick++;
		float num = (float)_executeTransitionTick * 1f / (lerpTime * 1f);
		if (num <= 1f)
		{
			float num2 = world.CameraConfig.animationCurve.Evaluate(num);
			Vector3 normalized = (targetPosition - startPosition).normalized;
			float num3 = Vector3.Distance(targetPosition, startPosition);
			progress = startPosition + num2 * num3 * normalized;
			startAdsorptionCameraDis = startCameraDis + (targetCameraDis - startCameraDis) * num2;
		}
		else
		{
			progress = targetPosition;
			startAdsorptionCameraDis = targetCameraDis;
		}
	}

	public void OpenDrawDebug(bool isOpen)
	{
		if (!(_drawScreenBound == null))
		{
			_drawScreenBound.isDraw = isOpen;
		}
	}

	public void UpdateScreenRect(float heroGazeScope)
	{
		_heroActivitiesRadius = heroGazeScope;
	}

	public void UpdateEntityCenterOffset(Vector3 centerOffset)
	{
		_centerOffset = centerOffset;
	}

	public void UpdateStretchLimit(float minLimit, float maxLimit, int lerpStretchTimer)
	{
		_startLerpCameraMinDistance = _cameraMinDistance;
		_endLerpCameraMinDistance = minLimit;
		_startLerpCameraMaxDistance = _cameraMaxDistance;
		_endLerpCameraMaxDistance = maxLimit;
		_isLerpLimit = true;
		_stretchTimer = Frame2Time(lerpStretchTimer);
		_isLerpStretch = true;
	}

	public void UpdateCameraStretchSpeed(float stretchSpeed, int lerpStretchTimer)
	{
		_startLerpStretchRate = _stretchRate;
		_endLerpStretchRate = stretchSpeed;
		_isLerpRate = true;
		_stretchTimer = Frame2Time(lerpStretchTimer);
		_isLerpStretch = true;
	}

	public void UpdateCameraStretchDeterminationDistance(float determinationDistance, int lerpStretchTimer)
	{
		_startLerpStretchDeterminationDistance = _stretchDeterminationDistance;
		_endLerpStretchDeterminationDistance = determinationDistance;
		_isLerpDeterminationDistance = true;
		_stretchTimer = Frame2Time(lerpStretchTimer);
		_isLerpStretch = true;
	}

	public void UpdateStretchSharpness(float stretchSharpness, float adsorptionSharpness)
	{
	}

	public bool GetAdsorpInEnterOrExitState()
	{
		if (_adsorptionTransition != AdsorptionTransitionState.StartTransition2Adsorption)
		{
			return _adsorptionTransition == AdsorptionTransitionState.ExitAdsorption;
		}
		return true;
	}

	private Vector3 HeroPosition()
	{
		if (_heroEntity == null)
		{
			return _centerOffset;
		}
		EntityViewComponent component = _heroEntity.GetComponent<EntityViewComponent>();
		if (component == null)
		{
			return _centerOffset;
		}
		if (component.Transform == null)
		{
			return _centerOffset;
		}
		return _centerOffset + component.Transform.position;
	}

	private Transform HeroTransform()
	{
		return _heroEntity?.GetComponent<EntityViewComponent>()?.Transform;
	}

	private Vector3 MonsterPosition()
	{
		Vector3 vector = _monsterEntity?.GetComponent<EntityViewComponent>()?.Transform.position ?? Vector3.zero;
		return _centerOffset + vector;
	}

	private Vector3 HeroEulerAngles()
	{
		return _heroEntity?.GetComponent<EntityViewComponent>()?.Transform.eulerAngles ?? Vector3.zero;
	}

	private Vector3 MonsterEulerAngles()
	{
		return _monsterEntity?.GetComponent<EntityViewComponent>()?.Transform.eulerAngles ?? Vector3.zero;
	}

	private Vector3 CurrentCameraCommentPoint(CameraKey cameraKey)
	{
		return GetTran(cameraKey).FollowTarget?.position ?? (HeroPosition() + GetVirtualCameraTrackedObjectOffset(cameraKey));
	}

	private Vector3 CurrentCurrentFollowPoint(CameraKey cameraKey)
	{
		CinemachineFramingTransposerAp tran = GetTran(cameraKey);
		if (tran == null)
		{
			return HeroPosition();
		}
		if (tran.FollowTarget == null)
		{
			return HeroPosition();
		}
		return tran.FollowTarget.position;
	}

	private Vector3 CurrentCameraPosition(CameraKey cameraKey)
	{
		return GetVirtualCamera(cameraKey).transform.position;
	}

	private Vector3 CurrentCameraAngle(CameraKey cameraKey)
	{
		return GetVirtualCamera(cameraKey).transform.eulerAngles;
	}

	private void CreateCamera()
	{
		if (SystemIsNeedExecute)
		{
			if (!_isInitCamera)
			{
				_battleVirtualCamera = CreateVirtualCamera(world.CameraConfig.battleCameraBaseData, HeroTransform());
				_ultimateSkillVirtualCamera = CreateVirtualCamera(world.CameraConfig.ultimateSkillCameraBaseData, HeroTransform());
				AdjustVirtualCameraLerpSpeed(CameraKey.BattleCamera, GetCameraBaseData(CameraKey.BattleCamera).cameraDamp);
				AdjustVirtualCameraLerpSpeed(CameraKey.UltimateSkill, GetCameraBaseData(CameraKey.UltimateSkill).cameraDamp);
				_isInitCamera = true;
			}
			_battleVirtualCamera.Follow = HeroTransform();
			_ultimateSkillVirtualCamera.Follow = HeroTransform();
		}
	}

	public void BindTargetEntity(HeroEntity heroEntity)
	{
		InitAdsorptionData();
		_heroEntity = heroEntity;
		CreateCamera();
	}

	public void SwitchBingTargetEntity(HeroEntity heroEntity)
	{
		_heroEntity = heroEntity;
		CreateCamera();
	}

	public void SwitchBindMonsterEntity(MonsterEntity monsterEntity)
	{
		_monsterEntity = monsterEntity;
		UpdateEntityRadius(world.CameraConfig.heroRadius, _monsterEntity.MonsterTypeConfig.CamRadius);
		AdjustCameraBaseDistance((_monsterEntity.MonsterTypeConfig.CamDistanceBaseline == 0f) ? world.CameraConfig.cameraDistanceBaseValue : _monsterEntity.MonsterTypeConfig.CamDistanceBaseline, 0f);
		UpdateStretchLimit((_monsterEntity.MonsterTypeConfig.AutoDistanceMin == 0f) ? _cameraDistanceBaseValue : _monsterEntity.MonsterTypeConfig.AutoDistanceMin, (_monsterEntity.MonsterTypeConfig.AutoDistanceMax == 0f) ? _cameraDistanceBaseValue : _monsterEntity.MonsterTypeConfig.AutoDistanceMax, 0);
		UpdateMonsterEntityBoundOffset(_monsterEntity.MonsterTypeConfig.CamRelativeOffset.ToVector3(), _monsterEntity.MonsterTypeConfig.CamAbsoluteOffset.ToVector3(), 0);
		UpdateCameraStretchDeterminationDistance(_monsterEntity.MonsterTypeConfig.AutoDistTrigger, 0);
		UpdateCameraStretchSpeed(_monsterEntity.MonsterTypeConfig.AutoDistSpeed, 0);
	}

	public void BattleResumeCameraBaseDistance()
	{
		if (SystemIsNeedExecute)
		{
			_battleVirtualCamera.transform.eulerAngles = world.CameraConfig.battleCameraBaseData.cameraRotate;
			CinemachineFramingTransposerAp cinemachineComponent = _battleVirtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>();
			if ((bool)cinemachineComponent)
			{
				cinemachineComponent.m_XDamping = world.CameraConfig.battleCameraBaseData.cameraDamp.x;
				cinemachineComponent.m_YDamping = world.CameraConfig.battleCameraBaseData.cameraDamp.y;
				cinemachineComponent.m_ZDamping = world.CameraConfig.battleCameraBaseData.cameraDamp.z;
				_adsorptionStartCameraDis = cinemachineComponent.m_CameraDistance;
				_startLerpPoint = GetVirtualCameraOffset(CameraKey.BattleCamera);
			}
			UpdateMonsterEntityBoundRadius(world.CameraConfig.monsterRadius, 0);
			UpdateMonsterEntityBoundOffset(world.CameraConfig.monsterBoundOffset, Vector3.zero, 0);
			AdjustVirtualCameraOffset(CameraKey.BattleCamera, world.CameraConfig.battleCameraBaseData.cameraOffset);
		}
	}

	public void SetLevelBattleCameraPriority(bool battleCameraBaseData)
	{
		if (battleCameraBaseData)
		{
			_battleVirtualCamera.Priority = world.CameraConfig.battleCameraBaseData.battleCameraProperty;
		}
		else
		{
			_battleVirtualCamera.Priority = world.CameraConfig.levelBattleCameraPriority;
		}
	}

	public void SetBattleCameraInLevelBattle()
	{
		CinemachineVirtualCamera activeVirtualCamera = GetActiveVirtualCamera();
		_battleVirtualCamera.transform.eulerAngles = activeVirtualCamera.transform.eulerAngles;
		_battleVirtualCamera.m_Lens.FieldOfView = activeVirtualCamera.m_Lens.FieldOfView;
		CinemachineFramingTransposer cinemachineComponent = activeVirtualCamera.GetCinemachineComponent<CinemachineFramingTransposer>();
		if (cinemachineComponent != null)
		{
			AdjustCameraBaseDistance(cinemachineComponent.m_CameraDistance, 0f);
			_cameraDistanceBaseValue = cinemachineComponent.m_CameraDistance;
			AdjustVirtualCameraDistance(CameraKey.BattleCamera, cinemachineComponent.m_CameraDistance);
		}
	}

	private float Frame2Time(int tick)
	{
		int num = (GameSettingExtension.GetIntRawValue("帧率") + 1) * 30;
		float num2 = 1f / (float)num;
		float num3 = (float)num / 30f;
		return (float)Mathf.RoundToInt((float)tick * num3) * num2;
	}

	private float GetAppearDelateTime()
	{
		int num = (GameSettingExtension.GetIntRawValue("帧率") + 1) * 30;
		return 1f / (float)num;
	}

	public void OnMonsterRelease()
	{
		_monsterEntity = null;
		HideAdsorption();
	}

	private void InitBoundData()
	{
		if (_battleCamera != null)
		{
			_heroActivitiesRadius = world.CameraConfig.heroGazeScopeX;
		}
		UpdateEntityBoundData();
	}

	private void UpdateEntityBoundData()
	{
		if (!(_battleCamera == null))
		{
			UpdateBoundRadius();
			_heroCenter = TSUtil.TransformPoint(HeroPosition(), HeroEulerAngles(), Vector3.one, _heroBoundOffset);
			_monsterCenter = TSUtil.TransformPoint(MonsterPosition() + _monsterBoundAbsoluteOffset, MonsterEulerAngles(), Vector3.one, _monsterBoundOffset);
			_monsterToHeroLine = new Line(_heroCenter, _monsterCenter);
		}
	}

	private void UpdateBoundRadius()
	{
		if (_isLerpBound)
		{
			float num = 0f;
			if (_adjustBoundTimer == 0f)
			{
				num = 1f;
			}
			else
			{
				_lerpTimer += _deltaTime;
				num = _lerpTimer / _adjustBoundTimer;
			}
			if (_isLerpRadius)
			{
				_monsterRadius3D = Mathf.Lerp(_startAdjustBoundRadius, _endAdjustBoundRadius, num);
			}
			if (_isLerpOffset)
			{
				_monsterBoundOffset = Vector3.Lerp(_startMonsterBoundOffset, _endMonsterBoundOffset, num);
				_monsterBoundAbsoluteOffset = Vector3.Lerp(_startMonsterBoundAbsoluteOffset, _endMonsterBoundAbsoluteOffset, num);
			}
			if (num >= 1f)
			{
				_lerpTimer = 0f;
				_isLerpBound = false;
				_isLerpRadius = false;
				_isLerpOffset = false;
			}
		}
	}

	public void UpdateEntityRadius(float heroRadius, float monsterRadius)
	{
		_heroRadius3D = heroRadius;
		UpdateMonsterEntityBoundRadius(monsterRadius, 0);
	}

	public void UpdateMonsterEntityBoundRadius(float monsterRadius, int adjustTick)
	{
		_startAdjustBoundRadius = _monsterRadius3D;
		_endAdjustBoundRadius = monsterRadius;
		_isLerpRadius = true;
		_adjustBoundTimer = Frame2Time(adjustTick);
		_isLerpBound = true;
	}

	public void UpdateEntityBoundOffset(Vector3 heroBoundOffset, Vector3 monsterBoundOffset, Vector3 monsterBoundAbsoluteOffset)
	{
		_heroBoundOffset = heroBoundOffset;
		_monsterBoundOffset = monsterBoundOffset;
		_monsterBoundAbsoluteOffset = monsterBoundAbsoluteOffset;
	}

	public void UpdateMonsterEntityBoundOffset(Vector3 monsterBoundOffset, Vector3 monsterBoundAbsoluteOffset, int adjustTick)
	{
		_startMonsterBoundOffset = _monsterBoundOffset;
		_endMonsterBoundOffset = monsterBoundOffset;
		_startMonsterBoundAbsoluteOffset = _monsterBoundAbsoluteOffset;
		_endMonsterBoundAbsoluteOffset = monsterBoundAbsoluteOffset;
		_isLerpOffset = true;
		_adjustBoundTimer = Frame2Time(adjustTick);
		_isLerpBound = true;
	}

	public void ReductionStretchBoundParam(bool reductionBoundRadius, bool reductionBoundPosition, int adjustTick)
	{
		if (_monsterEntity != null && _monsterEntity.MonsterTypeConfig != null)
		{
			if (reductionBoundPosition)
			{
				UpdateMonsterEntityBoundOffset(_monsterEntity.MonsterTypeConfig.CamRelativeOffset.ToVector3(), _monsterEntity.MonsterTypeConfig.CamAbsoluteOffset.ToVector3(), adjustTick);
			}
			if (reductionBoundRadius)
			{
				UpdateMonsterEntityBoundRadius(_monsterEntity.MonsterTypeConfig.CamRadius, adjustTick);
			}
		}
	}

	private Vector2 FilterHitPoint(Vector2 startPoint, List<Vector2> hitPoint, float tempValue = 0.01f)
	{
		for (int i = 0; i < hitPoint.Count; i++)
		{
			if (Mathf.Abs(hitPoint[i].x - startPoint.x) > tempValue && Mathf.Abs(hitPoint[i].y - startPoint.y) > tempValue)
			{
				return hitPoint[i];
			}
		}
		return new Vector2(-1f, -1f);
	}

	private Vector2 GetScreenRectPoint(Direction direction, ScreenRect screenRect)
	{
		return direction switch
		{
			Direction.LeftDown => screenRect.Rect.min, 
			Direction.RightUp => screenRect.Rect.max, 
			Direction.LeftUp => new Vector2(screenRect.Rect.min.x, screenRect.Rect.min.y + screenRect.Rect.height), 
			Direction.RightDown => new Vector2(screenRect.Rect.min.x + screenRect.Rect.width, screenRect.Rect.min.y), 
			Direction.Horizontal => new Vector2(screenRect.Rect.min.x + screenRect.Rect.width, screenRect.Rect.min.y), 
			_ => new Vector2(-1f, -1f), 
		};
	}

	private Direction GetRelativePosition(Vector2 pointA, Vector2 pointB, float threshold = 0.1f)
	{
		float num = pointA.x - pointB.x;
		float num2 = pointA.y - pointB.y;
		int num3 = 0;
		int num4 = 0;
		if (Mathf.Abs(num) > threshold)
		{
			num3 = ((num > 0f) ? 10 : 20);
		}
		if (Mathf.Abs(num2) > threshold)
		{
			num4 = ((num2 > 0f) ? 1 : 2);
		}
		switch (num3 + num4)
		{
		case 0:
			return Direction.Center;
		case 10:
		case 20:
			return Direction.Horizontal;
		case 1:
			return Direction.VerticalUp;
		case 2:
			return Direction.VerticalDown;
		case 11:
			return Direction.RightUp;
		case 21:
			return Direction.LeftUp;
		case 22:
			return Direction.LeftDown;
		default:
			return Direction.RightDown;
		}
	}

	private void InitAdjustDistanceData()
	{
		_adjustMinDistanceLimit = world.CameraConfig.distanceMin;
		_adjustMaxDistanceLimit = world.CameraConfig.distanceMax;
		_commandIndex = 0;
	}

	private BaseAdjustDistanceData GetDistanceCommand(CameraKey cameraKey)
	{
		for (int i = 0; i < _currentDistanceCommandList.Count; i++)
		{
			if (_currentDistanceCommandList[i] != null && _currentDistanceCommandList[i].CameraKey == cameraKey)
			{
				return _currentDistanceCommandList[i];
			}
		}
		return null;
	}

	public int CreateRateAdjustDistanceData(CameraKey cameraKey, Vector3 lerpSpeed, bool isAdjustCameraBaseDistance, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, ChangeValueType changeValueType, float changeValue, float changeRateValue, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return -1;
		}
		BaseAdjustDistanceData distanceCommand = GetDistanceCommand(cameraKey);
		if (distanceCommand != null)
		{
			if ((distanceCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || distanceCommand.AdjustCameraState != AdjustCameraState.ShowTime || distanceCommand.Priority > priority) && (distanceCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || distanceCommand.AdjustCameraState == AdjustCameraState.ShowTime) && (distanceCommand.CameraPriorityType != ChangeCameraPriorityType.AllProgress || distanceCommand.Priority > priority))
			{
				return -1;
			}
			DelDistanceCommand(cameraKey);
		}
		if (_adsorptionTransition == AdsorptionTransitionState.ExitAdsorption)
		{
			return -1;
		}
		distanceCommand = CreateRateCommand(cameraKey, tick, isOpenCurveLerp, animationCurve, priority, changeValueType, changeValue, changeRateValue, cameraPriorityType);
		if (isAdjustCameraBaseDistance && cameraKey == CameraKey.BattleCamera)
		{
			_cameraDistanceBaseValue = distanceCommand.TargetDistance;
		}
		AdjustVirtualCameraLerpSpeed(cameraKey, lerpSpeed);
		_currentDistanceCommandList.Add(distanceCommand);
		return distanceCommand.CommandId;
	}

	public int CreateFixedAdjustDistanceData(CameraKey cameraKey, Vector3 lerpSpeed, bool isAdjustCameraBaseDistance, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, float distanceValue, DistanceValueLimit distanceValueLimit, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return -1;
		}
		BaseAdjustDistanceData distanceCommand = GetDistanceCommand(cameraKey);
		if (distanceCommand != null)
		{
			if ((distanceCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || distanceCommand.AdjustCameraState != AdjustCameraState.ShowTime || distanceCommand.Priority > priority) && (distanceCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || distanceCommand.AdjustCameraState == AdjustCameraState.ShowTime) && (distanceCommand.CameraPriorityType != ChangeCameraPriorityType.AllProgress || distanceCommand.Priority > priority))
			{
				return -1;
			}
			DelDistanceCommand(cameraKey);
		}
		distanceCommand = CreateFixedCommand(cameraKey, tick, isOpenCurveLerp, animationCurve, priority, distanceValue, distanceValueLimit, cameraPriorityType);
		if (distanceCommand == null)
		{
			return -1;
		}
		distanceCommand.CameraKey = cameraKey;
		if (isAdjustCameraBaseDistance && cameraKey == CameraKey.BattleCamera)
		{
			_cameraDistanceBaseValue = distanceCommand.TargetDistance;
		}
		AdjustVirtualCameraLerpSpeed(cameraKey, lerpSpeed);
		_currentDistanceCommandList.Add(distanceCommand);
		return distanceCommand.CommandId;
	}

	private RateAdjustDistanceData CreateRateCommand(CameraKey cameraKey, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, ChangeValueType changeValueType, float changeValue, float changeRateValue, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		RateAdjustDistanceData rateAdjustDistanceData = ReferencePool.Acquire<RateAdjustDistanceData>();
		rateAdjustDistanceData.CameraKey = cameraKey;
		rateAdjustDistanceData.ShowTimer = Frame2Time(tick);
		rateAdjustDistanceData.IsOpenCurveLerp = isOpenCurveLerp;
		rateAdjustDistanceData.AnimationCurve = animationCurve;
		rateAdjustDistanceData.Priority = priority;
		rateAdjustDistanceData.ExecuteTime = 0f;
		rateAdjustDistanceData.StartDistance = GetTran(cameraKey).m_CameraDistance;
		rateAdjustDistanceData.CommandId = _commandIndex++;
		rateAdjustDistanceData.ChangeType = changeValueType;
		rateAdjustDistanceData.ChangeValue = changeValue;
		rateAdjustDistanceData.ChangeRateValue = changeRateValue;
		rateAdjustDistanceData.AdjustCameraState = AdjustCameraState.ShowTime;
		rateAdjustDistanceData.CameraPriorityType = cameraPriorityType;
		rateAdjustDistanceData.ComputerTargetDistance(_adjustMinDistanceLimit, _adjustMaxDistanceLimit, rateAdjustDistanceData.StartDistance, GetCameraBaseData(rateAdjustDistanceData.CameraKey)?.cameraDistance ?? 30);
		return rateAdjustDistanceData;
	}

	private FixedAdjustDistanceData CreateFixedCommand(CameraKey cameraKey, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, float distanceValue, DistanceValueLimit distanceValueLimit, ChangeCameraPriorityType cameraPriorityType)
	{
		FixedAdjustDistanceData fixedAdjustDistanceData = ReferencePool.Acquire<FixedAdjustDistanceData>();
		fixedAdjustDistanceData.ShowTimer = Frame2Time(tick);
		fixedAdjustDistanceData.IsOpenCurveLerp = isOpenCurveLerp;
		fixedAdjustDistanceData.AnimationCurve = animationCurve;
		fixedAdjustDistanceData.Priority = priority;
		fixedAdjustDistanceData.ExecuteTime = 0f;
		fixedAdjustDistanceData.StartDistance = GetTran(cameraKey).m_CameraDistance;
		fixedAdjustDistanceData.CommandId = _commandIndex++;
		fixedAdjustDistanceData.AdjustCameraState = AdjustCameraState.ShowTime;
		fixedAdjustDistanceData.DistanceValue = distanceValue;
		fixedAdjustDistanceData.DistanceLimit = distanceValueLimit;
		fixedAdjustDistanceData.CameraPriorityType = cameraPriorityType;
		if (!fixedAdjustDistanceData.ComputerTargetDistance(fixedAdjustDistanceData.StartDistance))
		{
			ReferencePool.Release(fixedAdjustDistanceData);
			return null;
		}
		return fixedAdjustDistanceData;
	}

	public void ReductionDistance(CameraKey cameraKey, int reductionTick, int indexReduction, Vector3 lerpSpeed, bool reductionCameraBaseDistance)
	{
		if (_adsorptionTransition == AdsorptionTransitionState.StartTransition2Adsorption || _adsorptionTransition == AdsorptionTransitionState.ExitAdsorption)
		{
			_currentDistanceCommandList.Clear();
			return;
		}
		BaseAdjustDistanceData distanceCommand = GetDistanceCommand(cameraKey);
		if (distanceCommand != null && distanceCommand.CommandId == indexReduction)
		{
			distanceCommand.ExecuteTime = 0f;
			distanceCommand.ReductionTime = Frame2Time(reductionTick);
			distanceCommand.AdjustCameraState = AdjustCameraState.ReductionState;
			distanceCommand.StartReductionDistance = GetTran(cameraKey).m_CameraDistance;
			if (reductionCameraBaseDistance)
			{
				_cameraDistanceBaseValue = world.CameraConfig.cameraDistanceBaseValue;
			}
			AdjustVirtualCameraLerpSpeed(distanceCommand.CameraKey, lerpSpeed);
		}
	}

	public void AdjustCameraBaseDistance(float baseDistance, float lerpTime)
	{
		_startLerpCameraDistanceBaseValue = _cameraDistanceBaseValue;
		_endLerpCameraDistanceBaseValue = baseDistance;
		_lerpDistanceTimer = lerpTime;
		_isStartDistanceLerp = true;
	}

	public void ResumeCameraBaseDistance(float lerpTime)
	{
		_startLerpCameraDistanceBaseValue = _cameraDistanceBaseValue;
		_endLerpCameraDistanceBaseValue = world.CameraConfig.cameraDistanceBaseValue;
		_lerpDistanceTimer = lerpTime;
		_isStartDistanceLerp = true;
	}

	private void UpdateCameraDistance()
	{
		for (int i = 0; i < _currentDistanceCommandList.Count; i++)
		{
			UpdateCameraDistance(_currentDistanceCommandList[i]);
		}
	}

	private void UpdateCameraDistance(BaseAdjustDistanceData distanceCommand)
	{
		if (distanceCommand == null)
		{
			return;
		}
		Vector3 vector = CurrentCameraAngle(distanceCommand.CameraKey);
		float y = CurrentCurrentFollowPoint(distanceCommand.CameraKey).y;
		if (distanceCommand.AdjustCameraState == AdjustCameraState.ShowTime)
		{
			float num = Mathf.Sin(vector.x * (MathF.PI / 180f)) * distanceCommand.TargetDistance + GetVirtualCameraTrackedObjectOffset(distanceCommand.CameraKey).y + y;
			distanceCommand.ShowTime(_deltaTime, distanceCommand.StartDistance, distanceCommand.TargetDistance, distanceCommand.ShowTimer, out var progress);
			AdjustVirtualCameraDistance(distanceCommand.CameraKey, progress);
			float y2 = CurrentCameraPosition(distanceCommand.CameraKey).y;
			if (Mathf.Abs(num - y2) <= 0.05f)
			{
				EndCustomAdjustDistance(distanceCommand);
			}
		}
		if (distanceCommand.AdjustCameraState == AdjustCameraState.ReductionState)
		{
			float progress2 = 0f;
			float num2 = 0f;
			if (distanceCommand.CameraKey == CameraKey.BattleCamera)
			{
				float num3 = (_isOpenCameraStretch ? _dynamicStretchDistance : _cameraDistanceBaseValue);
				num2 = Mathf.Sin(vector.x * (MathF.PI / 180f)) * num3 + GetVirtualCameraTrackedObjectOffset(distanceCommand.CameraKey).y + y;
				distanceCommand.ValueLerp(_deltaTime, distanceCommand.StartReductionDistance, num3, distanceCommand.ReductionTime, out progress2);
			}
			else
			{
				num2 = Mathf.Sin(vector.x * (MathF.PI / 180f)) * _cameraDistanceBaseValue + GetVirtualCameraTrackedObjectOffset(distanceCommand.CameraKey).y;
				distanceCommand.ValueLerp(_deltaTime, distanceCommand.StartReductionDistance, _cameraDistanceBaseValue, distanceCommand.ReductionTime, out progress2);
			}
			AdjustVirtualCameraDistance(distanceCommand.CameraKey, progress2);
			float y3 = CurrentCameraPosition(distanceCommand.CameraKey).y;
			if (Mathf.Abs(num2 - y3) <= 0.05f)
			{
				DelDistanceCommand(distanceCommand.CameraKey);
			}
		}
	}

	private void EndCustomAdjustDistance(BaseAdjustDistanceData distanceCommand)
	{
		distanceCommand.AdjustCameraState = AdjustCameraState.WaitReductionState;
		distanceCommand.ExecuteTime = 0f;
	}

	private void DelDistanceCommand(CameraKey cameraKey)
	{
		AdjustVirtualCameraLerpSpeed(cameraKey, GetCameraBaseData(cameraKey)?.cameraDamp ?? (Vector3.one * 0.5f));
		BaseAdjustDistanceData distanceCommand = GetDistanceCommand(cameraKey);
		if (distanceCommand != null)
		{
			_currentDistanceCommandList.Remove(distanceCommand);
			ReferencePool.Release(distanceCommand);
		}
	}

	private bool IsCanAdsorptionStateStretchCamera()
	{
		BaseAdjustDistanceData distanceCommand = GetDistanceCommand(CameraKey.BattleCamera);
		if (distanceCommand == null)
		{
			return true;
		}
		if (distanceCommand.AdjustCameraState == AdjustCameraState.Null)
		{
			return true;
		}
		return false;
	}

	private void InitAdjustFovData()
	{
		_adjustBattleCameraFov = world.CameraConfig.battleCameraBaseData.cameraFov;
		_adjustUItimateCameraFov = world.CameraConfig.ultimateSkillCameraBaseData.cameraFov;
	}

	public int CreateAdjustFovData(CameraKey cameraKey, int priority, Adjust adjust, float changeValue, float fixedValue, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return -1;
		}
		AdjustFOVData fovCommand = GetFovCommand(cameraKey);
		if (fovCommand != null)
		{
			if ((fovCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || fovCommand.AdjustCameraState != AdjustCameraState.ShowTime || fovCommand.Priority > priority) && (fovCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || fovCommand.AdjustCameraState == AdjustCameraState.ShowTime) && (fovCommand.CameraPriorityType != ChangeCameraPriorityType.AllProgress || fovCommand.Priority > priority))
			{
				return -1;
			}
			DelFovCommand(cameraKey);
		}
		float targetFov = 0f;
		switch (adjust)
		{
		case Adjust.ChangeValue:
			targetFov = GetCameraFov(cameraKey) + changeValue;
			break;
		case Adjust.FixedValue:
			targetFov = fixedValue;
			break;
		}
		fovCommand = CreateFovCommand(cameraKey, priority, targetFov, tick, isOpenCurveLerp, animationCurve, cameraPriorityType);
		_currentFovCommandList.Add(fovCommand);
		return fovCommand.CommandId;
	}

	private AdjustFOVData CreateFovCommand(CameraKey cameraKey, int priority, float targetFov, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		AdjustFOVData adjustFOVData = ReferencePool.Acquire<AdjustFOVData>();
		adjustFOVData.AdjustCameraState = AdjustCameraState.ShowTime;
		adjustFOVData.CameraKey = cameraKey;
		adjustFOVData.Priority = priority;
		adjustFOVData.AnimationCurve = animationCurve;
		adjustFOVData.ExecuteTime = 0f;
		adjustFOVData.TargetFov = targetFov;
		adjustFOVData.CameraPriorityType = cameraPriorityType;
		adjustFOVData.IsOpenCurveLerp = isOpenCurveLerp;
		adjustFOVData.CommandId = _commandIndex++;
		adjustFOVData.ShowTimer = Frame2Time(tick);
		adjustFOVData.StartFov = GetCameraFov(cameraKey);
		if (cameraKey == CameraKey.BattleCamera)
		{
			adjustFOVData.EndReductionFov = _adjustBattleCameraFov;
		}
		else
		{
			adjustFOVData.EndReductionFov = _adjustUItimateCameraFov;
		}
		return adjustFOVData;
	}

	private void UpdateCameraFov()
	{
		for (int i = 0; i < _currentFovCommandList.Count; i++)
		{
			UpdateCameraFov(_currentFovCommandList[i]);
		}
	}

	private void UpdateCameraFov(AdjustFOVData fovCommand)
	{
		if (fovCommand == null)
		{
			return;
		}
		if (fovCommand.AdjustCameraState == AdjustCameraState.ShowTime)
		{
			fovCommand.ShowTime(_deltaTime, fovCommand.StartFov, fovCommand.TargetFov, fovCommand.ShowTimer, out var progress);
			AdjustVirtualCameraFov(fovCommand.CameraKey, progress);
			if (Mathf.Abs(progress - fovCommand.TargetFov) <= 0.0001f)
			{
				EndCustomAdjustFov(fovCommand);
			}
		}
		if (fovCommand.AdjustCameraState == AdjustCameraState.ReductionState)
		{
			fovCommand.ValueLerp(_deltaTime, fovCommand.StartReductionFov, fovCommand.EndReductionFov, fovCommand.ReductionTime, out var progress2);
			AdjustVirtualCameraFov(fovCommand.CameraKey, progress2);
			CurrentCameraPosition(fovCommand.CameraKey);
			if (Mathf.Abs(progress2 - fovCommand.EndReductionFov) <= 0.0001f)
			{
				DelFovCommand(fovCommand.CameraKey);
			}
		}
	}

	private void EndCustomAdjustFov(AdjustFOVData fovCommand)
	{
		fovCommand.AdjustCameraState = AdjustCameraState.WaitReductionState;
		fovCommand.ExecuteTime = 0f;
	}

	public void ReductionFov(CameraKey cameraKey, int reductionTick, int indexReduction)
	{
		AdjustFOVData fovCommand = GetFovCommand(cameraKey);
		if (fovCommand != null && fovCommand.CommandId == indexReduction)
		{
			fovCommand.ExecuteTime = 0f;
			fovCommand.ReductionTime = Frame2Time(reductionTick);
			fovCommand.StartReductionFov = GetCameraFov(cameraKey);
			fovCommand.AdjustCameraState = AdjustCameraState.ReductionState;
		}
	}

	private void DelFovCommand(CameraKey cameraKey)
	{
		AdjustFOVData fovCommand = GetFovCommand(cameraKey);
		if (fovCommand != null)
		{
			_currentFovCommandList.Remove(fovCommand);
			ReferencePool.Release(fovCommand);
		}
	}

	private AdjustFOVData GetFovCommand(CameraKey cameraKey)
	{
		for (int i = 0; i < _currentFovCommandList.Count; i++)
		{
			if (_currentFovCommandList[i] != null && _currentFovCommandList[i].CameraKey == cameraKey)
			{
				return _currentFovCommandList[i];
			}
		}
		return null;
	}

	private void AdjustVirtualCameraFov(CameraKey cameraKey, float fovValue)
	{
		if (SystemIsNeedExecute)
		{
			CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
			if (!(virtualCamera == null))
			{
				virtualCamera.m_Lens.FieldOfView = fovValue;
			}
		}
	}

	private float GetCameraFov(CameraKey cameraKey)
	{
		return GetVirtualCamera(cameraKey).m_Lens.FieldOfView;
	}

	public void MakeImpulse(MakeImpulseSourceData makeImpulseSourceData)
	{
		if (_makeImpulseSourceDatas == null)
		{
			_makeImpulseSourceDatas = new List<MakeImpulseSourceData>(5);
		}
		AddImpulseSource(makeImpulseSourceData);
		makeImpulseSourceData.ImpulseNums--;
		if (makeImpulseSourceData.ImpulseNums <= 0f)
		{
			ReferencePool.Release(makeImpulseSourceData);
			return;
		}
		makeImpulseSourceData.Timer = makeImpulseSourceData.ImpulseInterval;
		_makeImpulseSourceDatas.Add(makeImpulseSourceData);
	}

	private void AddImpulseSource(MakeImpulseSourceData data)
	{
		CinemachineCustomImpulseDefinition obj = new CinemachineCustomImpulseDefinition
		{
			m_ImpulseChannel = 1,
			m_ImpulseShape = CinemachineCustomImpulseDefinition.ImpulseShapes.Custom,
			m_CustomImpulseShape = data.ImpulseForceCurve,
			m_ImpulseType = CinemachineCustomImpulseDefinition.ImpulseTypes.Propagating,
			m_DissipationDistance = data.ImpulseDistance,
			m_PropagationSpeed = data.ImpulseSpeed
		};
		Vector3 vector = Vector3.zero;
		if (data.ImpulsePosEntityId != 0)
		{
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(data.ImpulsePosEntityId);
			if (entity != null && !string.IsNullOrEmpty(data.ImpulsePosPoint))
			{
				vector = entity.GetComponent<EntityBoneComponent>().GetBonePosition(data.ImpulsePosPoint);
			}
		}
		else
		{
			vector = data.ImpulsePosition;
		}
		vector += data.ImpulsePositionOffset;
		CinemachineCustomImpulseManager.ImpulseEvent impulseEvent = obj.CreateAndReturnEvent(vector, data.ImpulseDir * data.ImpulseForce);
		if (impulseEvent != null)
		{
			CinemachineCustomImpulseListener cinemachineCustomImpulseListener = AddImpulseListener(data);
			if (!(cinemachineCustomImpulseListener == null))
			{
				cinemachineCustomImpulseListener.SourcePos = vector;
				impulseEvent.BingListener = cinemachineCustomImpulseListener;
				allListeners.Add(cinemachineCustomImpulseListener);
			}
		}
	}

	public CinemachineCustomImpulseListener AddImpulseListener(MakeImpulseSourceData data)
	{
		CinemachineVirtualCamera activeVirtualCamera = GetActiveVirtualCamera();
		if (activeVirtualCamera == null)
		{
			return null;
		}
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(world.ActorId);
		if (entity == null)
		{
			return null;
		}
		CinemachineCustomImpulseListener cinemachineCustomImpulseListener = activeVirtualCamera.gameObject.AddComponent<CinemachineCustomImpulseListener>();
		cinemachineCustomImpulseListener.m_ChannelMask = 1;
		cinemachineCustomImpulseListener.m_ApplyAfter = CinemachineCore.Stage.Noise;
		cinemachineCustomImpulseListener.m_ReactionSettings.m_AmplitudeGain = data.IntensityInit;
		cinemachineCustomImpulseListener.m_ReactionSettings.m_FrequencyGain = data.frequency;
		cinemachineCustomImpulseListener.m_ReactionSettings.m_Duration = data.duration;
		cinemachineCustomImpulseListener.m_UseCameraSpace = true;
		cinemachineCustomImpulseListener.m_ReactionSettings.m_SecondaryNoise = GetNoiseData(data.NoiseName)?.noiseSettings;
		cinemachineCustomImpulseListener.m_ReactionSettings.SetAnimationCurve(data.StrengCurve, data.DistanceStrengCurve, data.FrequencyCurve);
		cinemachineCustomImpulseListener.m_ReactionSettings.UseRandomNoise = data.UseRandomNoise;
		cinemachineCustomImpulseListener.FollowTrans = entity.GetComponent<EntityViewComponent>().Transform;
		cinemachineCustomImpulseListener.PriorityCurve = data.ImpulsePriorityCurve;
		cinemachineCustomImpulseListener.PriorityInit = data.ImpulsePriorityInit;
		cinemachineCustomImpulseListener.PriorityDisCurve = data.ImpulsePriorityDisCurve;
		cinemachineCustomImpulseListener.DissipationDistance = data.ImpulseDistance;
		cinemachineCustomImpulseListener.BlendAmplitudeDuration = data.BlendTime;
		cinemachineCustomImpulseListener.IgnoreImpuseEffect = ActorIdIgnoreImpulse;
		CinemachineCustomImpulseManager.Instance.AddListener(cinemachineCustomImpulseListener);
		return cinemachineCustomImpulseListener;
	}

	private void UpdateImpulse(float delateTime)
	{
		ExecuteMoreTimeImpulse(delateTime);
		UpdateListener(delateTime);
	}

	private void ExecuteMoreTimeImpulse(float delateTime)
	{
		if (_makeImpulseSourceDatas == null)
		{
			return;
		}
		for (int i = 0; i < _makeImpulseSourceDatas.Count; i++)
		{
			MakeImpulseSourceData makeImpulseSourceData = _makeImpulseSourceDatas[i];
			makeImpulseSourceData.Timer -= delateTime;
			if (makeImpulseSourceData.Timer <= 0f)
			{
				AddImpulseSource(makeImpulseSourceData);
				makeImpulseSourceData.ImpulseNums--;
				makeImpulseSourceData.Timer = makeImpulseSourceData.ImpulseInterval;
				if (makeImpulseSourceData.ImpulseNums <= 0f)
				{
					_makeImpulseSourceDatas.RemoveAt(i);
					ReferencePool.Release(makeImpulseSourceData);
					i--;
				}
			}
		}
	}

	private void UpdateListener(float delateTime)
	{
		if (allListeners == null)
		{
			return;
		}
		for (int i = 0; i < allListeners.Count; i++)
		{
			CinemachineCustomImpulseListener cinemachineCustomImpulseListener = allListeners[i];
			if (cinemachineCustomImpulseListener != null)
			{
				cinemachineCustomImpulseListener.ImpulseTimer -= delateTime;
				continue;
			}
			allListeners.RemoveAt(i);
			i--;
		}
	}

	public void TreeStopRemoveImpulse(int removeIndex)
	{
		for (int i = 0; i < _makeImpulseSourceDatas.Count; i++)
		{
			if (_makeImpulseSourceDatas[i].ImpulseUniqueIndex == removeIndex)
			{
				_makeImpulseSourceDatas.RemoveAt(i);
				i--;
			}
		}
	}

	public void SetIgnoreImpulse(bool ignoreImpulse, int entityId)
	{
		if (entityId == world.ActorId && ignoreImpulse != ActorIdIgnoreImpulse)
		{
			ActorIdIgnoreImpulse = ignoreImpulse;
			for (int i = 0; i < allListeners.Count; i++)
			{
				allListeners[i].IgnoreImpuseEffect = ignoreImpulse;
			}
		}
	}

	public override UniTask<bool> OnEnter(object data = null)
	{
		if (_vCameraPool == null)
		{
			_vCameraPool = new ObjectPool<GameObject>(new VirtualCameraFactory(world.VirCameraRoot), 5, 5);
		}
		InitCameraBrainData();
		InitNoiseData();
		InitAdjustDistanceData();
		InitAdjustAngleData();
		InitAdjustFovData();
		return base.OnEnter(data);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_battleCamera = GetSystem<CameraSystem>().BattleCamera;
		InitBoundData();
	}

	private void InitCameraBrainData()
	{
		_brain = GetSystem<CameraSystem>().BattleCamera.GetComponent<CinemachineBrain>();
		if (!(_brain == null))
		{
			_brain.m_BlendUpdateMethod = world.CameraConfig.brainUpdateMethod;
			_brain.m_UpdateMethod = world.CameraConfig.updateMethod;
			if (world.IsStoryWorld)
			{
				_brain.m_DefaultBlend.m_Time = world.CameraConfig.levelDefaultBlendTime;
				_brain.m_DefaultBlend.m_CustomCurve = world.CameraConfig.customCurveAnimationCurve;
			}
			else
			{
				_brain.m_DefaultBlend.m_Time = world.CameraConfig.battleDefaultBlendTime;
			}
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		_deltaTime = deltaTime * cameraSpeed;
		UpdateAdsorptionPoint();
		UpdateCameraShake(_deltaTime);
		UpdateCameraDistance();
		UpdateCameraOffset();
		UpdateCameraRotate();
		UpdateCameraMove(_deltaTime);
		UpdateImpulse(_deltaTime);
		UpdateCameraFov();
	}

	private CinemachineVirtualCamera GetActiveVirtualCamera()
	{
		if (_brain == null)
		{
			return null;
		}
		if (_brain.ActiveVirtualCamera == null)
		{
			return null;
		}
		if (_brain.ActiveVirtualCamera.VirtualCameraGameObject == null)
		{
			return null;
		}
		return _brain.ActiveVirtualCamera.VirtualCameraGameObject.GetComponent<CinemachineVirtualCamera>();
	}

	public override void OnGameSpeedChanged(float beforeTheChangeSpeed, float gameSpeed)
	{
		if (world.GameSpeedIgnoreEntityCount() == 0)
		{
			CinemachineCore.UniformDeltaTimeOverride = GetAppearDelateTime() * gameSpeed;
			cameraSpeed = gameSpeed;
		}
		else
		{
			CinemachineCore.UniformDeltaTimeOverride = -1f;
			cameraSpeed = 1f;
		}
	}

	private CinemachineVirtualCamera CreateVirtualCamera(CameraBaseData cameraBaseData, Transform followPoint)
	{
		if (_vCameraPool == null)
		{
			_vCameraPool = new ObjectPool<GameObject>(new VirtualCameraFactory(world.VirCameraRoot), 5);
		}
		GameObject gameObject = _vCameraPool.Allocate();
		gameObject.transform.eulerAngles = cameraBaseData.cameraRotate;
		gameObject.name = cameraBaseData.cameraName;
		CinemachineVirtualCamera component = gameObject.GetComponent<CinemachineVirtualCamera>();
		component.m_Lens.FieldOfView = cameraBaseData.cameraFov;
		component.m_Lens.NearClipPlane = cameraBaseData.nearClipPlane;
		component.m_Lens.FarClipPlane = cameraBaseData.farClipPlane;
		component.Priority = cameraBaseData.battleCameraProperty;
		component.Follow = followPoint;
		CinemachineFramingTransposerAp cinemachineComponent = component.GetCinemachineComponent<CinemachineFramingTransposerAp>();
		cinemachineComponent.m_CameraDistance = cameraBaseData.cameraDistance;
		_cameraDistanceBaseValue = cinemachineComponent.m_CameraDistance;
		cinemachineComponent.m_TrackedObjectOffset = cameraBaseData.cameraOffset;
		component.enabled = true;
		gameObject.SetActive(value: true);
		return component;
	}

	public CinemachineVirtualCamera CreateTimelineCameraByOtherCamera(CinemachineVirtualCamera battleCamera = null)
	{
		if (battleCamera == null)
		{
			battleCamera = GetVirtualCamera(CameraKey.BattleCamera);
		}
		if (_vCameraPool == null)
		{
			_vCameraPool = new ObjectPool<GameObject>(new VirtualCameraFactory(world.VirCameraRoot), 5);
		}
		GameObject gameObject = _vCameraPool.Allocate();
		CinemachineVirtualCamera orAddComponent = gameObject.GetOrAddComponent<CinemachineVirtualCamera>();
		CopyVirtualCamera(battleCamera, orAddComponent);
		gameObject.transform.rotation = battleCamera.transform.rotation;
		orAddComponent.enabled = true;
		gameObject.SetActive(value: true);
		return orAddComponent;
	}

	private void CopyVirtualCamera(CinemachineVirtualCamera sourceCamera, CinemachineVirtualCamera newCamera)
	{
		newCamera.Follow = sourceCamera.Follow;
		newCamera.LookAt = sourceCamera.LookAt;
		newCamera.m_Priority = sourceCamera.m_Priority;
		newCamera.m_Lens = sourceCamera.m_Lens;
		CinemachineFramingTransposerAp cinemachineComponent = sourceCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>();
		if ((bool)cinemachineComponent)
		{
			CinemachineFramingTransposerAp dest = newCamera.AddCinemachineComponent<CinemachineFramingTransposerAp>();
			CopyTransposerSettings(cinemachineComponent, dest);
		}
	}

	private void CopyTransposerSettings(CinemachineFramingTransposerAp source, CinemachineFramingTransposerAp dest)
	{
		dest.m_CameraDistance = source.m_CameraDistance;
		dest.m_TrackedObjectOffset = source.m_TrackedObjectOffset;
		dest.m_XDamping = source.m_XDamping;
		dest.m_YDamping = source.m_YDamping;
		dest.m_ZDamping = source.m_ZDamping;
	}

	private void CopyComposerSettings(CinemachineComposer source, CinemachineComposer dest)
	{
		dest.m_ScreenX = source.m_ScreenX;
		dest.m_ScreenY = source.m_ScreenY;
		dest.m_DeadZoneWidth = source.m_DeadZoneWidth;
		dest.m_DeadZoneHeight = source.m_DeadZoneHeight;
		dest.m_SoftZoneWidth = source.m_SoftZoneWidth;
		dest.m_SoftZoneHeight = source.m_SoftZoneHeight;
	}

	private CinemachineVirtualCamera GetVirtualCamera(CameraKey cameraKey)
	{
		return cameraKey switch
		{
			CameraKey.BattleCamera => _battleVirtualCamera, 
			CameraKey.UltimateSkill => _ultimateSkillVirtualCamera, 
			_ => null, 
		};
	}

	private CinemachineFramingTransposerAp GetTran(CameraKey cameraKey)
	{
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (virtualCamera == null)
		{
			return null;
		}
		return virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>();
	}

	private Vector3 GetVirtualCameraTrackedObjectOffset(CameraKey cameraKey)
	{
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (virtualCamera == null)
		{
			return Vector3.zero;
		}
		CinemachineFramingTransposerAp cinemachineComponent = virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>();
		if (cinemachineComponent == null)
		{
			return Vector3.zero;
		}
		return cinemachineComponent.m_TrackedObjectOffset;
	}

	public void SwitchLookAtTransform(CameraKey cameraKey, Transform transform)
	{
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (!(virtualCamera == null))
		{
			virtualCamera.m_LookAt = transform;
		}
	}

	public void AdjustVirtualCameraPriority(CameraKey cameraKey, int priority)
	{
		if (SystemIsNeedExecute)
		{
			CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
			if (!(virtualCamera == null))
			{
				virtualCamera.Priority = priority;
			}
		}
	}

	public void AdjustVirtualCameraBlendTime(float blendTime)
	{
		if (SystemIsNeedExecute)
		{
			_brain.m_DefaultBlend.m_Time = blendTime;
		}
	}

	public void AdjustBattleCameraOffset(CameraKey cameraKey, Vector3 offset)
	{
		if (!SystemIsNeedExecute)
		{
			return;
		}
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (!(virtualCamera == null))
		{
			CinemachineTransposer cinemachineComponent = virtualCamera.GetCinemachineComponent<CinemachineTransposer>();
			if (!(cinemachineComponent == null))
			{
				offset += cinemachineComponent.m_FollowOffset;
				cinemachineComponent.m_FollowOffset = offset;
			}
		}
	}

	public void AdjustBlendTime(float blendTime)
	{
		if (SystemIsNeedExecute)
		{
			_brain.m_DefaultBlend.m_Time = blendTime;
		}
	}

	private void SwitchFollowPoint(CameraKey cameraKey, Transform followPoint)
	{
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (!(virtualCamera == null) && !(virtualCamera.Follow == followPoint))
		{
			virtualCamera.Follow = followPoint;
		}
	}

	public void AdjustVirtualCameraFieldOfView(CameraKey cameraKey, float fieldOfView)
	{
		if (SystemIsNeedExecute)
		{
			CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
			if (!(virtualCamera == null))
			{
				virtualCamera.m_Lens.FieldOfView = fieldOfView;
			}
		}
	}

	private void AdjustVirtualCameraDistance(CameraKey cameraKey, float distance)
	{
		if (SystemIsNeedExecute)
		{
			CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
			if (!(virtualCamera == null))
			{
				virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_CameraDistance = distance;
			}
		}
	}

	private void AdjustVirtualCameraOffset(CameraKey cameraKey, Vector3 offset)
	{
		if (SystemIsNeedExecute)
		{
			CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
			if (!(virtualCamera == null))
			{
				virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_TrackedObjectOffset = offset;
			}
		}
	}

	private Vector3 GetVirtualCameraOffset(CameraKey cameraKey)
	{
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (virtualCamera == null)
		{
			return Vector3.zero;
		}
		return virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_TrackedObjectOffset;
	}

	private float GetVirtualCameraDistance(CameraKey cameraKey)
	{
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (virtualCamera == null)
		{
			return 0f;
		}
		return virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_CameraDistance;
	}

	private void AdjustVirtualCameraDistance(CameraKey cameraKey, Vector3 angle)
	{
		if (SystemIsNeedExecute)
		{
			CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
			if (!(virtualCamera == null))
			{
				virtualCamera.transform.eulerAngles = angle;
			}
		}
	}

	private void AdjustVirtualCameraLerpSpeed(CameraKey cameraKey, Vector3 lerpSpeed)
	{
		if (!SystemIsNeedExecute)
		{
			return;
		}
		CinemachineVirtualCamera virtualCamera = GetVirtualCamera(cameraKey);
		if (!(virtualCamera == null))
		{
			if (world.BattleWorldMode == BattleWorldMode.SyncBattle)
			{
				lerpSpeed = Vector3.zero;
			}
			virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_XDamping = lerpSpeed.x;
			virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_YDamping = lerpSpeed.y;
			virtualCamera.GetCinemachineComponent<CinemachineFramingTransposerAp>().m_ZDamping = lerpSpeed.z;
		}
	}

	public CameraBaseData GetCameraBaseData(CameraKey cameraKey)
	{
		return cameraKey switch
		{
			CameraKey.BattleCamera => world.CameraConfig.battleCameraBaseData, 
			CameraKey.UltimateSkill => world.CameraConfig.ultimateSkillCameraBaseData, 
			_ => null, 
		};
	}

	public void RestBlendTime()
	{
		if (SystemIsNeedExecute)
		{
			_brain.m_DefaultBlend.m_Time = world.CameraConfig.levelDefaultBlendTime;
		}
	}

	public bool IsBlendState()
	{
		if (!SystemIsNeedExecute)
		{
			return false;
		}
		return _brain.IsBlending;
	}

	public override void OnReset()
	{
		_vCameraPool?.Dispose();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		OnReset();
		if (_drawScreenBound != null)
		{
			_drawScreenBound = null;
		}
		_heroEntity = null;
		_monsterEntity = null;
		_battleCamera = null;
		_battleVirtualCamera = null;
		_ultimateSkillVirtualCamera = null;
		_levelTriggerVirtualCamera = null;
		_isInitCamera = false;
		foreach (BaseAdjustDistanceData currentDistanceCommand in _currentDistanceCommandList)
		{
			if (currentDistanceCommand != null)
			{
				ReferencePool.Release(currentDistanceCommand);
			}
		}
		_currentDistanceCommandList.Clear();
		_currentDistanceCommandList = null;
		foreach (AdjustRotateData currentRotateCommand in _currentRotateCommandList)
		{
			if (currentRotateCommand != null)
			{
				ReferencePool.Release(currentRotateCommand);
			}
		}
		_currentRotateCommandList.Clear();
		_currentRotateCommandList = null;
		foreach (BaseAdjustOffsetData currentOffsetCommand in _currentOffsetCommandList)
		{
			if (currentOffsetCommand != null)
			{
				ReferencePool.Release(currentOffsetCommand);
			}
		}
		_currentOffsetCommandList.Clear();
		_currentOffsetCommandList = null;
	}

	public void EnqueueLevelTriggerVirtualCamera(CinemachineVirtualCamera virtualCamera, bool lockHero, bool followHero)
	{
		if (_levelTriggerVirtualCamera != null)
		{
			_levelTriggerVirtualCamera.gameObject.SetActive(value: false);
		}
		_levelTriggerVirtualCamera = virtualCamera;
		_levelTriggerVirtualCamera.gameObject.SetActive(value: true);
	}

	public void CloseLevelTriggerVirtualCamera()
	{
		if (_levelTriggerVirtualCamera != null)
		{
			_levelTriggerVirtualCamera.gameObject.SetActive(value: false);
		}
		_levelTriggerVirtualCamera = null;
	}

	public void ModifyCameraMove(TargetPointInfo targetPointInfo, float camMoveSpeed)
	{
		_targetPointList.Add(targetPointInfo);
		_moveSpeed = camMoveSpeed;
	}

	private void HideCameraMove()
	{
		_targetPointList.Clear();
		_currentTargetPointIndex = 0;
		_currentStayTime = 0f;
		_moveSpeed = 0f;
	}

	private void UpdateCameraMove(float deltaTime)
	{
		if (_targetPointList.Count == 0)
		{
			return;
		}
		if (_currentTargetPointIndex != -1 && _targetPointList[_currentTargetPointIndex].targetPoint != null && Vector3.Distance(_tempCameraTargetPoint.position, _targetPointList[_currentTargetPointIndex].targetPoint.position) < 0.01f)
		{
			if (_currentStayTime < _targetPointList[_currentTargetPointIndex].stayTime)
			{
				_currentStayTime += deltaTime;
				return;
			}
			_currentTargetPointIndex++;
			_currentStayTime = 0f;
			if (_currentTargetPointIndex >= _targetPointList.Count)
			{
				_currentTargetPointIndex = -1;
			}
		}
		if (_currentTargetPointIndex != -1 && _targetPointList[_currentTargetPointIndex].targetPoint != null)
		{
			_tempCameraTargetPoint.position = Vector3.Lerp(_tempCameraTargetPoint.position, _targetPointList[_currentTargetPointIndex].targetPoint.position, _moveSpeed * deltaTime);
		}
		else
		{
			HideCameraMove();
		}
	}

	private BaseAdjustOffsetData GetOffsetCommand(CameraKey cameraKey)
	{
		for (int i = 0; i < _currentOffsetCommandList.Count; i++)
		{
			if (_currentOffsetCommandList[i] != null && _currentOffsetCommandList[i].CameraKey == cameraKey)
			{
				return _currentOffsetCommandList[i];
			}
		}
		return null;
	}

	public int CreateMoveCameraCommand(CameraKey cameraKey, CameraOffsetType cameraOffsetType, int entityId, string pointName, bool cameraFollowPoint, Vector3 positionOffset, Vector3 fixedOffset, Vector3 relativeOffset, Vector3 absoluteOffset, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, Vector3 lerpSpeed, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return -1;
		}
		BaseAdjustOffsetData offsetCommand = GetOffsetCommand(cameraKey);
		if (offsetCommand != null)
		{
			if ((offsetCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || offsetCommand.AdjustCameraState != AdjustCameraState.ShowTime || offsetCommand.Priority > priority) && (offsetCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || offsetCommand.AdjustCameraState == AdjustCameraState.ShowTime) && (offsetCommand.CameraPriorityType != ChangeCameraPriorityType.AllProgress || offsetCommand.Priority > priority))
			{
				return -1;
			}
			DelOffsetCommand(cameraKey);
		}
		if (_adsorptionTransition == AdsorptionTransitionState.ExitAdsorption)
		{
			return -1;
		}
		offsetCommand = CreateMoveCameraOffsetBaseCommand(tick, isOpenCurveLerp, animationCurve, priority, cameraPriorityType, cameraKey);
		switch (cameraOffsetType)
		{
		case CameraOffsetType.Offset:
			offsetCommand = CreateRelativeOffsetCommand(offsetCommand, relativeOffset, absoluteOffset);
			break;
		case CameraOffsetType.Vector3:
			offsetCommand = CreateFixedOffsetCommand(offsetCommand, fixedOffset);
			break;
		case CameraOffsetType.EntityId:
			offsetCommand = CreateEntityOffsetCommand(offsetCommand, entityId, pointName, cameraFollowPoint, positionOffset);
			break;
		}
		if (offsetCommand == null)
		{
			return -1;
		}
		AdjustVirtualCameraLerpSpeed(cameraKey, lerpSpeed);
		_currentOffsetCommandList.Add(offsetCommand);
		return offsetCommand.CommandId;
	}

	private BaseAdjustOffsetData CreateMoveCameraOffsetBaseCommand(int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, ChangeCameraPriorityType cameraPriorityType, CameraKey cameraKey)
	{
		BaseAdjustOffsetData baseAdjustOffsetData = ReferencePool.Acquire<BaseAdjustOffsetData>();
		baseAdjustOffsetData.CameraKey = cameraKey;
		baseAdjustOffsetData.ShowTimer = Frame2Time(tick);
		baseAdjustOffsetData.IsOpenCurveLerp = isOpenCurveLerp;
		baseAdjustOffsetData.AnimationCurve = animationCurve;
		baseAdjustOffsetData.Priority = priority;
		baseAdjustOffsetData.ExecuteTime = 0f;
		baseAdjustOffsetData.StartPosition = GetVirtualCameraTrackedObjectOffset(cameraKey);
		baseAdjustOffsetData.CmdStartHeroPosotion = CurrentCurrentFollowPoint(cameraKey);
		baseAdjustOffsetData.CommandId = _commandIndex++;
		baseAdjustOffsetData.AdjustCameraState = AdjustCameraState.ShowTime;
		baseAdjustOffsetData.CameraPriorityType = cameraPriorityType;
		return baseAdjustOffsetData;
	}

	private BaseAdjustOffsetData CreateEntityOffsetCommand(BaseAdjustOffsetData data, int entityId, string pointName, bool cameraFollowPoint, Vector3 offsetValue)
	{
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(entityId);
		if (entity == null)
		{
			ReferencePool.Release(data);
			return null;
		}
		if (cameraFollowPoint)
		{
			data.IsUpdateTargetPosition = true;
			data.FollowPoint = entity.GetComponent<EntityBoneComponent>()?.GetBoneRoot(pointName);
			data.PointOffsetValue = offsetValue;
			data.StartShowTimePoint = CurrentCameraCommentPoint(data.CameraKey);
			if (data.FollowPoint == null)
			{
				ReferencePool.Release(data);
				return null;
			}
		}
		else
		{
			if (entity.GetComponent<EntityBoneComponent>() == null)
			{
				ReferencePool.Release(data);
				return null;
			}
			data.TargetWorldPosition = TSUtil.TransformPoint(entity.GetComponent<EntityBoneComponent>().GetBonePosition(pointName), entity.transform.eulerAngles, Vector3.one, offsetValue);
			data.TargetPosition = TSUtil.TransformPoint(entity.GetComponent<EntityBoneComponent>().GetBonePosition(pointName), entity.transform.eulerAngles, Vector3.one, offsetValue) - CurrentCameraCommentPoint(data.CameraKey);
		}
		return data;
	}

	private BaseAdjustOffsetData CreateFixedOffsetCommand(BaseAdjustOffsetData data, Vector3 fixedPosition)
	{
		data.TargetWorldPosition = fixedPosition;
		data.TargetPosition = fixedPosition - CurrentCameraCommentPoint(data.CameraKey);
		return data;
	}

	private BaseAdjustOffsetData CreateRelativeOffsetCommand(BaseAdjustOffsetData data, Vector3 relativeOffset, Vector3 absoluteOffset)
	{
		if (_heroEntity == null)
		{
			ReferencePool.Release(data);
			return null;
		}
		data.TargetPosition = TSUtil.TransformPoint(GetVirtualCameraTrackedObjectOffset(data.CameraKey) + absoluteOffset, _heroEntity.transform.eulerAngles, Vector3.one, relativeOffset);
		data.TargetWorldPosition = data.TargetPosition + CurrentCurrentFollowPoint(data.CameraKey);
		return data;
	}

	private void UpdateCameraOffset()
	{
		for (int i = 0; i < _currentOffsetCommandList.Count; i++)
		{
			UpdateCameraOffset(_currentOffsetCommandList[i]);
		}
	}

	private void UpdateCameraOffset(BaseAdjustOffsetData offsetCommand)
	{
		if (offsetCommand == null)
		{
			return;
		}
		offsetCommand.UpdateTargetPosition();
		if (offsetCommand.AdjustCameraState == AdjustCameraState.ShowTime)
		{
			float num = offsetCommand.ShowTime(_deltaTime, offsetCommand.ShowTimer, offsetCommand.StartPosition, offsetCommand.TargetPosition, out var progress);
			progress += offsetCommand.CmdStartHeroPosotion - CurrentCurrentFollowPoint(offsetCommand.CameraKey);
			AdjustVirtualCameraOffset(offsetCommand.CameraKey, progress);
			if (CheckVector3(GetVirtualCameraOffset(offsetCommand.CameraKey), offsetCommand.TargetPosition) && num >= 1f)
			{
				EndCustomAdjustOffset(offsetCommand);
			}
		}
		if (offsetCommand.AdjustCameraState == AdjustCameraState.WaitReductionState)
		{
			AdjustVirtualCameraOffset(offsetCommand.CameraKey, offsetCommand.TargetWorldPosition - CurrentCurrentFollowPoint(offsetCommand.CameraKey));
		}
		if (offsetCommand.AdjustCameraState == AdjustCameraState.ReductionState)
		{
			Vector3 vector = ((offsetCommand.CameraKey != CameraKey.BattleCamera) ? GetCameraBaseData(offsetCommand.CameraKey).cameraOffset : ((_adsorptionTransition == AdsorptionTransitionState.Adsorption) ? _adsorptionOffsetPosition : GetCameraBaseData(offsetCommand.CameraKey).cameraOffset));
			if (offsetCommand.CameraKey == CameraKey.BattleCamera)
			{
				offsetCommand.LineAdjustOffsetVector(_deltaTime, offsetCommand.ReductionTick, offsetCommand.StartReductionPosition, vector, out var progress2);
				AdjustVirtualCameraOffset(offsetCommand.CameraKey, progress2);
			}
			else
			{
				offsetCommand.LineAdjustOffsetVector(_deltaTime, offsetCommand.ReductionTick, offsetCommand.StartReductionPosition, vector, out var progress3);
				AdjustVirtualCameraOffset(offsetCommand.CameraKey, progress3);
			}
			if (CheckVector3(GetVirtualCameraOffset(offsetCommand.CameraKey), vector))
			{
				DelOffsetCommand(offsetCommand.CameraKey);
			}
		}
	}

	private void EndCustomAdjustOffset(BaseAdjustOffsetData offsetCommand)
	{
		offsetCommand.AdjustCameraState = AdjustCameraState.WaitReductionState;
		offsetCommand.ExecuteTime = 0f;
	}

	private bool IsCanAdsorptionStateAdjustmentCameraOffset()
	{
		BaseAdjustOffsetData offsetCommand = GetOffsetCommand(CameraKey.BattleCamera);
		if (offsetCommand == null)
		{
			return true;
		}
		if (offsetCommand.AdjustCameraState == AdjustCameraState.Null)
		{
			return true;
		}
		return false;
	}

	public void ReductionOffset(CameraKey cameraKey, int reductionTick, int indexReduction, Vector3 lerpSpeed)
	{
		if (_adsorptionTransition == AdsorptionTransitionState.StartTransition2Adsorption || _adsorptionTransition == AdsorptionTransitionState.ExitAdsorption)
		{
			_currentOffsetCommandList.Clear();
			return;
		}
		BaseAdjustOffsetData offsetCommand = GetOffsetCommand(cameraKey);
		if (offsetCommand != null && offsetCommand.CommandId == indexReduction)
		{
			offsetCommand.ExecuteTime = 0f;
			offsetCommand.ReductionTick = Frame2Time(reductionTick);
			offsetCommand.AdjustCameraState = AdjustCameraState.ReductionState;
			offsetCommand.StartReductionPosition = GetVirtualCameraOffset(cameraKey);
			AdjustVirtualCameraLerpSpeed(cameraKey, lerpSpeed);
		}
	}

	private void DelOffsetCommand(CameraKey cameraKey)
	{
		AdjustVirtualCameraLerpSpeed(cameraKey, GetCameraBaseData(cameraKey)?.cameraDamp ?? (Vector3.one * 0.5f));
		BaseAdjustOffsetData offsetCommand = GetOffsetCommand(cameraKey);
		if (offsetCommand != null)
		{
			_currentOffsetCommandList.Remove(offsetCommand);
			ReferencePool.Release(offsetCommand);
		}
	}

	private bool CheckVector3(Vector3 oneValue, Vector3 twoValue)
	{
		if (Mathf.Abs(oneValue.x - twoValue.x) <= 0.05f && Mathf.Abs(oneValue.y - twoValue.y) <= 0.05f && Mathf.Abs(oneValue.z - twoValue.z) <= 0.05f)
		{
			return true;
		}
		return false;
	}

	private void InitAdjustAngleData()
	{
	}

	private AdjustRotateData GetRotateCommand(CameraKey cameraKey)
	{
		for (int i = 0; i < _currentRotateCommandList.Count; i++)
		{
			if (_currentRotateCommandList[i] != null && _currentRotateCommandList[i].CameraKey == cameraKey)
			{
				return _currentRotateCommandList[i];
			}
		}
		return null;
	}

	public int CreateRotateCameraCommand(CameraKey cameraKey, CameraRotateAdjust cameraRotateType, Vector3 changeValue, Vector3 fixedValue, int relativeEntityId, int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, ChangeCameraPriorityType cameraPriorityType)
	{
		if (!SystemIsNeedExecute)
		{
			return -1;
		}
		AdjustRotateData rotateCommand = GetRotateCommand(cameraKey);
		if (rotateCommand != null)
		{
			if ((rotateCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || rotateCommand.AdjustCameraState != AdjustCameraState.ShowTime || !(rotateCommand.Priority <= (float)priority)) && (rotateCommand.CameraPriorityType != ChangeCameraPriorityType.ExcuteProgress || rotateCommand.AdjustCameraState == AdjustCameraState.ShowTime) && (rotateCommand.CameraPriorityType != ChangeCameraPriorityType.AllProgress || !(rotateCommand.Priority <= (float)priority)))
			{
				return -1;
			}
			DelRotateCommand(cameraKey);
		}
		rotateCommand = CreateCameraAngleBaseCommand(tick, isOpenCurveLerp, animationCurve, priority, cameraPriorityType, cameraKey);
		switch (cameraRotateType)
		{
		case CameraRotateAdjust.ChangeValue:
			rotateCommand = CreateChangeValueRotateCommand(rotateCommand, changeValue);
			break;
		case CameraRotateAdjust.FixedValue:
			rotateCommand = CreateFixedRotateCommand(rotateCommand, fixedValue);
			break;
		case CameraRotateAdjust.EntityRelativeRotate:
		{
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(relativeEntityId);
			if (entity != null)
			{
				rotateCommand = CreateRelativeEntityRotateCommand(rotateCommand, Vector3.up * entity.transform.eulerAngles.y + changeValue);
			}
			break;
		}
		}
		if (rotateCommand == null)
		{
			return -1;
		}
		_currentRotateCommandList.Add(rotateCommand);
		return rotateCommand.CommandId;
	}

	private void DelRotateCommand(CameraKey cameraKey)
	{
		AdjustRotateData rotateCommand = GetRotateCommand(cameraKey);
		if (rotateCommand != null)
		{
			_currentRotateCommandList.Remove(rotateCommand);
			ReferencePool.Release(rotateCommand);
		}
	}

	private AdjustRotateData CreateCameraAngleBaseCommand(int tick, bool isOpenCurveLerp, AnimationCurve animationCurve, int priority, ChangeCameraPriorityType cameraPriorityType, CameraKey cameraKey)
	{
		AdjustRotateData adjustRotateData = ReferencePool.Acquire<AdjustRotateData>();
		adjustRotateData.CameraKey = cameraKey;
		adjustRotateData.ShowTimer = Frame2Time(tick);
		adjustRotateData.IsOpenCurveLerp = isOpenCurveLerp;
		adjustRotateData.AnimationCurve = animationCurve;
		adjustRotateData.Priority = priority;
		adjustRotateData.ExecuteTime = 0f;
		adjustRotateData.StartAngle = CurrentCameraAngle(adjustRotateData.CameraKey);
		adjustRotateData.CommandId = _commandIndex++;
		adjustRotateData.AdjustCameraState = AdjustCameraState.ShowTime;
		adjustRotateData.CameraPriorityType = cameraPriorityType;
		return adjustRotateData;
	}

	private AdjustRotateData CreateFixedRotateCommand(AdjustRotateData data, Vector3 fixedAngle)
	{
		data.TargetAngle = fixedAngle;
		data.TargetAngle = AngleConvert(data.TargetAngle);
		return data;
	}

	private AdjustRotateData CreateChangeValueRotateCommand(AdjustRotateData data, Vector3 changeValue)
	{
		data.TargetAngle = data.StartAngle + changeValue;
		data.TargetAngle = AngleConvert(data.TargetAngle);
		return data;
	}

	private AdjustRotateData CreateRelativeEntityRotateCommand(AdjustRotateData data, Vector3 endValue)
	{
		endValue.x = data.StartAngle.x + endValue.x;
		endValue.z = data.StartAngle.z + endValue.z;
		endValue = AngleConvert(endValue);
		data.TargetAngle = endValue;
		return data;
	}

	private void UpdateCameraRotate()
	{
		for (int i = 0; i < _currentRotateCommandList.Count; i++)
		{
			UpdateCameraRotate(_currentRotateCommandList[i]);
		}
	}

	private Vector3 AngleConvert(Vector3 angle)
	{
		if (angle.x > 180f)
		{
			angle.x -= 360f;
		}
		if (angle.y > 180f)
		{
			angle.y -= 360f;
		}
		if (angle.z > 180f)
		{
			angle.z -= 360f;
		}
		return angle;
	}

	private void UpdateCameraRotate(AdjustRotateData rotateCommand)
	{
		if (rotateCommand == null)
		{
			return;
		}
		if (rotateCommand.AdjustCameraState == AdjustCameraState.ShowTime)
		{
			bool num = rotateCommand.ShowTime(_deltaTime, rotateCommand.StartAngle, rotateCommand.TargetAngle, rotateCommand.ShowTimer, out var resultAngle);
			AdjustVirtualCameraDistance(rotateCommand.CameraKey, resultAngle);
			if (num)
			{
				EndCustomAdjustRotate(rotateCommand);
			}
		}
		if (rotateCommand.AdjustCameraState == AdjustCameraState.ReductionState)
		{
			bool num2 = rotateCommand.AngleLerp(_deltaTime, rotateCommand.StartReductionAngle, GetCameraBaseData(rotateCommand.CameraKey).cameraRotate, rotateCommand.ReductionTime, out var resultAngle2);
			AdjustVirtualCameraDistance(rotateCommand.CameraKey, resultAngle2);
			if (num2)
			{
				DelRotateCommand(rotateCommand.CameraKey);
			}
		}
	}

	private void EndCustomAdjustRotate(AdjustRotateData rotateCommand)
	{
		rotateCommand.AdjustCameraState = AdjustCameraState.WaitReductionState;
		rotateCommand.ExecuteTime = 0f;
	}

	public void ReductionAngle(CameraKey cameraKey, int reductionTick, int indexReduction)
	{
		AdjustRotateData rotateCommand = GetRotateCommand(cameraKey);
		if (rotateCommand != null && rotateCommand.CommandId == indexReduction)
		{
			rotateCommand.ExecuteTime = 0f;
			rotateCommand.ReductionTime = Frame2Time(reductionTick);
			rotateCommand.AdjustCameraState = AdjustCameraState.ReductionState;
			rotateCommand.StartReductionAngle = CurrentCameraAngle(rotateCommand.CameraKey);
			rotateCommand.StartReductionAngle = AngleConvert(rotateCommand.StartReductionAngle);
		}
	}

	private void InitNoiseData()
	{
		if (!(world.NoiseSettings == null) && world.NoiseSettings.cameraShakeNoiseDataList != null)
		{
			for (int i = 0; i < world.NoiseSettings.cameraShakeNoiseDataList.Count; i++)
			{
				NoiseData noiseData = world.NoiseSettings.cameraShakeNoiseDataList[i];
				_battleCameraShakeData.TryAdd(noiseData.noiseName, noiseData);
			}
			for (int j = 0; j < world.NoiseSettings.cameraShakeIntensityCurveDataList.Count; j++)
			{
				CurveData curveData = world.NoiseSettings.cameraShakeIntensityCurveDataList[j];
				_cameraIntensityCurveData.TryAdd(curveData.CurveName, curveData);
			}
			for (int k = 0; k < world.NoiseSettings.cameraShakefrequencyCurveDataList.Count; k++)
			{
				CurveData curveData2 = world.NoiseSettings.cameraShakefrequencyCurveDataList[k];
				_cameraFrequencyCurveData.TryAdd(curveData2.CurveName, curveData2);
			}
			for (int l = 0; l < world.NoiseSettings.impulseRangeCurveDataList.Count; l++)
			{
				CurveData curveData3 = world.NoiseSettings.cameraShakefrequencyCurveDataList[l];
				_impulseRangeCurveData.TryAdd(curveData3.CurveName, curveData3);
			}
		}
	}

	private NoiseData GetNoiseData(string noiseName)
	{
		if (string.IsNullOrEmpty(noiseName))
		{
			return null;
		}
		if (_battleCameraShakeData.TryGetValue(noiseName, out var value))
		{
			return value;
		}
		return null;
	}

	public CurveData GetIntensityCurveData(string curveName)
	{
		if (string.IsNullOrEmpty(curveName))
		{
			return null;
		}
		if (_cameraIntensityCurveData.TryGetValue(curveName, out var value))
		{
			return value;
		}
		return null;
	}

	public CurveData GetFrequencyCurveData(string curveName)
	{
		if (string.IsNullOrEmpty(curveName))
		{
			return null;
		}
		if (_cameraFrequencyCurveData.TryGetValue(curveName, out var value))
		{
			return value;
		}
		return null;
	}

	public CurveData GetImpulseRangeCurveData(string curveName)
	{
		if (string.IsNullOrEmpty(curveName))
		{
			return null;
		}
		if (_impulseRangeCurveData.TryGetValue(curveName, out var value))
		{
			return value;
		}
		return null;
	}

	private void UpdateCameraShake(float deltaTime)
	{
		if (!_isCameraShakePause && _currentActiveShakerData != null)
		{
			_currentActiveShakerData.LinearTime -= deltaTime;
			if (_currentActiveShakerData.LinearTime >= 0f)
			{
				ChangeCameraShakeParam(_currentActiveShakerData.CurTimeIntensity, _currentActiveShakerData.CurTimeFrequency);
			}
			else
			{
				ClearShakeData();
			}
		}
	}

	private void ChangeCameraShakeParam(float intensity, float frequency)
	{
		if (_perlin != null)
		{
			_perlin.m_AmplitudeGain = intensity;
			_perlin.m_FrequencyGain = frequency;
		}
	}

	private void ClearShakeData()
	{
		if (_currentActiveShakerData != null)
		{
			ReferencePool.Release(_currentActiveShakerData);
			_currentActiveShakerData = null;
		}
		if (_perlin != null)
		{
			_perlin.m_AmplitudeGain = 0f;
			_perlin.m_NoiseProfile = null;
			_perlin.m_FrequencyGain = 0f;
		}
	}

	public int SetCameraShakeParam(float weight, float duration, float intensity, float frequency, string noiseName, AnimationCurve intensityCurveData, AnimationCurve frequencyCurveData, float intensityBlendTime, bool useRandomNoise, int infoIndex)
	{
		if (_currentActiveShakerData != null && _currentActiveShakerData.Weight > weight)
		{
			return 0;
		}
		if (_brain == null)
		{
			return 0;
		}
		CinemachineVirtualCamera cinemachineVirtualCamera = _brain.ActiveVirtualCamera?.VirtualCameraGameObject?.GetComponent<CinemachineVirtualCamera>();
		if (cinemachineVirtualCamera == null)
		{
			return 0;
		}
		CinemachineBasicMultiChannelPerlinCtrlRandom cinemachineBasicMultiChannelPerlinCtrlRandom = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlinCtrlRandom>();
		if (cinemachineBasicMultiChannelPerlinCtrlRandom == null)
		{
			cinemachineBasicMultiChannelPerlinCtrlRandom = cinemachineVirtualCamera.AddCinemachineComponent<CinemachineBasicMultiChannelPerlinCtrlRandom>();
			cinemachineBasicMultiChannelPerlinCtrlRandom.m_AmplitudeGain = 0f;
		}
		float lastIntensity = 0f;
		if (_currentActiveShakerData != null)
		{
			lastIntensity = _currentActiveShakerData.CurTimeFrequency;
		}
		else
		{
			intensityBlendTime = 0f;
		}
		ClearShakeData();
		NoiseData noiseData = GetNoiseData(noiseName);
		noiseData = ((noiseData == null) ? GetNoiseData("Default") : noiseData);
		_currentActiveShakerData = CameraShakeData.Create(_currentActiveShakerData, weight, duration, intensity, frequency, noiseData, intensityCurveData, frequencyCurveData, intensityBlendTime, lastIntensity, infoIndex);
		if (_currentActiveShakerData.NoiseData == null)
		{
			return 0;
		}
		_perlin = cinemachineBasicMultiChannelPerlinCtrlRandom;
		_perlin.UseRandomNoise = useRandomNoise;
		if (_perlin == null)
		{
			return 0;
		}
		_perlin.m_FrequencyGain = _currentActiveShakerData.CurTimeFrequency;
		_perlin.m_NoiseProfile = _currentActiveShakerData.NoiseData?.noiseSettings;
		return cameraShakeIndex;
	}

	public bool GetSummonedCanShake(BaseEntity entity)
	{
		if (entity is SummonedEntity { Parent: not null } summonedEntity && summonedEntity.Parent.Id == entity.GetWorld().ActorId)
		{
			return true;
		}
		return false;
	}

	public void OnPauseShakeCamera()
	{
		_isCameraShakePause = true;
		ChangeCameraShakeParam(0f, 0f);
	}

	public void OnResumeShakeCamera()
	{
		_isCameraShakePause = false;
		if (_currentActiveShakerData == null)
		{
			ChangeCameraShakeParam(0f, 0f);
		}
		else if (_currentActiveShakerData.LinearTime > 0f)
		{
			ChangeCameraShakeParam(_currentActiveShakerData.StartingIntensity, _currentActiveShakerData.StartingFrequency);
		}
	}

	public void ClearCameraShake(int index)
	{
		if (_currentActiveShakerData != null && index == _currentActiveShakerData.InfoIndex)
		{
			ReferencePool.Release(_currentActiveShakerData);
			_currentActiveShakerData = null;
			if (_perlin != null)
			{
				_perlin.m_AmplitudeGain = 0f;
				_perlin.m_NoiseProfile = null;
				_perlin.m_FrequencyGain = 0f;
			}
		}
	}

	public int GetCameraShakeIndex()
	{
		cameraShakeIndex++;
		return cameraShakeIndex;
	}
}
