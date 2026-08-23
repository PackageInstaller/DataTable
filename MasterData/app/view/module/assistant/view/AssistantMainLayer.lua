local AssistantMainLayer = class("AssistantMainLayer", require("app.fairyGUI.assistant.UI_AssistantMainLayer"), function()
	return fgui.GComponent:create({
		resName = "AssistantMainLayer",
		pkgPath = "ui/assistant/assistant",
		isFullScreen = true,
		pkgName = "assistant"
	})
end)
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.model.User.skinData
local AssistantCommon = require("app.view.module.assistant.common.AssistantCommon")

function AssistantMainLayer:ctor()
	self._selectedGroup = nil
	self._assistantId = 0
	self._assistantDressId = 0
	self._useAssistantId = 0
	self._useAssistantDressId = 0
	self._assistantBaseInfo = nil
	self._knightList = nil
	self._selectedKnightList = nil
	self._selectedSkinList = {}
	self._skinList = nil
	self.m_enterTransition = self:getView():getTransition("enter")
	self.m_backTransition = self:getView():getTransition("back")

	self:_initComp()
	self:_addListener()
end

function AssistantMainLayer:onLoad()
	self:_addNetWorkListener()
	self:_updateLayer()
	self.m_enterTransition:play()
end

function AssistantMainLayer:_initComp()
	self:_initData()
	self:_initUI()
end

function AssistantMainLayer:receiveCompEvent(arg_5_1)
	local var_5_0 = {
		...
	}

	if arg_5_1 == "AssistantSkinSwitch" then
		if var_5_0[1].knight and self._assistantDressId ~= 0 then
			self._assistantDressId = 0

			self:_updateKnightSpine()
		elseif var_5_0[1].skin and self._assistantDressId ~= var_5_0[1].skin.id then
			self._assistantDressId = var_5_0[1].skin.id

			self:_updateKnightSpine()
		end

		if self._assistantId and self._assistantDressId then
			self._selectedSkinList[self._assistantId] = self._assistantDressId
		end
	end
end

function AssistantMainLayer:_initData()
	self._assistantDressId = nil
	self._knightList = {}
	self._selectedKnightList = nil
end

function AssistantMainLayer:_initUI()
	self:addListen(self.m_skinComp)
	self:addBg(g.core.common.Path:getHomeBackground(g.core.config.bg_book_info.get((g.core.model.User.userActiveSceneData:getSceneId())).pic))
	self.m_groupList:setSelectedIndex(0)
	self.m_runBanner:init({
		index = 1,
		width = 88,
		target = self.m_groupList
	})
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightRenderer))
end

function AssistantMainLayer:_addListener()
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._changeGroup))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._changeKnight))
	self.m_changeAssistant:addClickListener(handler(self, self._onSelectedAssistant))
	self.m_changePosition:addClickListener(handler(self, self._onChangePosition))
	self.m_changeMainScene:addClickListener(handler(self, self._onChangeScene))
end

function AssistantMainLayer:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECV_ROLE_INFO, handler(self, self._refreshLayer), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeMainScene
	})
end

function AssistantMainLayer:_updateLayer()
	self._useAssistantId = g.core.model.User:getAssistantId()
	self._useAssistantDressId = g.core.model.User:getAssistantDressId()
	self._assistantId = self._useAssistantId
	self._assistantDressId = self._useAssistantDressId
	self._selectedSkinList[self._assistantId] = self._assistantDressId

	self:_updateDressComp()
	self:_updateKnightList(self._selectedGroup or 0)
	self:_updateKnightSpine()
end

function AssistantMainLayer:_updateKnightSpine()
	self.m_knightList:setTouchable(false)
	self.m_skinComp:setTouchable(false)
	self:newScheduleOnce(handler(self, function()
		self.m_knightList:setTouchable(true)
		self.m_skinComp:setTouchable(true)
	end), 0.05)

	local var_11_0 = {
		resId = var_0_2:getKnightResInfo({
			knightId = self._assistantId,
			skinId = self._assistantDressId
		}).painted_id
	}

	var_11_0.isShowBg = true

	self.m_assistantSpine:removeChildren()
	self.m_assistantSpine:addChild((DrawKnight.new(var_11_0)))
end

function AssistantMainLayer:_updateKnightList(arg_13_1)
	if self._knightList[arg_13_1] == nil then
		self._knightList[arg_13_1] = arg_13_1 ~= 0 and var_0_2:getOwnKnightListWithOutMain(arg_13_1) or var_0_2:getOwnerList()
	end

	self:_sortKnightList(self._knightList[arg_13_1])

	self._selectedKnightList = self._knightList[arg_13_1]

	local var_13_0 = #self._selectedKnightList

	self.m_knightList:setNumItems(#self._selectedKnightList)
	self.m_knightList:transitionShowCells("listIconUiScaleIn", 0.06)
	self.m_isEmptyController:setSelectedIndex(var_13_0 > 0 and 0 or 1)
end

function AssistantMainLayer:_sortKnightList(arg_14_1)
	table.sort(arg_14_1, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:getBaseInfo()

		if var_15_0.advance_id == self._useAssistantId then
			return true
		end

		local var_15_1 = arg_15_1:getBaseInfo()

		if var_15_1.advance_id == self._useAssistantId then
			return false
		end

		if var_15_0.quality ~= var_15_1.quality then
			return var_15_0.quality > var_15_1.quality
		end

		return var_15_0.advance_id < var_15_1.advance_id
	end)
end

function AssistantMainLayer:_onKnightRenderer(arg_16_1, arg_16_2)
	if self._selectedKnightList then
		arg_16_2:updateIcon(self._selectedKnightList[arg_16_1 + 1], self._useAssistantId, self._assistantId)
	end
end

function AssistantMainLayer:_updateDressComp()
	self._skinList = var_0_3:getOwnKnightSkins(self._assistantId) or {}

	self.m_skinComp:initComp({
		skinList = self._skinList,
		knight = var_0_2:getKnight({
			base_id = self._assistantId
		}),
		skinId = self._selectedSkinList[self._assistantId]
	})
end

function AssistantMainLayer:_changeGroup()
	local var_18_0 = self.m_groupList:getSelectedIndex()

	if not self._selectedGroup or self._selectedGroup ~= var_18_0 then
		self._selectedGroup = var_18_0

		self:_updateKnightList(var_18_0)
	end
end

function AssistantMainLayer:_changeKnight()
	local var_19_0 = self._selectedKnightList[self.m_knightList:getSelectedIndex() + 1]:getBaseInfo().advance_id

	if self._assistantId == var_19_0 then
		return
	else
		self._assistantId = var_19_0
	end

	self:_updateKnightSpine()
	self:_updateDressComp()
end

function AssistantMainLayer:_onSelectedAssistant()
	if not self._assistantId or not self._assistantDressId then
		return
	end

	if self._assistantId == self._useAssistantId and self._assistantDressId == self._useAssistantDressId then
		return
	end

	g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
		type = 5,
		frame = self._assistantId,
		sk_dress = self._assistantDressId
	})
end

function AssistantMainLayer:_onChangePosition()
	self.m_backTransition:play(handler(self, function()
		self:dispatchCompEvent("Assistant_ChangePosition")
		g.core.module.ModuleManager:popComponent()
	end))
end

function AssistantMainLayer:_onChangeScene()
	self.m_backTransition:play(handler(self, function()
		self:dispatchCompEvent("Assistant_ChangeScene")
		g.core.module.ModuleManager:popComponent()
	end))
end

function AssistantMainLayer:_refreshLayer()
	local var_25_0 = g.core.model.User:getAssistantId()
	local var_25_1 = g.core.model.User:getAssistantDressId()

	if self._useAssistantId ~= var_25_0 or self._useAssistantDressId ~= var_25_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		local var_25_2 = AssistantCommon.getAssistantData()

		var_25_2.assistantId = var_25_0
		var_25_2.skinId = var_25_1

		AssistantCommon.setAssistantData(var_25_2)
	end

	self:_updateLayer()
end

return AssistantMainLayer
