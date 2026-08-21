#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public abstract class MovingPlatform : SerializedMonoBehaviour, IMoverController, IMovingPlatformInteractive
{
	public enum WrapMode
	{
		Once,
		Loop,
		PingPong
	}

	private string animtorParamActive = "IsActive";

	protected string animtorParamMoveSpeed = "MoveSpeedZero";

	protected PhysicsMover Mover;

	protected Transform vTsm;

	protected Vector3 originPosition;

	protected Vector3 originEulerAngles;

	private float stableMovementSharpness = 15f;

	private float stableRotationSharpness = 1f / 30f;

	[SerializeField]
	private int id;

	[SerializeField]
	private bool paused;

	public Animator PlatformAnimator;

	[SerializeField]
	private List<Collider> colliders = new List<Collider>();

	[SerializeField]
	public List<PhysicsMoverVolume> moverHitVolumes = new List<PhysicsMoverVolume>();

	[SerializeField]
	protected MovingPaltformInteractiveCom[] movingPaltformInteractiveComs;

	protected bool moveSpeedZero = true;

	protected SceneSystem _sceneSystem;

	private Collider[] triggerColliders = (Collider[])(object)new Collider[4];

	private bool hasTriggered;

	private List<Collider> lastTriggerColliders = new List<Collider> { null, null, null, null };

	[SerializeField]
	private Vector3 size = new Vector3(5f, 0.4f, 5f);

	[SerializeField]
	private Vector3 center = new Vector3(0f, 0.2f, 0f);

	protected Vector3? newPos;

	protected abstract bool IsRunning { get; }

	public int ID => id;

	protected virtual bool CanHit => false;

	protected bool Paused => paused;

	public void OnInit(object data = null)
	{
		_sceneSystem = data as SceneSystem;
		GameObject gameObject = new GameObject();
		gameObject.transform.SetParent(((Component)this).transform.parent);
		gameObject.hideFlags = HideFlags.HideInHierarchy;
		gameObject.layer = LayerMask.NameToLayer("Ground");
		gameObject.transform.rotation = ((Component)this).transform.rotation;
		gameObject.transform.position = ((Component)this).transform.position;
		gameObject.transform.localScale = ((Component)this).transform.localScale;
		SetVirtualSaveData(gameObject);
		vTsm = gameObject.transform;
		Rigidbody rigidbody = gameObject.AddComponent<Rigidbody>();
		Mover = gameObject.AddComponent<PhysicsMover>();
		Mover.MoverController = this;
		Mover.Rigidbody = rigidbody;
		UpdateDeterministicPhysicsCollider();
		originPosition = vTsm.position;
		originEulerAngles = vTsm.rotation.eulerAngles;
		Mover.OnInit(data);
		OnInited();
	}

	protected virtual void SetVirtualSaveData(GameObject virtualObj)
	{
	}

	public void OnUpdate(float deltaTime)
	{
		((Component)this).transform.position = Vector3.Lerp(((Component)this).transform.position, vTsm.position, 1f - Mathf.Exp((0f - stableMovementSharpness) * deltaTime));
		((Component)this).transform.rotation = Quaternion.Slerp(((Component)this).transform.rotation, vTsm.rotation, deltaTime / stableRotationSharpness);
		if (IsRunning)
		{
			if (hasTriggered)
			{
				for (int i = 0; i < 4; i++)
				{
					lastTriggerColliders[i] = null;
				}
				hasTriggered = false;
			}
			return;
		}
		int num = Physics.OverlapBoxNonAlloc(((Component)this).transform.position + center, size * 0.5f, triggerColliders, ((Component)this).transform.rotation, 1 << LayerMask.NameToLayer("AreaTrigger"));
		if (num > 0)
		{
			for (int j = 0; j < num; j++)
			{
				if (!lastTriggerColliders.Contains(triggerColliders[j]) && ((Component)(object)triggerColliders[j]).TryGetComponent(out SetHitPlatformCanHitTrigger component))
				{
					component.DoExecute(ID);
				}
			}
			for (int k = 0; k < 4; k++)
			{
				if (k >= num)
				{
					lastTriggerColliders[k] = null;
				}
				else
				{
					lastTriggerColliders[k] = triggerColliders[k];
				}
			}
			hasTriggered = true;
		}
		else
		{
			for (int l = 0; l < 4; l++)
			{
				lastTriggerColliders[l] = null;
			}
			hasTriggered = false;
		}
	}

	public virtual void ResetPlatform()
	{
	}

	public void SetPlatformPos(Vector3 pos)
	{
		newPos = pos;
	}

	public void UpdateOriginPosition(Vector3 position)
	{
		originPosition = position;
	}

	public void UpdateOriginRotation(Vector3 eulerAngles)
	{
		originEulerAngles = eulerAngles;
	}

	public void UpdateOriginPositionAndRotation(Vector3 position, Vector3 eulerAngles)
	{
		originPosition = position;
		originEulerAngles = eulerAngles;
	}

	private void UpdateDeterministicPhysicsCollider()
	{
		foreach (Collider collider in colliders)
		{
			MeshCollider val = (MeshCollider)(object)((collider is MeshCollider) ? collider : null);
			if (val != null)
			{
				MeshCollider obj = vTsm.gameObject.AddComponent<MeshCollider>();
				obj.sharedMesh = val.sharedMesh;
				obj.convex = val.convex;
				((Collider)obj).isTrigger = ((Collider)val).isTrigger;
				((Collider)obj).sharedMaterial = ((Collider)val).sharedMaterial;
				((Collider)obj).enabled = true;
			}
			BoxCollider val2 = (BoxCollider)(object)((collider is BoxCollider) ? collider : null);
			if (val2 != null)
			{
				BoxCollider obj2 = vTsm.gameObject.AddComponent<BoxCollider>();
				obj2.center = val2.center;
				obj2.size = val2.size;
				((Collider)obj2).isTrigger = ((Collider)val2).isTrigger;
				((Collider)obj2).sharedMaterial = ((Collider)val2).sharedMaterial;
				((Collider)obj2).enabled = true;
			}
			collider.enabled = false;
		}
	}

	protected virtual void OnInited()
	{
	}

	protected virtual void OnResetPlatform()
	{
		for (int i = 0; i < 4; i++)
		{
			lastTriggerColliders[i] = null;
		}
	}

	protected abstract void OnUpdateMovement(out Vector3 goalPosition, out Quaternion goalRotation, float deltaTime);

	protected abstract void GetMoveSpeedZero();

	public void SetPause(bool paused)
	{
		this.paused = paused;
		if ((Object)(object)PlatformAnimator == null)
		{
			Log.Error("动画控制器是空的" + ((Component)this).transform.GetFullPath());
			return;
		}
		if (paused)
		{
			PlatformAnimator.SetBool(animtorParamActive, false);
		}
		else
		{
			if (!((Component)(object)PlatformAnimator).gameObject.activeSelf)
			{
				((Component)(object)PlatformAnimator).gameObject.SetActive(value: true);
			}
			PlatformAnimator.SetBool(animtorParamActive, true);
		}
		OnPause();
	}

	public virtual void OnPause()
	{
	}

	public void UpdateMovement(out Vector3 goalPosition, out Quaternion goalRotation, float deltaTime)
	{
		if (paused)
		{
			goalPosition = Mover.TransientPosition;
			goalRotation = Mover.TransientRotation;
		}
		else
		{
			OnUpdateMovement(out goalPosition, out goalRotation, deltaTime);
		}
		if (newPos.HasValue)
		{
			goalPosition = newPos.Value;
			newPos = null;
		}
		GetMoveSpeedZero();
	}

	public void SetPlatPos(Vector3 pos)
	{
		newPos = ((Component)this).transform.parent.TransformPoint(pos);
	}

	public virtual void InteractiveFinish(int index)
	{
	}

	public virtual void SavePlatformData()
	{
	}

	public bool GetPauseState()
	{
		return paused;
	}
}
