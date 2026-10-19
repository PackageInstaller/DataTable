using System;
using UnityEngine;

namespace Lumin.LoungeSystem;

[Serializable]
public class MusicBoxData
{
	[SerializeField]
	private int musicId;

	[SerializeField]
	private string musicPath;

	[SerializeField]
	private string musicName;

	public int MusicId => musicId;

	public string MusicPath => musicPath;

	public string MusicName => musicName;

	public MusicBoxData(int id, string path, string name)
	{
		musicId = id;
		musicPath = path;
		musicName = name;
	}

	public MusicBoxData(string path, string name)
	{
		musicPath = path;
		musicName = name;
	}

	public MusicBoxData(string path)
	{
		musicPath = path;
	}
}
