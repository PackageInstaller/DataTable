using UnityEngine;

namespace Ase;

public class MapPointItemData : OptionBase
{
	private string icon;

	private Vector2 pos;

	private string pointName;

	private bool isLock;

	private int id;

	private int type;

	private bool redPoint;

	public int ID => id;

	public string Icon => icon;

	public Vector2 Pos => pos;

	public string PointName => pointName;

	public bool IsLock => isLock;

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public MapPointItemData(OptionBase parent, int id, int type, string icon, string name, Vector2 pos, bool isLock = false)
	{
		base.parent = parent;
		this.id = id;
		this.type = type;
		this.icon = icon;
		pointName = name;
		this.pos = pos;
		this.isLock = isLock;
	}

	public void SetRedPoint(bool redPoint)
	{
		if (!IsLock)
		{
			RedPoint = redPoint;
		}
	}

	public void HideName()
	{
		if (isLock)
		{
			pointName = "";
		}
	}

	public void OnClick()
	{
		if (!isLock)
		{
			parent?.ItemOnClick(new OptionArg(this, "OnClick"));
		}
	}

	public void SetRedPoint()
	{
		if (RedPoint)
		{
			RedPoint = false;
			Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(type, id);
		}
	}

	public void CloseHeroRedPoint()
	{
		if (RedPoint)
		{
			RedPoint = false;
			Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveHeroRedPoint(id);
		}
	}
}
