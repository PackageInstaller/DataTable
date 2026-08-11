namespace UnityEngine.Rendering;

public class DocumentationInfo
{
	private const string fallbackVersion = "12.1";

	private const string url = "https://docs.unity3d.com/Packages/{0}@{1}/manual/{2}.html";

	public static string version => "12.1";

	public static string GetPageLink(string packageName, string pageName)
	{
		return $"https://docs.unity3d.com/Packages/{packageName}@{version}/manual/{pageName}.html";
	}
}
