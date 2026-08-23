local AssistantAdvMainLayer = class("AssistantAdvMainLayer", require("app.fairyGUI.assistant.UI_AssistantAdvMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "assistant",
		isFullScreen = true,
		pkgPath = "ui/assistant/assistant",
		resName = "AssistantAdvMainLayer"
	})
end)
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.model.User.skinData
local var_0_4 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_MAX_NOMINATE_NUM).parameter

function AssistantAdvMainLayer:ctor()
	self._selectedGroup = 0
	self._knightList = {}
	self._selectedKnightList = {}
	self._nominateList = {}
	self._curSelAdvanceId = 0
	self._tempSelSkinId = {}

	self:_initBtn()
	self:_initComp()
end

function AssistantAdvMainLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeBgBtn
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOW_KNIGHT_SET, self._onS2CShowKnightSet, self)
	self:_updateLayer()
	self.m_enterTransition:play()
	self:_selectKnight()
end

function AssistantAdvMainLayer:onUnload()
	g.core.network.GameNetProxy:send_C2S_ShowKnight_Set({
		show_knights = g.core.model.User:packNominateServerList()
	})
end

function AssistantAdvMainLayer:_initBtn()
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._selectGroup))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._selectKnight))
	self.m_nominateBtn:addClickListener(handler(self, self._onNominateBtnClick))
	self.m_changePosBtn:addClickListener(handler(self, self._onChangePosBtnClick))
	self.m_changeBgBtn:addClickListener(handler(self, self._onChangeBgBtnClick))
end

function AssistantAdvMainLayer:_initComp()
	self:addListen(self.m_skinComp)
	self.m_groupList:setSelectedIndex(0)
	self.m_runBanner:init({
		width = 88,
		index = 1,
		target = self.m_groupList
	})
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListRenderer))
end

function AssistantAdvMainLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "AssistantSkinSwitch" then
		if arg_7_2.knight then
			self._tempSelSkinId[self._curSelAdvanceId] = 0

			g.core.model.User:updateNominateInfo(self._curSelAdvanceId, {
				skinId = 0
			})
			self:_updateKnightSpine()
			self.m_skinComp:updateAllCellIsInUse()
		elseif arg_7_2.skin then
			self._tempSelSkinId[self._curSelAdvanceId] = arg_7_2.skin.id

			g.core.model.User:updateNominateInfo(self._curSelAdvanceId, {
				skinId = arg_7_2.skin.id
			})
			self:_updateKnightSpine()
			self.m_skinComp:updateAllCellIsInUse()
		end
	end
end

function AssistantAdvMainLayer:_updateLayer()
	self._nominateList = g.core.model.User:getNominateList()
	self._curSelAdvanceId = self._nominateList[1].advanceId

	self:_updateKnightList(self._selectedGroup)
	self:_updateKnightSpine()
	self:_updateDressComp()
	self:_updateBg()
end

function AssistantAdvMainLayer:_updateKnightSpine(arg_9_1)
	if self._curSelAdvanceId == arg_9_1 then
		self:_updateKnightNominateState()

		return
	end

	self._curSelAdvanceId = arg_9_1 or self._curSelAdvanceId

	self:_updateKnightNominateState()
	self.m_knightList:setTouchable(false)
	self.m_skinComp:setTouchable(false)
	self:newScheduleOnce(handler(self, function()
		self.m_knightList:setTouchable(true)
		self.m_skinComp:setTouchable(true)
	end), 0.05)

	local var_9_0 = {
		knightId = self._curSelAdvanceId
	}

	var_9_0.skinId = self._tempSelSkinId[self._curSelAdvanceId] or g.core.model.User:getNominateInfo(self._curSelAdvanceId).skinId

	local var_9_1 = var_0_2:getKnightResInfo(var_9_0)

	self.m_assistantSpine:removeChildren()
	self.m_assistantSpine:addChild((DrawKnight.new({
		isShowBg = true,
		resId = var_9_1.painted_id,
		baseInfo = var_9_1
	})))
end

function AssistantAdvMainLayer:_updateKnightNominateState()
	local var_11_0 = 0

	if g.core.model.User:isInNominateList(self._curSelAdvanceId) ~= 0 then
		var_11_0 = 1

		if self._tempSelSkinId[self._curSelAdvanceId] and self._tempSelSkinId[self._curSelAdvanceId] ~= 0 then
			g.core.model.User:updateNominateInfo(self._curSelAdvanceId, {
				skinId = self._tempSelSkinId[self._curSelAdvanceId]
			})
		end
	end

	self.m_isNominateController:setSelectedIndex(var_11_0)
end

function AssistantAdvMainLayer:_updateDressComp()
	local var_12_0 = var_0_3:getOwnKnightSkins(self._curSelAdvanceId) or {}

	self.m_skinComp:initComp({
		skinList = var_12_0,
		knight = var_0_2:getKnight({
			base_id = self._curSelAdvanceId
		}),
		skinId = g.core.model.User:getNominateInfo(self._curSelAdvanceId).skinId
	})
end

function AssistantAdvMainLayer:_updateBg()
	local var_13_0 = g.core.common.Path:getHomeBackground(g.core.config.bg_book_info.get(g.core.model.User:getNominateInfo(self._curSelAdvanceId).bg).pic)

	if not self.m_bgLoader then
		self.m_bgLoader = self:addBg(var_13_0)
	else
		self.m_bgLoader:setURL(var_13_0)
	end
end

function AssistantAdvMainLayer:_updateKnightList(arg_14_1)
	if self._knightList[arg_14_1] == nil then
		self._knightList[arg_14_1] = arg_14_1 ~= 0 and var_0_2:getOwnKnightListWithOutMain(arg_14_1) or var_0_2:getOwnerList()
	end

	local var_14_0 = {}

	if arg_14_1 == 0 then
		var_14_0 = self._knightList[arg_14_1]
	else
		local var_14_1 = {}

		for iter_14_0, iter_14_1 in ipairs((g.core.model.User:getNominateList())) do
			var_14_1[iter_14_1.advanceId] = true
		end

		for iter_14_2, iter_14_3 in ipairs(self._knightList[arg_14_1]) do
			var_14_0[iter_14_2] = iter_14_3

			local var_14_2 = iter_14_3:getAdvanceId()

			if var_14_1[var_14_2] then
				var_14_1[var_14_2] = nil
			end
		end

		for iter_14_4, iter_14_5 in pairs(var_14_1) do
			var_14_0[#var_14_0 + 1] = var_0_2:getKnight({
				advance_id = iter_14_4
			})
		end
	end

	self:_sortKnightList(var_14_0)

	self._selectedKnightList = var_14_0

	local var_14_3 = #self._selectedKnightList

	self.m_knightList:setNumItems(#self._selectedKnightList)
	self.m_knightList:transitionShowCells("listIconUiScaleIn", 0.06)
	self.m_isEmptyController:setSelectedIndex(var_14_3 > 0 and 0 or 1)
end

function AssistantAdvMainLayer:_sortKnightList(arg_15_1)
	table.sort(arg_15_1, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:getBaseInfo()
		local var_16_1 = arg_16_1:getBaseInfo()
		local var_16_2 = g.core.model.User:isInNominateList(var_16_0.advance_id)
		local var_16_3 = g.core.model.User:isInNominateList(var_16_1.advance_id)

		if var_16_2 > 0 then
			local var_16_4 = var_0_4 + 1 - var_16_2 or 0

			if var_16_3 > 0 then
				local var_16_5 = var_0_4 + 1 - var_16_3 or 0

				if var_16_4 ~= var_16_5 then
					return var_16_5 < var_16_4
				end

				if var_16_0.quality ~= var_16_1.quality then
					return var_16_0.quality > var_16_1.quality
				end
			end
		end

		return var_16_0.advance_id < var_16_1.advance_id
	end)
end

function AssistantAdvMainLayer:_onKnightListRenderer(arg_17_1, arg_17_2)
	arg_17_2:updateIcon(self._selectedKnightList[arg_17_1 + 1], 0, self._curSelAdvanceId)
	arg_17_2:setNominate((g.core.model.User:isInNominateList(self._selectedKnightList[arg_17_1 + 1]:getBaseInfo().advance_id)))
end

function AssistantAdvMainLayer:_selectGroup()
	local var_18_0 = self.m_groupList:getSelectedIndex()

	if self._selectedGroup ~= var_18_0 then
		self._selectedGroup = var_18_0

		self:_updateKnightList(var_18_0)
	end
end

function AssistantAdvMainLayer:_selectKnight()
	local var_19_0 = self._selectedKnightList[self.m_knightList:getSelectedIndex() + 1]:getBaseInfo().advance_id

	self:_updateKnightSpine(var_19_0)

	if false then
		local var_19_1 = g.core.model.User:isInNominateList(var_19_0)

		if var_19_1 > 0 then
			if #self._nominateList == 1 then
				g.core.module.ModuleManager:tip(g.core.lang:get(100543))

				return
			else
				self._tempSelSkinId[var_19_0] = 0
				self._nominateList = g.core.model.User:removeNominateByIndex(var_19_1)

				self:updateNominateNum()

				return
			end
		elseif #self._nominateList >= var_0_4 then
			g.core.module.ModuleManager:tip(g.core.lang:get(100544))

			return
		else
			self._nominateList = g.core.model.User:insertNominateByAdvanceId(var_19_0)

			self:updateNominateNum()

			return
		end
	else
		self:_updateDressComp()
		self:_updateBg()
	end
end

function AssistantAdvMainLayer:_onNominateBtnClick()
	local var_20_0 = self.m_isNominateController:getSelectedIndex()

	if var_20_0 == 0 then
		self:_onChangeToNominate(self._curSelAdvanceId)
	elseif var_20_0 == 1 then
		self:_onChangeToIdle(self._curSelAdvanceId)
	end
end

function AssistantAdvMainLayer:_onChangeToNominate(arg_21_1)
	if #g.core.model.User:getNominateList() >= var_0_4 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100544))

		return
	end

	g.core.model.User:insertNominateByAdvanceId(arg_21_1)
	g.core.network.GameNetProxy:send_C2S_ShowKnight_Set({
		show_knights = g.core.model.User:packNominateServerList()
	})
end

function AssistantAdvMainLayer:_onChangeToIdle(arg_22_1)
	if #self._nominateList == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100543))

		return
	end

	g.core.model.User:removeNominateByIndex((g.core.model.User:isInNominateList(arg_22_1)))
	g.core.network.GameNetProxy:send_C2S_ShowKnight_Set({
		show_knights = g.core.model.User:packNominateServerList()
	})
end

function AssistantAdvMainLayer:updateNominateNum(arg_23_1)
	if arg_23_1 then
		self:_sortKnightList(self._selectedKnightList)
	end

	self.m_knightList:setNumItems(#self._selectedKnightList)
	self.m_nominateBtn:setTitle((g.core.lang:get(100542, {
		cur = #self._nominateList,
		max = var_0_4
	})))
end

function AssistantAdvMainLayer:_onChangePosBtnClick()
	if g.core.model.User:isInNominateList(self._curSelAdvanceId) == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100547))

		return
	end

	self.m_backTransition:play(handler(self, function()
		self:dispatchCompEvent("Assistant_ChangePosition", {
			advanceId = self._curSelAdvanceId,
			skinId = self._tempSelSkinId[self._curSelAdvanceId]
		})
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:popComponent()
		end, 0)
	end))
end

function AssistantAdvMainLayer:_onChangeBgBtnClick()
	if g.core.model.User:isInNominateList(self._curSelAdvanceId) == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100547))

		return
	end

	self.m_backTransition:play(handler(self, function()
		self:dispatchCompEvent("Assistant_ChangeScene", {
			advanceId = self._curSelAdvanceId,
			skinId = self._tempSelSkinId[self._curSelAdvanceId]
		})
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:popComponent()
		end, 0)
	end))
end

function AssistantAdvMainLayer:_onS2CShowKnightSet(arg_30_1, arg_30_2, arg_30_3)
	self._nominateList = g.core.model.User:getNominateList()

	self:_updateKnightList(self._selectedGroup)
	self:_updateKnightSpine(self._curSelAdvanceId)
end

return AssistantAdvMainLayer
