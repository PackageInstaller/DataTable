using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Utility")]
[Description("Simply use to debug return true or false by inverting the condition if needed")]
public class DebugCondition : ConditionTask
{
	protected override bool OnCheck()
	{
		return false;
	}
}
