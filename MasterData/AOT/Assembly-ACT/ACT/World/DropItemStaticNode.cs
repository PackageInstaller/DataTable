using ACT.Battle;
using ACT.Game.Data;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World;

public class DropItemStaticNode : RuntimeStaticNode
{
	public static ObjectPool<DropItemStaticNode> dropItemPool = new ObjectPool<DropItemStaticNode>((DropItemStaticNode x) =>
	{
		x.entity = default;
		x.dropData = null;
		x.dropSourceUid = 0;
		x.m_Task = default;
		x.loadPolicy = LoadPolicy.DoUnLoad;
		x.loadState = LoadState.UnLoad;
		x.bounds = default;
	}, null);

	public DropItem dropData;

	public int dropSourceUid;

	private Entity entity;

	private UniTask m_Task;

	public override async void OnLoad()
	{
		if (!m_Task.GetAwaiter().IsCompleted)
		{
			await m_Task;
		}
		if (loadState == LoadState.Loaded)
		{
			entity = Singleton<DropItemManager>.instance.AddDropItem(dropData);
			m_Task = MonoECS.instance.SpawnDropItem(entity, dropSourceUid, dropData, this);
		}
	}

	public override async void OnRelase()
	{
		if (!m_Task.GetAwaiter().IsCompleted)
		{
			await m_Task;
		}
		if (loadState == LoadState.UnLoad)
		{
			Singleton<DropItemManager>.instance.RemoveDropItem(dropData.Uid);
		}
	}
}
