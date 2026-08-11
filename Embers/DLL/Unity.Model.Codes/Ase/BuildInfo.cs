namespace Ase;

public class BuildInfo
{
	public string GameVersion { get; set; }

	public string ResourceVersion { get; set; }

	public string CodeVersion { get; set; }

	public string DataTableVersion { get; set; }

	public string AudioVersion { get; set; }

	public string ParadoxVersion { get; set; }

	public string StoryVersion { get; set; }

	public string ScenesVersion { get; set; }

	public int InternalGameVersion { get; set; }

	public int InternalResourceVersion { get; set; }

	public int InternalCodeVersion { get; set; }

	public int InternalDataTableVersion { get; set; }

	public int InternalParadoxVersion { get; set; }

	public int InternalStoryVersion { get; set; }

	public int InternalScenesVersion { get; set; }

	public string Channel { get; set; }

	public long SubChannel { get; set; }
}
