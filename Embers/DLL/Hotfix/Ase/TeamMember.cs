#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class TeamMember : ViewModelBase
{
	private string name;

	private int icon;

	private HeroModel heroModel;

	private PeripheryHeroData _peripheryHeroData;

	private int memberId;

	private bool isSelf;

	private bool isAI;

	private bool isRobot;

	public bool LoadSuccess = true;

	public long uid;

	public long guildId;

	public bool isFirst;

	public int heroCardFrame;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public HeroModel HeroModel
	{
		get
		{
			return heroModel;
		}
		private set
		{
			Set(ref heroModel, value, "HeroModel");
		}
	}

	public int MemberId => memberId;

	public bool IsSelf => isSelf;

	public bool IsAI => isAI;

	public long GuildId => guildId;

	public TeamMember(int memberId, bool isCaptain, HeroModel heroModel, bool isSelf = true, bool isAi = false)
	{
		this.memberId = memberId;
		isAI = isAi;
		this.isSelf = isSelf;
		name = heroModel.Name;
		HeroModel = heroModel;
		heroModel.CheckAddGuildBaseBuff();
	}

	private TeamMember()
	{
	}

	public static TeamMember CreateMulti(int memberId, string playerName, int playerIcon, bool isCaptain, HeroModel heroModel, long uid, long guildId, bool isFirst, int serverRobot, bool isSelf = true, bool isAi = false)
	{
		TeamMember obj = new TeamMember
		{
			memberId = memberId,
			heroModel = heroModel,
			uid = uid,
			isSelf = isSelf,
			isAI = isAi,
			name = (isSelf ? Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Name : playerName),
			LoadSuccess = false,
			guildId = guildId,
			isFirst = isFirst
		};
		obj.isRobot = obj.GetIsRobot(serverRobot, memberId);
		return obj;
	}

	public static TeamMember CreateMultiRecord(int memberId, string playerName, int playerIcon, bool isCaptain, HeroModel heroModel, long uid, long guildId, bool isFirst, int serverRobot, bool isSelf = true, bool isAi = false, bool isRobot = false)
	{
		return new TeamMember
		{
			memberId = memberId,
			heroModel = heroModel,
			uid = uid,
			isSelf = isSelf,
			isAI = isAi,
			name = playerName,
			icon = playerIcon,
			LoadSuccess = false,
			guildId = guildId,
			isFirst = isFirst,
			isRobot = isRobot
		};
	}

	public PeripheryHeroData GetPeripheryHeroData()
	{
		if (heroModel != null)
		{
			_peripheryHeroData = heroModel.GetPeripheryHeroData(uid, memberId, name);
		}
		_peripheryHeroData.isRobot = isRobot;
		return _peripheryHeroData;
	}

	public bool GetIsRobot(int serverData, int index)
	{
		if (index < 0)
		{
			Log.Error($"索引不能为负数: {index}");
			return false;
		}
		if (index >= 32)
		{
			Log.Error($"索引 {index} 超出32位整数范围");
			return false;
		}
		return ((serverData >> index - 1) & 1) == 1;
	}
}
