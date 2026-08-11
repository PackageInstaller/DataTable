using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class HeroInDependentData : ViewModelBase
{
	public BaseEntity OwnBaseEntity;

	private float resFillAmount;

	private bool isEmpty;

	private int currentFill;

	private int maxFill;

	public float ResFillAmount
	{
		get
		{
			return resFillAmount;
		}
		set
		{
			Set(ref resFillAmount, value, "ResFillAmount");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public int CurrentFill
	{
		get
		{
			return currentFill;
		}
		set
		{
			Set(ref currentFill, value, "CurrentFill");
		}
	}

	public int MaxFill
	{
		get
		{
			return maxFill;
		}
		set
		{
			Set(ref maxFill, value, "MaxFill");
		}
	}

	public static HeroInDependentData Create()
	{
		return new HeroInDependentData
		{
			IsEmpty = true
		};
	}

	public virtual void CalculateFillAmount()
	{
	}
}
