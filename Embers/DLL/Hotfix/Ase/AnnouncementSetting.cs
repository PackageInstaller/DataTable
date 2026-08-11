namespace Ase;

public class AnnouncementSetting
{
	public string Title { get; set; }

	public string Version { get; set; }

	public string Date { get; set; }

	public string Content { get; set; }

	public bool Validate()
	{
		if (!string.IsNullOrEmpty(Title))
		{
			return !string.IsNullOrEmpty(Content);
		}
		return false;
	}
}
