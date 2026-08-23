local DrawSuccuba = require("app.view.common.DrawSuccuba")
local SuccubaChatHandbookLayer = class("SuccubaChatHandbookLayer", require("app.fairyGUI.succuba.UI_SuccubaChatHandbookLayer"), function()
	return fgui.GComponent:create({
		resName = "SuccubaChatHandbookLayer",
		pkgPath = "ui/succuba/succuba",
		isFullScreen = true,
		pkgName = "succuba"
	}, ...)
end)

function SuccubaChatHandbookLayer:ctor(arg_2_1)
	self._selectedSid = arg_2_1.sid or 0
	self._selectedIdx = 1
	self._handList = nil
	self._interactionComp = nil

	self:_initView()
	self.m_topBarComp:setResInfoById(356)
end

function SuccubaChatHandbookLayer:_initView()
	self.m_bookList:setVirtual(self)
	self.m_bookList:setItemRenderer(handler(self, self._onRenderBookCell))
	self.m_leftBtn:addClickListener(handler(self, self._onLeftBtnClicked))
	self.m_rightBtn:addClickListener(handler(self, self._onRightBtnClicked))
end

function SuccubaChatHandbookLayer:onLoad()
	self._succubaList = g.core.model.User.succubaData:getSuccubaList()

	if self._selectedSid ~= 0 then
		for iter_4_0, iter_4_1 in ipairs(self._succubaList) do
			if self._selectedSid == iter_4_1:getSid() then
				self._selectedIdx = iter_4_0

				break
			end
		end
	end

	self:updateView(self._succubaList[self._selectedIdx])
end

function SuccubaChatHandbookLayer:onClickBackBtn()
	self.m_backTransition:play(handler(self, function(arg_6_0)
		g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_6_0)
	end))
end

function SuccubaChatHandbookLayer:updateView(arg_7_1)
	self._selectedSid = arg_7_1:getSid()

	self:updateCurShowRoomBg(arg_7_1:getAdvanceId(), arg_7_1:getRoomId())
	self:_updateDrawSuccuba(arg_7_1:getMineShowCfg())

	self._handList = {}

	for iter_7_0, iter_7_1 in ipairs((arg_7_1:getInteractionHandbookCfgList())) do
		self._handList[iter_7_0] = iter_7_1
	end

	table.sort(self._handList, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_7_1:isActiveEvent(arg_8_0.id)

		if var_8_0 ~= arg_7_1:isActiveEvent(arg_8_1.id) then
			return var_8_0
		end

		if arg_8_0.quality ~= arg_8_1.quality then
			return arg_8_1.quality < arg_8_0.quality
		end

		return arg_8_0.id > arg_8_1.id
	end)
	self.m_bookList:setNumItems(#self._handList)
	self:_updateLeftAndRightBtnVisible()
end

function SuccubaChatHandbookLayer:_onRenderBookCell(arg_9_1, arg_9_2)
	arg_9_2:updateHandbookCell(self._handList[arg_9_1 + 1], self._succubaList[self._selectedIdx])
end

function SuccubaChatHandbookLayer:_updateDrawSuccuba(arg_10_1)
	if self._drawSuccuba and self._drawSuccuba:getShowInfo().advance_id == arg_10_1.advance_id then
		return
	end

	self.m_spineNode:removeChildren()

	self._drawSuccuba = DrawSuccuba.new({
		showCfg = arg_10_1,
		bgUrl = self._bgUrl
	})

	self.m_spineNode:addChild(self._drawSuccuba)
end

function SuccubaChatHandbookLayer:_onLeftBtnClicked()
	self._selectedIdx = self._selectedIdx - 1

	self:updateView(self._succubaList[self._selectedIdx])
end

function SuccubaChatHandbookLayer:_onRightBtnClicked()
	self._selectedIdx = self._selectedIdx + 1

	self:updateView(self._succubaList[self._selectedIdx])
end

function SuccubaChatHandbookLayer:_updateLeftAndRightBtnVisible()
	self.m_leftBtn:setVisible(self._selectedIdx > 1)
	self.m_rightBtn:setVisible(self._selectedIdx < #self._succubaList)
end

function SuccubaChatHandbookLayer:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "showInteraction" then
		self:_showInteraction(arg_14_2.cfg)

		return true
	end
end

function SuccubaChatHandbookLayer:_showInteraction(arg_15_1)
	local var_15_0

	if not self._interactionComp then
		self._interactionComp = fgui.UIPackage:createObject("succuba", "SuccubaMainInteractionComp")

		self._interactionComp:setSize(cc.size(display.width, display.height))
		self:addChild(self._interactionComp)

		var_15_0 = {
			cfg = arg_15_1,
			callback = handler(self, self._hideInteraction)
		}
	end

	var_15_0.succuba = self._succubaList[self._selectedIdx]
	var_15_0.drawSuccuba = self._drawSuccuba

	self._interactionComp:playInteraction(var_15_0)
	self._interactionComp:setVisible(true)
	self.m_isPlayController:setSelectedIndex(1)
end

function SuccubaChatHandbookLayer:_hideInteraction()
	self._interactionComp:setVisible(false)
	self._drawSuccuba:playIdle()
	self.m_isPlayController:setSelectedIndex(0)
end

function SuccubaChatHandbookLayer:updateCurShowRoomBg(arg_17_1, arg_17_2)
	local var_17_0 = {
		"bg/succuba/",
		g.core.config.succuba_room_info.get(arg_17_2).general
	}

	if arg_17_1 then
		var_17_0[#var_17_0 + 1] = "_"
		var_17_0[#var_17_0 + 1] = arg_17_1
	end

	var_17_0[#var_17_0 + 1] = ".jpg"
	self._bgUrl = table.concat(var_17_0)
end

return SuccubaChatHandbookLayer
