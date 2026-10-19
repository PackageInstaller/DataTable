using System.Collections;

namespace Unity.VisualScripting.Community;

[UnitTitle("If")]
[UnitCategory("Community/Control")]
[TypeIcon(typeof(If))]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.BetterIf")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.If")]
public class BetterIf : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput In;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput Condition;

	[DoNotSerialize]
	public ControlOutput True;

	[DoNotSerialize]
	public ControlOutput False;

	[DoNotSerialize]
	[PortLabel("Next")]
	public ControlOutput Finished;

	protected override void Definition()
	{
		In = ControlInputCoroutine("In", Enter, EnterCoroutine);
		True = ControlOutput("True");
		False = ControlOutput("False");
		Finished = ControlOutput("Finished");
		Condition = ValueInput<bool>("Condition");
		Succession(In, True);
		Succession(In, False);
		Succession(In, Finished);
		Requirement(Condition, In);
	}

	private IEnumerator EnterCoroutine(Flow flow)
	{
		if (flow.GetValue<bool>(Condition))
		{
			yield return True;
		}
		else
		{
			yield return False;
		}
		yield return Finished;
	}

	private ControlOutput Enter(Flow flow)
	{
		if (flow.GetValue<bool>(Condition))
		{
			flow.Invoke(True);
		}
		else
		{
			flow.Invoke(False);
		}
		return Finished;
	}
}
