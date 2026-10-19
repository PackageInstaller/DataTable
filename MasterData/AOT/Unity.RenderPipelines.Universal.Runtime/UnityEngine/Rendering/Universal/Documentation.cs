namespace UnityEngine.Rendering.Universal;

internal class Documentation : DocumentationInfo
{
	public const string packageName = "com.unity.render-pipelines.universal";

	public static string GetPageLink(string pageName)
	{
		return DocumentationInfo.GetPageLink("com.unity.render-pipelines.universal", pageName);
	}
}
