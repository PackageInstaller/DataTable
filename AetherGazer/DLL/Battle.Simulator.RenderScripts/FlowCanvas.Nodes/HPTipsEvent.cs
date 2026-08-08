using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("伤害显示事件", 0)]
[Category("Render/事件")]
[Description("伤害显示事件")]
public class HPTipsEvent : EventNode, IRenderCreateHPTips
{
	private FlowOutput output;

	private long value;

	private DamageType type = DamageType.Damage;

	private int injuredEntityID;

	private int abilityID;

	private int sourceEntityID;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private Vector3 _Position;

	public void RenderCreateHPTips(int causeDamageAbilityID, int injuredEntityID, long value, DamageType type, int causeDamageEntityID, Vector3 position)
	{
		abilityID = causeDamageAbilityID;
		sourceEntityID = causeDamageEntityID;
		this.injuredEntityID = injuredEntityID;
		this.value = Math.Abs(value);
		this.type = type;
		_Position = position;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		output.Call(f);
	}

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("输出");
		AddValueOutput("受击者ID:", () => injuredEntityID);
		AddValueOutput("造成伤害的技能ID:", () => abilityID);
		AddValueOutput("数值:", () => value);
		AddValueOutput("伤害类型:", () => type);
		AddValueOutput("攻击者:", () => sourceEntityID);
		AddValueOutput("显示位置", () => _Position);
	}
}
