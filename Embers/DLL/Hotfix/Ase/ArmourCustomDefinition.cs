using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

public static class ArmourCustomDefinition
{
	public static string GetDescription(DREquipmentPacks config, string titleColor, string contentColor)
	{
		StringBuilder stringBuilder = new StringBuilder();
		int maxCount = 0;
		if (Enum.IsDefined(typeof(ArmourCustomMode), config.EquipmentsType))
		{
			stringBuilder.AppendLine("<color=" + titleColor + ">" + GetPopupGroupTitle((ArmourCustomMode)config.EquipmentsType, ArmourCustomType.MainEntry, 1) + "：</color>");
			if (config.Equipments.Count > 0)
			{
				stringBuilder.Append("<color=" + contentColor + ">");
				for (int i = 0; i < config.Equipments.Count; i++)
				{
					DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(config.Equipments[i]);
					if (dataRow == null)
					{
						continue;
					}
					maxCount = dataRow.AttributeMaxNum;
					int entryId = ((dataRow.Regular.Count > 0) ? dataRow.Regular[0] : 0);
					if (entryId > 0)
					{
						DRAttributeTotal dataRow2 = GameEntry.DataTable.GetDataRow((DRAttributeTotal p) => p.Uid == entryId);
						if (dataRow2 != null)
						{
							stringBuilder.Append((i == 0) ? dataRow2.Name : ("、" + dataRow2.Name));
						}
					}
				}
				stringBuilder.Append("</color>");
			}
		}
		stringBuilder.Append("\n");
		stringBuilder.AppendLine();
		if (Enum.IsDefined(typeof(ArmourCustomMode), config.MainAttributeType))
		{
			stringBuilder.AppendLine("<color=" + titleColor + ">" + GetPopupGroupTitle((ArmourCustomMode)config.MainAttributeType, ArmourCustomType.MainAttribute, 1) + "：</color>");
			if (config.DefenseAttribute.Count > 0)
			{
				stringBuilder.Append("<color=" + contentColor + ">");
				for (int num = 0; num < config.DefenseAttribute.Count; num++)
				{
					DRAffix dataRow3 = GameEntry.DataTable.GetDataRow<DRAffix>(config.DefenseAttribute[num]);
					if (dataRow3 != null)
					{
						stringBuilder.Append((num == 0) ? dataRow3.Desc : ("、" + dataRow3.Desc));
					}
				}
				stringBuilder.Append("</color>");
			}
		}
		stringBuilder.Append("\n");
		stringBuilder.AppendLine();
		if (Enum.IsDefined(typeof(ArmourCustomMode), config.SecondaryAttributeType))
		{
			stringBuilder.AppendLine("<color=" + titleColor + ">" + GetPopupGroupTitle((ArmourCustomMode)config.SecondaryAttributeType, ArmourCustomType.SubAttribute, maxCount) + "：</color>");
			List<DRAttributeStore> list = GameEntry.DataTable.GetDataRows((DRAttributeStore p) => p.StoreId == config.AttributeStore).ToList();
			if (list != null && list.Count > 0)
			{
				stringBuilder.Append("<color=" + contentColor + ">");
				for (int num2 = 0; num2 < list.Count; num2++)
				{
					DRAffix dataRow4 = GameEntry.DataTable.GetDataRow<DRAffix>(list[num2].AttributeId);
					if (dataRow4 != null)
					{
						stringBuilder.Append((num2 == 0) ? dataRow4.Desc : ("、" + dataRow4.Desc));
					}
				}
				stringBuilder.Append("</color>");
			}
		}
		return stringBuilder.ToString();
	}

	public static string GetGroupTitle(ArmourCustomMode mode, ArmourCustomType targetType, int curCount = 0, int maxCount = 0)
	{
		string text = "";
		switch (targetType)
		{
		case ArmourCustomType.MainEntry:
			text = "主词条";
			break;
		case ArmourCustomType.MainAttribute:
			text = "主属性";
			break;
		case ArmourCustomType.SubAttribute:
			text = "副属性";
			break;
		}
		switch (mode)
		{
		case ArmourCustomMode.ManualSelection:
			return $"可选{text} ({curCount}/{maxCount})";
		case ArmourCustomMode.FixSelection:
			if (maxCount <= 1)
			{
				return "固定选择" + text;
			}
			return $"固定选择{maxCount}条{text}";
		case ArmourCustomMode.RandomSelection:
			if (maxCount <= 1)
			{
				return "随机选择" + text;
			}
			return $"随机选择{maxCount}条{text}";
		default:
			return "";
		}
	}

	public static string GetPopupGroupTitle(ArmourCustomMode mode, ArmourCustomType targetType, int maxCount = 0)
	{
		string text = "";
		switch (targetType)
		{
		case ArmourCustomType.MainEntry:
			text = "主词条";
			break;
		case ArmourCustomType.MainAttribute:
			text = "主属性";
			break;
		case ArmourCustomType.SubAttribute:
			text = "副属性";
			break;
		}
		switch (mode)
		{
		case ArmourCustomMode.ManualSelection:
			if (maxCount <= 1)
			{
				return "可选" + text;
			}
			return $"可选择{maxCount}个{text}";
		case ArmourCustomMode.FixSelection:
			if (maxCount <= 1)
			{
				return "固定" + text;
			}
			return $"固定{maxCount}条{text}";
		case ArmourCustomMode.RandomSelection:
			if (maxCount <= 1)
			{
				return "随机" + text;
			}
			return $"随机获得{maxCount}个{text}";
		default:
			return "";
		}
	}
}
