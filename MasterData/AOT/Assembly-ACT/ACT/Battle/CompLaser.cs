using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle;

public class CompLaser : EcsComponent
{
	private static ObjectPool<RuntimeLaser> s_LaserPool = new ObjectPool<RuntimeLaser>(null, null);

	public List<RuntimeLaser> Lasers { get; private set; }

	protected override void OnGet()
	{
		Lasers = new List<RuntimeLaser>();
	}

	protected override void OnRelease()
	{
		if (Lasers == null)
		{
			return;
		}
		foreach (RuntimeLaser laser in Lasers)
		{
			laser.OnUnInit();
			s_LaserPool.Release(laser);
		}
		Lasers.Clear();
	}

	public RuntimeLaser AddLaser()
	{
		RuntimeLaser runtimeLaser = s_LaserPool.Get();
		Lasers.Add(runtimeLaser);
		runtimeLaser.OnInit();
		return runtimeLaser;
	}

	public void RemoveLaser(RuntimeLaser laser)
	{
		if (laser != null && Lasers.Contains(laser))
		{
			laser.OnUnInit();
			Lasers.Remove(laser);
			s_LaserPool.Release(laser);
		}
	}

	public void RemoveAllLasers()
	{
		for (int num = Lasers.Count - 1; num >= 0; num--)
		{
			RuntimeLaser runtimeLaser = Lasers[num];
			runtimeLaser.OnUnInit();
			s_LaserPool.Release(runtimeLaser);
		}
		Lasers.Clear();
	}
}
