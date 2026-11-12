using UnityEngine;

public abstract class BaseGraphicIndicator : MonoBehaviour
{
	protected Vector2 _position;

	protected float _rotation;

	protected float _progress;

	public virtual Vector2 position
	{
		get
		{
			return _position;
		}
		set
		{
			_position = value;
			transform.localPosition = new Vector3(_position.x, _position.y, 0f);
		}
	}

	public virtual float rotation
	{
		get
		{
			return _rotation;
		}
		set
		{
			_rotation = value;
			transform.localRotation = Quaternion.Euler(0f, 0f, _rotation);
		}
	}

	public virtual float progress
	{
		get
		{
			return _progress;
		}
		set
		{
			_progress = Mathf.Clamp01(value);
			RefreshProgressGraphic();
		}
	}

	public virtual Color baseColor
	{
		get
		{
			return Color.white;
		}
		set
		{
		}
	}

	public virtual Color progressColor
	{
		get
		{
			return Color.white;
		}
		set
		{
		}
	}

	protected virtual void Awake()
	{
		_position = new Vector2(transform.localPosition.x, transform.localPosition.z);
		_rotation = transform.localRotation.eulerAngles.z;
		RefreshBaseGraphic();
		RefreshProgressGraphic();
	}

	protected virtual void RefreshBaseGraphic()
	{
	}

	protected virtual void RefreshProgressGraphic()
	{
	}
}
