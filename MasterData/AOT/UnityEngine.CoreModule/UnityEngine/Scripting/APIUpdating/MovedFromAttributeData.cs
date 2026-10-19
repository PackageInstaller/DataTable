namespace UnityEngine.Scripting.APIUpdating;

internal struct MovedFromAttributeData
{
	public string className;

	public string nameSpace;

	public string assembly;

	public bool classHasChanged;

	public bool nameSpaceHasChanged;

	public bool assemblyHasChanged;

	public bool autoUdpateAPI;

	public void Set(bool autoUpdateAPI, string sourceNamespace = null, string sourceAssembly = null, string sourceClassName = null)
	{
		className = sourceClassName;
		classHasChanged = className != null;
		nameSpace = sourceNamespace;
		nameSpaceHasChanged = nameSpace != null;
		assembly = sourceAssembly;
		assemblyHasChanged = assembly != null;
		autoUdpateAPI = autoUpdateAPI;
	}
}
