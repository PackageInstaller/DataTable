#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Text.RegularExpressions;
using GameFramework;

namespace Ase;

public static class ChatHelper
{
	public static string ChangeEmoji2String(int emojiId)
	{
		if (emojiId <= 0)
		{
			return "";
		}
		DREmoticon dataRow = GameEntry.DataTable.GetDataRow((DREmoticon p) => p.Id == emojiId);
		if (dataRow != null)
		{
			return dataRow.Unicode ?? "";
		}
		return "/表情";
	}

	public static (int, string) ChangeString2Emoji(string content)
	{
		try
		{
			if (new Regex("^/[a-zA-Z]{4}$").IsMatch(content))
			{
				DREmoticon dataRow = GameEntry.DataTable.GetDataRow((DREmoticon p) => p.Unicode.Equals(content));
				if (dataRow != null)
				{
					return (dataRow.Id, dataRow.Resource);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("解析聊天消息发生异常 " + content + " " + ex.Message + " / " + ex.StackTrace);
		}
		return (0, null);
	}
}
