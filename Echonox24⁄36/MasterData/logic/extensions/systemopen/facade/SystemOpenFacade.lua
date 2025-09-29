-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/facade/SystemOpenFacade.lua

module("logic.extensions.systemopen.facade.SystemOpenFacade", package.seeall)

local M = class("SystemOpenFacade", BaseFacade)

function M:ctor()
	return
end

function M:judgeUIState(systemEnum, goTarget)
	local transitionTarget = UIEffectUtil.getButtonTransition(goTarget)

	if self:isOpen(systemEnum) then
		transitionTarget:setEnable()
		transitionTarget:setVisible(true)
	elseif self:isShowOnLock(systemEnum) then
		transitionTarget:setVisible(true)
		transitionTarget:setDisable(true)
	else
		transitionTarget:setVisible(false)
	end
end

function M:addOpenSystem(systemEnum)
	return SystemOpenModel.instance:addOpenSystem(systemEnum)
end

function M:updateOpenSystemCondition(systemEnum, bits)
	return SystemOpenModel.instance:updateOpenSystemCondition(systemEnum, bits)
end

function M:isOpen(systemEnum, isShowLockTips)
	local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(systemEnum)

	if systemOpenCO then
		local isOpen, lockIndex = SystemOpenModel.instance:isOpen(systemEnum)

		if isOpen then
			return true
		end

		if systemOpenCO:isDefaultOpen() then
			return true
		end

		if isShowLockTips then
			local showHintStr
			local lockTips = systemOpenCO:getLockTips()

			if not string.nilorempty(lockTips) then
				showHintStr = lockTips
			else
				printWarn("暂未填写未解锁提示" .. systemEnum)
			end

			if showHintStr then
				FloatWordMgr.instance:show(showHintStr)
			end
		end

		return false
	end

	printWarn(string.format("功能是否开启判断中，找不到对应的配表[systemEnum: %s, isShowLockTips: %s]", tostring(systemEnum), tostring(isShowLockTips)))

	return false
end

function M:isShowOnLock(systemEnum)
	local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(systemEnum)

	if systemOpenCO then
		return systemOpenCO:isShowOnLock()
	end

	return true
end

function M:addSystemOpenHandler(systemEnum, callback, handler)
	SystemOpenModel.instance:addOpenSystemHandler(systemEnum, callback, handler)
end

function M:isOpenJudgeFromServer(systemId)
	return SystemOpenModel.instance:isOpenJudgeFromServer(systemId)
end

function M:simulationUpdateSystem(systemEnum, isOpen)
	local bits = isOpen and 15 or 0

	SystemOpenModel.instance:updateOpenSystemCondition(systemEnum, bits)
end

M.instance = M.New()

return M
