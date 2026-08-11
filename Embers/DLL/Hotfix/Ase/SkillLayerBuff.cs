#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class SkillLayerBuff : BuffOperationBase<BuffDataSkillLayer>
{
	private HeroSkillData skillData;

	private int delta;

	protected override void OnExecute()
	{
		skillData = base.buffOwner.GetComponent<SkillComponent>()?.GetSkillData(dataBase.skillId);
		if (skillData == null)
		{
			Log.Error("无法获取技能：" + dataBase.skillId);
			return;
		}
		int layer = GetLayer(skillData.CacheLayer, dataBase.layer, dataBase.changeType);
		delta = layer - skillData.CacheLayer;
		skillData.AmendSkillLayer(layer);
	}

	protected override void OnDispose()
	{
		skillData?.AmendSkillLayer(skillData.CacheLayer - delta);
	}

	private int GetLayer(int layer1, int layer2, ChangeType changeType)
	{
		return changeType switch
		{
			ChangeType.Set => layer2, 
			ChangeType.Add => layer1 + layer2, 
			ChangeType.Dec => layer1 - layer2, 
			ChangeType.Mul => layer1 * layer2, 
			ChangeType.Div => layer1 / layer2, 
			ChangeType.Clear => 0, 
			ChangeType.Reset => 0, 
			_ => layer1, 
		};
	}
}
