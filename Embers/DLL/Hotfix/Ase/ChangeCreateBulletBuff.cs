using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class ChangeCreateBulletBuff : BuffOperationBase<BuffDataChangeCreateBullet>
{
	private Dictionary<int, int> changeDic = new Dictionary<int, int>();

	protected override void OnInit()
	{
		base.OnInit();
		int[] args = dataBase.args;
		if (args == null || args.Length % 2 != 0)
		{
			return;
		}
		int num = args.Length / 2;
		for (int i = 0; i < num; i++)
		{
			int key = args[i * 2];
			if (changeDic.ContainsKey(key))
			{
				break;
			}
			int value = args[i * 2 + 1];
			changeDic.Add(key, value);
		}
	}

	protected override void OnExecute()
	{
		BulletSystem system = base.buffOwner.GetSystem<BulletSystem>();
		if (system == null)
		{
			return;
		}
		foreach (KeyValuePair<int, int> item in changeDic)
		{
			system.AddChangeCreateBullet(item.Key, item.Value);
		}
	}

	protected override void OnDispose()
	{
		BulletSystem system = base.buffOwner.GetSystem<BulletSystem>();
		if (system == null)
		{
			return;
		}
		foreach (KeyValuePair<int, int> item in changeDic)
		{
			system.RemoveChangeCreateBullet(item.Key);
		}
		changeDic.Clear();
	}
}
