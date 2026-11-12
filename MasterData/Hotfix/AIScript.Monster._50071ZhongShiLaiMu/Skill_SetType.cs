#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50071ZhongShiLaiMu;

public class Skill_SetType : SkillSimpleBase
{
	private const string waterTag = "Water";

	private const string darkTag = "Dark";

	private const string earthTag = "Earth";

	private const string fireTag = "Fire";

	private const string lightTag = "Light";

	private const string commonTag = "Common";

	private const string windTag = "Wind";

	protected override IEnumerator DoMainLogic()
	{
		switch (GetElementTag())
		{
		case 0:
			SetLogicTagFpValue(_actor, "slimeType", 0);
			break;
		case 1:
			SetLogicTagFpValue(_actor, "slimeType", 5);
			break;
		case 2:
			SetLogicTagFpValue(_actor, "slimeType", 3);
			break;
		case 3:
			SetLogicTagFpValue(_actor, "slimeType", 1);
			break;
		case 4:
			SetLogicTagFpValue(_actor, "slimeType", 4);
			break;
		case 5:
			SetLogicTagFpValue(_actor, "slimeType", 6);
			break;
		case 6:
			SetLogicTagFpValue(_actor, "slimeType", 2);
			break;
		default:
			SetTypeByBuff();
			break;
		}
		yield break;
	}

	private void SetTypeByBuff()
	{
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 500710000);
		if (buffFromTarget != null && buffFromTarget.Count > 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 500710000:
				SetLogicTagFpValue(_actor, "slimeType", 0);
				break;
			case 500710001:
				SetLogicTagFpValue(_actor, "slimeType", 1);
				break;
			case 500710002:
				SetLogicTagFpValue(_actor, "slimeType", 2);
				break;
			case 500710003:
				SetLogicTagFpValue(_actor, "slimeType", 3);
				break;
			case 500710004:
				SetLogicTagFpValue(_actor, "slimeType", 4);
				break;
			case 500710005:
				SetLogicTagFpValue(_actor, "slimeType", 5);
				break;
			case 500710006:
				SetLogicTagFpValue(_actor, "slimeType", 6);
				break;
			default:
				SetLogicTagFpValue(_actor, "slimeType", 0);
				NovaLogger.Debug("中史莱姆自身元素类型判断异常,保底处理为水");
				break;
			}
		}
		else
		{
			NovaLogger.Debug("中史莱姆出生技能元素判断异常，保底处理为水");
			SetLogicTagFpValue(_actor, "slimeType", 0);
		}
	}

	protected int GetElementTag()
	{
		int num = 0;
		switch (GetMonsterTagValue(_actor, 1))
		{
		case "Water":
			return 0;
		case "Dark":
			return 1;
		case "Earth":
			return 2;
		case "Fire":
			return 3;
		case "Light":
			return 4;
		case "Common":
			return 5;
		case "Wind":
			return 6;
		default:
			NovaLogger.Debug("中史莱姆.添加标签.Tag异常");
			return -1;
		}
	}
}
