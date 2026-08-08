using System;

public class Listener
{
	public delegate void MyValueChange(object sender, EventArgs args);

	private string myValue;

	private bool myActive;

	public string MyValue
	{
		get
		{
			return myValue;
		}
		set
		{
			if (value != myValue)
			{
				WhenMyValueChange();
				myValue = value;
			}
		}
	}

	public bool MyActive
	{
		get
		{
			return myActive;
		}
		set
		{
			if (value != myActive)
			{
				WhenMyValueChange();
				myActive = value;
			}
		}
	}

	public event MyValueChange OnValueChanged;

	private void WhenMyValueChange()
	{
		OnValueChanged?.Invoke(this, null);
	}
}
