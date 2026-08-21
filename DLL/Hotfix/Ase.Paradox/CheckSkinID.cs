using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("判断实体是否正在使用该皮肤", 0)]
[Category("✫ DragonLost/Skin")]
[Description("判断实体是不是正在使用指定ID的皮肤")]
public class CheckSkinID : ConditionTaskBase
{
	[Name("目标ID", 0)]
	[RequiredField]
	[Description("要检查皮肤ID的实体ID")]
	public BBParameter<int> targetId;

	[Name("皮肤ID", 0)]
	[Description("要检查的皮肤ID")]
	public BBParameter<int> skinID;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: false);
		if (entity == null)
		{
			return false;
		}
		if (entity.HeroSkin != null)
		{
			return entity.HeroSkin.Id == skinID.value;
		}
		return false;
	}
}
