using System.Collections.Generic;
using Ase;
using GameFramework;

public class SingleBattleDamage : IReference
{
	public List<int> Entities;

	public List<float> MaxDamages;

	public static SingleBattleDamage Create(bool isFromPool = true)
	{
		SingleBattleDamage obj = ((!isFromPool) ? new SingleBattleDamage() : (Singleton<ObjectPool>.Instance.Fetch(typeof(SingleBattleDamage)) as SingleBattleDamage));
		obj.Entities = new List<int>();
		obj.MaxDamages = new List<float>();
		return obj;
	}

	public void Clear()
	{
		Entities.Clear();
		MaxDamages.Clear();
	}
}
