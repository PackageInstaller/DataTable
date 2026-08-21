using System;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;

[Category("✫ Blackboard")]
public class SetEnumFlag : ActionTask
{
	[BlackboardOnly]
	[RequiredField]
	public readonly BBObjectParameter Variable = new BBObjectParameter(typeof(Enum));

	public readonly BBObjectParameter Flag = new BBObjectParameter(typeof(Enum));

	public readonly BBParameter<bool> Clear = new BBParameter<bool>();

	protected override string info => string.Format("{0} {1} for {2} flag", Clear.value ? "Clear" : "Set", Variable, Flag);

	protected override void OnExecute()
	{
		int num = (int)Variable.value;
		num = ((!Clear.value) ? (num | (int)Flag.value) : (num & ~(int)Flag.value));
		Variable.value = Enum.ToObject(Variable.varRef.varType, num);
		EndAction();
	}
}
