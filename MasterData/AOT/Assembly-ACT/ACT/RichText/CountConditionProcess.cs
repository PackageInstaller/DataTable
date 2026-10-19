using System;
using ACT.Utility;

namespace ACT.RichText;

public class CountConditionProcess
{
	public static (string, string) CumulativeOnlineDurationProcess(int preConditionId, int progress, int number)
	{
		if (preConditionId != 18)
		{
			return (string.Empty, string.Empty);
		}
		TimeSpan timeSpan = TimeSpan.FromSeconds(progress);
		int num = timeSpan.Hours + timeSpan.Days * 24;
		int minutes = timeSpan.Minutes;
		int seconds = timeSpan.Seconds;
		string text = string.Empty;
		TimeSpan timeSpan2 = TimeSpan.FromSeconds(number);
		int num2 = timeSpan2.Hours + timeSpan2.Days * 24;
		int minutes2 = timeSpan2.Minutes;
		int seconds2 = timeSpan2.Seconds;
		string text2 = string.Empty;
		if (num > 0 && minutes > 0)
		{
			text += string.Format("{0}{1}", num, LocalizationUtility.GetLocalizeString("Common", 41000109));
			text += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
		}
		else if (num > 0 && minutes == 0)
		{
			text += string.Format("{0}{1}", num, LocalizationUtility.GetLocalizeString("Common", 41000109));
		}
		else if (num == 0 && minutes > 0 && seconds > 0)
		{
			text += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
			text += string.Format("{0}{1}", seconds, LocalizationUtility.GetLocalizeString("Common", 624));
		}
		else if (num == 0 && minutes > 0 && seconds == 0)
		{
			text += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
		}
		else if (num == 0 && minutes == 0 && seconds > 0)
		{
			text += string.Format("{0}{1}", seconds, LocalizationUtility.GetLocalizeString("Common", 624));
		}
		if (num2 > 0 && minutes2 > 0)
		{
			text2 += string.Format("{0}{1}", num2, LocalizationUtility.GetLocalizeString("Common", 41000109));
			text2 += string.Format("{0}{1}", minutes2, LocalizationUtility.GetLocalizeString("Common", 41000110));
		}
		else if (num2 > 0 && minutes2 == 0)
		{
			text2 += string.Format("{0}{1}", num2, LocalizationUtility.GetLocalizeString("Common", 41000109));
		}
		else if (num2 == 0 && minutes2 > 0 && seconds2 > 0)
		{
			text2 += string.Format("{0}{1}", minutes2, LocalizationUtility.GetLocalizeString("Common", 41000110));
			text2 += string.Format("{0}{1}", seconds2, LocalizationUtility.GetLocalizeString("Common", 624));
		}
		else if (num2 == 0 && minutes2 > 0 && seconds2 == 0)
		{
			text2 += string.Format("{0}{1}", minutes2, LocalizationUtility.GetLocalizeString("Common", 41000110));
		}
		else if (num2 == 0 && minutes2 == 0 && seconds2 > 0)
		{
			text2 += string.Format("{0}{1}", seconds2, LocalizationUtility.GetLocalizeString("Common", 624));
		}
		return (text, text2);
	}
}
