namespace Newtonsoft.Json.Linq;

public class JsonCloneSettings
{
	internal static readonly JsonCloneSettings SkipCopyAnnotations = new JsonCloneSettings
	{
		CopyAnnotations = false
	};

	public bool CopyAnnotations { get; set; }

	public JsonCloneSettings()
	{
		CopyAnnotations = true;
	}
}
