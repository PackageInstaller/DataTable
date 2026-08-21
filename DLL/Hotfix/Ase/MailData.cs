using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MailData : ViewModelBase
{
	private long mailId;

	private long validTime;

	public bool hasLocaled;

	private bool isNew;

	private DateTime sendTime;

	private DateTime expTime;

	private MailTypeEnum mailType = MailTypeEnum.Mail_Read;

	private string mailTitle;

	private string mailContent;

	private string sendTimeDate;

	private string leftTime;

	private List<PropDataBase> attachmentList;

	public long MailId
	{
		get
		{
			return mailId;
		}
		private set
		{
			Set(ref mailId, value, "MailId");
		}
	}

	public DateTime SendTime
	{
		get
		{
			return sendTime;
		}
		private set
		{
			Set(ref sendTime, value, "SendTime");
		}
	}

	public DateTime ExpTime
	{
		get
		{
			return expTime;
		}
		private set
		{
			Set(ref expTime, value, "ExpTime");
		}
	}

	public MailTypeEnum MailType
	{
		get
		{
			return mailType;
		}
		private set
		{
			Set(ref mailType, value, "MailType");
		}
	}

	public string MailTitle
	{
		get
		{
			return mailTitle;
		}
		private set
		{
			Set(ref mailTitle, value, "MailTitle");
		}
	}

	public string MailContent
	{
		get
		{
			return mailContent;
		}
		private set
		{
			Set(ref mailContent, value, "MailContent");
		}
	}

	public string SendTimeDate
	{
		get
		{
			return sendTimeDate;
		}
		private set
		{
			Set(ref sendTimeDate, value, "SendTimeDate");
		}
	}

	public string LeftTime
	{
		get
		{
			return leftTime;
		}
		private set
		{
			Set(ref leftTime, value, "LeftTime");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		private set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public long ValidTime => validTime;

	public List<PropDataBase> AttachmentList => attachmentList;

	public static MailData Create(PbMailData pbMailData)
	{
		MailData mailData = new MailData();
		if (pbMailData.IsDelete == 1)
		{
			return null;
		}
		mailData.mailId = pbMailData.Lid;
		mailData.mailContent = pbMailData.Content.Replace("\\n", "\n");
		mailData.mailTitle = pbMailData.Title;
		mailData.sendTime = StampToDateTime(pbMailData.SendTime.ToString());
		mailData.expTime = StampToDateTime(pbMailData.ValidTime.ToString());
		mailData.attachmentList = GetAttachment(pbMailData.Attachment);
		mailData.validTime = pbMailData.ValidTime;
		mailData.sendTimeDate = GetDate(mailData.sendTime);
		mailData.leftTime = GetLeftTime(mailData.validTime);
		if (mailData.attachmentList != null)
		{
			if (pbMailData.IsReceive == 1)
			{
				mailData.mailType = MailTypeEnum.Mail_Attachment_Read;
			}
			else
			{
				mailData.mailType = MailTypeEnum.Mail_Attachment;
			}
		}
		else if (pbMailData.IsRead == 1)
		{
			mailData.mailType = MailTypeEnum.Mail_Read;
		}
		else
		{
			mailData.mailType = MailTypeEnum.Mail_Unread;
		}
		return mailData;
	}

	public static DateTime StampToDateTime(string timeStamp)
	{
		DateTime dateTime = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
		long ticks = long.Parse(timeStamp + "0000000");
		TimeSpan value = new TimeSpan(ticks);
		return dateTime.Add(value);
	}

	public static string GetLeftTime(long validTime)
	{
		long num = validTime - (long)(DateTime.Now - TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1))).TotalSeconds;
		if (num <= 0)
		{
			return "0天0小时";
		}
		long num2 = num / 60 / 60;
		long num3 = num2 / 24;
		long num4 = num2 % 24;
		return $"{num3}天{num4}小时";
	}

	public static string GetDate(DateTime dateTime)
	{
		return dateTime.ToString("yyyy.MM.dd");
	}

	public static List<PropDataBase> GetAttachment(string attachment)
	{
		if (string.IsNullOrEmpty(attachment))
		{
			return null;
		}
		List<PropDataBase> list = new List<PropDataBase>();
		attachment = attachment.Replace("\"", "");
		attachment = attachment.Replace(" ", "");
		attachment = attachment.Trim('[', ']');
		string[] array = attachment.Split(',');
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split(':');
			if (array2.Length >= 3 && int.TryParse(array2[0], out var result) && int.TryParse(array2[1], out var result2) && int.TryParse(array2[2], out var result3))
			{
				list.Add(PropDataBase.CreateByType(result, result2, result3));
			}
		}
		return list;
	}

	public static MailData CreateEmpty()
	{
		return new MailData
		{
			mailId = 0L,
			MailType = MailTypeEnum.Mail_Read,
			mailContent = "",
			mailTitle = "",
			sendTime = DateTime.Now,
			expTime = DateTime.Now
		};
	}

	public bool OnSelected()
	{
		SetNew(isNew: false);
		if (mailType == MailTypeEnum.Mail_Unread)
		{
			MailType = MailTypeEnum.Mail_Read;
			return true;
		}
		return false;
	}

	public bool OnGetAttachment()
	{
		SetNew(isNew: false);
		if (mailType == MailTypeEnum.Mail_Attachment)
		{
			MailType = MailTypeEnum.Mail_Attachment_Read;
			return true;
		}
		return false;
	}

	public void SetAttachmentGotState()
	{
		MailType = MailTypeEnum.Mail_Attachment_Read;
	}

	public void SetNew(bool isNew)
	{
		IsNew = isNew;
	}
}
