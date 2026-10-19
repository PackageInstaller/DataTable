using System;

namespace ACT.Config;

[Serializable]
public class Msgcode
{
	public readonly int id;

	public readonly int codeType;

	public readonly int codeModule;

	public readonly int subCode;

	public readonly string code = "";

	public readonly int text;

	public readonly int rank;

	public readonly bool trackingUpload;

	public readonly int popupType;

	public readonly int region0;

	public readonly int time;

	public readonly int onTop;

	public Msgcode(int id, int codeType, int codeModule, int subCode, string code, int text, int rank, bool trackingUpload, int popupType, int region0, int time, int onTop)
	{
		this.id = id;
		this.codeType = codeType;
		this.codeModule = codeModule;
		this.subCode = subCode;
		this.code = code;
		this.text = text;
		this.rank = rank;
		this.trackingUpload = trackingUpload;
		this.popupType = popupType;
		this.region0 = region0;
		this.time = time;
		this.onTop = onTop;
	}
}
