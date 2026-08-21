using System;
using System.Threading;
using Entitas;

public abstract class JobSystem<TEntity> : IExecuteSystem, ISystem where TEntity : class, IEntity
{
	private readonly IGroup<TEntity> _group;

	private readonly int _threads;

	private readonly Job<TEntity>[] _jobs;

	private int _threadsRunning;

	protected JobSystem(IGroup<TEntity> group, int threads)
	{
		_group = group;
		_threads = threads;
		_jobs = new Job<TEntity>[threads];
		for (int i = 0; i < _jobs.Length; i++)
		{
			_jobs[i] = new Job<TEntity>();
		}
	}

	public void Execute()
	{
		_threadsRunning = _threads;
		TEntity[] entities = _group.GetEntities();
		int num = entities.Length % _threads;
		int num2 = entities.Length / _threads + ((num != 0) ? 1 : 0);
		for (int i = 0; i < _threads; i++)
		{
			int num3 = i * num2;
			int num4 = num3 + num2;
			if (num4 > entities.Length)
			{
				num4 = entities.Length;
			}
			Job<TEntity> job = _jobs[i];
			job.Set(entities, num3, num4);
			if (num3 != num4)
			{
				ThreadPool.QueueUserWorkItem(queueOnThread, _jobs[i]);
			}
			else
			{
				Interlocked.Decrement(ref _threadsRunning);
			}
		}
		while (_threadsRunning != 0)
		{
		}
		Job<TEntity>[] jobs = _jobs;
		foreach (Job<TEntity> job2 in jobs)
		{
			if (job2.exception != null)
			{
				throw job2.exception;
			}
		}
	}

	private void queueOnThread(object state)
	{
		Job<TEntity> job = (Job<TEntity>)state;
		try
		{
			for (int i = job.from; i < job.to; i++)
			{
				Execute(job.entities[i]);
			}
		}
		catch (Exception exception)
		{
			job.exception = exception;
		}
		finally
		{
			Interlocked.Decrement(ref _threadsRunning);
		}
	}

	protected abstract void Execute(TEntity entity);
}
