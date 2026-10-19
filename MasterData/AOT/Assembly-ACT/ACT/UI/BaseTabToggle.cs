using System;
using ACT.UI.Interface;
using Bamboo.ImageCenter;

namespace ACT.UI;

public abstract class BaseTabToggle : ActToggle, ITabItem
{
	private ImageAssetStation _station;

	private ITabContent _content;

	public virtual int TabIdentify { get; set; }

	public virtual int SortOrder => 0;

	public ITabContent Content
	{
		get
		{
			return _content;
		}
		set
		{
			if (_content != value)
			{
				ITabContent content = _content;
				_content = value;
				if (content != null)
				{
					content.Tab = null;
				}
				_content = value;
				if (value != null)
				{
					value.Tab = this;
				}
			}
		}
	}

	public virtual ImageAssetStation Station
	{
		get
		{
			ImageAssetStation station = _station;
			if (station != null && !station.IsReleased)
			{
				return _station;
			}
			_station = GetComponentInParent<IBaseUIView>(includeInactive: true)?.Station;
			return _station;
		}
		set
		{
			_station = value;
		}
	}

	public int TabName { get; set; }

	public virtual Func<bool> CanActive { get; set; } = () => true;

	public Action<BaseTabToggle> OnTabActiveCallback { get; set; }

	public Action<BaseTabToggle> OnTabDeActiveCallback { get; set; }

	public BetterAnimation Animation => _animation;

	protected override void Awake()
	{
		base.Awake();
		onToggleOn.AddListener(OnTabActive);
		onToggleOff.AddListener(OnTabDeActive);
	}

	protected virtual void OnTabActive()
	{
		OnTabActiveCallback?.Invoke(this);
	}

	protected virtual void OnTabDeActive()
	{
		OnTabDeActiveCallback?.Invoke(this);
	}
}
