using System;

namespace ACT.Config;

[Serializable]
public class EscSystem
{
	public readonly int id;

	public readonly int localNameId;

	public readonly int icon;

	public readonly int openType;

	public readonly string path = "";

	public readonly int rank;

	public readonly int Theme;

	public EscSystem(int id, int localNameId, int icon, int openType, string path, int rank, int Theme)
	{
		this.id = id;
		this.localNameId = localNameId;
		this.icon = icon;
		this.openType = openType;
		this.path = path;
		this.rank = rank;
		this.Theme = Theme;
	}
}
