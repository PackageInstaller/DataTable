using System;
using ACT.Game.Data;

namespace ACT.Game;

[Serializable]
public class LocalAssist
{
	[Serializable]
	public class LocalAssistSkin
	{
		public int id;

		public int[] colors;

		public int equipColor;

		public AssistSkin ToPB()
		{
			AssistSkin assistSkin = new AssistSkin();
			assistSkin.Id = id;
			if (colors != null)
			{
				for (int i = 0; i < colors.Length; i++)
				{
					assistSkin.Colors[colors[i]] = true;
				}
			}
			assistSkin.Color = equipColor;
			return assistSkin;
		}
	}

	public int id;

	public LocalAssistSkin[] skins;

	public int equipSkin;

	public Assist ToPB()
	{
		Assist assist = new Assist();
		assist.Id = id;
		if (skins != null)
		{
			for (int i = 0; i < skins.Length; i++)
			{
				AssistSkin assistSkin = skins[i].ToPB();
				assist.Skins.Add(assistSkin.Id, assistSkin);
			}
		}
		assist.Skin = equipSkin;
		return assist;
	}
}
