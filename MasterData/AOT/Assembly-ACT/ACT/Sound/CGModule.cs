using System.Collections.Generic;
using ACT.Config;
using ACT.Model;
using Fundamental;

namespace ACT.Sound;

public class CGModule : Model<CGModule>
{
	private readonly Dictionary<int, DialogueCG> _activeTexts = new Dictionary<int, DialogueCG>();

	private readonly List<int> _removeKeys = new List<int>();

	public override ContextType ContextType => ContextType.GAME;

	public IReadOnlyDictionary<int, DialogueCG> ActiveTexts => _activeTexts;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		_activeTexts.Clear();
	}

	public List<int> Set(int id, DialogueCG data)
	{
		if (data == null)
		{
			return null;
		}
		_removeKeys.Clear();
		foreach (KeyValuePair<int, DialogueCG> activeText in _activeTexts)
		{
			if (activeText.Value.type == data.type && activeText.Key != id)
			{
				_removeKeys.Add(activeText.Key);
			}
		}
		for (int i = 0; i < _removeKeys.Count; i++)
		{
			_activeTexts.Remove(_removeKeys[i]);
		}
		_activeTexts[id] = data;
		return _removeKeys;
	}

	public void Remove(int id)
	{
		_activeTexts.Remove(id);
	}

	public void Clear()
	{
		_activeTexts.Clear();
	}
}
