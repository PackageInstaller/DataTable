#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50131ShiLaiMuDui;

public class Skill_SetType : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
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
		yield break;
	}
}
