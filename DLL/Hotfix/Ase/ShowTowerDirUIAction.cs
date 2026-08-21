using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("显示延边指引", 0)]
[Description("显示延边指引。")]
[Category("✫ DragonLost/Interactive")]
public class ShowTowerDirUIAction : ActionTaskBase
{
	[Name("延边指引唯一ID", 0)]
	[Description("返回延边指引唯一ID")]
	public BBParameter<int> DirUIId = 0;

	[Name("延边指引Icon名字", 0)]
	[Description("延边指引Icon名字")]
	public string DirUIIConName = "";

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = GetOwnerEntity();
		if (baseEntity != null)
		{
			DirUIId.value = ownerEntity.GetSystem<ClimbTowerSystem>().ShowDirUI(DirUIIConName, baseEntity.transform.position);
		}
		OnActionFinish();
	}
}
