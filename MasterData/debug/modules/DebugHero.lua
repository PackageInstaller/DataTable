-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugHero.lua

local DebugConst = require("Debug/DebugConst")
local DebugModule = {}
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")

DebugModule.ENTRY_NAME = "英雄系统"

function DebugModule.getHero(sender, menu, value)
	local debugM = UIManager.getUI("debug", nil, false)
	local ResHero = require("ClientData/ResHero")
	local Hero = require("Common/Object/Hero")

	if value == "" then
		MsgManager.notice("请输入英雄id或名称")
	else
		local count = false

		for k, v in pairs(ResHero) do
			if tostring(k) == value then
				count = true

				RPC.executeGM("//hero " .. value)
			elseif v.hero_name == value then
				count = true

				RPC.executeGM("//hero " .. k)
			elseif v.hero_name:match(".*" .. value .. ".*") then
				count = true

				MsgManager.notice(k .. ":" .. v.hero_name)
			end
		end

		if not count then
			RPC.executeGM("//hero " .. value)
		end
	end
end

function DebugModule.setCrystal(sender, menu, value)
	for heroGid, hero in pairs(CurAvatar.heroDic) do
		if hero.star == 3 then
			RPC.crystalMsgSetSympathizer(heroGid)
		end
	end
end

local HeroMap = {}
local HeroList = {
	"无"
}
local ResRoleImageData = require("ClientData/ResRoleImageData")
local ResHero = require("ClientData/ResHero")

for heroID, data in pairs(ResRoleImageData) do
	local tag = heroID .. ""
	local heroData = ResHero[heroID]

	if heroData == nil then
		-- block empty
	else
		tag = tag .. ":" .. heroData.hero_name
	end

	HeroMap[tag] = heroID

	table.insert(HeroList, tag)
end

local HeroIDMap = {}
local HeroIDList = {
	"无"
}

for heroID, data in pairs(ResHero) do
	local tag = heroID .. ""
	local heroData = ResHero[heroID]

	if heroData == nil then
		-- block empty
	else
		tag = tag .. ":" .. heroData.hero_name
	end

	HeroIDMap[tag] = heroID

	table.insert(HeroIDList, tag)
end

local CurHeroImage

function DebugModule.showHeroImage(sender, menu, value)
	local id = HeroMap[value]

	if id then
		if CurHeroImage == nil then
			CurHeroImage = UIControls.Role(sender.mWindow)
		end

		CurHeroImage:showRole(id)
	elseif CurHeroImage then
		CurHeroImage:setVisible(false)
	end
end

local HeroEmojiMap = {
	怒 = "02",
	哭 = "01"
}
local HeroEmojiList = {
	"无",
	"哭",
	"怒"
}

function DebugModule.showHeroEmoji(sender, menu, value)
	local emoji = HeroEmojiMap[value]

	if CurHeroImage then
		CurHeroImage:showEmoji(emoji)
	end
end

local HeroMainPos = 1

function DebugModule.selectMainHeroPos(sender, menu, value)
	HeroMainPos = tonumber(value)
end

function DebugModule.setMainHeroModel(sender, menu, value)
	local ui = UIManager.getUI("mainMenu", nil, false)

	if ui then
		ui:setHero(HeroMainPos, tonumber(value))
	else
		MsgManager.notice("界面没打开")
	end
end

function DebugModule.setHeroSkinTime(sender, menu, value)
	DebugModule.value = tonumber(value)

	for k, v in ipairs(ResItemHeroSkin[DebugModule.value]) do
		if ResItemHeroSkin[DebugModule.value][k].valid_time_id then
			ResItemHeroSkin[DebugModule.value][k].valid_time_id = 1
		end
	end
end

function DebugModule.showListAttrHero(sender, menu, value)
	local hero = BaseObject.GetObject(tonumber(value))
	local hero1 = BaseObject.GetObject(tonumber(value))

	CurAvatar:showLimitStarHeroForGetNewDlg({
		hero,
		hero1
	})
end

function DebugModule.getHeroID(sender, menu, value)
	local debugM = UIManager.getUI("debug", nil, false)
	local ResHero = require("ClientData/ResHero")
	local Hero = require("Common/Object/Hero")
end

DebugModule.FUNC_MENU = {
	{
		name = "获得英雄",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getHero
	},
	{
		name = "英雄id列表",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = DebugModule.getHeroID,
		value = HeroIDList
	},
	{
		name = "打开英雄获得界面2个",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.showListAttrHero
	},
	{
		name = "设置三星共鸣者",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.setCrystal
	},
	{
		name = "解锁英雄皮肤",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.setHeroSkinTime
	},
	{
		name = "英雄立绘",
		typ = DebugConst.BTN_TYPE_MENU,
		value = {
			{
				name = "显示英雄立绘",
				typ = DebugConst.BTN_TYPE_COMBOX,
				func = DebugModule.showHeroImage,
				value = HeroList
			},
			{
				name = "显示英雄表情",
				typ = DebugConst.BTN_TYPE_COMBOX,
				func = DebugModule.showHeroEmoji,
				value = HeroEmojiList
			}
		}
	},
	{
		name = "设置展示英雄",
		typ = DebugConst.BTN_TYPE_MENU,
		value = {
			{
				name = "选择位置",
				typ = DebugConst.BTN_TYPE_COMBOX,
				func = DebugModule.selectMainHeroPos,
				value = {
					1,
					2,
					3,
					4,
					5
				}
			},
			{
				name = "显示英雄模型",
				typ = DebugConst.BTN_TYPE_INPUT,
				func = DebugModule.setMainHeroModel
			}
		}
	}
}

return DebugModule
