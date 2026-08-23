local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.LineUpConst
local var_0_3 = g.core.const.ConstMgr.PetConst.LINEUP_MAX
local var_0_4 = g.core.model.User.petsData
local var_0_5 = g.core.common.ModuleUnlock
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.module.ModuleManager
local LineUpPetMainLayer = class("LineUpPetMainLayer", require("app.fairyGUI.lineUp.UI_LineUpPetMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "lineUp",
		isFullScreen = true,
		pkgPath = "ui/lineUp/lineUp",
		resName = "LineUpPetMainLayer"
	}, ...)
end)

function LineUpPetMainLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._selectedIdxCpp = math.clamp(arg_2_1.index or 0, 0, var_0_3)
	self._backFromCultivation = false
	self._firstIn = true
	self._listPos = self.m_lineUpList:getPosition()
	self._petSidDict = {}

	self:_initView()
end

function LineUpPetMainLayer:_initView()
	self:_initTransParams()
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_topBar:setResInfoById(var_0_2.TopBarId)
	self.m_lineUpList:setVirtual()
	self.m_lineUpList:doFairyBatching(false)
	self.m_lineUpList:setItemRenderer(handler(self, self._onLineUpItemRenderer))
	self.m_lineUpList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickLineUpItem))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_gotoKnightLineupBtn:addClickListener(handler(self, self._onClickGotoKnightLineupBtn))
end

function LineUpPetMainLayer:_initTransParams()
	local var_4_0 = {
		self._listPos.x - 40,
		self._listPos.y
	}
	local var_4_1 = {
		self._listPos.x,
		self._listPos.y
	}

	self.m_enterTransition:changeParams({
		startFlag = var_4_0,
		endFlag = var_4_1
	})
	self.m_backTransition:changeParams({
		startFlag = var_4_1,
		endFlag = var_4_0
	})
end

function LineUpPetMainLayer:onLoad()
	var_0_6:addEventListener(var_0_0.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onS2CChangeFormation, self)
	var_0_6:addEventListener(var_0_0.EVENT_NET_S2C_PET_INHERITFORMATION, self._onS2CInheritFormation, self)
	var_0_6:addEventListener(var_0_0.EVENT_SELECTED_PET_CHANGE, self._onSelectedIdxChanged, self)
	var_0_6:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_formationBtn
	})
	var_0_6:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_gotoKnightLineupBtn
	})

	self._firstIn = true

	self:_updateData()
	self:_updateView(self._selectedIdxCpp, true)
end

function LineUpPetMainLayer:onUnload()
	return
end

function LineUpPetMainLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "COMP_EVENT_ENTER_ANI_END" then
		-- block empty
	elseif arg_7_1 == "COMP_EVENT_ENTER_DEVELOP_LAYER" then
		self._backFromCultivation = true
	end
end

function LineUpPetMainLayer:_onSelectedIdxChanged(arg_8_1, arg_8_2)
	self:_updateView(arg_8_2 - 1, true)
end

function LineUpPetMainLayer:_onS2CChangeFormation(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.tp ~= g.core.network.proto.TYPE_PET then
		return
	end

	if self:_getSelectedSid() > 0 then
		var_0_7:tip(g.core.lang:get(200006))
	else
		var_0_7:tip(g.core.lang:get(200007))
	end

	self:_updateData()
	self:_updateView(arg_9_3.pos - 1, true)
end

function LineUpPetMainLayer:_onS2CInheritFormation(arg_10_1, arg_10_2, arg_10_3)
	var_0_7:tip(g.core.lang:get(200013))
	self:_updateData()
	self:_updateView(arg_10_3.pos - 1, true)

	if arg_10_3.award then
		var_0_7:awardSummary(arg_10_3.award, false, nil, g.core.lang:get(200014))
	end
end

function LineUpPetMainLayer:_onLineUpItemRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCell({
		pos = arg_11_1 + 1,
		sid = self._petSidDict[arg_11_1 + 1]
	})
end

function LineUpPetMainLayer:_onClickLineUpItem(arg_12_1)
	local var_12_0 = self.m_lineUpList:getSelectedIndex()

	if var_12_0 == self._selectedIdxCpp then
		if (self._petSidDict[var_12_0 + 1] or 0) == 0 then
			self.m_petMainComp:onClickAddBtn()
		end

		return
	end

	var_0_6:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)

	local var_12_2 = self:_getLineupFuncId(var_12_0 + 1)

	if var_0_5:isModuleUnlock(var_12_2) then
		self:_updateView(var_12_0, false)
	else
		self.m_lineUpList:setSelectedIndex(self._selectedIdxCpp)
		var_0_7:tip(g.core.lang:get(200001, {
			level = var_0_5:getModuleUnlockLevel(var_12_2)
		}))
	end
end

function LineUpPetMainLayer:_onFormationBtnClick()
	var_0_7:pushModule(g.view.entrance.FORMATION)
end

function LineUpPetMainLayer:_onClickGotoKnightLineupBtn()
	var_0_7:replaceModule(g.view.entrance.LINE_UP)
end

function LineUpPetMainLayer:_updateData()
	self._petSidDict = var_0_4:getLineupSidDict()

	self:_sortLineupSidArr(self._petSidArr)
end

function LineUpPetMainLayer:_sortLineupSidArr(arg_16_1)
	if not arg_16_1 or #arg_16_1 < 2 then
		return
	end

	table.sort(arg_16_1, function(arg_17_0, arg_17_1)
		local var_17_0 = var_0_4:getPetBySid(arg_17_0)
		local var_17_1 = var_0_4:getPetBySid(arg_17_1)

		if var_17_0 and var_17_1 then
			return var_17_0:getLineupPos() < var_17_1:getLineupPos()
		else
			return checkbool(var_17_0)
		end
	end)
end

function LineUpPetMainLayer:_updateView(arg_18_1, arg_18_2)
	self._selectedIdxCpp = arg_18_1

	if arg_18_2 then
		self.m_lineUpList:setNumItems(var_0_3)
		self.m_lineUpList:setSelectedIndex(arg_18_1)
		self.m_lineUpList:transitionShowCells("enter", 0.06)
	end

	self:_updateMainComp(arg_18_1)
end

function LineUpPetMainLayer:_updateMainComp(arg_19_1)
	self.m_petMainComp:updateComp(arg_19_1 + 1, self._petSidDict[arg_19_1 + 1])

	if self._firstIn then
		self._firstIn = false

		if self._backFromCultivation then
			self._backFromCultivation = false

			self.m_petMainComp:playEnterAni(var_0_2.EnterAniType.ENTER_FROM_CULTIVATE)
		else
			self.m_petMainComp:playEnterAni(var_0_2.EnterAniType.ENTER)
		end
	else
		self.m_petMainComp:playEnterAni(var_0_2.EnterAniType.ENTER)
	end
end

function LineUpPetMainLayer:_getSelectedSid()
	return self._petSidDict[self._selectedIdxCpp + 1] or 0
end

function LineUpPetMainLayer:_getLineupFuncId(arg_21_1)
	return var_0_1.FUNCTION_TYPE[var_0_2.PET_LINE_UP_FUNC_ID_PRE_KEY .. arg_21_1]
end

return LineUpPetMainLayer
