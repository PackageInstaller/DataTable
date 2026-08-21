using UnityEngine;

public class BlockShow : MonoBehaviour
{
	public int BlockID;

	public float range;

	public Vector2 offset;

	public Vector2 size;

	public Color color = Color.red;

	public BlockType type;

	public string nickName;

	public bool export = true;

	public bool IsActive = true;

	private void OnDrawGizmos()
	{
		if (!export || type == BlockType.none)
		{
			return;
		}
		if (type == BlockType.column)
		{
			Gizmos.color = color;
			Vector3 center = ExportPos();
			Gizmos.DrawWireSphere(center, ExportRange());
			Gizmos.color = new Color(1f, 1f, 1f, 0f);
			Gizmos.DrawSphere(center, ExportRange());
			Gizmos.color = Color.white;
		}
		if (type == BlockType.cube)
		{
			if (IsActive)
			{
				Gizmos.color = color;
				Gizmos.DrawCube(ExportPos(), ExportSize());
				Gizmos.color = Color.white;
				return;
			}
			Gizmos.color = color;
			Vector3 center2 = ExportPos();
			Gizmos.DrawWireCube(center2, ExportSize());
			Gizmos.color = new Color(1f, 1f, 1f, 0f);
			Gizmos.DrawCube(center2, ExportSize());
			Gizmos.color = Color.white;
		}
	}

	public Vector3 ExportPos()
	{
		Vector3 localScale = base.transform.localScale;
		return base.transform.position + new Vector3(offset.x * localScale.x, 0f, offset.y * localScale.y);
	}

	public Vector3 ExportSize()
	{
		Vector3 localScale = base.transform.localScale;
		return new Vector3(size.x * localScale.x, 0.1f, size.y * localScale.y);
	}

	public float ExportRange()
	{
		Vector3 localScale = base.transform.localScale;
		return range * localScale.x;
	}
}
