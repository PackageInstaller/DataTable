-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/MonumentMO.lua

module("logic.extensions.playerinfo.model.MonumentMO", package.seeall)

local MonumentMO = class("MonumentMO")

function MonumentMO:ctor(cfg)
	self._id = cfg.id
	self._no = cfg.no
	self._label = cfg.label
	self._lv = cfg.lv
	self._style = cfg.style
	self._name = cfg.name
	self._text = cfg.text
	self._cupDesc = cfg.cupDesc
	self._content = cfg.content
	self._param = cfg.param
	self._noShow = cfg.noShow > 0
	self._notGetNoShow = cfg.notGetNoShow > 0
	self._priority = cfg.priority
	self._finishCnt = 0
	self._isFinish = false
	self._obtTime = 0
	self._rate = 0
end

function MonumentMO:getId()
	return self._id
end

function MonumentMO:getNo()
	return self._no
end

function MonumentMO:getLabel()
	return self._label
end

function MonumentMO:getLv()
	return self._lv
end

function MonumentMO:getName()
	return self._name
end

function MonumentMO:getStyle()
	return self._style
end

function MonumentMO:getIcon()
	return self._icon
end

function MonumentMO:getPriority()
	return self._priority
end

function MonumentMO:canJump()
	return self:getJumpId() > 0
end

function MonumentMO:getJumpId()
	return self._jumpId or 0
end

function MonumentMO:getText()
	return self._text or ""
end

function MonumentMO:getDesc()
	if not self._taskDesc then
		self:_parseTask()
	end

	return self._taskDesc
end

function MonumentMO:getUpgradeDesc()
	if not self:getIsFinish() or not self:canUpgrade() then
		return self:getDesc()
	else
		local mo = MonumentModel.instance:getUpgradeMonumentMo(self:getNo(), self:getLv() + 1)

		return mo:getDesc()
	end
end

function MonumentMO:getCupDesc()
	return self._cupDesc
end

function MonumentMO:setFinishCnt(count)
	self._finishCnt = count
end

function MonumentMO:getMaxCnt()
	if not self._maxCount then
		self:_parseTask()
	end

	if not self._maxCount then
		return 1
	end

	return tonumber(self._maxCount)
end

function MonumentMO:getUpgradeMaxCnt()
	if not self:getIsFinish() or not self:canUpgrade() then
		return self:getMaxCnt()
	else
		local mo = MonumentModel.instance:getUpgradeMonumentMo(self:getNo(), self:getLv() + 1)

		return mo:getMaxCnt()
	end
end

function MonumentMO:getFinishCnt()
	return self._finishCnt
end

function MonumentMO:getUpgradeFinishCnt()
	if not self:getIsFinish() or not self:canUpgrade() then
		return self:getFinishCnt()
	else
		local mo = MonumentModel.instance:getUpgradeMonumentMo(self:getNo(), self:getLv() + 1)

		return mo:getFinishCnt()
	end
end

function MonumentMO:setIsFinish(isFinish)
	self._isFinish = isFinish
end

function MonumentMO:getIsFinish()
	return self._isFinish
end

function MonumentMO:setObtTime(time)
	self._obtTime = time
end

function MonumentMO:getObtTime()
	return self._obtTime
end

function MonumentMO:setRate(rate)
	self._rate = rate
end

function MonumentMO:getRate()
	return self._rate
end

function MonumentMO:getIsNoShow()
	return self._noShow
end

function MonumentMO:isNotGetNoShow()
	return self._notGetNoShow
end

function MonumentMO:canGetReward()
	return self:getFinishCnt() >= self:getMaxCnt()
end

function MonumentMO:canUpgrade()
	local maxLevel = MonumentModel.instance:getMaxLevel(self:getNo())

	return maxLevel > self:getLv()
end

function MonumentMO:_parseTask()
	if not string.nilorempty(self._param) and self._content > 0 then
		self._taskDesc, self._maxCount, self._isTaskGroup = TaskUtil.parseContent(self._content, self._param)

		printWarn("====_parseTask====", self._no, self._content, self._param, self._taskDesc, self._maxCount, self._isTaskGroup)
	end

	if not string.nilorempty(self._text) then
		self._taskDesc = self._text
	end
end

return MonumentMO
