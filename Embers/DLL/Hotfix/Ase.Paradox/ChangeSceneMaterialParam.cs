using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("改变场景材质球参数", 0)]
[Category("✫ DragonLost/Scene")]
[Description("改变场景材质球参数")]
public class ChangeSceneMaterialParam : ActionTaskBase
{
	[Name("材质球Key", 0)]
	[Description("在场景中添加材质球的Key")]
	public int MaterialKey;

	[Name("材质球序号", 0)]
	[Description("在MeshRender中材质球的序号")]
	public int MaterialIndex;

	[Name("材质球参数类型", 0)]
	[Description("材质球参数类型")]
	public MaterialParamType MaterialParamType;

	[Name("材质球参数的最终值", 0)]
	[Description("改变材质球参数的最终值")]
	public float ChangeValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (MaterialParamType == MaterialParamType.MagicBlend)
		{
			ownerEntity.GetSystem<SceneSystem>().ChangeMaterialMagicBlend(MaterialKey, MaterialIndex, ChangeValue);
		}
		OnActionFinish();
	}
}
