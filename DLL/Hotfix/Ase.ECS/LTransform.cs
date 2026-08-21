using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class LTransform : ILTransform, IReference
{
	private Vector3 _position;

	private Quaternion _rotation;

	private Vector3 _localScale;

	private float _deg;

	private Vector3 _eulerAngles;

	public virtual Vector3 position
	{
		get
		{
			return _position;
		}
		set
		{
			_position = value;
		}
	}

	public virtual Vector3 localScale
	{
		get
		{
			return _localScale;
		}
		set
		{
			_localScale = value;
		}
	}

	public virtual Quaternion rotation
	{
		get
		{
			return _rotation;
		}
		set
		{
			_rotation = value;
		}
	}

	public Vector3 eulerAngles
	{
		get
		{
			return _rotation.eulerAngles;
		}
		set
		{
			rotation = Quaternion.Euler(value);
		}
	}

	public static LTransform Create(EntityPositionData pointData)
	{
		LTransform lTransform = ReferencePool.Acquire<LTransform>();
		lTransform.position = pointData.position;
		lTransform.localScale = pointData.scale;
		lTransform.rotation = Quaternion.Euler(pointData.rotation);
		return lTransform;
	}

	public void Clear()
	{
		position = Vector3.zero;
		localScale = Vector3.one;
		rotation = Quaternion.Euler(Vector3.zero);
	}
}
