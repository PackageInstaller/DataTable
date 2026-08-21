using System.Text;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class DamageInfoViewModel : ViewModelBase
{
	private bool empty;

	private string name;

	private bool isSelf;

	private float damage;

	private float enterDownDamage;

	private string damageText;

	private float tenacity;

	private string tenacityText;

	private float cure;

	private string cureText;

	private float maxDamage;

	private float maxTenacity;

	private float maxCure;

	private int showIndex;

	private bool downState;

	private string downDamageText;

	private StringBuilder _stringBuilder;

	private int skinId;

	public int SkinId => skinId;

	public bool Empty
	{
		get
		{
			return empty;
		}
		set
		{
			Set(ref empty, value, "Empty");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public float Damage
	{
		get
		{
			return damage;
		}
		private set
		{
			Set(ref damage, value, "Damage");
			DamageText = Utility.Convert.DamageNumberToString(value);
		}
	}

	public string DownDamageText
	{
		get
		{
			return downDamageText;
		}
		private set
		{
			Set(ref downDamageText, value, "DownDamageText");
		}
	}

	public string DamageText
	{
		get
		{
			return damageText;
		}
		private set
		{
			Set(ref damageText, value, "DamageText");
		}
	}

	public float Tenacity
	{
		get
		{
			return tenacity;
		}
		private set
		{
			Set(ref tenacity, value, "Tenacity");
			TenacityText = Utility.Convert.DamageNumberToString(value);
		}
	}

	public string TenacityText
	{
		get
		{
			return tenacityText;
		}
		private set
		{
			Set(ref tenacityText, value, "TenacityText");
		}
	}

	public float Cure
	{
		get
		{
			return cure;
		}
		private set
		{
			Set(ref cure, value, "Cure");
			CureText = Utility.Convert.DamageNumberToString(value);
		}
	}

	public string CureText
	{
		get
		{
			return cureText;
		}
		private set
		{
			Set(ref cureText, value, "CureText");
		}
	}

	public float MaxDamage
	{
		get
		{
			return maxDamage;
		}
		private set
		{
			Set(ref maxDamage, value, "MaxDamage");
		}
	}

	public float MaxTenacity
	{
		get
		{
			return maxTenacity;
		}
		private set
		{
			Set(ref maxTenacity, value, "MaxTenacity");
		}
	}

	public float MaxCure
	{
		get
		{
			return maxCure;
		}
		private set
		{
			Set(ref maxCure, value, "MaxCure");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public int ShowIndex
	{
		get
		{
			return showIndex;
		}
		set
		{
			Set(ref showIndex, value, "ShowIndex");
		}
	}

	public bool DownState
	{
		get
		{
			return downState;
		}
		set
		{
			Set(ref downState, value, "DownState");
		}
	}

	public DamageInfoViewModel(OptionBase parent, BattleHeroData heroData, int index)
	{
		Damage = 0f;
		Tenacity = 0f;
		Cure = 0f;
		Name = heroData.Name;
		MaxDamage = 0f;
		MaxTenacity = 0f;
		MaxCure = 0f;
		IsSelf = heroData.IsSelf;
		showIndex = index;
		downState = false;
		if (heroData.HeroModel.IsSkin)
		{
			skinId = heroData.HeroModel.SkinConfigId;
		}
	}

	public void RefreshDS(EntityStatInfo data, float d, float t, float c)
	{
		SetDamageNumber(data.Damage - enterDownDamage);
		Damage = data.Damage;
		Tenacity = data.Tenacity;
		Cure = data.CurativeDose;
		MaxDamage = d;
		MaxTenacity = t;
		MaxCure = c;
	}

	private void SetDamageNumber(float num)
	{
		if (DownState)
		{
			if (_stringBuilder == null)
			{
				_stringBuilder = new StringBuilder(10);
			}
			else
			{
				_stringBuilder.Clear();
			}
			string text = ((int)num).ToString();
			for (int i = 0; i < text.Length; i++)
			{
				_stringBuilder.Append($"<sprite={text[i]}>");
			}
			DownDamageText = _stringBuilder.ToString();
		}
	}

	public void RefreshDS(float d, float t, float c)
	{
		MaxDamage = d;
		MaxTenacity = t;
		MaxCure = c;
	}

	public void RefreshSelf(bool isSelf)
	{
		IsSelf = isSelf;
	}

	public void Reset()
	{
		Damage = 0f;
		MaxDamage = 0f;
		Tenacity = 0f;
		MaxTenacity = 0f;
		IsSelf = false;
	}

	public void SetDownState(bool enterDown)
	{
		DownState = enterDown;
		enterDownDamage = damage;
		if (enterDown)
		{
			DownDamageText = "<sprite=0>";
		}
	}

	public float GetToTalDownDamage()
	{
		return damage - enterDownDamage;
	}
}
