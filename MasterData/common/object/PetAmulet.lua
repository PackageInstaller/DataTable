-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\PetAmulet.lua

local BaseObject = require("Common/Object/BaseObject")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResAmuletStar = require("ClientData/ResAmuletStar")
local strClassName = "PetAmulet"
local PetAmulet = Class(strClassName, BaseObject)

function PetAmulet:ctor(data)
	return
end

function PetAmulet:_initData()
	PetAmulet.super._initData(self)

	self.id = self._serverData.resid or 0
	self.resData = ResPetAmulet[self.id]

	if not self.resData then
		-- block empty
	end

	self.name = self.resData.name or ""
	self.quality = self.resData.quality
	self.baseStar = self.resData.base_star
	self.maxStar = self.resData.max_star
	self.mainSkill = self.resData.main_skill
	self.assistantSkill = self.resData.assistant_skill
	self.translateItemId = self.resData.translate_item_id
	self.initMana = self.resData.init_mana
	self.manaGen = self.resData.mana_gen
	self.star = self._serverData.star or self.baseStar
	self.itemType = Const.ITEM_TYPE_PET_AMULET
end

function PetAmulet:getIconPath()
	if self.resData and self.resData.icon_path and self.resData.icon then
		return {
			self.resData.icon_path,
			self.resData.icon
		}
	end
end

function PetAmulet:isMaxStar()
	return self.star >= self.maxStar
end

function PetAmulet:getMainSkill()
	local starData = ResAmuletStar[self.star]

	return self.resData.main_skill, starData.skill_level
end

function PetAmulet:getAssistSkill()
	local starData = ResAmuletStar[self.star]

	return self.resData.assistant_skill, starData.skill_level
end

function PetAmulet:checkCanStarUp()
	if not self:isMaxStar() then
		local haveNum = CurAvatar:getItemNumById(self.translateItemId)
		local costNum = ResAmuletStar[self.star + 1].need_piece_num

		if costNum <= haveNum then
			return true
		end
	end

	return false
end

function PetAmulet:checkCanWearedInAssist()
	if self.quality >= Const.PET_QUALITY_ORANGE and self.assistantSkill ~= nil and self.assistantSkill ~= 0 then
		return true
	end

	return false
end

return PetAmulet
