using System.Numerics;
using System.Runtime.Serialization;

namespace Octree;

[DataContract]
public struct Ray
{
	[DataMember]
	private Vector3 _direction;

	[DataMember]
	public Vector3 Origin { get; set; }

	public Vector3 Direction
	{
		get
		{
			return _direction;
		}
		set
		{
			_direction = Vector3.Normalize(value);
		}
	}

	public Ray(Vector3 origin, Vector3 direction)
	{
		Origin = origin;
		_direction = Vector3.Normalize(direction);
	}

	public Vector3 GetPoint(float distance)
	{
		return Origin + Direction * distance;
	}

	public override string ToString()
	{
		return $"Origin: {Origin}, Dir: {Direction}";
	}

	public string ToString(string format)
	{
		return $"Origin: {Origin.ToString(format)}, Dir: {Direction.ToString(format)}";
	}
}
