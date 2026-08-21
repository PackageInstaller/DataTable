using System;
using GameFramework.Runtime;

namespace Ase;

public class AnnouncementData : ViewModelBase
{
	private long id;

	private int type;

	private int priority;

	private string picture;

	private DateTime startTime;

	private long lastTime;

	private string title;

	private string content;

	private bool isRead;

	public long Id
	{
		get
		{
			return id;
		}
		set
		{
			Set(ref id, value, "Id");
		}
	}

	public int Type
	{
		get
		{
			return type;
		}
		set
		{
			Set(ref type, value, "Type");
		}
	}

	public int Priority
	{
		get
		{
			return priority;
		}
		set
		{
			Set(ref priority, value, "Priority");
		}
	}

	public string Picture
	{
		get
		{
			return picture;
		}
		set
		{
			Set(ref picture, value, "Picture");
		}
	}

	public DateTime StartTime
	{
		get
		{
			return startTime;
		}
		set
		{
			Set(ref startTime, value, "StartTime");
		}
	}

	public long LastTime
	{
		get
		{
			return lastTime;
		}
		set
		{
			Set(ref lastTime, value, "LastTime");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

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

	public bool IsRead
	{
		get
		{
			return isRead;
		}
		set
		{
			Set(ref isRead, value, "IsRead");
		}
	}

	public static AnnouncementData Create(NoticeInfo noticeInfo, bool isRead = false)
	{
		AnnouncementData announcementData = new AnnouncementData
		{
			id = noticeInfo.id,
			type = noticeInfo.type,
			priority = noticeInfo.priority,
			picture = noticeInfo.picture,
			lastTime = noticeInfo.lastTime,
			title = noticeInfo.title,
			content = noticeInfo.content,
			isRead = isRead
		};
		if (!string.IsNullOrEmpty(noticeInfo.startTime))
		{
			DateTime.TryParse(noticeInfo.startTime, out announcementData.startTime);
		}
		return announcementData;
	}

	public static AnnouncementData Create(PbNotice pbNotice, bool isRead = false)
	{
		AnnouncementData announcementData = new AnnouncementData
		{
			id = pbNotice.Id,
			type = pbNotice.Type,
			priority = pbNotice.Priority,
			picture = pbNotice.Picture,
			lastTime = pbNotice.LastTime,
			title = pbNotice.Title,
			content = pbNotice.Content,
			isRead = isRead
		};
		if (!string.IsNullOrEmpty(pbNotice.StartTime))
		{
			DateTime.TryParse(pbNotice.StartTime, out announcementData.startTime);
		}
		return announcementData;
	}
}
