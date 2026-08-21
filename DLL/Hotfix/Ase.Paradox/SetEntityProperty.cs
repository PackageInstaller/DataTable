using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("设置实体属性值", 0)]
[Category("✫ DragonLost/Entity")]
[Description("设置指定实体的指定属性值。")]
public class SetEntityProperty : ActionTaskBase
{
	private float delta;

	[Name("实体Id", 0)]
	[Description("要设置属性值的目标实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("是否选择自己", 0)]
	[Description("指示是否选择当前行为树的所有者作为目标实体。")]
	public bool Iself = true;

	[Name("计算方式", 0)]
	[Description("指定要执行的操作类型，例如设置、增加、减少等。")]
	public OperationMethod Operation;

	[Name("属性名", 0)]
	[Description("要设置的属性的名称。")]
	public BBParameter<string> propertyKey;

	[Name("属性类型", 0)]
	[Description("指定要设置的属性类型，例如初始值、最大值、固定值等。")]
	public PropertyType PropertyType;

	[Name("行为树结束恢复", 0)]
	[Description("指示是否在行为树结束时恢复属性值。")]
	public bool ReviveValue;

	[Name("属性值", 0)]
	[Description("要设置的属性值。")]
	public BBParameter<float> setValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = (Iself ? ownerEntity : GetEntity(EntityId.value, isSyncEntity: false));
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"设置实体属性值 计算方式 {Operation}  属性名  {propertyKey.value}  " + $"属性类型  : {PropertyType} 行为树结束恢复 {ReviveValue}  属性值 {setValue.value} " + $"_recodeCurrentValue {delta}", baseEntity);
		}
		float num = 0f;
		Ase.ECS.PropertyData propertyData = baseEntity?.GetPropertyDataOrCreate(propertyKey.value);
		if (propertyData == null)
		{
			OnActionFail("无法获取当前实体属性值");
			return;
		}
		switch (PropertyType)
		{
		case PropertyType.FixedValue:
			num = OperationTools.Operate(propertyData.ReadCurValue, setValue.value, Operation);
			num = Mathf.Clamp(num, propertyData.MinValueLimit ? 0f : propertyData.MinValue, propertyData.MaxValue - propertyData.BuffValue);
			delta = num - propertyData.ReadCurValue;
			propertyData.Set(num);
			break;
		case PropertyType.InitValue:
			num = OperationTools.Operate(propertyData.InitValue, setValue.value, Operation);
			baseEntity.SetPropertyInit(propertyKey.value, num);
			break;
		case PropertyType.MaxValue:
			num = OperationTools.Operate(propertyData.MaxValue, setValue.value, Operation);
			baseEntity.SetPropertyMax(propertyKey.value, num);
			break;
		}
		if (((Operation == OperationMethod.Add && setValue.value > 0f) || (Operation == OperationMethod.Subtract && setValue.value < 0f)) && propertyKey.value == "Energy" && baseEntity.IsActorEntity)
		{
			ObserverActorAddEenergyParams observerActorAddEenergyParams = ReferencePool.Acquire<ObserverActorAddEenergyParams>();
			observerActorAddEenergyParams.Init(baseEntity);
			baseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.ActorAddEnergy, observerActorAddEenergyParams);
			ReferencePool.Release(observerActorAddEenergyParams);
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity == null)
		{
			return;
		}
		BaseEntity baseEntity = (Iself ? ownerEntity : GetEntity(EntityId.value, isSyncEntity: false));
		if (ReviveValue)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"恢复设置实体属性值 计算方式 {Operation}  属性名  {propertyKey.value}  " + $"属性类型  : {PropertyType} 行为树结束恢复 {ReviveValue}  属性值 {setValue.value} " + $"_recodeCurrentValue  {delta}", baseEntity);
			}
			switch (PropertyType)
			{
			case PropertyType.FixedValue:
				baseEntity?.ChangeProperty(propertyKey.value, 0f - delta);
				break;
			case PropertyType.MaxValue:
				baseEntity?.ResetMax2Original(propertyKey.value);
				break;
			case PropertyType.InitValue:
				break;
			}
		}
	}
}
