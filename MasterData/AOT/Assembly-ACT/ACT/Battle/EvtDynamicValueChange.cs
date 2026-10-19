using ACT.Core;

namespace ACT.Battle;

public class EvtDynamicValueChange : BaseEvt
{
	public DynamicValue dynamicValue;

	public string name;

	public float changeValue;

	public override void Reset()
	{
		dynamicValue = null;
		name = null;
		changeValue = 0f;
	}
}
