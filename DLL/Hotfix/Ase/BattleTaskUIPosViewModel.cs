using UnityEngine;

namespace Ase;

public class BattleTaskUIPosViewModel : OptionBase
{
	private Vector3 uiPos;

	private float uiPointRadius;

	private IUpdateActorPos updateActorPos;

	private string iconName;

	public Vector3 UIPos => uiPos;

	public Vector3 ActorPos
	{
		get
		{
			if (updateActorPos != null)
			{
				return updateActorPos.GetActorPos();
			}
			return Vector3.zero;
		}
	}

	public float UIPointRadius => uiPointRadius;

	public string IconName
	{
		get
		{
			return iconName;
		}
		set
		{
			Set(ref iconName, value, "IconName");
		}
	}

	private int index { get; set; }

	public int Index => index;

	public BattleTaskUIPosViewModel(IUpdateActorPos parent, Vector3 pos, float pointRadius, int index, string iconName = "task_dir_icon")
	{
		updateActorPos = parent;
		uiPos = pos;
		uiPointRadius = pointRadius;
		this.iconName = iconName;
		this.index = index;
	}

	public void UpdatePos(Vector3 pos, float radius)
	{
		uiPos = pos;
		uiPointRadius = radius;
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
	}
}
