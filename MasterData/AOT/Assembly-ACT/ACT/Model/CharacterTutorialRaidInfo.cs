using System.Collections.Generic;
using ACT.Config;
using ACT.Utility;

namespace ACT.Model;

public class CharacterTutorialRaidInfo
{
	private int _raidEnterId;

	private int _raidId;

	private int _characterId;

	private LocalizeStringData _raidNameLocalizedStringData;

	private GroupImageData _raidImageData;

	private List<ItemKv> reward;

	public int RaidEnterId => _raidEnterId;

	public int RaidId => _raidId;

	public int CharacterId => _characterId;

	public LocalizeStringData RaidNameLocalizedStringData => _raidNameLocalizedStringData;

	public GroupImageData RaidImageData => _raidImageData;

	public List<ItemKv> Reward => reward;

	public CharacterTutorialRaidInfo(RaidEntranceData raidEntranceData)
	{
		_raidEnterId = raidEntranceData.id;
		int[] raidId = raidEntranceData.raidId;
		if (raidId != null && raidId.Length > 0)
		{
			_raidId = raidEntranceData.raidId[0];
			_characterId = raidEntranceData.raidIconAddress;
		}
		_raidNameLocalizedStringData = new LocalizeStringData(LocalizeTable.ShortCommon, raidEntranceData.entranceName);
		_raidImageData = new GroupImageData(126, raidEntranceData.raidIconAddress);
		reward = new List<ItemKv>();
		if (raidEntranceData.GetType().GetField("rewardItemShow")?.GetValue(raidEntranceData) is List<ItemKv> collection)
		{
			reward.AddRange(collection);
		}
	}
}
