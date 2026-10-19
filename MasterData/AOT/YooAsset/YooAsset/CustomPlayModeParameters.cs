using System.Collections.Generic;

namespace YooAsset;

public class CustomPlayModeParameters : InitializeParameters
{
	public readonly List<FileSystemParameters> FileSystemParameterList = new List<FileSystemParameters>();
}
