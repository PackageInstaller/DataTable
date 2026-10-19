using ACT.Config;

namespace ACT.Utility;

public class LocalizeStringData
{
	private LocalizeTable _table;

	private int _id;

	public LocalizeTable Table => _table;

	public int Id => _id;

	public LocalizeStringData(LocalizeTable table, int id)
	{
		_table = table;
		_id = id;
	}

	public LocalizeStringData(LocalizeStringConfig config)
	{
		_table = config.table;
		_id = config.id;
	}

	public bool IsValid()
	{
		if (_table != LocalizeTable.None)
		{
			return _id != 0;
		}
		return false;
	}
}
