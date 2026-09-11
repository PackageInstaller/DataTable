using System;

[Serializable]
public struct KeyToTranslateFileIdData
{
	public ulong hash1;

	public ulong hash2;

	public string translateFileName;

	public int translateIndex;
}
