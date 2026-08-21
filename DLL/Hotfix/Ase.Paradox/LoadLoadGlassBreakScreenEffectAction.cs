using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("提前加载特效", 0)]
[Category("✫ DragonLost/Effect")]
[Description("提前加载特效")]
public class LoadLoadGlassBreakScreenEffectAction : ActionTaskBase
{
	[RequiredField]
	[Name("特效Id", 0)]
	[Description("要播放的特效的ID。")]
	public int EffectId;

	protected override void OnExecute()
	{
		base.OnExecute();
		DREffect dataRow = GameEntry.DataTable.GetDataRow<DREffect>(EffectId);
		if (dataRow == null)
		{
			OnActionFinish();
			return;
		}
		string effectAssetPathByLevel = ownerEntity.GetSystem<EffectSystem>().GetEffectAssetPathByLevel(dataRow);
		effectAssetPathByLevel = AssetUtility.GetEntityAsset(effectAssetPathByLevel);
		ownerEntity.GetSystem<SceneSystem>().LoadGlassBreakScreenEffect(effectAssetPathByLevel);
		OnActionFinish();
	}
}
