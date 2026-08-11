using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("Vector2长度比较", 0)]
[Category("✫ Blackboard")]
[Description("Vector2长度比较,如果大于返回true,其他返回false")]
public class CompareVectorMagnitude : ConditionTaskBase
{
	public BBParameter<Vector2> VectorValue;

	public BBParameter<float> Magnitude;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return VectorValue.value.SqrMagnitude() > Magnitude.value * Magnitude.value;
	}
}
