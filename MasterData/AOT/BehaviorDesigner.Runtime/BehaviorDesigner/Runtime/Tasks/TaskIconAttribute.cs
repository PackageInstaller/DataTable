using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
public class TaskIconAttribute : Attribute
{
	private string mIconPath;

	private string mLightIconGUID;

	private string mDarkIconGUID;

	public string IconPath
	{
		get
		{
			return mIconPath;
		}
		set
		{
			mIconPath = value;
		}
	}

	public string LightIconGUID => mLightIconGUID;

	public string DarkIconGUID => mDarkIconGUID;

	public TaskIconAttribute(string iconString)
	{
		if (iconString.ToLower().Contains("."))
		{
			mIconPath = iconString;
		}
		else
		{
			mLightIconGUID = (mDarkIconGUID = iconString);
		}
	}

	public TaskIconAttribute(string lightIconGUID, string darkIconGUID)
	{
		mLightIconGUID = lightIconGUID;
		mDarkIconGUID = darkIconGUID;
	}
}
