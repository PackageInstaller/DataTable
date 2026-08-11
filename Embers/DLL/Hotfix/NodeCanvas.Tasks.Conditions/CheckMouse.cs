using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("System Events")]
public class CheckMouse : ConditionTask<Collider>
{
	public MouseInteractionTypes checkType;

	protected override string info => checkType.ToString();

	protected override bool OnCheck()
	{
		return false;
	}

	protected override void OnEnable()
	{
		base.router.onMouseEnter += OnMouseEnter;
		base.router.onMouseExit += OnMouseExit;
		base.router.onMouseOver += OnMouseOver;
	}

	protected override void OnDisable()
	{
		base.router.onMouseEnter -= OnMouseEnter;
		base.router.onMouseExit -= OnMouseExit;
		base.router.onMouseOver -= OnMouseOver;
	}

	private void OnMouseEnter(EventData msg)
	{
		if (checkType == MouseInteractionTypes.MouseEnter)
		{
			YieldReturn(value: true);
		}
	}

	private void OnMouseExit(EventData msg)
	{
		if (checkType == MouseInteractionTypes.MouseExit)
		{
			YieldReturn(value: true);
		}
	}

	private void OnMouseOver(EventData msg)
	{
		if (checkType == MouseInteractionTypes.MouseOver)
		{
			YieldReturn(value: true);
		}
	}
}
