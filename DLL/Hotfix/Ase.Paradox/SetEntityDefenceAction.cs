using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置实体方向减伤", 0)]
[Description("为指定实体设置方向减伤效果。")]
public class SetEntityDefenceAction : ActionTaskBase
{
	private BaseEntity _baseEntity;

	[Name("实体Id", 0)]
	[Description("要设置方向减伤的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("减伤开始角度", 0)]
	[Description("减伤范围的起始角度。")]
	public BBParameter<int> startDir;

	[Name("减伤结束角度", 0)]
	[Description("减伤范围的结束角度。")]
	public BBParameter<int> endDir;

	[Name("特效ID", 0)]
	[Description("用于显示方向减伤效果的特效ID。")]
	public int EffectId;

	[Name("绑点", 0)]
	[Description("特效绑定的节点名称。")]
	public string PointKey;

	[Name("特效间隔", 0)]
	[Description("特效显示的间隔时间。")]
	public float Interval;

	[Name("减伤系数", 0)]
	[Description("实体的减伤系数。")]
	public BBParameter<float> subDamageValue;

	[Name("削韧减免系数", 0)]
	[Description("实体的削韧减免系数。")]
	public BBParameter<float> subTenacityValue;

	[Name("是否跟随行为树移除", 0)]
	[Description("指示是否在行为树停止时移除减伤效果。")]
	public bool isGraphStopRemove;

	protected override void OnExecute()
	{
		base.OnExecute();
		_baseEntity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (_baseEntity == null)
		{
			EndAction(success: false);
			return;
		}
		_baseEntity.GetComponent<EntityDefenceComponent>()?.SetDefendValue(subDamageValue.value, subTenacityValue.value, startDir.value, endDir.value, EffectId, Interval, PointKey);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (_baseEntity != null)
		{
			if (isGraphStopRemove)
			{
				_baseEntity?.GetComponent<EntityDefenceComponent>()?.RemoveDefence();
			}
			_baseEntity = null;
		}
	}
}
