using System;

namespace ACT.Config;

[Serializable]
public class GameStartLoading
{
	public readonly int id;

	public readonly int picture;

	public readonly int title;

	public readonly int content;

	public GameStartLoading(int id, int picture, int title, int content)
	{
		this.id = id;
		this.picture = picture;
		this.title = title;
		this.content = content;
	}
}
