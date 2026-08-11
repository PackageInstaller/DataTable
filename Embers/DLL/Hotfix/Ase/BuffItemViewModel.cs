using UnityEngine;

namespace Ase;

public class BuffItemViewModel : OptionBase
{
	private Buff buff;

	private int layer;

	private float maxTime;

	private float curTime;

	private float leftTimePercent;

	private string icon;

	private string desc;

	private bool showTime;

	private bool showAlphaValue;

	private string buffName;

	private bool noActive;

	private bool showLayer;

	private bool pressEnable = true;

	public Buff Buff => buff;

	public int Layer
	{
		get
		{
			return layer;
		}
		private set
		{
			Set(ref layer, value, "Layer");
		}
	}

	public float MaxTime
	{
		get
		{
			return maxTime;
		}
		private set
		{
			Set(ref maxTime, value, "MaxTime");
		}
	}

	public float CurTime
	{
		get
		{
			return curTime;
		}
		private set
		{
			Set(ref curTime, value, "CurTime");
		}
	}

	public float LeftTimePercent
	{
		get
		{
			return leftTimePercent;
		}
		private set
		{
			Set(ref leftTimePercent, value, "LeftTimePercent");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public bool ShowTime
	{
		get
		{
			return showTime;
		}
		private set
		{
			Set(ref showTime, value, "ShowTime");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string BuffName
	{
		get
		{
			return buffName;
		}
		private set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public bool ShowAlphaValue
	{
		get
		{
			return showAlphaValue;
		}
		private set
		{
			Set(ref showAlphaValue, value, "ShowAlphaValue");
		}
	}

	public bool NoActive
	{
		get
		{
			return noActive;
		}
		private set
		{
			Set(ref noActive, value, "NoActive");
		}
	}

	public bool ShowLayer
	{
		get
		{
			return showLayer;
		}
		private set
		{
			Set(ref showLayer, value, "ShowLayer");
		}
	}

	public BuffItemViewModel(Buff buff)
	{
		this.buff = buff;
		layer = buff.GetLayer();
		icon = buff.Config.BuffIcon;
		desc = buff.Config.Desc;
		maxTime = buff.MaxLifeTime;
		curTime = buff.CurLifeTime;
		showTime = buff.MaxLifeTime > 0f;
		buffName = buff.Config.Name;
		ShowAlphaValue = false;
		showLayer = buff.Config.MaxLayer > 1;
		noActive = false;
	}

	public BuffItemViewModel(DRBuff buff)
	{
		icon = ((buff.BuffIcon == null) ? "" : buff.BuffIcon);
		desc = ((buff.Desc == null) ? "" : buff.Desc);
		ShowAlphaValue = false;
	}

	public BuffItemViewModel()
	{
	}

	public void SetNoActive()
	{
		if (maxTime > 0f)
		{
			CurTime = maxTime;
		}
		NoActive = true;
	}

	public override void SetParent(OptionBase parent)
	{
		base.SetParent(parent);
	}

	public void OnHideDesc()
	{
		pressEnable = true;
	}

	public void Update()
	{
		if (buff != null && !noActive)
		{
			Layer = buff.GetLayer();
			CurTime = buff.CurLifeTime;
			MaxTime = buff.MaxLifeTime;
			LeftTimePercent = Mathf.Clamp01(1f - curTime * 1f / maxTime);
			if (maxTime > 1f && maxTime - curTime <= 1f)
			{
				ShowAlphaValue = true;
			}
			if (maxTime > 1f && maxTime - curTime > 1f && ShowAlphaValue)
			{
				ShowAlphaValue = false;
			}
		}
	}

	public new void Dispose()
	{
		Update();
		buff = null;
	}
}
