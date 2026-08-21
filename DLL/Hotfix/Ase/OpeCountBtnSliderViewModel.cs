using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class OpeCountBtnSliderViewModel : OptionBase
{
	private int opeCount;

	private int opeCountMin;

	private int opeCountMax;

	private float sliderValue;

	private float sliderValueMin;

	private bool canDec;

	private bool canAdd;

	private bool showBtnDec = true;

	private bool showBtnAdd = true;

	private bool btnAutoHide;

	private InteractionRequest<float> fixSliderRequest = new InteractionRequest<float>();

	private Action<int> onOpeCountChanged;

	public int OpeCount
	{
		get
		{
			return opeCount;
		}
		private set
		{
			if (Set(ref opeCount, value, "OpeCount"))
			{
				onOpeCountChanged?.Invoke(value);
				parent?.ItemOnClick(this);
			}
		}
	}

	public int OpeCountMin
	{
		get
		{
			return opeCountMin;
		}
		private set
		{
			Set(ref opeCountMin, value, "OpeCountMin");
			SliderValueMin = ((OpeCountMax <= 0) ? 0f : Mathf.Clamp((float)value / (float)OpeCountMax, 0f, 1f));
		}
	}

	public int OpeCountMax
	{
		get
		{
			return opeCountMax;
		}
		private set
		{
			Set(ref opeCountMax, value, "OpeCountMax");
			SliderValueMin = ((value <= 0) ? 0f : Mathf.Clamp((float)OpeCountMin / (float)value, 0f, 1f));
		}
	}

	public float SliderValue
	{
		get
		{
			return sliderValue;
		}
		set
		{
			if (value < SliderValueMin)
			{
				fixSliderRequest.Raise(SliderValueMin);
			}
			else if (OpeCountMax == 0)
			{
				Set(ref sliderValue, 1f, "SliderValue");
				fixSliderRequest.Raise(1f);
				SetUseCount();
			}
			else
			{
				Set(ref sliderValue, value, "SliderValue");
				SetUseCount();
			}
		}
	}

	public float SliderValueMin
	{
		get
		{
			return sliderValueMin;
		}
		private set
		{
			Set(ref sliderValueMin, value, "SliderValueMin");
			SliderValue = Mathf.Clamp(SliderValue, value, 1f);
		}
	}

	public bool CanAdd
	{
		get
		{
			return canAdd;
		}
		private set
		{
			Set(ref canAdd, value, "CanAdd");
			ShowBtnAdd = !btnAutoHide || CanAdd;
		}
	}

	public bool CanDec
	{
		get
		{
			return canDec;
		}
		private set
		{
			Set(ref canDec, value, "CanDec");
			ShowBtnDec = !btnAutoHide || CanDec;
		}
	}

	public bool ShowBtnDec
	{
		get
		{
			return showBtnDec;
		}
		private set
		{
			Set(ref showBtnDec, value, "ShowBtnDec");
		}
	}

	public bool ShowBtnAdd
	{
		get
		{
			return showBtnAdd;
		}
		private set
		{
			Set(ref showBtnAdd, value, "ShowBtnAdd");
		}
	}

	public IInteractionRequest FixSliderRequest => fixSliderRequest;

	public OpeCountBtnSliderViewModel()
	{
	}

	public OpeCountBtnSliderViewModel(int operateCountMin = 0, bool btnAutoHide = false)
	{
		OpeCountMin = operateCountMin;
		this.btnAutoHide = btnAutoHide;
	}

	public OpeCountBtnSliderViewModel(OptionBase parent, int operateCountMin = 0, bool btnAutoHide = false)
	{
		base.parent = parent;
		OpeCountMin = operateCountMin;
		this.btnAutoHide = btnAutoHide;
	}

	public void SetOpeCountMin(int min, bool forceUpdate = false)
	{
		OpeCountMin = min;
		if (forceUpdate)
		{
			SetUseCount();
		}
	}

	public void SetOpeCountMax(int max, bool forceUpdate = false)
	{
		OpeCountMax = max;
		if (forceUpdate)
		{
			SetUseCount();
		}
	}

	public void AddOpeCountChangedAction(Action<int> action)
	{
		onOpeCountChanged = (Action<int>)Delegate.Combine(onOpeCountChanged, action);
	}

	public void AddOpeCount()
	{
		if (OpeCount < OpeCountMax)
		{
			int num = OpeCount + 1;
			SliderValue = CalSliderValue(num);
			SetUseCount(num);
		}
	}

	public void DecOpeCount()
	{
		if (OpeCount > OpeCountMin)
		{
			int num = OpeCount - 1;
			SliderValue = CalSliderValue(num);
			SetUseCount(num);
		}
	}

	private float CalSliderValue(int count)
	{
		if (OpeCountMax != 0)
		{
			return (float)count / (float)OpeCountMax;
		}
		return 0f;
	}

	private void SetUseCount(int i = -1)
	{
		if (i == -1)
		{
			OpeCount = ((OpeCountMax >= OpeCountMin) ? Mathf.Clamp((int)(SliderValue * (float)OpeCountMax), OpeCountMin, OpeCountMax) : OpeCountMin);
		}
		else
		{
			OpeCount = i;
		}
		CanDec = OpeCount > OpeCountMin;
		CanAdd = OpeCount < OpeCountMax;
	}

	public void ResetToMin()
	{
		if (OpeCountMax == 0)
		{
			SliderValue = 1f;
		}
		else
		{
			SliderValue = Mathf.Clamp((float)OpeCountMin / (float)OpeCountMax, 0f, 1f);
		}
	}
}
