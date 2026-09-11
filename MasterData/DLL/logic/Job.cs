using System;
using Entitas;

internal class Job<TEntity> where TEntity : class, IEntity
{
	public TEntity[] entities;

	public int from;

	public int to;

	public Exception exception;

	public void Set(TEntity[] entities, int from, int to)
	{
		this.entities = entities;
		this.from = from;
		this.to = to;
		exception = null;
	}
}
