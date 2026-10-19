namespace PathFinding2D.Runtime.Models;

public class PriorityItem<T> where T : class
{
	public T Item { get; }

	public float Priority { get; set; }

	public PriorityItem(T item, float priority)
	{
		Item = item;
		Priority = priority;
	}
}
