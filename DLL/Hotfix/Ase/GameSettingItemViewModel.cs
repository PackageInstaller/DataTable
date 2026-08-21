using GameFramework.Runtime;

namespace Ase;

public class GameSettingItemViewModel : ItemOptionBase
{
	protected string name;

	protected float minValue;

	protected float maxValue;

	protected float defaultValue;

	protected float value;

	protected bool defaultSwitchTag;

	protected bool switchTag;

	protected string defaultMultiValue;

	protected string multiValue;

	protected float lastValue;

	protected string lastMultiValue;

	protected bool blockInBattle;

	protected bool inBattle;

	protected InteractionRequest<float> valueChanged;

	protected InteractionRequest<bool> switchTagChanged;

	protected InteractionRequest<string> multipleValueChanged;

	protected bool workWhenChanged;

	public bool WorkWhenChanged => workWhenChanged;

	public bool BlockInBattle
	{
		get
		{
			return blockInBattle;
		}
		protected set
		{
			Set(ref blockInBattle, value, "BlockInBattle");
		}
	}

	public bool InBattle
	{
		get
		{
			return inBattle;
		}
		protected set
		{
			Set(ref inBattle, value, "InBattle");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public float MinValue
	{
		get
		{
			return minValue;
		}
		private set
		{
			Set(ref minValue, value, "MinValue");
		}
	}

	public float MaxValue
	{
		get
		{
			return maxValue;
		}
		private set
		{
			Set(ref maxValue, value, "MaxValue");
		}
	}

	public float DefaultValue
	{
		get
		{
			return defaultValue;
		}
		private set
		{
			Set(ref defaultValue, value, "DefaultValue");
		}
	}

	public float Value
	{
		get
		{
			return value;
		}
		set
		{
			Set(ref this.value, value, "Value");
			valueChanged.Raise(value);
		}
	}

	public bool DefaultSwitchTag
	{
		get
		{
			return defaultSwitchTag;
		}
		set
		{
			Set(ref defaultSwitchTag, value, "DefaultSwitchTag");
		}
	}

	public bool SwitchTag
	{
		get
		{
			return switchTag;
		}
		set
		{
			Set(ref switchTag, value, "SwitchTag");
			switchTagChanged.Raise(value);
		}
	}

	public string DefaultMultValue
	{
		get
		{
			return defaultMultiValue;
		}
		private set
		{
			Set(ref defaultMultiValue, value, "DefaultMultValue");
		}
	}

	public string MultiValue
	{
		get
		{
			return multiValue;
		}
		set
		{
			Set(ref multiValue, value, "MultiValue");
			multipleValueChanged.Raise(value);
		}
	}

	public float LastValue => lastValue;

	public InteractionRequest<float> ValueChanged => valueChanged;

	public InteractionRequest<bool> SwitchTagChanged => switchTagChanged;

	public InteractionRequest<string> MultipleValueChanged => multipleValueChanged;

	public GameSettingItemViewModel()
	{
	}

	public GameSettingItemViewModel(OptionBase parent, GameSettingConfigHelper.SettingData param, bool inBattle, bool workWhenChanged = false)
	{
		base.parent = parent;
		valueChanged = new InteractionRequest<float>();
		switchTagChanged = new InteractionRequest<bool>();
		multipleValueChanged = new InteractionRequest<string>();
		BlockInBattle = param.Config.BlockInBattle;
		InBattle = inBattle;
		MinValue = param.Config.MinValue;
		MaxValue = param.Config.MaxValue;
		DefaultValue = param.Config.DefaultValue;
		DefaultSwitchTag = param.Config.DefaultSwitchTag;
		Name = param.Config.Name;
		Value = param.Value;
		SwitchTag = param.SwitchTag;
		this.workWhenChanged = workWhenChanged;
	}

	public virtual bool SetDefault()
	{
		if (SwitchTag.Equals(DefaultSwitchTag) && Value.Equals(DefaultValue))
		{
			return false;
		}
		Value = DefaultValue;
		SwitchTag = DefaultSwitchTag;
		return true;
	}

	public void SetValueByGraphicData(float value)
	{
		Value = GameSettingExtension.GetSettingIndex(name, value);
	}

	public bool SetValue(float value)
	{
		if (Value.Equals(value))
		{
			return false;
		}
		Value = value;
		return true;
	}

	public bool SetSwitchTag(bool tag)
	{
		if (SwitchTag == tag)
		{
			return false;
		}
		SwitchTag = tag;
		return true;
	}

	public bool SetLastValue(float value)
	{
		if (lastValue.Equals(value))
		{
			return false;
		}
		lastValue = value;
		return true;
	}

	public void ClearCache()
	{
		lastValue = Value;
	}

	public double GetValueRate()
	{
		return Value;
	}

	public void Save()
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(Name, out var settingData))
		{
			settingData.SetValue(Value);
			settingData.SetSwitchTag(SwitchTag);
		}
	}
}
