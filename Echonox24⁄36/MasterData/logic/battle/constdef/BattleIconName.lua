-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/constdef/BattleIconName.lua

module("logic.battle.constdef.BattleIconName", package.seeall)

local BattleIconName = {}

BattleIconName.colorType2Icon = {
	[GameEnum.ColorTypeEnum.Red] = "frame_zhiye_4",
	[GameEnum.ColorTypeEnum.Blue] = "frame_zhiye_2",
	[GameEnum.ColorTypeEnum.Green] = "frame_zhiye_3",
	[GameEnum.ColorTypeEnum.Gray] = "frame_zhiye_1"
}
BattleIconName.colorType2Bg = {
	[GameEnum.ColorTypeEnum.Red] = "frame_zhiye_14",
	[GameEnum.ColorTypeEnum.Blue] = "frame_zhiye_13",
	[GameEnum.ColorTypeEnum.Green] = "frame_zhiye_12",
	[GameEnum.ColorTypeEnum.Gray] = "frame_zhiye_11"
}
BattleIconName.colorType2WeakPointBg = {
	[GameEnum.ColorTypeEnum.Red] = "frame_zhiye1_4",
	[GameEnum.ColorTypeEnum.Blue] = "frame_zhiye1_3",
	[GameEnum.ColorTypeEnum.Green] = "frame_zhiye1_2",
	[GameEnum.ColorTypeEnum.Gray] = "frame_zhiye1_1"
}
BattleIconName.career2Icon = {
	[GameEnum.CareerEnum.Sentinel] = "frame_zhiye_101",
	[GameEnum.CareerEnum.Assault] = "frame_zhiye_102",
	[GameEnum.CareerEnum.Sniper] = "frame_zhiye_103",
	[GameEnum.CareerEnum.Super] = "frame_zhiye_104",
	[GameEnum.CareerEnum.Heavy] = "frame_zhiye_105",
	[GameEnum.CareerEnum.Cure] = "frame_zhiye_106",
	[GameEnum.CareerEnum.Grox] = "frame_zhiye_107",
	[GameEnum.CareerEnum.Myth] = "frame_zhiye_108"
}
BattleIconName.quality2Icon = {
	[GameEnum.QualityEnum.S] = "battlequality_4",
	[GameEnum.QualityEnum.A] = "battlequality_3",
	[GameEnum.QualityEnum.B] = "battlequality_2",
	[GameEnum.QualityEnum.C] = "battlequality_1"
}
BattleIconName.qualityLine2Icon = {
	[GameEnum.QualityEnum.S] = "battlequality_line_4",
	[GameEnum.QualityEnum.A] = "battlequality_line_3",
	[GameEnum.QualityEnum.B] = "battlequality_line_2",
	[GameEnum.QualityEnum.C] = "battlequality_line_1"
}
BattleIconName.displayCategory2Icon = {
	[BattleEnum.SkillDisplayCategory.ATK_PHY] = "lzd_37",
	[BattleEnum.SkillDisplayCategory.ATK_MAG] = "lzd_38"
}
BattleIconName.sanity2Icon = {
	"battle_sanity_02",
	"battle_sanity_01",
	"battle_sanity_03"
}
BattleIconName.sanity2BgIcon = {
	[1] = "lzd_003",
	[2] = "lzd_002"
}
BattleIconName.attackType2Icon = {
	[BattleEnum.AttackType.PHYSICS] = "lzd_37",
	[BattleEnum.AttackType.MAGIC] = "lzd_38"
}

local kTagLabelExt = {
	[BattleEnum.Tag.MoonRing] = "zd",
	[BattleEnum.Tag.Chase] = "zj",
	[BattleEnum.Tag.Assist] = "yh",
	[BattleEnum.Tag.BoreSpine] = "zc",
	[BattleEnum.Tag.ArcLight] = "hg",
	[BattleEnum.Tag.Snipe] = "sd",
	[BattleEnum.Tag.Bomb] = "cg"
}

function BattleIconName.getColorTypeWeakPointBg(colorType)
	return BattleIconName.colorType2WeakPointBg[colorType]
end

function BattleIconName.getColorTypeIcon(colorType)
	return BattleIconName.colorType2Icon[colorType]
end

function BattleIconName.getColorTypeBg(colorType)
	return BattleIconName.colorType2Bg[colorType]
end

function BattleIconName.getCareerIcon(career)
	return BattleIconName.career2Icon[career]
end

function BattleIconName.getQualityIcon(quality)
	return BattleIconName.quality2Icon[quality]
end

function BattleIconName.getQualityLineIcon(quality)
	return BattleIconName.qualityLine2Icon[quality]
end

function BattleIconName.getCampIcon(camp)
	local camp2Icon = CommEnum.CampType2BattleIcon

	return camp2Icon[camp]
end

function BattleIconName.getSanityIcon(sanityValue)
	local sanity2Icon = BattleIconName.sanity2Icon

	if sanityValue == 0 then
		return sanity2Icon[3]
	end

	return sanityValue > 0 and sanity2Icon[1] or sanity2Icon[2]
end

function BattleIconName.getSanityBgIcon(sanityValue)
	local sanity2Icon = BattleIconName.sanity2BgIcon

	return sanityValue >= 0 and sanity2Icon[1] or sanity2Icon[2]
end

function BattleIconName.getSkillDisplayCategoryIcon(skillDisplayCategory)
	local displayCategory2Icon = BattleIconName.displayCategory2Icon

	return displayCategory2Icon[skillDisplayCategory]
end

function BattleIconName.getTagLableIcon(tagName, count)
	local tagEnum = BattleEnum.Tag[tagName]
	local tagNameExt = kTagLabelExt[tagEnum]

	count = Mathf.Clamp(count, 1, 3)

	return string.format("zdljbx_text_000%s_%s", count, tagNameExt)
end

function BattleIconName.setSkillIcon(img, skillId, callFunc, callHandler)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
	local iconType = IconType.SkillIcon

	if skillCOWrapper:getSkillType() == BattleEnum.SkillCategory.ECHO then
		iconType = IconType.EchoItemIcon
	elseif skillCOWrapper:getSkillType() == BattleEnum.SkillCategory.EQUIPMENT then
		iconType = IconType.ItemIcon
	end

	IconLoader.setSprite(img, iconType, ActiveSkillCOUtil.getSkillIcon(skillCOWrapper:getSkillCO()), function()
		if callFunc then
			callFunc(callHandler, img)
		end
	end, self)
end

return BattleIconName
