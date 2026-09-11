using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到BUFF元素属性(子类型)(pure)", 0)]
[Category("Logic/Buff")]
[Description("通过buff子类型，得到buff对应的元素属性")]
public class BuffSubType2Element : PureFunctionNode<int, string>
{
	public static bool TryParseBuffSubType2Ele(string subType, out int element)
	{
		element = -1;
		switch (subType)
		{
		case "BUFF_TYPE_BLOOD":
		case "BUFF_STRONGCONTROL_PHYSICS":
			element = 0;
			return true;
		case "BUFF_DOT_WIND_1":
		case "BUFF_STRONGCONTROL_WIND":
			element = 2;
			return true;
		case "BUFF_TYPE_FIRE":
		case "BUFF_STRONGCONTROL_FIRE":
			element = 4;
			return true;
		case "BUFF_DOT_ICE_1":
		case "BUFF_TYPE_FREEZE":
			element = 6;
			return true;
		case "BUFF_DOT_WATER_1":
		case "BUFF_STRONGCONTROL_WATER":
			element = 8;
			return true;
		case "BUFF_DOT_DARK_1":
		case "BUFF_STRONGCONTROL_DARK":
			element = 10;
			return true;
		case "BUFF_DOT_LIGHT_1":
		case "BUFF_STRONGCONTROL_LIGHT":
			element = 12;
			return true;
		case "BUFF_DOT_THUNDER_1":
		case "BUFF_TYPE_PARALYZE":
			element = 14;
			return true;
		default:
			return false;
		}
	}

	public override int Invoke(string buffSubType)
	{
		TryParseBuffSubType2Ele(buffSubType, out var element);
		return element;
	}
}
