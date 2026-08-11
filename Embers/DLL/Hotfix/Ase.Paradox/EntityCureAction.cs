#define ENABLE_LOG
using System.Globalization;
using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("实体治疗", 0)]
[Description("对指定的实体进行治疗，增加其生命值。")]
[Category("✫ DragonLost/Entity")]
public class EntityCureAction : ActionTaskBase
{
	[Name("治疗数值", 0)]
	[Description("治疗的数值，即增加的生命值。")]
	public BBParameter<int> cure;

	[Name("被治疗实体", 0)]
	[Description("要进行治疗的实体的实体Id。")]
	[RequiredField]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("实体治疗出错：实体为空!");
			EndAction();
			return;
		}
		HpComponent component = entity.GetComponent<HpComponent>();
		if (component == null)
		{
			LogActionError("实体治疗出错：HpComponent为空!");
			EndAction();
			return;
		}
		component.RecoveryHp(ownerEntity, cure.value, out var cureHp);
		int num = Mathf.FloorToInt(cureHp);
		if (num <= 0)
		{
			EndAction();
			return;
		}
		UIDamageTextSystem system = ownerEntity.GetSystem<UIDamageTextSystem>();
		if (system != null)
		{
			TextDamageParam textDamageParam = ReferencePool.Acquire<TextDamageParam>();
			textDamageParam.showContent = num.ToString(CultureInfo.InvariantCulture);
			system.ShowStackDamageText(textDamageParam, entity, "health");
		}
		EndAction();
	}
}
