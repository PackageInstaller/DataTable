using System;
using System.Reflection;
using System.Text;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public static class LuaHelper
{
	public delegate void ETLCallBack1(GameObject go, PointerEventData e);

	public delegate void ETLCallBack2(GameObject go, BaseEventData e);

	public delegate void ETLCallBack3(GameObject go, AxisEventData e);

	private static ILuaInterface sLuaInterface;

	public static void SetLua(ILuaInterface luaInterface)
	{
		sLuaInterface = luaInterface;
	}

	public static bool IsLuaClientInited()
	{
		return sLuaInterface != null;
	}

	[NoToLua]
	public static LuaFunction GetFunc(string funcName)
	{
		return sLuaInterface?.luaState?.GetFunction(funcName);
	}

	[NoToLua]
	public static LuaState GetLuaState()
	{
		return sLuaInterface?.luaState;
	}

	public static object[] CallFunction(string funcName, params object[] args)
	{
		object[] result = null;
		if (sLuaInterface != null && sLuaInterface.luaState != null)
		{
			try
			{
				LuaFunction function = sLuaInterface.luaState.GetFunction(funcName);
				if (function != null)
				{
					result = function.LazyCall(args);
				}
			}
			catch (Exception message)
			{
				Debugger.LogError(message);
			}
		}
		return result;
	}

	public static ETLCallBack1 EventTriggerAction1(LuaFunction func)
	{
		return delegate(GameObject go, PointerEventData e)
		{
			func.Call(go, e);
		};
	}

	public static ETLCallBack2 EventTriggerAction2(LuaFunction func)
	{
		return delegate(GameObject go, BaseEventData e)
		{
			func.Call(go, e);
		};
	}

	public static ETLCallBack3 EventTriggerAction3(LuaFunction func)
	{
		return delegate(GameObject go, AxisEventData e)
		{
			func.Call(go, e);
		};
	}

	public static Action VoidAction(LuaFunction func)
	{
		return delegate
		{
			func.Call();
		};
	}

	public static Action<float> FloatAction(LuaFunction func)
	{
		return delegate(float obj)
		{
			func.Call(obj);
		};
	}

	public static Action<string> StringAction(LuaFunction func)
	{
		return delegate(string obj)
		{
			func.Call(obj);
		};
	}

	public static object CloneOb(UnityEngine.Object ob)
	{
		return UnityEngine.Object.Instantiate(ob, Vector3.zero, Quaternion.identity);
	}

	public static bool IsUObject(object obj)
	{
		return obj != null;
	}

	public static void UnityGC()
	{
		GC.Collect(0);
	}

	public static void SafeDelOb(object ob)
	{
		if (ob != null)
		{
			UnityEngine.Object.Destroy(ob as GameObject);
		}
	}

	public static string ShowOb(object ob)
	{
		if (ob == null)
		{
			return "null";
		}
		StringBuilder stringBuilder = new StringBuilder();
		Type type = ob.GetType();
		FieldInfo[] fields = type.GetFields();
		stringBuilder.Append("Ob type is : ").Append(type.FullName).Append("\n");
		stringBuilder.Append("fields:\n").Append("name     value\n");
		FieldInfo[] array = fields;
		foreach (FieldInfo fieldInfo in array)
		{
			object value = fieldInfo.GetValue(ob);
			if (value != null && value.ToString() != "null")
			{
				stringBuilder.Append($"{fieldInfo.Name} -- {value}\n");
			}
		}
		stringBuilder.Append("--------\n");
		stringBuilder.Append("propertys:\n").Append("name     value\n");
		PropertyInfo[] properties = type.GetProperties();
		foreach (PropertyInfo propertyInfo in properties)
		{
			object value2 = propertyInfo.GetValue(ob, null);
			if (value2 != null && value2.ToString() != "null")
			{
				stringBuilder.Append($"{propertyInfo.Name} -- {value2}\n");
			}
		}
		stringBuilder.Append("-------------------\n");
		return stringBuilder.ToString();
	}

	public static RuntimePlatform GetPlatform()
	{
		return RuntimePlatform.WindowsEditor;
	}

	public static Vector2 ScreenToLocal(RectTransform rtf, Vector2 scrPos, Camera cam)
	{
		Vector2 localPoint = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rtf, scrPos, cam, out localPoint);
		return localPoint;
	}

	public static void SetTfLocalPosValue(Transform tf, float v1, float v2, float v3)
	{
		tf.localPosition = new Vector3(v1, v2, v3);
	}

	public static void SetRtfLocalPosValue(RectTransform tf, float v1, float v2, float v3)
	{
		tf.localPosition = new Vector3(v1, v2, v3);
	}

	public static void SetTfWorldPosValue(Transform tf, float v1, float v2, float v3)
	{
		tf.position = new Vector3(v1, v2, v3);
	}

	public static void SetTfLoalScaleValue(Transform tf, float v1, float v2, float v3)
	{
		tf.localScale = new Vector3(v1, v2, v3);
	}

	public static void SetRtfLocalScaleValue(RectTransform tf, float v1, float v2, float v3)
	{
		tf.localScale = new Vector3(v1, v2, v3);
	}

	public static void SetTfLocalRotateValue(Transform tf, float v1, float v2, float v3)
	{
		tf.localEulerAngles = new Vector3(v1, v2, v3);
	}

	public static void SetRtfLocalRotateValue(RectTransform tf, float v1, float v2, float v3)
	{
		tf.localEulerAngles = new Vector3(v1, v2, v3);
	}

	public static void SetGOParentGO(GameObject child, GameObject parent, bool keepPos)
	{
		child.transform.SetParent(parent.transform, keepPos);
	}

	public static void SetGOParentTF(GameObject child, Transform parent, bool keepPos)
	{
		child.transform.SetParent(parent, keepPos);
	}

	public static void CopyTransformInfoGO(GameObject ob, GameObject src)
	{
		CopyTransformInfoTF(ob.transform, src.transform);
	}

	public static void CopyTransformInfoTF(Transform tf, Transform src)
	{
		tf.SetParent(src.parent, worldPositionStays: false);
		tf.localPosition = src.localPosition;
		tf.rotation = src.rotation;
	}

	public static void SetTFChildActive(Transform tf, string childName, bool active)
	{
		tf.Find(childName).gameObject.SetActive(active);
	}

	public static void ResetTF(Transform tf, bool active)
	{
		tf.gameObject.SetActive(active);
		tf.localScale = Vector3.one;
		tf.localPosition = Vector3.zero;
	}

	public static void ClearObject(UnityEngine.Object ob)
	{
		Image[] array = new Image[0];
		if (ob is GameObject)
		{
			array = ((GameObject)ob).GetComponentsInChildren<Image>();
		}
		else if (ob is Transform)
		{
			array = ((Transform)ob).GetComponentsInChildren<Image>();
		}
		for (int i = 0; i < array.Length; i++)
		{
			array[i].sprite = null;
		}
	}

	public static void SetSpColor(SpriteRenderer sp, float r, float g, float b, float a)
	{
		sp.color = new Color(r, g, b, a);
	}

	public static void SetRtfSize(RectTransform tf, float v1, float v2)
	{
		tf.sizeDelta = new Vector2(v1, v2);
	}

	public static Color StringToColor(string str)
	{
		Color color = default(Color);
		ColorUtility.TryParseHtmlString(str, out color);
		return color;
	}

	public static string GetTotalGCMemory(bool force)
	{
		return GC.GetTotalMemory(force).ToString();
	}

	public static string GetAllocateMemoryFromCurrentThread()
	{
		return GC.GetAllocatedBytesForCurrentThread().ToString();
	}

	public static string GetLuaMemory()
	{
		return sLuaInterface.luaState.GetFunction("collectgarbage").Invoke<string, float>("count").ToString();
	}

	public static string LogLuaState()
	{
		return sLuaInterface.luaState.LogLuaState();
	}

	public static void SendOnBeginDragToHandler(IBeginDragHandler handler, PointerEventData eventData)
	{
		handler.OnBeginDrag(eventData);
	}

	public static void SendOnDragToHandler(IDragHandler handler, PointerEventData eventData)
	{
		handler.OnDrag(eventData);
	}

	public static void SendOnEndDragToHandler(IEndDragHandler handler, PointerEventData eventData)
	{
		handler.OnEndDrag(eventData);
	}

	public static void Quit()
	{
		Application.Quit();
	}
}
