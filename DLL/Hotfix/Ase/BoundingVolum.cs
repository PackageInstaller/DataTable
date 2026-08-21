using PrimitiveDetection;

namespace Ase;

public class BoundingVolum
{
	public float minX;

	public float maxX;

	public float minY;

	public float maxY;

	public float minZ;

	public float maxZ;

	public virtual void Update(BasePrimitive primitive)
	{
	}
}
