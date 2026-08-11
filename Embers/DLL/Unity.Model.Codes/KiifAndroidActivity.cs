using System;
using UnityEngine;

public class KiifAndroidActivity
{
	private static AndroidJavaObject managerJo;

	private static AndroidJavaObject GetClass()
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Expected O, but got Unknown
		if (Application.platform == RuntimePlatform.Android)
		{
			string text = "com.chkj.externalstoragedirectory.SDCardManager";
			if (managerJo == null)
			{
				managerJo = new AndroidJavaObject(text, Array.Empty<object>());
			}
		}
		return managerJo;
	}

	public static bool CallObjectMethod(string name, params object[] args)
	{
		//IL_0036: Expected O, but got Unknown
		if (Application.platform != RuntimePlatform.Android)
		{
			return false;
		}
		if (GetClass() == null)
		{
			Debug.LogWarning("Object is null when calling method " + name);
			return false;
		}
		try
		{
			GetClass().Call(name, args);
			return true;
		}
		catch (AndroidJavaException ex)
		{
			Debug.LogError("Exception calling method " + name + ": " + (object)ex);
			return false;
		}
	}

	public static bool CallObjectMethod<T>(out T result, string name)
	{
		//IL_0047: Expected O, but got Unknown
		result = default(T);
		if (Application.platform != RuntimePlatform.Android)
		{
			return false;
		}
		if (GetClass() == null)
		{
			Debug.LogWarning("Object is null when calling method " + name);
			return false;
		}
		try
		{
			result = GetClass().Call<T>(name, Array.Empty<object>());
			return true;
		}
		catch (AndroidJavaException ex)
		{
			Debug.LogError("Exception calling method " + name + ": " + (object)ex);
			return false;
		}
	}

	public static bool CallObjectMethod<T>(out T result, string name, params object[] args)
	{
		//IL_0038: Expected O, but got Unknown
		result = default(T);
		if (GetClass() == null)
		{
			Debug.LogError("Object is null when calling method " + name);
			return false;
		}
		try
		{
			result = GetClass().Call<T>(name, args);
			return true;
		}
		catch (AndroidJavaException ex)
		{
			Debug.LogError("Exception calling method " + name + ": " + (object)ex);
			return false;
		}
	}

	public static AndroidJavaObject GetActivity(string package_name, string activity_name)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		AndroidJavaClass val = new AndroidJavaClass(package_name);
		if ((int)val == 0)
		{
			return null;
		}
		return ((AndroidJavaObject)val).GetStatic<AndroidJavaObject>(activity_name);
	}
}
