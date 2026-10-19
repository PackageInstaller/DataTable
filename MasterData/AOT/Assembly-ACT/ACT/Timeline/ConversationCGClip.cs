using System;
using System.Threading;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public sealed class ConversationCGClip : PlayableAsset
{
	private const string CgAssetFolder = "Conversation/";

	[Tooltip("dialogueBackgroundDatas 的 D 列 ID，不能为空")]
	public int cgId;

	[Min(0f)]
	public float fadeInTime = 0.5f;

	[Min(0f)]
	public float fadeOutTime = 0.5f;

	[NonSerialized]
	private ConversationCGBehaviour m_Behaviour;

	[NonSerialized]
	private AssetStation m_PreloadStation;

	[NonSerialized]
	private AssetLoadHandle m_PreloadHandle;

	[NonSerialized]
	private Sprite m_PreloadedSprite;

	[NonSerialized]
	private bool m_Preloading;

	[NonSerialized]
	private int m_PreloadVersion;

	public Sprite PreloadedSprite => m_PreloadedSprite;

	private void OnValidate()
	{
		if (cgId == 0)
		{
			Debug.LogError("ConversationCGClip 的 CG ID 不能为空，请填写 dialogueBackgroundDatas 的 D 列 ID。", this);
		}
		fadeInTime = Mathf.Max(0f, fadeInTime);
		fadeOutTime = Mathf.Max(0f, fadeOutTime);
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		if (m_Behaviour == null)
		{
			m_Behaviour = new ConversationCGBehaviour();
		}
		m_Behaviour.clip = this;
		return ScriptPlayable<ConversationCGBehaviour>.Create(graph, m_Behaviour);
	}

	public async UniTask PreloadAsync(CancellationToken token)
	{
		if (m_Preloading || (bool)m_PreloadedSprite || cgId <= 0 || token.IsCancellationRequested || !TryGetAssetPath(out var path))
		{
			return;
		}
		AssetStation station = AssetStationManager.BattleStation;
		if (station == null)
		{
			return;
		}
		m_Preloading = true;
		int version = m_PreloadVersion;
		AssetLoadHandle handle = default;
		try
		{
			handle = station.LoadAsync<Texture2D>("Conversation/" + path);
			await handle;
			if (version != m_PreloadVersion || token.IsCancellationRequested)
			{
				ReleaseHandle(station, handle);
				return;
			}
			if (!handle.IsValid)
			{
				Debug.LogError($"预加载 CG 图片失败，加载句柄无效，ID: {cgId}, Path: {path}", this);
				return;
			}
			Texture2D texture2D = handle.As<Texture2D>();
			if (!texture2D)
			{
				Debug.LogError($"CG 图片资源加载结果为空，ID: {cgId}, Path: {path}", this);
				ReleaseHandle(station, handle);
			}
			else
			{
				m_PreloadStation = station;
				m_PreloadHandle = handle;
				m_PreloadedSprite = CreateSprite(texture2D);
			}
		}
		catch (Exception exception)
		{
			Debug.LogError($"预加载 CG 图片失败，ID: {cgId}, Path: {path}", this);
			Debug.LogException(exception, this);
			ReleaseHandle(station, handle);
		}
		finally
		{
			m_Preloading = false;
		}
	}

	public void ReleasePreloaded()
	{
		m_PreloadVersion++;
		if (m_PreloadHandle.IsValid)
		{
			m_PreloadStation?.Release(m_PreloadHandle);
		}
		m_PreloadHandle = default;
		m_PreloadStation = null;
		if ((bool)m_PreloadedSprite)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(m_PreloadedSprite);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(m_PreloadedSprite);
			}
		}
		m_PreloadedSprite = null;
	}

	private static void ReleaseHandle(AssetStation station, AssetLoadHandle handle)
	{
		if (handle.IsValid)
		{
			station.Release(handle);
		}
	}

	private bool TryGetAssetPath(out string path)
	{
		path = null;
		if (RuntimeConfigs.data != null && RuntimeConfigs.data.dialogueBackgroundDatas.TryGetValue(cgId, out var value) && value != null && !string.IsNullOrEmpty(value.path))
		{
			path = value.path;
			return true;
		}
		Debug.LogError($"CG 图片 ID {cgId} 在 dialogueBackgroundDatas 中不存在或路径为空，请检查 D 列 ID。", this);
		return false;
	}

	private static Sprite CreateSprite(Texture2D texture)
	{
		return Sprite.Create(texture, new Rect(0f, 0f, texture.width, texture.height), new Vector2(0.5f, 0.5f), 100f);
	}
}
