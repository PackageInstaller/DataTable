using System;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/触发器内部事件/发送Lua事件", 3)]
public class Task_TriggerLuaMsg : TaskCellBase
{
	public enum LuaArgType
	{
		String,
		Int,
		Float,
		Bool
	}

	[Serializable]
	public class LuaArg
	{
		public LuaArgType type;

		public string stringValue;

		public int intValue;

		public float floatValue;

		public bool boolValue;

		public object GetValue()
		{
			return type switch
			{
				LuaArgType.Int => (object)intValue, 
				LuaArgType.Float => floatValue, 
				LuaArgType.Bool => boolValue, 
				_ => stringValue, 
			};
		}
	}

	public string eventName;

	public List<LuaArg> args = new List<LuaArg>();

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(eventName))
		{
			LogWarning("未配置Lua事件名");
			EndAction(success: false);
			return;
		}
		int num = ((args != null) ? args.Count : 0);
		switch (num)
		{
		case 0:
			MonoSingleton<LuaManager>.Instance.FireEvent(eventName);
			break;
		case 1:
			MonoSingleton<LuaManager>.Instance.FireEvent(eventName, args.get_Item(0).GetValue());
			break;
		case 2:
			MonoSingleton<LuaManager>.Instance.FireEvent(eventName, args.get_Item(0).GetValue(), args.get_Item(1).GetValue());
			break;
		case 3:
			MonoSingleton<LuaManager>.Instance.FireEvent(eventName, args.get_Item(0).GetValue(), args.get_Item(1).GetValue(), args.get_Item(2).GetValue());
			break;
		default:
			if (num > 4)
			{
				LogWarning("参数超过4个,仅发送前4个: " + eventName);
			}
			MonoSingleton<LuaManager>.Instance.FireEvent(eventName, args.get_Item(0).GetValue(), args.get_Item(1).GetValue(), args.get_Item(2).GetValue(), args.get_Item(3).GetValue());
			break;
		}
		EndAction();
	}
}
