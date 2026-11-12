using System.Collections.Generic;

public class LogicUserDataVariable<T>
{
	public struct LogicUserDataTag
	{
		public T userData;
	}

	public readonly Dictionary<string, LogicUserDataTag> _logicUserTags = new Dictionary<string, LogicUserDataTag>();

	public void SetLogicTagUserData(string tag, T value)
	{
		_logicUserTags.set_Item(tag, new LogicUserDataTag
		{
			userData = value
		});
	}

	public T GetLogicTagUserData(string tag)
	{
		if (_logicUserTags.TryGetValue(tag, out var value))
		{
			return value.userData;
		}
		return default;
	}

	public void RemoveLogicTag(string tag)
	{
		if (_logicUserTags.ContainsKey(tag))
		{
			_logicUserTags.Remove(tag);
		}
	}
}
