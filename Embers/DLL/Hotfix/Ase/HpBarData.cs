using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HpBarData : ViewModelBase, IReference
{
	private float curHp;

	private float maxHp;

	private float curShield;

	private float maxShield;

	private int action;

	private float laterHp;

	private float laterShield;

	public float CurHp
	{
		get
		{
			return curHp;
		}
		private set
		{
			Set(ref curHp, value, "CurHp");
		}
	}

	public float MaxHp
	{
		get
		{
			return maxHp;
		}
		private set
		{
			Set(ref maxHp, value, "MaxHp");
		}
	}

	public float CurShield
	{
		get
		{
			return curShield;
		}
		private set
		{
			Set(ref curShield, value, "CurShield");
		}
	}

	public float MaxShield
	{
		get
		{
			return maxShield;
		}
		private set
		{
			Set(ref maxShield, value, "MaxShield");
		}
	}

	public int Action
	{
		get
		{
			return action;
		}
		private set
		{
			Set(ref action, value, "Action");
		}
	}

	public float LaterHp
	{
		get
		{
			return laterHp;
		}
		private set
		{
			Set(ref laterHp, value, "LaterHp");
		}
	}

	public float LaterShield
	{
		get
		{
			return laterShield;
		}
		private set
		{
			Set(ref laterShield, value, "LaterShield");
		}
	}

	public HpBarData()
	{
		Reset();
	}

	public void UpdateData(float hp, float hpMax, float shield, float shieldMax)
	{
		CurHp = hp;
		MaxHp = hpMax;
		CurShield = shield;
		MaxShield = shieldMax;
	}

	public void UpdateData(int actionValue)
	{
		Action = actionValue;
	}

	public void UpdateLaterHp(float hp)
	{
		LaterHp = hp;
	}

	public void UpdateLaterShield(float shield)
	{
		LaterShield = shield;
	}

	public void Reset()
	{
		CurHp = 1f;
		MaxHp = 1f;
		MaxShield = 1f;
		CurShield = 1f;
		Action = 0;
		LaterHp = 1f;
		LaterShield = 1f;
	}

	public void Clear()
	{
		Reset();
	}
}
