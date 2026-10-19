using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

public abstract class PointerEventUnit : GameObjectEventUnit<PointerEventData>
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput data { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		data = ValueOutput<PointerEventData>("data");
	}

	protected override void AssignArguments(Flow flow, PointerEventData data)
	{
		flow.SetValue(this.data, data);
	}
}
