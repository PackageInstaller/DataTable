using System;
using UnityEngine;

[DisallowMultipleComponent]
public class QWAgent : MonoBehaviour, IQWAgent
{
	public Vector2 BodySize = new Vector2(0.6f, 2f);

	public const float SkinWidth = 0f;

	protected IQWBlackboard _blackboard;

	protected QWCharacterCamera _camera;

	protected IQWCBehavior[] _behaviors;

	public bool IsInit { get; set; }

	public QWBlackboard Blackboard => _blackboard as QWBlackboard;

	public virtual Animator AgentAnimator => Blackboard.animator;

	public Vector3 Position
	{
		get
		{
			return base.transform.position;
		}
		set
		{
			base.transform.position = value;
		}
	}

	public Quaternion Rotation
	{
		get
		{
			return base.transform.rotation;
		}
		set
		{
			base.transform.rotation = value;
		}
	}

	public Vector3 Forward
	{
		get
		{
			return Rotation * Vector3.forward;
		}
		set
		{
			Quaternion quaternion = Quaternion.FromToRotation(Forward, value);
			Rotation = quaternion * Rotation;
		}
	}

	public virtual Vector3 Up
	{
		get
		{
			return Rotation * Vector3.up;
		}
		set
		{
			Quaternion quaternion = Quaternion.FromToRotation(Up, value);
			Rotation = quaternion * Rotation;
		}
	}

	public Vector3 Right => base.transform.right;

	public Vector3 Top => GetTop(Position);

	public Vector3 Center => GetCenter(Position);

	public virtual QWAgentLayer GetAgentLayer()
	{
		return QWAgentLayer.Thing;
	}

	public Vector3 GetBottomCenter(Vector3 position, float bottomOffset = 0f)
	{
		return position + Up * (BodySize.y / 2f + bottomOffset);
	}

	public Vector3 GetTopCenter(Vector3 position, float topOffset = 0f)
	{
		return position + Up * ((0f - BodySize.y) / 2f - topOffset);
	}

	public Vector3 GetCenter(Vector3 position)
	{
		return position + Multiply(Up, BodySize.y / 2f);
	}

	public Vector3 GetTop(Vector3 position)
	{
		return position + Multiply(Up, BodySize.y - 0f);
	}

	public Vector3 GetBottom(Vector3 position)
	{
		return position + Multiply(Up, 0f);
	}

	public static Vector3 Multiply(Vector3 vectorValue, float floatValue)
	{
		vectorValue.x *= floatValue;
		vectorValue.y *= floatValue;
		vectorValue.z *= floatValue;
		return vectorValue;
	}

	public virtual void Spawn(EntitySpawnedEvent data)
	{
		throw new NotImplementedException();
	}

	public virtual void Initialize()
	{
		if (IsInit)
		{
			return;
		}
		if (_camera == null)
		{
			_camera = GetComponent<QWCharacterCamera>();
		}
		if (_behaviors == null)
		{
			_behaviors = GetComponents<IQWCBehavior>();
		}
		if (_blackboard == null)
		{
			_blackboard = GetComponent<IQWBlackboard>();
			_blackboard.InitBlackboard();
		}
		if (_behaviors != null)
		{
			for (int i = 0; i < _behaviors.Length; i++)
			{
				_behaviors[i].Initialize();
			}
		}
		QWAgentManager.Instance.Register(this);
		IsInit = true;
	}

	public virtual void ActiveAgent()
	{
		if (_behaviors != null)
		{
			for (int i = 0; i < _behaviors.Length; i++)
			{
				_behaviors[i].ActiveBehavior();
			}
		}
	}

	public virtual void FixedUpdateAgent()
	{
		if (_behaviors == null)
		{
			return;
		}
		int num = _behaviors.Length;
		for (int i = 0; i < num; i++)
		{
			if (IsInit)
			{
				_behaviors[i].FixedUpdateBehavior();
			}
		}
	}

	public virtual void UpdateAgent()
	{
		if (_behaviors == null)
		{
			return;
		}
		int num = _behaviors.Length;
		for (int i = 0; i < num; i++)
		{
			if (IsInit)
			{
				_behaviors[i].UpdateBehavior();
			}
		}
	}

	public virtual void LateUpdateAgent()
	{
		if (_behaviors == null)
		{
			return;
		}
		int num = _behaviors.Length;
		for (int i = 0; i < num; i++)
		{
			if (IsInit)
			{
				_behaviors[i].LateUpdateBehavior();
			}
		}
	}

	public virtual void Despawn(EntityDespawnedEvent data)
	{
	}

	public virtual void ResetAgent()
	{
		if (_blackboard != null)
		{
			_blackboard.ResetBlackboard();
		}
		if (_behaviors != null)
		{
			for (int i = 0; i < _behaviors.Length; i++)
			{
				_behaviors[i].ResetBehavior();
			}
		}
		_behaviors = null;
		IsInit = false;
	}

	public virtual void DisposeAgent()
	{
		QWAgentManager.Instance.UnRegister(this);
		if (_behaviors != null)
		{
			for (int i = 0; i < _behaviors.Length; i++)
			{
				_behaviors[i].DestroyBehavior();
			}
			_behaviors = null;
		}
		if (_blackboard != null)
		{
			_blackboard.Dispose();
		}
		IsInit = false;
	}
}
