using UnityEngine;

namespace EasyCharacterMovement;

[RequireComponent(typeof(BoxCollider))]
public class PhysicsVolume : MonoBehaviour
{
	[Tooltip("Determines which PhysicsVolume takes precedence if they overlap (higher value == higher priority).")]
	[SerializeField]
	private int _priority;

	[Tooltip("Determines the amount of friction applied by the volume as Character using CharacterMovement moves through it.\nThe higher this value, the harder it will feel to move through the volume.")]
	[SerializeField]
	private float _friction;

	[Tooltip("Determines the terminal velocity of Characters using CharacterMovement when falling.")]
	[SerializeField]
	private float _maxFallSpeed;

	[Tooltip("Determines if the volume contains a fluid, like water.")]
	[SerializeField]
	private bool _waterVolume;

	private BoxCollider _collider;

	public BoxCollider boxCollider
	{
		get
		{
			if (_collider == null)
			{
				_collider = GetComponent<BoxCollider>();
			}
			return _collider;
		}
	}

	public int priority
	{
		get
		{
			return _priority;
		}
		set
		{
			_priority = value;
		}
	}

	public float friction
	{
		get
		{
			return _friction;
		}
		set
		{
			_friction = Mathf.Max(0f, value);
		}
	}

	public float maxFallSpeed
	{
		get
		{
			return _maxFallSpeed;
		}
		set
		{
			_maxFallSpeed = Mathf.Max(0f, value);
		}
	}

	public bool waterVolume
	{
		get
		{
			return _waterVolume;
		}
		set
		{
			_waterVolume = value;
		}
	}

	protected virtual void OnReset()
	{
		priority = 0;
		friction = 0.5f;
		maxFallSpeed = 40f;
		waterVolume = true;
	}

	protected virtual void OnOnValidate()
	{
		friction = _friction;
		maxFallSpeed = _maxFallSpeed;
	}

	protected virtual void OnAwake()
	{
		boxCollider.isTrigger = true;
	}

	private void Reset()
	{
		OnReset();
	}

	private void OnValidate()
	{
		OnOnValidate();
	}

	private void Awake()
	{
		OnAwake();
	}
}
