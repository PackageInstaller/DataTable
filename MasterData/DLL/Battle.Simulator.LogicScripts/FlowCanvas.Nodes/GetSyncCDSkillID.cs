using System;
using Config;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取与指定技能同步CD的技能", 0)]
[Category("Logic/Config")]
[Description("获取与指定技能同步CD的技能")]
public class GetSyncCDSkillID : FlowControlNode
{
	private int _currentObject;

	private int _currentIndex;

	private bool _broken;

	private ValueInput<int> _abilityIDInput;

	protected override void RegisterPorts()
	{
		_abilityIDInput = AddValueInput<int>("AbilityID");
		AddValueOutput("Current", () => _currentObject);
		AddValueOutput("Index", () => _currentIndex);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			_currentIndex = -1;
			int value = _abilityIDInput.value;
			AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(value);
			if (config == null)
			{
				fFinish.Call(f);
			}
			else
			{
				_broken = false;
				f.breakCall = delegate
				{
					_broken = true;
				};
				for (int num = 0; num < config.SyncCDSkillID.Count; num++)
				{
					if (_broken)
					{
						break;
					}
					_currentObject = config.SyncCDSkillID.get_Item(num);
					_currentIndex = num;
					fCurrent.Call(f);
				}
				f.breakCall = null;
				fFinish.Call(f);
			}
		});
		AddFlowInput("Break", delegate
		{
			_broken = true;
		});
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (port == _abilityIDInput)
		{
			Type enumerableElementType = otherPort.type.GetEnumerableElementType();
			if (enumerableElementType != null)
			{
				ReplaceWith(typeof(GetSyncCDSkillID).RTMakeGenericType(enumerableElementType));
			}
		}
	}
}
