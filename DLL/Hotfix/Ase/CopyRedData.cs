using System;

namespace Ase;

[Serializable]
public class CopyRedData
{
	public int copyId;

	public int copyTypeId;

	public int copyMainId;

	public bool isRed;

	public void SetRed(bool isRed)
	{
		this.isRed = isRed;
	}
}
