using System;
using ACT.Core;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
[AbilityTypeMetadata("属性修改配置", "Other", new string[] { "attribute", "property", "modify", "buff", "damage", "formula" })]
public struct ABProperty
{
	[Tooltip("要对什么属性进行修改")]
	public uint property;

	[Tooltip("对一个属性的base，mul，add，还是max进行修改计算。默认为加算")]
	public PropertySub sub;

	public DamageFormula value;

	[Tooltip("属性来源是否变化")]
	public bool isChanged;

	[Tooltip("属性来源是否为caster")]
	public bool isCaster;

	public bool additivity;

	public PropertyDescriptor propertyDescriptor;
}
