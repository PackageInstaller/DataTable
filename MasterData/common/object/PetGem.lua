-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\PetGem.lua

local BaseObject = require("Common/Object/BaseObject")
local ResPet = require("ClientData/ResPet")
local ResPetGem = require("ClientData/ResPetGem")
local ResPetGemAttrLibrary = require("ClientData/ResPetGemAttrLibrary")
local strClassName = "PetGem"
local PetGem = Class(strClassName, BaseObject)

function PetGem:ctor(data)
	return
end

function PetGem:_initData()
	PetGem.super._initData(self)

	self.gid = self._serverData.gid or ""
	self.id = self._serverData.resid or 0
	self.resData = ResPetGem[self.id]

	if not self.resData then
		-- block empty
	end

	self.name = self.resData.name
	self.baseLevel = self.resData.level
	self.numType = self.resData.num_type
	self.effect1 = self.resData.effect1
	self.effect2 = self.resData.effect2
	self.randWeight = self.resData.rand_weight
	self.level = self._serverData.level or self.baseLevel
	self.mainAttr = self._serverData.main_attr or {}
	self.subAttr = self._serverData.sub_attr or {}
	self.itemType = Const.ITEM_TYPE_PET_GEM
	self.quality = Const.ITEM_QUALITY_PURPLE
end

function PetGem:getIconPath(isRandom)
	if isRandom then
		return {
			self.resData.icon_path,
			self.resData.icon
		}
	end

	if self.mainAttr and self.mainAttr[1] then
		local mainAttrId = self.mainAttr[1].attr_id

		if mainAttrId and ResPetGemAttrLibrary[mainAttrId] and ResPetGemAttrLibrary[mainAttrId].icon_path and ResPetGemAttrLibrary[mainAttrId].icon then
			return {
				ResPetGemAttrLibrary[mainAttrId].icon_path,
				ResPetGemAttrLibrary[mainAttrId].icon
			}
		end
	else
		return {
			self.resData.icon_path,
			self.resData.icon
		}
	end
end

function PetGem:getQualityPath()
	return UIConst.COMMON_QUALITY_CONFIG[self.quality]
end

function PetGem:getMainAttr()
	return self.mainAttr[1]
end

function PetGem:getSubAttr()
	return self.subAttr
end

function PetGem:checkHasHigherLvGemNotWearing()
	for i, v in pairs(CurAvatar.petGemDic) do
		if v.inWearing == nil and v.level > self.level then
			return true
		end
	end

	return false
end

function PetGem:checkGemCanLevelUp()
	if not self:isMaxLevel() then
		local sameLevelNum = 0

		for i, v in pairs(CurAvatar.petGemDic) do
			if v.gid ~= self.gid and v.level == self.level and v.inWearing == nil then
				sameLevelNum = sameLevelNum + 1
			end
		end

		return sameLevelNum >= 2
	end

	return false
end

function PetGem:getMaxLevel()
	local maxLevel = 1

	for i, v in pairs(ResPetGem) do
		if maxLevel < v.level then
			maxLevel = v.level
		end
	end

	return maxLevel
end

function PetGem:isMaxLevel()
	return self.level == self:getMaxLevel()
end

function PetGem:getProps(props)
	local mainAttr = self:getMainAttr() or {}

	mainAttr = mainAttr.attr_id

	local attrData = ResPetGemAttrLibrary[mainAttr]

	if attrData and attrData.attr then
		for _, info in ipairs(attrData.attr) do
			local propName = BattleConst.PROP_TYPE_CONFIG[info.type_id]

			if propName then
				props[propName] = (props[propName] or 0) + info.num
			end
		end
	end

	local subAttrs = self:getSubAttr()

	for _, subAttr in ipairs(subAttrs or {}) do
		local subAttrData = ResPetGemAttrLibrary[subAttr.attr_id]

		if subAttrData and subAttrData.attr then
			for _, info in ipairs(subAttrData.attr) do
				local propName = BattleConst.PROP_TYPE_CONFIG[info.type_id]

				if propName then
					props[propName] = (props[propName] or 0) + info.num
				end
			end
		end
	end
end

function PetGem:isPetGem()
	return true
end

function PetGem:getNextLevelGem()
	if self.resData.up_id then
		local fakeGem = BaseObject.GetObject(self.resData.up_id)

		fakeGem.subAttr = self.subAttr
		fakeGem.mainAttr = self.mainAttr

		if fakeGem.resData.main_attr_library ~= self.resData.main_attr_library then
			local mainAttrId = self.mainAttr[1].attr_id

			for i, v in pairs(ResPetGemAttrLibrary) do
				if v.library_id == fakeGem.resData.main_attr_library and v.attr[1].type_id == ResPetGemAttrLibrary[mainAttrId].attr[1].type_id then
					fakeGem.mainAttr = {
						{
							attr_id = i
						}
					}
				end
			end
		end

		return fakeGem
	end
end

function PetGem:getNumStr()
	return ClientUtils.getNumShortStr(self.num)
end

return PetGem
