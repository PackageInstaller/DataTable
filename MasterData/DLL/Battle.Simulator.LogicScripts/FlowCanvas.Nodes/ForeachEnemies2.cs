using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("遍历敌人阵营比较黑板值(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历所有 Enemy 阵营的实体\n根据入口差异会对属性值进行不同的检查\n公示类型主要是针对属性key的不同计算规则，默认为 none 则只会比较基础值\n例如比较 169 最终值（基础值和buff修改的值），需要用加法公式来处理，得到最终属性值")]
public class ForeachEnemies2 : FlowControlNodeOfLogic
{
	private enum E_compareKey
	{
		None,
		LessThan,
		LessAndEqual,
		Equal,
		GreaterAndEqual,
		GreaterThan
	}

	private int _count;

	private int _entityID;

	private FlowOutput _notFoundOut;

	private FlowOutput _doOut;

	private FlowOutput _doneOut;

	private ValueInput<int> _wantedVarIntNameInput;

	private ValueInput<int> _valueInput;

	private ValueInput<AttributeCalcType> _calcTypeInput;

	protected override void RegisterPorts()
	{
		_wantedVarIntNameInput = AddValueInput<int>("变量名字", "wantedVarIntName");
		_valueInput = AddValueInput<int>("比较值", "value");
		_calcTypeInput = AddValueInput<AttributeCalcType>("公式类型", "calcType");
		_doOut = AddFlowOutput("Do", "do");
		_doneOut = AddFlowOutput("Done", "done");
		_notFoundOut = AddFlowOutput("不存在", "notFound");
		AddFlowInput("小于", "lessThan", delegate(Flow f)
		{
			Invoke(ref f, E_compareKey.LessThan);
		});
		AddFlowInput("小于等于", "lessAndEqual", delegate(Flow f)
		{
			Invoke(ref f, E_compareKey.LessAndEqual);
		});
		AddFlowInput("等于", "equal", delegate(Flow f)
		{
			Invoke(ref f, E_compareKey.Equal);
		});
		AddFlowInput("大于等于", "greaterAndEqual", delegate(Flow f)
		{
			Invoke(ref f, E_compareKey.GreaterAndEqual);
		});
		AddFlowInput("大于", "greaterThan", delegate(Flow f)
		{
			Invoke(ref f, E_compareKey.GreaterThan);
		});
		AddValueOutput("实体ID", "entityID", () => _entityID);
		AddValueOutput("数量", "count", () => _count);
	}

	private void Invoke(ref Flow f, E_compareKey compareKey)
	{
		_count = 0;
		_entityID = 0;
		List<int> emptyList = FrameListPool<int>.Claim();
		if (TryFilter(compareKey, _wantedVarIntNameInput.value, _valueInput.value, ref emptyList))
		{
			_count = emptyList.Count;
			for (int i = 0; i < emptyList.Count; i++)
			{
				_entityID = emptyList[i];
				_doOut.Call(f);
			}
			_doneOut.Call(f);
		}
		else
		{
			_notFoundOut.Call(f);
		}
		FrameListPool<int>.Release(emptyList);
	}

	private bool TryFilter(E_compareKey compareKey, int varInt, int value, ref List<int> emptyList)
	{
		List<int> allEnemy = SpawnProcessor.GetAllEnemy(base.mSimContext);
		for (int num = allEnemy.Count - 1; num >= 0; num--)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(allEnemy[num]);
			if (CommonProcessor.IsAliveRole(entityWithEntityID) && AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, varInt, out var baseValue, out var _, out var _))
			{
				long num2 = baseValue;
				if (_calcTypeInput.value != AttributeCalcType.None)
				{
					num2 = AttributeProcessor.GetFinalAttributeByAttributeID(entityWithEntityID.entityBlackboard.var.mAttributeID, varInt, _calcTypeInput.value);
				}
				switch (compareKey)
				{
				case E_compareKey.LessThan:
					if (num2 < value)
					{
						emptyList.Add(entityWithEntityID.creationIndex);
					}
					break;
				case E_compareKey.LessAndEqual:
					if (num2 <= value)
					{
						emptyList.Add(entityWithEntityID.creationIndex);
					}
					break;
				case E_compareKey.Equal:
					if (num2 == value)
					{
						emptyList.Add(entityWithEntityID.creationIndex);
					}
					break;
				case E_compareKey.GreaterAndEqual:
					if (num2 >= value)
					{
						emptyList.Add(entityWithEntityID.creationIndex);
					}
					break;
				case E_compareKey.GreaterThan:
					if (num2 > value)
					{
						emptyList.Add(entityWithEntityID.creationIndex);
					}
					break;
				default:
					Debug.LogError("=====>>>>> ForeachEnemies2 中没有对应的判断处理，请检查");
					break;
				}
			}
		}
		if (emptyList.Count > 0)
		{
			return true;
		}
		return false;
	}
}
