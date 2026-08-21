using UnityEngine;

namespace Ase;

public class TaskPosition
{
	public bool active;

	public Vector2 position;

	public float rangeRadius;

	public TaskPosition(Vector2 position, bool active, float rangeRadius = 0f)
	{
		this.position = position;
		this.active = active;
		this.rangeRadius = rangeRadius;
	}

	public static TaskPosition Clone(TaskPosition taskPosition)
	{
		return new TaskPosition(taskPosition.position, taskPosition.active, taskPosition.rangeRadius);
	}
}
