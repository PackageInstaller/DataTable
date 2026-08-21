#define ENABLE_LOG
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取是否开启出场动画", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取指定实体是否开启了出场动画")]
public class GetIsOpenBornAnimation : ActionTaskBase
{
	[Name("是否开启出场动画", 0)]
	[RequiredField]
	[Description("用于存储是否开启出场动画的变量")]
	public BBParameter<bool> IsOpen;

	protected override void OnExecute()
	{
		base.OnExecute();
		MonsterNode data = ownerEntity.GetData<MonsterNode>(MonsterGroup.MONSTERNODE_KEY);
		if ((Object)(object)data == null)
		{
			LogActionError("获取是否开启出场动画失败：找不到MonsterNode！");
			EndAction();
		}
		else
		{
			IsOpen.value = data.openAnimation;
			EndAction();
		}
	}
}
