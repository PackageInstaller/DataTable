namespace Ase;

public class BTBuffViewModel : OptionBase
{
	private Buff buff;

	private string desc;

	private int buffId;

	private float limitTime;

	private float maxLimitTime;

	private float coolingTime;

	private float maxCoolingTime;

	private BuffState state;

	private int layer;

	private bool isLoop;

	public string Desc
	{
		get
		{
			return desc;
		}
		set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public int BuffId
	{
		get
		{
			return buffId;
		}
		set
		{
			Set(ref buffId, value, "BuffId");
		}
	}

	public int Layer
	{
		get
		{
			return layer;
		}
		set
		{
			Set(ref layer, value, "Layer");
		}
	}

	public float LimitTime
	{
		get
		{
			return limitTime;
		}
		set
		{
			Set(ref limitTime, value, "LimitTime");
		}
	}

	public float MaxLimitTime
	{
		get
		{
			return maxLimitTime;
		}
		set
		{
			Set(ref maxLimitTime, value, "MaxLimitTime");
		}
	}

	public float CoolingTime
	{
		get
		{
			return coolingTime;
		}
		set
		{
			Set(ref coolingTime, value, "CoolingTime");
		}
	}

	public float MaxCoolingTime
	{
		get
		{
			return maxCoolingTime;
		}
		set
		{
			Set(ref maxCoolingTime, value, "MaxCoolingTime");
		}
	}

	public BuffState State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public bool IsLoop
	{
		get
		{
			return isLoop;
		}
		set
		{
			Set(ref isLoop, value, "IsLoop");
		}
	}

	public BTBuffViewModel(Buff buff)
	{
		this.buff = buff;
		GetBuffData(buff);
	}

	public void OnUpdate()
	{
		if (buff != null)
		{
			GetBuffData(buff);
		}
	}

	public void UpdateBuff(Buff buff)
	{
		this.buff = buff;
		GetBuffData(buff);
	}

	private void GetBuffData(Buff buff)
	{
		Desc = buff.Desc;
		BuffId = buff.BuffId;
		LimitTime = buff.CurLifeTime;
		MaxLimitTime = buff.MaxLifeTime;
		MaxCoolingTime = buff.RepeatTime;
		Layer = buff.GetLayer();
	}
}
