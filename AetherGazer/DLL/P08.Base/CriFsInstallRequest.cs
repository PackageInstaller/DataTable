public class CriFsInstallRequest : CriFsRequest
{
	public string sourcePath { get; protected set; }

	public string destinationPath { get; protected set; }

	public float progress { get; protected set; }
}
