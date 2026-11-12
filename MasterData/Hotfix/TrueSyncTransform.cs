using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

public class TrueSyncTransform : LogicMonoComponent
{
	private TrueSync.Physics2D.Transform _dtTransform;

	private UnityEngine.Transform _transform;

	public bool Dirty;

	protected FP _positionY;

	public bool transformSyncEnabled { get; set; } = true;

	public TrueSync.Physics2D.Transform dtTransform
	{
		get
		{
			return _dtTransform;
		}
		set
		{
			_dtTransform = value;
			Dirty = true;
			if (transformSyncEnabled)
			{
				TSVector2 position = Position;
				_transform.position = new Vector3((float)position.x, (float)_positionY, (float)position.y);
				FP rotation = Rotation;
				_transform.rotation = Quaternion.Euler(0f, 0f - (float)rotation, 0f);
			}
		}
	}

	public TSVector2 Position
	{
		get
		{
			return _dtTransform.p;
		}
		set
		{
			if (!(_dtTransform.p == value))
			{
				_dtTransform.p = value;
				Dirty = true;
				if (transformSyncEnabled)
				{
					_transform.position = new Vector3((float)value.x, (float)_positionY, (float)value.y);
				}
			}
		}
	}

	public FP PositionY
	{
		get
		{
			return _positionY;
		}
		set
		{
			_positionY = value;
			if (transformSyncEnabled)
			{
				Vector3 position = _transform.position;
				position.y = (float)value;
				_transform.position = position;
			}
		}
	}

	public TSVector Position3D => new TSVector(_dtTransform.p.x, _positionY, _dtTransform.p.y);

	public FP Rotation
	{
		get
		{
			return _dtTransform.q.GetAngle() * FP.Rad2Deg;
		}
		set
		{
			Rot q = new Rot(value * FP.Deg2Rad);
			if (!(_dtTransform.q.s == q.s) || !(_dtTransform.q.c == q.c))
			{
				_dtTransform.q = q;
				Dirty = true;
				if (transformSyncEnabled)
				{
					_transform.rotation = Quaternion.Euler(0f, 0f - (float)value, 0f);
				}
			}
		}
	}

	public FP Rotation360 => (Rotation + 360f) % 360f;

	public TSVector2 Forward
	{
		get
		{
			FP s = _dtTransform.q.s;
			return new TSVector2(y: _dtTransform.q.c, x: -s);
		}
		set
		{
			FP y = -value.x;
			FP y2 = value.y;
			FP rotation = FP.Atan2(y, y2) * FP.Rad2Deg;
			Rotation = rotation;
		}
	}

	public TSVector2 Back
	{
		get
		{
			return Forward * -1f;
		}
		set
		{
			Forward = value * -1f;
		}
	}

	public TSVector2 Right
	{
		get
		{
			FP s = _dtTransform.q.s;
			return new TSVector2(_dtTransform.q.c, s);
		}
		set
		{
			FP y = value.y;
			FP x = value.x;
			FP rotation = FP.Atan2(y, x) * FP.Rad2Deg;
			Rotation = rotation;
		}
	}

	public TSVector2 Left
	{
		get
		{
			return Right * -1f;
		}
		set
		{
			Right = value * -1f;
		}
	}

	public TSVector2 TransformLocalPointToWorldSpace(TSVector2 point)
	{
		return MathUtils.Mul(ref _dtTransform, ref point);
	}

	public TSVector2 TransformWorldPointToLocalSpace(TSVector2 point)
	{
		return MathUtils.MulT(ref _dtTransform, ref point);
	}

	public void LookAt(TSVector2 target)
	{
		Forward = (target - Position).normalized;
	}

	private void Initialize()
	{
		Vector3 position = _transform.position;
		TSVector2 position2 = new TSVector2(position.x, position.z);
		Rot rotation = new Rot((0f - _transform.rotation.eulerAngles.y) * FP.Deg2Rad);
		_dtTransform = new TrueSync.Physics2D.Transform(ref position2, ref rotation);
		_positionY = _transform.position.y;
		Dirty = true;
	}

	protected override void OnInit()
	{
		_transform = transform;
	}

	public void RefreshTsPos()
	{
		_transform = transform;
		Initialize();
	}

	public override void OnActive()
	{
		Initialize();
	}

	private void OnEnable()
	{
		_transform = transform;
		Initialize();
	}
}
