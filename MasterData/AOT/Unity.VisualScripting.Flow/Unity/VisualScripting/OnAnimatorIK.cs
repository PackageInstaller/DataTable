using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Animation")]
public sealed class OnAnimatorIK : GameObjectEventUnit<int>
{
	public override Type MessageListenerType => typeof(AnimatorMessageListener);

	protected override string hookName => "OnAnimatorIK";

	[DoNotSerialize]
	public ValueOutput layerIndex { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		layerIndex = ValueOutput<int>("layerIndex");
	}

	protected override void AssignArguments(Flow flow, int layerIndex)
	{
		flow.SetValue(this.layerIndex, layerIndex);
	}
}
