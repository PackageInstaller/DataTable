using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("System Events")]
[Name("Check Mouse Click 2D", 0)]
public class CheckMouseClick2D : ConditionTask<Collider2D>
{
	public MouseClickEvent checkType;

	protected override string info => checkType.ToString();

	protected override bool OnCheck()
	{
		return false;
	}

	protected override void OnEnable()
	{
		base.router.onMouseDown += OnMouseDown;
		base.router.onMouseUp += OnMouseUp;
	}

	protected override void OnDisable()
	{
		base.router.onMouseDown -= OnMouseDown;
		base.router.onMouseUp -= OnMouseUp;
	}

	private void OnMouseDown(EventData msg)
	{
		if (checkType == MouseClickEvent.MouseDown)
		{
			YieldReturn(value: true);
		}
	}

	private void OnMouseUp(EventData msg)
	{
		if (checkType == MouseClickEvent.MouseUp)
		{
			YieldReturn(value: true);
		}
	}
}
