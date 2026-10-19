using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.Precache;
using UnityEngine;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.Battle;

public class EffectRuntimeItem : VisualEntryBase
{
	public float time;

	public float lastTime;

	public float lastSimulateTime;

	public ParticleSystem[] particles;

	public EffectDataType type;

	public EffectPoint point1;

	public EffectPoint point2;

	public GameObject go;

	public YooAssetReference assetReferenceAssetID;

	public Entity owner;

	public AsyncOperationStatus status;

	public MotionState removeWhenMotionExit;

	public string removeWhenConfigMotionExit;

	public bool toBeRemove;

	public bool removeWhenStop;

	public List<EffectRuntimeItem> ownerList;

	public bool isChangeWithEntity;

	public TimeScale timeScale;

	public bool xMirror;

	public MonoLineEffect lineRenderer;

	public MonoEffect[] scripts;

	public MonoConnectEffect connectEffect;

	public string effectName;

	internal bool isUIEffect;

	internal bool hiddenByUI;

	internal bool hiddenByOwner;

	internal bool hiddenByExternal;

	internal bool hiddenByAttachPoint;

	internal bool hiddenByAnchor;

	internal SystemEffect.UIEffectAnchor uiAnchor;

	internal Vector2 uiAnchoredOffset;

	internal Vector2 uiCustomAnchorPos;

	internal RectTransform uiFollowRect;

	internal bool uiRespectSafeArea;

	internal int uiSiblingOrder;

	internal bool isAttach;

	internal bool ignoreOwnerVisible;

	private bool _isValid;

	public InstanceHandle instanceHandle;

	internal Ability attachAbility;

	internal uint LoadVersion { get; private set; }

	public bool isDone
	{
		get
		{
			if (status == AsyncOperationStatus.Failed)
			{
				return attachAbility == null;
			}
			if (status == AsyncOperationStatus.None)
			{
				return false;
			}
			bool result = true;
			if (go == null)
			{
				return true;
			}
			if ((hiddenByUI || hiddenByOwner) && !toBeRemove)
			{
				return false;
			}
			if (particles != null)
			{
				for (int i = 0; i < particles.Length; i++)
				{
					if (particles[i].IsAlive(withChildren: true) || (isChangeWithEntity && !toBeRemove))
					{
						result = false;
					}
				}
			}
			if (scripts != null)
			{
				MonoEffect[] array = scripts;
				foreach (MonoEffect monoEffect in array)
				{
					if (monoEffect.controlRemove && !monoEffect.isDone)
					{
						result = false;
					}
				}
			}
			return result;
		}
	}

	public void SetPriority(int priority)
	{
		_priority = priority;
	}

	public override void Show()
	{
		GameObject gameObject = go;
		if ((object)gameObject != null)
		{
			gameObject.SafeSetActive(active: true);
		}
	}

	public override void Hide()
	{
		GameObject gameObject = go;
		if ((object)gameObject != null)
		{
			gameObject.SafeSetActive(active: false);
		}
	}

	public void Reset()
	{
		uint loadVersion = LoadVersion + 1;
		LoadVersion = loadVersion;
		_isValid = false;
		time = 0f;
		lastTime = 0f;
		lastSimulateTime = 0f;
		particles = null;
		point1 = default;
		point2 = default;
		if (instanceHandle != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(instanceHandle);
			instanceHandle = null;
		}
		go = null;
		assetReferenceAssetID = null;
		lineRenderer = null;
		connectEffect = null;
		if (scripts != null)
		{
			for (int i = 0; i < scripts.Length; i++)
			{
				if (!(scripts[i] == null))
				{
					scripts[i].OnReset();
				}
			}
			scripts = null;
		}
		status = AsyncOperationStatus.None;
		removeWhenMotionExit = MotionState.None;
		removeWhenConfigMotionExit = null;
		removeWhenStop = false;
		isChangeWithEntity = false;
		toBeRemove = false;
		if (ownerList != null)
		{
			ownerList.Remove(this);
		}
		ownerList = null;
		attachAbility = null;
		timeScale = TimeScale.Owner;
		effectName = null;
		xMirror = false;
		isUIEffect = false;
		hiddenByUI = false;
		hiddenByOwner = false;
		hiddenByExternal = false;
		hiddenByAttachPoint = false;
		hiddenByAnchor = false;
		uiAnchor = SystemEffect.UIEffectAnchor.TopLeft;
		uiAnchoredOffset = default;
		uiCustomAnchorPos = default;
		uiFollowRect = null;
		uiRespectSafeArea = false;
		uiSiblingOrder = 0;
		isAttach = false;
		ignoreOwnerVisible = false;
	}

	internal void OnLoaded(InstanceHandle handle, YooAssetReference effectReference)
	{
		status = AsyncOperationStatus.Succeeded;
		if (toBeRemove)
		{
			status = AsyncOperationStatus.Failed;
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			return;
		}
		instanceHandle = handle;
		SetControlPara(handle.Result, effectReference);
		Sync(init: true);
		PlayEffect(isNoOwner: false);
	}

	internal void OnLoadedNoOwner(InstanceHandle handle, YooAssetReference name, Vector3 pos, Quaternion rotate)
	{
		status = AsyncOperationStatus.Succeeded;
		if (toBeRemove)
		{
			status = AsyncOperationStatus.Failed;
			if (handle != null)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			}
		}
		else
		{
			instanceHandle = handle;
			SetControlPara(handle.Result, name);
			go.transform.position = pos;
			go.transform.rotation = rotate;
			PlayEffect(isNoOwner: true);
		}
	}

	internal void OnLoadedConnectEffect(InstanceHandle handle, YooAssetReference name, Vector3 pos, Quaternion rotate, Transform endTrans, Transform startTrans)
	{
		status = AsyncOperationStatus.Succeeded;
		if (toBeRemove)
		{
			status = AsyncOperationStatus.Failed;
			if (handle != null)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			}
			return;
		}
		instanceHandle = handle;
		SetControlPara(handle.Result, name);
		go.transform.position = pos;
		go.transform.rotation *= rotate;
		if (connectEffect != null)
		{
			connectEffect.SetPos(endTrans, startTrans);
		}
		PlayEffect(isNoOwner: true);
	}

	internal void Sync(bool init)
	{
		if (isUIEffect)
		{
			SyncUITransform(init);
			RefreshVisibility();
			return;
		}
		hiddenByAttachPoint = false;
		hiddenByAnchor = false;
		switch (type)
		{
		case EffectDataType.Point:
			if (point1.type == EffectPoint.EffectPointType.AttachPoint && point1.activeWithAttachPoint && (bool)go)
			{
				bool flag3 = point1.ShouldShowWithAttachPoint(owner);
				hiddenByAttachPoint = !flag3;
				RefreshVisibility();
				if (!flag3)
				{
					break;
				}
			}
			if (!point1.SyncTrans(init) || !go)
			{
				break;
			}
			if (point1.type != EffectPoint.EffectPointType.TargetGroundPos && point1.type != EffectPoint.EffectPointType.Character && point1.type != EffectPoint.EffectPointType.CustomTrans && !point1.useInitRotation && !point1.rotateNotFollow)
			{
				go.transform.rotation = point1.rot;
			}
			else if (owner.HasCompAbility() && owner.GetModel() != null && !point1.useInitRotation && !point1.rotateNotFollow)
			{
				if (point1.rotateFollowLogicDir)
				{
					go.transform.rotation = owner.GetCompPhysics().faceDirRot * Quaternion.Euler(0f, -90f, 0f);
				}
				else
				{
					go.transform.rotation = owner.GetModel().transform.rotation * Quaternion.Euler(0f, -90f, 0f) * Quaternion.Euler(point1.rotateOffset);
				}
			}
			else if (point1.useInitRotation)
			{
				go.transform.rotation = point1.initRotation;
			}
			go.transform.position = point1.pos + go.transform.rotation * point1.offset;
			if (point1.type == EffectPoint.EffectPointType.TargetGroundPos)
			{
				float maxDistance = ((point1.groundPosCheckLength != 0f) ? point1.groundPosCheckLength : 20f);
				Vector3 down = Vector3.down;
				if (Physics.Raycast(new Ray(go.transform.position, down), out var hitInfo, maxDistance, BattleConsts.enviromentMask))
				{
					go.transform.position = hitInfo.point;
				}
			}
			if (point1.aimTarget)
			{
				go.transform.rotation = Quaternion.LookRotation(owner.GetCompAim().aimTargetPosition - go.transform.position) * Quaternion.Euler(0f, -90f, 0f);
				if (go.GetComponentInChildren<LineRenderer>() != null)
				{
					LineRenderer componentInChildren = go.GetComponentInChildren<LineRenderer>();
					componentInChildren.SetPosition(0, new Vector3(0f, 0f, 0f));
					componentInChildren.SetPosition(1, new Vector3(40f, 0f, 0f));
				}
			}
			if (point1.useInitRotation)
			{
				go.transform.localEulerAngles += new Vector3(point1.oriRotX + point1.randomRot, point1.oriRotY, point1.oriRotZ + point1.randomRot);
			}
			if (point1.rotatationRandom)
			{
				go.transform.localEulerAngles = go.transform.localEulerAngles + point1.RandomRotOffset;
			}
			go.transform.localScale = new Vector3(Mathf.Abs(go.transform.localScale.x) * (float)((!xMirror) ? 1 : (-1)), go.transform.localScale.y, go.transform.localScale.z);
			break;
		case EffectDataType.Line:
		{
			Transform transform = owner.GetModel().transform;
			if (point1.SyncTrans(init))
			{
				lineRenderer.start = point1.pos + transform.rotation * point1.offset;
			}
			if (point2.SyncTrans(init))
			{
				lineRenderer.end = point2.pos + transform.rotation * point2.offset;
			}
			break;
		}
		case EffectDataType.ScaleX:
		{
			bool flag = point1.SyncTrans(init);
			bool flag2 = point2.SyncTrans(init);
			Quaternion xFaceRotation = owner.GetCompTransform().XFaceRotation;
			Vector3 vector = go.transform.position;
			if (flag)
			{
				vector = point1.pos + xFaceRotation * point1.offset;
				go.transform.position = vector;
			}
			Vector3 vector2 = Vector3.zero;
			if (flag2)
			{
				vector2 = point2.pos + xFaceRotation * point2.offset;
			}
			if (flag | flag2)
			{
				Vector3 vector3 = vector2 - vector;
				go.transform.localScale = new Vector3(vector3.magnitude, 1f, 1f);
				Vector3 vector4 = Vector3.Cross(vector3, Vector3.up);
				go.transform.rotation = Quaternion.LookRotation(vector4, Vector3.Cross(vector4, vector3));
			}
			break;
		}
		}
	}

	private void SyncUITransform(bool init)
	{
		if (go == null)
		{
			return;
		}
		RectTransform rectTransform = go.transform as RectTransform;
		if (!(rectTransform == null) && (init || uiAnchor == SystemEffect.UIEffectAnchor.FollowRect))
		{
			Vector2 vector2;
			if (uiAnchor == SystemEffect.UIEffectAnchor.FollowRect && uiFollowRect != null)
			{
				Vector2 vector = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, uiFollowRect.position);
				vector2 = new Vector2(vector.x / (float)Screen.width, vector.y / (float)Screen.height);
			}
			else
			{
				vector2 = GetUIAnchor(uiAnchor, uiCustomAnchorPos);
			}
			if (uiRespectSafeArea)
			{
				Rect safeArea = Screen.safeArea;
				float num = safeArea.xMin / (float)Screen.width;
				float num2 = safeArea.yMin / (float)Screen.height;
				float num3 = safeArea.width / (float)Screen.width;
				float num4 = safeArea.height / (float)Screen.height;
				vector2 = new Vector2(num + vector2.x * num3, num2 + vector2.y * num4);
			}
			rectTransform.anchorMin = vector2;
			rectTransform.anchorMax = vector2;
			rectTransform.anchoredPosition = uiAnchoredOffset;
		}
	}

	private static Vector2 GetUIAnchor(SystemEffect.UIEffectAnchor anchor, Vector2 custom)
	{
		return anchor switch
		{
			SystemEffect.UIEffectAnchor.TopLeft => new Vector2(0f, 1f), 
			SystemEffect.UIEffectAnchor.TopCenter => new Vector2(0.5f, 1f), 
			SystemEffect.UIEffectAnchor.TopRight => new Vector2(1f, 1f), 
			SystemEffect.UIEffectAnchor.MiddleLeft => new Vector2(0f, 0.5f), 
			SystemEffect.UIEffectAnchor.Center => new Vector2(0.5f, 0.5f), 
			SystemEffect.UIEffectAnchor.MiddleRight => new Vector2(1f, 0.5f), 
			SystemEffect.UIEffectAnchor.BottomLeft => new Vector2(0f, 0f), 
			SystemEffect.UIEffectAnchor.BottomCenter => new Vector2(0.5f, 0f), 
			SystemEffect.UIEffectAnchor.BottomRight => new Vector2(1f, 0f), 
			SystemEffect.UIEffectAnchor.Custom => custom, 
			_ => new Vector2(0.5f, 0.5f), 
		};
	}

	internal void SetOwnerVisible(bool visible)
	{
		hiddenByOwner = !visible;
		RefreshVisibility();
	}

	internal void SetExternalVisible(bool visible)
	{
		hiddenByExternal = !visible;
		RefreshVisibility();
	}

	internal void RefreshVisibility()
	{
		if (go != null)
		{
			go.SafeSetActive(!hiddenByUI && !hiddenByOwner && !hiddenByExternal && !hiddenByAttachPoint && !hiddenByAnchor);
		}
	}

	internal void SyncEffectActiveOrNot(bool isShow)
	{
		SetExternalVisible(isShow);
	}

	internal void SetSpeed(float speed)
	{
		if (timeScale != TimeScale.Owner)
		{
			return;
		}
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			for (int i = 0; i < array.Length; i++)
			{
				ParticleSystem.MainModule main = array[i].main;
				main.simulationSpeed = speed;
			}
		}
		if (scripts != null)
		{
			MonoEffect[] array2 = scripts;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].SetSpeed(speed);
			}
		}
	}

	internal void Simulate(float deltaTime, bool restart)
	{
		if (timeScale != TimeScale.Owner)
		{
			return;
		}
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			foreach (ParticleSystem particleSystem in array)
			{
				if (particleSystem.isPaused)
				{
					if (particleSystem.main.duration + particleSystem.main.startDelay.constantMax > lastSimulateTime || particleSystem.main.loop)
					{
						particleSystem.Simulate(deltaTime, withChildren: false, restart);
						continue;
					}
					particleSystem.Play();
					particleSystem.Stop();
				}
			}
		}
		if (scripts != null)
		{
			MonoEffect[] array2 = scripts;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].UpdateBehave(deltaTime);
			}
		}
	}

	internal void SetEffectTime(float time)
	{
		if (timeScale == TimeScale.Owner && particles != null)
		{
			ParticleSystem[] array = particles;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].time = time;
			}
		}
	}

	internal void SetToBeRemove()
	{
		if (!_isValid || toBeRemove)
		{
			return;
		}
		toBeRemove = true;
		if (status != AsyncOperationStatus.Succeeded)
		{
			return;
		}
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			foreach (ParticleSystem particleSystem in array)
			{
				if (!(particleSystem == null))
				{
					if (timeScale == TimeScale.Owner)
					{
						particleSystem.Play();
					}
					particleSystem.Stop();
					if (removeWhenStop)
					{
						particleSystem.Clear();
					}
				}
			}
		}
		if (scripts == null)
		{
			return;
		}
		MonoEffect[] array2 = scripts;
		foreach (MonoEffect monoEffect in array2)
		{
			if (!(monoEffect == null))
			{
				monoEffect.SetToBeRemove();
			}
		}
	}

	internal void RemoveImmediately()
	{
		if (!_isValid || status != AsyncOperationStatus.Succeeded)
		{
			return;
		}
		toBeRemove = true;
		if (particles != null)
		{
			ParticleSystem[] array = particles;
			foreach (ParticleSystem particleSystem in array)
			{
				if (!(particleSystem == null))
				{
					particleSystem.Stop();
					particleSystem.Clear();
				}
			}
		}
		if (scripts == null)
		{
			return;
		}
		MonoEffect[] array2 = scripts;
		foreach (MonoEffect monoEffect in array2)
		{
			if (!(monoEffect == null))
			{
				monoEffect.SetToBeRemove();
			}
		}
	}

	private void SetControlPara(GameObject handler, YooAssetReference name)
	{
		go = handler;
		assetReferenceAssetID = name;
		particles = go.GetComponentsInChildren<ParticleSystem>();
		lineRenderer = go.GetComponentInChildren<MonoLineEffect>();
		scripts = go.GetComponentsInChildren<MonoEffect>();
		connectEffect = go.GetComponentInChildren<MonoConnectEffect>();
	}

	private void PlayScriptsEffect(float simuSpeed)
	{
		MonoEffect[] array = scripts;
		foreach (MonoEffect obj in array)
		{
			obj.SetSpeed(simuSpeed);
			obj.SetTimeScale(timeScale);
			obj.StartEffect(this);
		}
	}

	private void PlayEffect(bool isNoOwner)
	{
		float simuSpeed = 1f;
		if (scripts == null && particles == null)
		{
			return;
		}
		ParticleSystem[] array;
		if (isNoOwner)
		{
			PlayScriptsEffect(simuSpeed);
			array = particles;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Play(withChildren: false);
			}
			return;
		}
		PlayScriptsEffect(simuSpeed);
		array = particles;
		foreach (ParticleSystem particleSystem in array)
		{
			_ = particleSystem.main;
			particleSystem.Simulate(time, withChildren: false, restart: true);
			if (timeScale != TimeScale.Owner)
			{
				particleSystem.Play(withChildren: false);
			}
		}
	}

	public void OnGet()
	{
		_isValid = true;
	}
}
