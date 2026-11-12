using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class LogicVariable : LogicComponent
{
	public enum LogicType
	{
		Number = 0,
		String = 1,
		TSVector2 = 2,
		List_TSVector2 = 4,
		Dic_Int_TSVector2 = 5,
		Dic_TSVector2_Long = 6,
		List_Long = 7
	}

	public struct LogicTag
	{
		[HideInInspector]
		public LogicType type;

		public FP numberValue;

		public string stringValue;

		public TSVector2 tsVec2Value;

		public List<TSVector2> listVect2Value;

		public Dictionary<int, TSVector2> dicIntVect2Value;

		public Dictionary<TSVector2, long> dicVect2LongValue;

		public List<long> listLongValue;

		private bool isNotNumber => type != LogicType.Number;

		private bool isNotString => type != LogicType.String;

		private bool isNotTSVector2 => type != LogicType.TSVector2;
	}

	[Space]
	public readonly Dictionary<string, LogicTag> _logicTags = new Dictionary<string, LogicTag>();

	[Space]
	protected readonly List<string> _logicCmdQueue = new List<string>();

	protected override void OnInit()
	{
		base.OnInit();
	}

	public bool HasLogicTag(string tag)
	{
		return _logicTags.ContainsKey(tag);
	}

	public void SetLogicTagValue(string tag, FP value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.Number,
			numberValue = value
		});
	}

	public FP GetLogicTagValue(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.Number)
			{
				return FP.Zero;
			}
			return value.numberValue;
		}
		return FP.Zero;
	}

	public void ToggleLogicTag(string tag, bool value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.Number,
			numberValue = (value ? FP.One : FP.Zero)
		});
	}

	public bool GetLogicTagToggle(string tag)
	{
		if (!_logicTags.TryGetValue(tag, out var value))
		{
			return false;
		}
		if (value.type == LogicType.Number)
		{
			return value.numberValue > FP.Zero;
		}
		return false;
	}

	public void SetLogicTagStringValue(string tag, string value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.String,
			stringValue = value
		});
	}

	public string GetLogicTagStringValue(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.String)
			{
				return null;
			}
			return value.stringValue;
		}
		return null;
	}

	public void SetLogicTagTSVector2Value(string tag, TSVector2 value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.TSVector2,
			tsVec2Value = value
		});
	}

	public TSVector2 GetLogicTagTSVector2Value(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.TSVector2)
			{
				return TSVector2.zero;
			}
			return value.tsVec2Value;
		}
		return TSVector2.zero;
	}

	public void SetLogicTagListTSVector2Value(string tag, List<TSVector2> value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.List_TSVector2,
			listVect2Value = value
		});
	}

	public List<TSVector2> GetLogicTagListTSVector2Value(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.List_TSVector2)
			{
				return null;
			}
			return value.listVect2Value;
		}
		return null;
	}

	public void SetLogicTagDicIntTSVector2Value(string tag, Dictionary<int, TSVector2> value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.Dic_Int_TSVector2,
			dicIntVect2Value = value
		});
	}

	public Dictionary<int, TSVector2> GetLogicTagDicIntTSVector2Value(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.Dic_Int_TSVector2)
			{
				return null;
			}
			return value.dicIntVect2Value;
		}
		return null;
	}

	public void SetLogicTagDicTSVector2LongValue(string tag, Dictionary<TSVector2, long> value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.Dic_TSVector2_Long,
			dicVect2LongValue = value
		});
	}

	public Dictionary<TSVector2, long> GetLogicTagDicTSVector2LongValue(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.Dic_TSVector2_Long)
			{
				return null;
			}
			return value.dicVect2LongValue;
		}
		return null;
	}

	public void SetLogicTagListLongValue(string tag, List<long> value)
	{
		_logicTags.set_Item(tag, new LogicTag
		{
			type = LogicType.List_Long,
			listLongValue = value
		});
	}

	public List<long> GetLogicTagListLongValue(string tag)
	{
		if (_logicTags.TryGetValue(tag, out var value))
		{
			if (value.type != LogicType.List_Long)
			{
				return null;
			}
			return value.listLongValue;
		}
		return null;
	}

	public void SetLogicTagTimer(string tag)
	{
		SetLogicTagValue(tag, Entity.LogicTime);
	}

	public bool IsLogicTagTimeout(string tag, FP timeout)
	{
		if (!_logicTags.TryGetValue(tag, out var value))
		{
			return true;
		}
		if (value.type == LogicType.Number)
		{
			return Entity.LogicTime > value.numberValue + timeout;
		}
		return true;
	}

	public void RemoveLogicTag(string tag)
	{
		_logicTags.Remove(tag);
	}

	public Dictionary<string, LogicTag> GetLogicTags()
	{
		return _logicTags;
	}

	public void EnqueueLogicCommand(string command, bool highPriority, bool unique)
	{
		if (string.IsNullOrEmpty(command))
		{
			return;
		}
		if (highPriority)
		{
			if (unique)
			{
				int num = _logicCmdQueue.IndexOf(command);
				if (num != -1)
				{
					_logicCmdQueue.RemoveAt(num);
				}
			}
			_logicCmdQueue.Insert(0, command);
		}
		else if (!unique || _logicCmdQueue.IndexOf(command) == -1)
		{
			_logicCmdQueue.Add(command);
		}
	}

	public string DequeueLogicCommand()
	{
		string text = PeekLogicCommand();
		if (!string.IsNullOrEmpty(text))
		{
			_logicCmdQueue.RemoveAt(0);
		}
		return text;
	}

	public string PeekLogicCommand()
	{
		if (_logicCmdQueue.Count <= 0)
		{
			return null;
		}
		return _logicCmdQueue.get_Item(0);
	}

	public int ConsumeCommands(string command)
	{
		if (string.IsNullOrEmpty(command))
		{
			return 0;
		}
		int num = 0;
		for (int num2 = _logicCmdQueue.Count - 1; num2 >= 0; num2--)
		{
			if (!(_logicCmdQueue.get_Item(num2) != command))
			{
				_logicCmdQueue.RemoveAt(num2);
				num++;
			}
		}
		return num;
	}

	public void ClearAllCommands()
	{
		_logicCmdQueue.Clear();
	}

	public void Clear()
	{
		_logicTags.Clear();
		ClearAllCommands();
	}
}
