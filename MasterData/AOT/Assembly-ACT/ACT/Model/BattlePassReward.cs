using System.Collections.Generic;

namespace ACT.Model;

public class BattlePassReward
{
	public int Level { get; set; }

	public BattlePassRewardType RewardType { get; set; }

	public BattlePassRewardStatus Status { get; set; }

	public List<(int itemId, int count)> RewardItems { get; set; } = new List<(int, int)>();

	public bool CanClaim => Status == BattlePassRewardStatus.CanClaim;

	public bool IsClaimed => Status == BattlePassRewardStatus.Claimed;

	public bool IsLocked => Status == BattlePassRewardStatus.Locked;
}
