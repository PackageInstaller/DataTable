-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/model/BounsModel.lua

module("logic.extensions.bonus.model.BounsModel", package.seeall)

local BounsModel = class("BounsModel", BaseModel)

function BounsModel:ctor()
	self._summerDoubleTab = nil
end

function BounsModel:onInit()
	self:onReset()
end

function BounsModel:onReset()
	self._perferentialLastOpenTagId = 0
	self._xiaonuoBirthLastOpenTagList = {}
	self._xiaonuoBirthLastOpenTagIdClearList = {}
	self.keyID = 0
	self._summerDoubleTab = nil
	self._lastBonusId = 0
	self._lastPreferentialviewTag = nil
end

function BounsModel:setKey(id)
	self.keyID = id
end

function BounsModel:clearData(id)
	if not id then
		return
	end

	self._xiaonuoBirthLastOpenTagList[id] = nil
	self._xiaonuoBirthLastOpenTagIdClearList[id] = nil
end

function BounsModel:checkHappyLemonDot()
	local str = FuncOpenModel.instance:getFuncIsOpen(275) and GameUtil.getUserData("happylemen_dot") or "notDot"

	return string.nilorempty(str)
end

function BounsModel:setHappyLemonClick()
	GameUtil.saveUserData("happylemen_dot", "isclick")
end

function BounsModel:getLastOpenTagId()
	return self._perferentialLastOpenTagId
end

function BounsModel:setLastOpenTagId(id)
	self._perferentialLastOpenTagId = checkint(id)
end

function BounsModel:getXiaoNuoBirthLastOpenTagId(id)
	return self._xiaonuoBirthLastOpenTagList[id]
end

function BounsModel:setXiaoNuoBirthLastOpenTagId(id)
	self._xiaonuoBirthLastOpenTagList[self.keyID] = checkint(id)
end

function BounsModel:getXiaoNuoBirthLastOpenTagIdClear(id)
	return self._xiaonuoBirthLastOpenTagIdClearList[id]
end

function BounsModel:setXiaoNuoBirthLastOpenTagIdClear(id)
	self._xiaonuoBirthLastOpenTagIdClearList[self.keyID] = checkint(id)
end

function BounsModel:setSummerDoubleTabIndex(index)
	self._summerDoubleTab = index
end

function BounsModel:getSummerDoubleTabIndex()
	return checknumber(self._summerDoubleTab)
end

function BounsModel:setLastOpenBonusId(id)
	self._lastBonusId = id
end

function BounsModel:getLastOpenBonusId()
	return self._lastBonusId
end

function BounsModel:setLastPreferentialviewTag(uniqueTag)
	self._lastPreferentialviewTag = uniqueTag
end

function BounsModel:getLastPreferentialviewTag()
	return self._lastPreferentialviewTag
end

BounsModel.instance = BounsModel.New()

return BounsModel
