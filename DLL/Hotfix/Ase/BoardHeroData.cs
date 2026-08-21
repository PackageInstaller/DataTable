using Cysharp.Text;

namespace Ase;

public class BoardHeroData
{
	public static int BgDefaultModeId;

	public int BoardHeroId { get; private set; }

	public int BackgroundId { get; private set; }

	public int InnerBackgroundId { get; private set; }

	public static string GetSpineAssetPath(string rawPath)
	{
		AudioLanguageEnum audioLanguage = Singleton<AudioSystem>.Instance.AudioLanguage;
		if (audioLanguage != AudioLanguageEnum.defaultLanguage)
		{
			return ZString.Format("{0}_{1}", rawPath, audioLanguage.ToString());
		}
		return rawPath;
	}

	public BoardHeroData(int boardHeroId, int backgroundId)
	{
		BoardHeroId = boardHeroId;
		BackgroundId = backgroundId;
	}

	public void ChangeHero(int id)
	{
		BoardHeroId = id;
	}

	public void ChangeBg(int backgroundId)
	{
		BackgroundId = backgroundId;
	}

	public void Change(int id, int backgroundId)
	{
		BoardHeroId = id;
		BackgroundId = backgroundId;
	}
}
