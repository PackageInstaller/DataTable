using System.Collections.Generic;

namespace Ase;

public class UserInfoViewModel : OptionBase
{
	private string avatar;

	private string border;

	private string userName;

	private long userUid;

	private int curLevel;

	private string guildName;

	private string userDesc;

	private int userCurExp;

	private int maxExp;

	private string userExp;

	private float userExpFillAmount;

	private int normalLevelAchieved;

	private int difficltLevelAchieved;

	private int bestLevel;

	private string createDate;

	private int bestRank;

	private int curRank;

	private List<int> expList = new List<int>();

	private List<ProfileImgData> profileImgList;

	private List<ProfileImgData> profileBorderList;

	private string previewName;

	private string previewImg;

	private string previewBorder;

	private string previewDesc;

	private bool isOwned;

	private RoleViewModel roleViewModel;

	private int changeType;

	public string Avatar
	{
		get
		{
			return avatar;
		}
		set
		{
			avatar = value;
		}
	}

	public string Border
	{
		get
		{
			return border;
		}
		set
		{
			border = value;
		}
	}

	public string UserName
	{
		get
		{
			return userName;
		}
		set
		{
			Set(ref userName, value, "UserName");
		}
	}

	public long UserUid
	{
		get
		{
			return userUid;
		}
		set
		{
			userUid = value;
		}
	}

	public int CurLevel
	{
		get
		{
			return curLevel;
		}
		set
		{
			Set(ref curLevel, value, "CurLevel");
		}
	}

	public string GuildName
	{
		get
		{
			return guildName;
		}
		set
		{
			Set(ref guildName, value, "GuildName");
		}
	}

	public string UserDesc
	{
		get
		{
			return userDesc;
		}
		set
		{
			Set(ref userDesc, value, "UserDesc");
		}
	}

	public int UserCurExp
	{
		get
		{
			return userCurExp;
		}
		set
		{
			Set(ref userCurExp, value, "UserCurExp");
		}
	}

	public int MaxExp
	{
		get
		{
			return maxExp;
		}
		set
		{
			Set(ref maxExp, value, "MaxExp");
		}
	}

	public string UserExp
	{
		get
		{
			return userExp;
		}
		set
		{
			Set(ref userExp, value, "UserExp");
		}
	}

	public float UserExpFillAmount
	{
		get
		{
			return userExpFillAmount;
		}
		set
		{
			Set(ref userExpFillAmount, value, "UserExpFillAmount");
		}
	}

	public int NormalLevelAchieved
	{
		get
		{
			return normalLevelAchieved;
		}
		set
		{
			Set(ref normalLevelAchieved, value, "NormalLevelAchieved");
		}
	}

	public int DifficltLevelAchieved
	{
		get
		{
			return difficltLevelAchieved;
		}
		set
		{
			Set(ref difficltLevelAchieved, value, "DifficltLevelAchieved");
		}
	}

	public int BestLevel
	{
		get
		{
			return bestLevel;
		}
		set
		{
			Set(ref bestLevel, value, "BestLevel");
		}
	}

	public string CreateDate
	{
		get
		{
			return createDate;
		}
		set
		{
			Set(ref createDate, value, "CreateDate");
		}
	}

	public int BestRank
	{
		get
		{
			return bestRank;
		}
		set
		{
			Set(ref bestRank, value, "BestRank");
		}
	}

	public int CurRank
	{
		get
		{
			return curRank;
		}
		set
		{
			Set(ref curRank, value, "CurRank");
		}
	}

	public string PreviewName
	{
		get
		{
			return previewName;
		}
		set
		{
			Set(ref previewName, value, "PreviewName");
		}
	}

	public string PreviewImg
	{
		get
		{
			return previewImg;
		}
		set
		{
			Set(ref previewImg, value, "PreviewImg");
		}
	}

	public string PreviewBorder
	{
		get
		{
			return previewBorder;
		}
		set
		{
			Set(ref previewBorder, value, "PreviewBorder");
		}
	}

	public string PreviewDesc
	{
		get
		{
			return previewDesc;
		}
		set
		{
			Set(ref previewDesc, value, "PreviewDesc");
		}
	}

	public bool IsOwned
	{
		get
		{
			return isOwned;
		}
		set
		{
			Set(ref isOwned, value, "IsOwned");
		}
	}

	public List<ProfileImgData> ProfileImgList
	{
		get
		{
			return profileImgList;
		}
		set
		{
			Set(ref profileImgList, value, "ProfileImgList");
		}
	}

	public List<ProfileImgData> ProfileBoderList
	{
		get
		{
			return profileBorderList;
		}
		set
		{
			Set(ref profileBorderList, value, "ProfileBoderList");
		}
	}

	public int ChangeType
	{
		get
		{
			return changeType;
		}
		set
		{
			Set(ref changeType, value, "ChangeType");
		}
	}

	private List<int> ExpList
	{
		get
		{
			return expList;
		}
		set
		{
			expList = value;
		}
	}

	public UserInfoViewModel()
	{
		DRAccountGrade[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRAccountGrade>();
		foreach (DRAccountGrade dRAccountGrade in allDataRow)
		{
			expList.Add(dRAccountGrade.NeedExp);
		}
		expList.Add(0);
		roleViewModel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		userUid = roleViewModel.PlayerInfo.Uid;
		userName = roleViewModel.PlayerInfo.Name;
		CurLevel = roleViewModel.PlayerInfo.Level;
		MaxExp = ExpList[CurLevel];
		Avatar = "1607_Upgrade";
		Border = "ReviveBar";
		GuildName = "KIIF";
		UserDesc = "这里是自我介绍";
		UserCurExp = 0;
		UserExp = UserCurExp + "/" + MaxExp;
		UserExpFillAmount = (float)UserCurExp / (float)MaxExp;
		normalLevelAchieved = 1;
		difficltLevelAchieved = 1;
		bestLevel = 2;
		createDate = "2021/10/20";
		bestRank = 1;
		curRank = 2;
		previewName = "KIIF";
		previewImg = "BVRoleIcon1";
		previewBorder = "equipment_grade_0";
		previewDesc = "这是默认！！！";
		profileImgList = new List<ProfileImgData>
		{
			new ProfileImgData("BVRoleIcon1", Border, isOwned: false, "测试头1", "这是第一个"),
			new ProfileImgData("BVRoleIcon2", Border, isOwned: false, "测试头像2", "这是第二个"),
			new ProfileImgData("BVRoleIcon3", Border, isOwned: true, "测试头像3", "这是第三个"),
			new ProfileImgData("BVRoleIcon3", Border, isOwned: false, "南星", "这是第一个"),
			new ProfileImgData("BVRoleIcon1", Border, isOwned: true, "测试头像2", "这是第二个"),
			new ProfileImgData("BVRoleIcon2", Border, isOwned: false, "测试头像3", "这是第三个"),
			new ProfileImgData("BVRoleIcon3", Border, isOwned: false, "南星", "这是第一个"),
			new ProfileImgData("BVRoleIcon1", Border, isOwned: true, "测试头像2", "这是第二个"),
			new ProfileImgData("BVRoleIcon1", Border, isOwned: false, "测试头像3", "这是第三个")
		};
		profileBorderList = new List<ProfileImgData>
		{
			new ProfileImgData(Avatar, "equipment_grade_0", isOwned: false, "测试边框1", "这是第一个"),
			new ProfileImgData(Avatar, "equipment_grade_1", isOwned: true, "测试边框2", "这是第二个"),
			new ProfileImgData(Avatar, "equipment_grade_2", isOwned: false, "测试边框3", "这是第三个"),
			new ProfileImgData(Avatar, "equipment_grade_3", isOwned: false, "测试边框4", "这是第四个"),
			new ProfileImgData(Avatar, "equipment_grade_4", isOwned: true, "测试边框5", "这是第五个"),
			new ProfileImgData(Avatar, "equipment_grade_5", isOwned: false, "测试边框6", "这是第六个")
		};
	}
}
