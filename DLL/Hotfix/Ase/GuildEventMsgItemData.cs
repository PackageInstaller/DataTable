using System;

namespace Ase;

public class GuildEventMsgItemData : OptionBase
{
	private string content;

	private string ymdText;

	private string hmsText;

	public string Content
	{
		get
		{
			return content;
		}
		set
		{
			Set(ref content, value, "Content");
		}
	}

	public string YmdText
	{
		get
		{
			return ymdText;
		}
		set
		{
			Set(ref ymdText, value, "YmdText");
		}
	}

	public string HmsText
	{
		get
		{
			return hmsText;
		}
		set
		{
			Set(ref hmsText, value, "HmsText");
		}
	}

	public GuildEventMsgItemData()
	{
	}

	public GuildEventMsgItemData(OptionBase parent, GuildEventMsgData data)
	{
		base.parent = parent;
		DRGuildEvent dataRow = GameEntry.DataTable.GetDataRow<DRGuildEvent>(data.Type);
		if (dataRow == null)
		{
			return;
		}
		object[] array = data.Params.Format();
		int result2;
		if (data.Type == 9 && array.Length >= 2)
		{
			if (array[1] != null && int.TryParse(array[1].ToString(), out var result) && Enum.IsDefined(typeof(GuildDefinition.GuildPositions), result))
			{
				GuildDefinition.GuildPositions guildPositions = (GuildDefinition.GuildPositions)result;
				array[1] = guildPositions.GetDescription();
			}
		}
		else if (data.Type == 6 && array.Length >= 1 && array[0] != null && int.TryParse(array[0].ToString(), out result2) && Enum.IsDefined(typeof(GuildDefinition.Flag), result2))
		{
			GuildDefinition.Flag flag = (GuildDefinition.Flag)result2;
			array[0] = flag.GetDescription();
		}
		Content = string.Format(dataRow.EventTxt, array);
		YmdText = data.Time.ToString("yyyy.MM.dd");
		HmsText = data.Time.ToString("HH:mm:ss");
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
