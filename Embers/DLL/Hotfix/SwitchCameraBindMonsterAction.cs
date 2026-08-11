using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("切换相机关注的怪物", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于切换相机关注的怪物，计算吸附点的位置")]
public class SwitchCameraBindMonsterAction : BaseVirtualCameraAction
{
	[Name("怪物实体ID", 0)]
	public BBParameter<int> EntityID;

	protected override bool IsUniqueBattleCameraCommand => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (IsCanCameraNode())
		{
			if (GetEntity(EntityID.value, isSyncEntity: false) is MonsterEntity monsterEntity)
			{
				ownerEntity.GetSystem<VirtualCameraSystem>().SwitchBindMonsterEntity(monsterEntity);
			}
			EndAction();
		}
	}
}
