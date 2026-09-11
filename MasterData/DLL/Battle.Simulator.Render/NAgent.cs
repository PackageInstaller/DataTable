using System.Collections;
using UnityEngine;

public abstract class NAgent : MonoBehaviour, INAgent
{
	public static Color OWNER_SEE_THROUGH = new Color(0.1922f, 0.498f, 0.7137f);

	public static Color TEAMMATE_SEE_THROUGH = new Color(0.0275f, 0.5059f, 0.1882f);

	public static Color ENEMY_SEE_THROUGH = new Color(0.5059f, 0.1176f, 0.0275f);

	public bool IsLocalPlayer;

	public int m_tempPerformAgentID;

	[HideInInspector]
	public TransformSetup transformSetup;

	private IBehavior[] behaviors;

	public int AgentID { get; set; }

	public int AgentConfigID { get; set; }

	public int AgentSkinID { get; set; }

	public Transform Transform { get; protected set; }

	public AudioSource Audio { get; private set; }

	public Animator Animator { get; private set; }

	public uint Camp { get; set; }

	public bool IsInit { get; set; }

	[HideInInspector]
	public virtual BBCommom Blackboard { get; set; }

	public Vector3 Position => Transform.position;

	public Vector3 Forward => Transform.forward;

	public Vector3 Right => Transform.right;

	public virtual bool IsOwner => false;

	public bool IsExposed { get; set; }

	public bool IsAlpha { get; set; }

	public float LastExposedTime { get; set; }

	public float AgentHeight { get; set; }

	public abstract bool IsAlive { get; }

	public abstract bool IsVisible { get; }

	public abstract bool IsInvulnerable { get; }

	public bool IsCanControl { get; set; }

	public bool IsNeedForceControl { get; set; }

	public ComponentTimeline ComponentTimeline { get; protected set; }

	public AttachPointSetup AttachPointSetup { get; protected set; }

	public abstract Vector3 ChestPosition { get; }

	public virtual float HealthPercent => 1f;

	public bool HasNickName { get; set; }

	public string NickName { get; set; }

	public AbilityStatueInfo TempAbilityStatus { get; set; }

	public abstract void ShowModel(bool show);

	public abstract bool IsEnemy(NAgent target);

	public bool CanMove()
	{
		return true;
	}

	public virtual void Initialize()
	{
		if (IsInit)
		{
			return;
		}
		IsInit = true;
		Transform = base.transform;
		if (Audio == null)
		{
			Audio = GetComponent<AudioSource>();
		}
		if (behaviors == null)
		{
			behaviors = GetComponents<IBehavior>();
		}
		if (behaviors != null)
		{
			for (int i = 0; i < behaviors.Length; i++)
			{
				behaviors[i].Initialize();
			}
		}
		if (Animator == null)
		{
			Animator = GetComponent<Animator>();
		}
	}

	public virtual void ActiveAgent()
	{
		if (behaviors != null)
		{
			for (int i = 0; i < behaviors.Length; i++)
			{
				behaviors[i].ActiveBehavior();
			}
		}
	}

	public virtual void StartUpdateAgentLogic()
	{
		if ((bool)Blackboard)
		{
			Blackboard.StartUpdateBlackboard();
		}
	}

	public virtual void UpdateAgentLogic(SimPersistentState state)
	{
		if ((bool)Blackboard)
		{
			Blackboard.FrameTime = 0f;
			Blackboard.UpdateBlackboard(state);
		}
	}

	public virtual void LateUpdateAgentLogic(SimPersistentState state)
	{
		if ((bool)Blackboard)
		{
			Blackboard.LateUpdateBlackboard(state);
		}
	}

	public virtual void EndUpdateAgentLogic()
	{
		if ((bool)Blackboard)
		{
			Blackboard.EndUpdateBlackboard();
		}
	}

	public virtual void FixedUpdateAgent()
	{
		if (behaviors != null)
		{
			for (int i = 0; i < behaviors.Length; i++)
			{
				behaviors[i].FixedUpdateBehavior();
			}
		}
	}

	public virtual void UpdateAgent()
	{
		if (behaviors != null && behaviors.Length != 0)
		{
			for (int i = 0; i < behaviors.Length; i++)
			{
				behaviors[i].UpdateBehavior();
			}
		}
		if ((bool)Blackboard)
		{
			Blackboard.FrameTime += Time.deltaTime;
			Blackboard.FramePercent = Mathf.Clamp01(Blackboard.FrameTime / 0.1f);
			Blackboard.Update();
		}
	}

	public virtual void LateUpdateAgent()
	{
		if (behaviors != null)
		{
			for (int i = 0; i < behaviors.Length; i++)
			{
				behaviors[i].LateUpdateBehavior();
			}
		}
		if ((bool)Blackboard)
		{
			Blackboard.PostUpdate();
		}
	}

	public virtual void ResetAgent()
	{
		if ((bool)Blackboard)
		{
			Blackboard.ResetBlackboard();
		}
		if (behaviors != null)
		{
			for (int i = 0; i < behaviors.Length; i++)
			{
				behaviors[i].ResetBehavior();
			}
		}
		behaviors = null;
		IsInit = false;
	}

	public virtual void Spawn(EntitySpawnedEvent data)
	{
		Initialize();
	}

	public virtual void Despawn(EntityDespawnedEvent data)
	{
		ComponentTimeline.TimelinePlayer.Shutdown();
		ComponentTimeline = null;
		IsLocalPlayer = false;
		ResetAgent();
		ReturnPool();
	}

	public void ReturnPool()
	{
		Component[] componentsInChildren = GetComponentsInChildren(typeof(PooledAsset), includeInactive: true);
		if (componentsInChildren != null)
		{
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				(componentsInChildren[i] as PooledAsset).Return();
			}
		}
		if (GetComponent<PooledAsset>() == null)
		{
			Object.Destroy(base.gameObject);
		}
	}

	public virtual IEnumerator ReturnPool(float delay)
	{
		while (delay > 0f)
		{
			delay -= Time.deltaTime;
			yield return null;
		}
		ReturnPool();
	}
}
