using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置受击盒开关", 0)]
public class SetHitVolumeEnable : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("受击盒索引数组", 0)]
	public int[] indexs = new int[0];

	[Name("开关", 0)]
	public bool enable;

	[Name("是否随行为树销毁", 0)]
	public bool isFollowDispose;

	private string[] keys;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = ownerEntity.GetSystem<EntitySystem>()?.GetEntity(entityId.value);
		if (baseEntity == null)
		{
			OnActionFail($"实体为空 实体ID:{entityId.value}");
			return;
		}
		HitColliderComponent component = baseEntity.GetComponent<HitColliderComponent>();
		if (component == null)
		{
			OnActionFail($"实体受击盒组件为空 实体ID:{entityId.value}");
			return;
		}
		VolumeSystem system = baseEntity.GetSystem<VolumeSystem>();
		if (system == null)
		{
			OnActionFail($"受击盒管理系统为空 实体ID:{entityId.value}");
			return;
		}
		if (indexs.IsNullOrEmpty())
		{
			OnActionFail($"受击盒索引数组为空 实体ID:{entityId.value}");
			return;
		}
		keys = new string[indexs.Length];
		for (int i = 0; i < indexs.Length; i++)
		{
			string hitColliderKey = component.GetHitColliderKey(indexs[i]);
			if (hitColliderKey == null || hitColliderKey == string.Empty)
			{
				OnActionFail($"实体受击盒key为空 实体ID:{entityId.value} 受击盒索引:{indexs[i]}");
				continue;
			}
			keys[i] = hitColliderKey;
			system.SetHitVolumeEnable(baseEntity.Id, hitColliderKey, enable);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (!isFollowDispose || ownerEntity == null || keys.IsNullOrEmpty())
		{
			return;
		}
		VolumeSystem system = ownerEntity.GetSystem<VolumeSystem>();
		if (system == null)
		{
			OnActionFail($"受击盒管理系统为空 实体ID:{entityId.value}");
			return;
		}
		for (int i = 0; i < keys.Length; i++)
		{
			system.SetHitVolumeEnable(entityId.value, keys[i], !enable);
		}
	}
}
