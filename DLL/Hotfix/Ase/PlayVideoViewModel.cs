using UnityEngine;

namespace Ase;

public class PlayVideoViewModel : OptionBase
{
	private string url;

	public string Url
	{
		get
		{
			return url;
		}
		private set
		{
			Set(ref url, value, "Url");
		}
	}

	public PlayVideoViewModel()
	{
	}

	public PlayVideoViewModel(string path)
	{
		SetUrl(path);
	}

	public void SetUrl(string path)
	{
		Url = Application.streamingAssetsPath + "/" + ("video/" + path + ".mp4").Replace("\\", "/");
	}
}
