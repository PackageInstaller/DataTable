using System;
using System.Collections.Generic;

namespace ACT.UI.AOT;

public static class ContentSegmentUtilities
{
	public static List<AnnouncementTextSegment> ParseText(string text)
	{
		List<AnnouncementTextSegment> list = new List<AnnouncementTextSegment>();
		if (string.IsNullOrEmpty(text))
		{
			return list;
		}
		int num = 0;
		int length = text.Length;
		while (num < length)
		{
			int num2 = text.IndexOf("[img src=", num, StringComparison.Ordinal);
			if (num2 == -1)
			{
				string text2 = text.Substring(num);
				if (!string.IsNullOrWhiteSpace(text2))
				{
					list.Add(new AnnouncementTextSegment
					{
						IsImage = false,
						Text = text2.Trim(),
						Url = null,
						Width = 0,
						Height = 0
					});
				}
				break;
			}
			if (num2 > num)
			{
				string text3 = text.Substring(num, num2 - num);
				if (!string.IsNullOrWhiteSpace(text3))
				{
					list.Add(new AnnouncementTextSegment
					{
						IsImage = false,
						Text = text3.Trim(),
						Url = null,
						Width = 0,
						Height = 0
					});
				}
			}
			int num3 = text.IndexOf(']', num2);
			if (num3 == -1)
			{
				string text4 = text.Substring(num2);
				if (!string.IsNullOrWhiteSpace(text4))
				{
					list.Add(new AnnouncementTextSegment
					{
						IsImage = false,
						Text = text4.Trim(),
						Url = null,
						Width = 0,
						Height = 0
					});
				}
				break;
			}
			AnnouncementTextSegment announcementTextSegment = ParseImageTag(text.Substring(num2, num3 - num2 + 1));
			if (announcementTextSegment != null)
			{
				list.Add(announcementTextSegment);
			}
			num = num3 + 1;
		}
		return list;
	}

	public static AnnouncementTextSegment ParseImageTag(string imgTag)
	{
		try
		{
			string[] array = imgTag.Substring(1, imgTag.Length - 2).Split(' ', StringSplitOptions.RemoveEmptyEntries);
			if (array.Length < 4)
			{
				return null;
			}
			string text = null;
			int num = 0;
			int num2 = 0;
			string[] array2 = array;
			foreach (string text2 in array2)
			{
				int result2;
				if (text2.StartsWith("src="))
				{
					text = text2.Substring(4);
				}
				else if (text2.StartsWith("width="))
				{
					if (int.TryParse(text2.Substring(6), out var result))
					{
						num = result;
					}
				}
				else if (text2.StartsWith("height=") && int.TryParse(text2.Substring(7), out result2))
				{
					num2 = result2;
				}
			}
			if (text != null && num > 0 && num2 > 0)
			{
				return new AnnouncementTextSegment
				{
					IsImage = true,
					Text = null,
					Url = text,
					Width = num,
					Height = num2
				};
			}
		}
		catch
		{
		}
		return null;
	}
}
