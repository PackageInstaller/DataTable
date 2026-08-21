using System.Collections;
using CriMana;
using UnityEngine;

namespace Packages.P08Main.Scripts.T0World.World;

public class T0WorldCriManaSceneVideoController : MonoBehaviour
{
	public enum PlayTime
	{
		OnStart,
		OnEndOfStartFrame,
		Manual
	}

	public string[] playlist;

	public CriManaMovieMaterial movieMaterial;

	public uint maxDataSize = 300000u;

	public string shaderName = "CriMana/SofdecPrimeYuvScene";

	public string shaderName_android = "CriMana/AndroidSofdecPrimeYuvScene";

	public string shaderName_ios = "CriMana/SofdecPrimeYuvScene";

	public PlayTime playTime;

	public bool playbackLoop;

	public int playbackLoopRangeStart;

	[Min(1f)]
	public int playbackLoopRangeLen = 1;

	public bool ignoreError;

	public int PlaylistMediaCnt
	{
		get
		{
			string[] array = playlist;
			if (array == null)
			{
				return 0;
			}
			return array.Length;
		}
	}

	private void OnValidate()
	{
		if (playbackLoop && PlaylistMediaCnt > 0)
		{
			playbackLoopRangeStart = Mathf.Clamp(playbackLoopRangeStart, 0, playlist.Length - 1);
			playbackLoopRangeLen = Mathf.Clamp(playbackLoopRangeLen, 1, PlaylistMediaCnt - playbackLoopRangeStart);
		}
	}

	private void Start()
	{
		movieMaterial.player.SetShaderDispatchCallback(ShaderDispatchCallback);
		movieMaterial.player.statusChangeCallback = OnMovieStatusChange;
		movieMaterial.player.SetMaxPictureDataSize(maxDataSize);
		PushPlaylistToPlayer();
		if (playTime == PlayTime.OnStart)
		{
			Play();
		}
		else if (playTime == PlayTime.OnEndOfStartFrame)
		{
			StartCoroutine(WaitEndOfFramePlayCouroutine());
		}
	}

	private IEnumerator WaitEndOfFramePlayCouroutine()
	{
		yield return new WaitForEndOfFrame();
		Play();
	}

	public void Play(bool restart = true)
	{
		if ((movieMaterial.player.status == Player.Status.Playing) & restart)
		{
			movieMaterial.player.Stop();
			PushPlaylistToPlayer();
		}
		if (PlaylistMediaCnt > 0)
		{
			movieMaterial.Play();
		}
	}

	private Shader ShaderDispatchCallback(MovieInfo movieInfo, bool additiveMode)
	{
		return Shader.Find(shaderName);
	}

	private void OnMovieStatusChange(Player.Status status)
	{
		if (playbackLoop && (status == Player.Status.PlayEnd || (ignoreError && status == Player.Status.Error)))
		{
			movieMaterial.player.Stop();
			PushPlaylistToPlayer();
			movieMaterial.player.Prepare();
			movieMaterial.player.Start();
		}
	}

	private void PushPlaylistToPlayer()
	{
		PushPlaylistToPlayer(new RangeInt(playbackLoopRangeStart, playbackLoopRangeLen));
	}

	private void PushPlaylistToPlayer(RangeInt range)
	{
		if (PlaylistMediaCnt > 0)
		{
			int num = Mathf.Clamp(range.start, 0, playlist.Length - 1);
			int num2 = Mathf.Clamp(range.end, num + 1, playlist.Length);
			for (int i = num; i < num2; i++)
			{
				string moviePath = playlist[i];
				movieMaterial.player.SetFile(null, moviePath, (i != num) ? Player.SetMode.Append : Player.SetMode.New);
			}
		}
	}
}
