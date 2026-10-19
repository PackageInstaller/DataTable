using System.Collections.Generic;
using Lumin.LoungeSystem.UI;
using UnityEngine;

namespace Lumin.LoungeSystem;

[CreateAssetMenu(fileName = "LoungeConfig", menuName = "Lounge/System Config")]
public class LoungeConfig : ScriptableObject
{
	[Header("系统设置")]
	[Tooltip("自动保存间隔（秒）")]
	public int autoSaveInterval = 300;

	[Header("房间设置")]
	[Tooltip("房间最大容量")]
	public int maxCharactersPerRoom = 5;

	[Tooltip("默认房间舒适度")]
	public int defaultRoomComfort = 50;

	[Header("互动设置")]
	[Tooltip("触摸冷却时间（秒）")]
	public float touchCooldown = 0.5f;

	[Tooltip("对话冷却时间（分钟）")]
	public int dialogueCooldownMinutes = 5;

	[Header("资源路径")]
	public string treasureBoxPrefabPath = "Prefabs/BackHome/Furniture/";

	public string musicBoxPrefabPath = "Prefabs/BackHome/Furniture/";

	[SerializeField]
	private List<MusicBoxData> musics = new List<MusicBoxData>();

	[Header("角色点位偏移配置")]
	[Tooltip("角色在不同点位下的位置/旋转偏移（按 角色ID + 点位ID 查询）")]
	[SerializeField]
	private List<CharacterPointOffsetEntry> characterPointOffsets = new List<CharacterPointOffsetEntry>();

	public List<MusicBoxData> Musics => musics;

	public List<CharacterPointOffsetEntry> CharacterPointOffsets => characterPointOffsets;

	public bool TryGetCharacterPointOffset(int characterId, int pointId, out CharacterPointOffset offset)
	{
		for (int i = 0; i < characterPointOffsets.Count; i++)
		{
			CharacterPointOffsetEntry characterPointOffsetEntry = characterPointOffsets[i];
			if (characterPointOffsetEntry.characterId == characterId && characterPointOffsetEntry.pointId == pointId)
			{
				offset = characterPointOffsetEntry.offset;
				return true;
			}
		}
		offset = CharacterPointOffset.Zero;
		return false;
	}

	public void SetCharacterPointOffset(int characterId, int pointId, CharacterPointOffset offset)
	{
		for (int i = 0; i < characterPointOffsets.Count; i++)
		{
			CharacterPointOffsetEntry characterPointOffsetEntry = characterPointOffsets[i];
			if (characterPointOffsetEntry.characterId == characterId && characterPointOffsetEntry.pointId == pointId)
			{
				characterPointOffsetEntry.offset = offset;
				return;
			}
		}
		characterPointOffsets.Add(new CharacterPointOffsetEntry
		{
			characterId = characterId,
			pointId = pointId,
			offset = offset
		});
	}

	public MusicBoxData GetMusic(int musicId)
	{
		return musics.Find((MusicBoxData g) => g.MusicId == musicId);
	}

	public MusicBoxData GetDefaultMusic()
	{
		if (musics.Count <= 0)
		{
			return null;
		}
		return musics[0];
	}

	public List<MusicBoxData> GetMusicsByName(string name)
	{
		return musics.FindAll((MusicBoxData g) => g.MusicName == name);
	}
}
