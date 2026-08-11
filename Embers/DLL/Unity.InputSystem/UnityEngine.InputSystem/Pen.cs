using System.ComponentModel;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(PenState), isGenericTypeOfDevice = true)]
public class Pen : Pointer
{
	public ButtonControl tip { get; protected set; }

	public ButtonControl eraser { get; protected set; }

	public ButtonControl firstBarrelButton { get; protected set; }

	public ButtonControl secondBarrelButton { get; protected set; }

	public ButtonControl thirdBarrelButton { get; protected set; }

	public ButtonControl fourthBarrelButton { get; protected set; }

	public ButtonControl inRange { get; protected set; }

	public Vector2Control tilt { get; protected set; }

	public AxisControl twist { get; protected set; }

	public new static Pen current { get; internal set; }

	public ButtonControl this[PenButton button] => button switch
	{
		PenButton.Tip => tip, 
		PenButton.Eraser => eraser, 
		PenButton.BarrelFirst => firstBarrelButton, 
		PenButton.BarrelSecond => secondBarrelButton, 
		PenButton.BarrelThird => thirdBarrelButton, 
		PenButton.BarrelFourth => fourthBarrelButton, 
		PenButton.InRange => inRange, 
		_ => throw new InvalidEnumArgumentException("button", (int)button, typeof(PenButton)), 
	};

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnRemoved()
	{
		base.OnRemoved();
		if (current == this)
		{
			current = null;
		}
	}

	protected override void FinishSetup()
	{
		tip = GetChildControl<ButtonControl>("tip");
		eraser = GetChildControl<ButtonControl>("eraser");
		firstBarrelButton = GetChildControl<ButtonControl>("barrel1");
		secondBarrelButton = GetChildControl<ButtonControl>("barrel2");
		thirdBarrelButton = GetChildControl<ButtonControl>("barrel3");
		fourthBarrelButton = GetChildControl<ButtonControl>("barrel4");
		inRange = GetChildControl<ButtonControl>("inRange");
		tilt = GetChildControl<Vector2Control>("tilt");
		twist = GetChildControl<AxisControl>("twist");
		base.FinishSetup();
	}
}
