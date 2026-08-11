using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("关闭延边指引", 0)]
[Description("关闭延边指引。")]
[Category("✫ DragonLost/Interactive")]
public class CloseTowerDirUIAction : ActionTaskBase
{
	[Name("延边指引唯一ID", 0)]
	[Description("关闭时延边指引唯一ID")]
	public BBParameter<int> DirUIId = 0;

	protected override async void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<ClimbTowerSystem>().CloseDirUI(DirUIId.value);
		OnActionFinish();
	}
}
