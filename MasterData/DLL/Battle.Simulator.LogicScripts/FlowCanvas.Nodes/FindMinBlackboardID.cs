using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("找到指定范围内指定黑板ID值最小的单位", 0)]
[Category("Logic/PosAndRot")]
[Description("找到指定范围内指定黑板ID值最小的单位")]
public class FindMinBlackboardID : FindTargetByConditions
{
	protected ValueInput<int> _tagBlackboardIDInput;

	private ValueInput<HitHeight> heightInput;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_tagBlackboardIDInput = AddValueInput<int>("黑板ID");
		heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
	}

	protected override bool FindAction(List<int> collisions, out int targetID)
	{
		targetID = 0;
		int num = int.MaxValue;
		for (int i = 0; i < collisions.Count; i++)
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
			if (simEntityByMultiColliders == null)
			{
				continue;
			}
			HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
			if (curHitHeight == HitHeight.None || heightInput.value.HasFlag(curHitHeight))
			{
				AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(simEntityByMultiColliders.creationIndex), _tagBlackboardIDInput.value, out var baseValue, out var _, out var _);
				if (num > baseValue)
				{
					num = (int)baseValue;
					targetID = simEntityByMultiColliders.creationIndex;
				}
			}
		}
		return true;
	}
}
