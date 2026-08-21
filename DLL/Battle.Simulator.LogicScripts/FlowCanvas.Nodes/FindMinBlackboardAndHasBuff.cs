using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("找到指定范围内存在指定buff的指定黑板ID值最小的单位", 0)]
[Category("Logic/PosAndRot")]
[Description("找到指定范围内存在指定buff的指定黑板ID值最小的单位")]
public class FindMinBlackboardAndHasBuff : FindMinBlackboardID
{
	private ValueInput<string> _buffSubtypeInput;

	private ValueInput<HitHeight> heightInput;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_buffSubtypeInput = AddValueInput<string>("Buff子类型");
		heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
	}

	protected override bool FindAction(List<int> collisions, out int targetID)
	{
		targetID = 0;
		int num = int.MaxValue;
		bool result = false;
		for (int i = 0; i < collisions.Count; i++)
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
			if (simEntityByMultiColliders == null || !BuffProcessor.HasBuffBySubtype(simEntityByMultiColliders, _buffSubtypeInput.value))
			{
				continue;
			}
			HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
			if (curHitHeight == HitHeight.None || heightInput.value.HasFlag(curHitHeight))
			{
				AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(collisions[i]), _tagBlackboardIDInput.value, out var baseValue, out var _, out var _);
				if (num > baseValue)
				{
					num = (int)baseValue;
					result = true;
					targetID = simEntityByMultiColliders.creationIndex;
				}
			}
		}
		return result;
	}
}
