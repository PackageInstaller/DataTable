-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/controller/SystemSideTipController.lua

module("logic.extensions.common.tip.controller.SystemSideTipController", package.seeall)

local M = class("SystemSideTipController", BaseController)

function M:ctor()
	self._isShow = false
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.SHOW_SIDE_TIP, self._addShowSideTips, self)
	GlobalDispatcher:addEventListener(EventType.LOGIN_CONNECT_SERVER_DONE_EVENT, self._connectServerDone, self)

	self._intervalTime = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.ShowSideTipsInterval) or 1
	self._showTime = 0
end

function M:onReset()
	self._isShow = false

	ViewMgr.instance:close(ViewName.HintFloatTipsViewPresentor)

	self._showTime = false

	removetimer(self._showHintTips, self)
end

function M:_connectServerDone()
	settimer(0.5, self._showHintTips, self, true)
end

function M:_showHintTips()
	if self._isShow then
		if self._showTime and self._intervalTime and Time.time - self._showTime >= self._intervalTime then
			self._isShow = false

			ViewMgr.instance:close(ViewName.HintFloatTipsViewPresentor)
			self:_showNextTips()
		end
	else
		self:_showNextTips()
	end
end

function M:_showNextTips()
	if SkillPerformanceMgr.instance:isInPerformance() then
		return
	end

	if self._isShow then
		return
	end

	local data = false

	if self._isShowMountTips then
		data = SystemSideTipModel.instance:getMonumentData()

		if not data then
			self._isShowMountTips = false
			data = SystemSideTipModel.instance:getData()
		end
	else
		data = SystemSideTipModel.instance:getData()
	end

	if data then
		self._showTime = Time.time
		self._isShow = true

		if enableLog then
			printWarn("显示提示", ViewMgr.instance:isOpen(ViewName.HintFloatTipsViewPresentor))
		end

		if not ViewMgr.instance:isOpen(ViewName.HintFloatTipsViewPresentor) then
			ViewMgr.instance:open(ViewName.HintFloatTipsViewPresentor, data)
		end
	end
end

function M:showMonumentTips()
	self._isShowMountTips = true

	self:_showNextTips()
end

function M:_addShowSideTips(e, data)
	if data.showType and data.showType == SystemSideTipEnum.SideType.Monument then
		SystemSideTipModel.instance:addMountData(data)
	else
		self._isShowMountTips = false

		SystemSideTipModel.instance:addData(data)
	end

	self:_showNextTips()
end

function M:testTips()
	local testTitle = "测试标题" .. math.random(1, 10)
	local testContent = "测试内容" .. math.random(20, 100)
	local anchorType = math.random(0, 8)
	local posX = math.random(0, 30)
	local posY = math.random(0, 30)
	local showType = SystemSideTipEnum.SideType.Monument

	SystemSideTipModel.instance:addMountData({
		iconName = "float_sign_1002",
		showType = showType,
		title = testTitle,
		content = testContent,
		anchor = anchorType,
		posX = posX,
		posY = posY
	})
end

M.instance = M.New()

return M
