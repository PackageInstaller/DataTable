namespace Ase;

public class GamePlayTipsViewModel : OptionBase
{
	private string title;

	private string content;

	public string Title => title;

	public string Content => content;

	public GamePlayTipsViewModel(OptionBase parent, string title, string content)
	{
		base.parent = parent;
		this.title = title;
		this.content = content.Replace("\\n", "\n");
	}

	public GamePlayTipsViewModel(OptionBase parent, int id, string title = "")
	{
		base.parent = parent;
		this.title = (title.Equals("") ? "玩法说明" : title);
		DRGameExplain dataRow = GameEntry.DataTable.GetDataRow<DRGameExplain>(id);
		if (dataRow == null)
		{
			content = "";
			Toast.ShowInfo($"游戏说明ID:{id}不存在");
		}
		else
		{
			content = dataRow.Content.Replace("\\n", "\n");
		}
	}
}
