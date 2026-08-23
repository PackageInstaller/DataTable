local var_0_0 = g.core.const.ConstMgr.FormationConst
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.model.User.gveDataMgr
local var_0_3 = g.core.model.User.petsData
local var_0_4 = g.core.model.User.succubaData
local var_0_5 = g.core.model.User.uniteTokenData
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = g.core.const.ConstMgr.LineUpConst
local GveFormationPresetLayer = class("GveFormationPresetLayer", require("app.fairyGUI.gve.UI_GveFormationPresetLayer"), function()
	return fgui.GComponent:create({
		resName = "GveFormationPresetLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveFormationPresetLayer:ctor(arg_2_1)
	self._formationData = var_0_2:getGveFormationData()
	self._touchStep = 0
	self._touchIndex = 0
	self._selectedComp = nil
	self._moveComp = nil
	self._isTouched = false
	self._curFormationIndex = arg_2_1 or 1
	self._curFormationStruct = nil
	self._isClickReturn = false
	self._isClickHome = false

	self:_initView()
end

function GveFormationPresetLayer:_initView()
	self.m_topBar:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_FORMATION_LAYER)
	self:addBg("bg/gve/bg_pshc_1.jpg")
	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
	self.m_topBar:setHomeCallBack(handler(self, self._onClickHome))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSaveBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_bottomComp:initComp()
	self.m_enterTransition:play()
end

function GveFormationPresetLayer:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "gve_preset_formation_click_add_knight" then
		self._curSelectPos = arg_4_2.pos

		var_0_6:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
			itemUrl = "ui://gve/GveLineUpKnightCell",
			isFilter = true,
			allList = self._formationData:getAllEquipKnightStruct(),
			isLineUpCall = handler(self, self._isLineupCall),
			clickCheckFunc = handler(self, self._clickLineup),
			gotoStr = g.core.lang:get(309188),
			cellParam = {
				formationStruct = self._curFormationStruct
			}
		}), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_4_1 == "gve_formation_click_add_unite" then
		self._curSelectPos = arg_4_2.pos

		var_0_6:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpUnitePop").new({
			itemUrl = "ui://gve/GveLineUpUniteTokenCell",
			allList = var_0_5:getOwnTokenList(),
			isLineUpCall = handler(self, self._isLineupUniteCall),
			clickCheckFunc = handler(self, self._clickLineupUnite),
			cellParam = {
				formationStruct = self._curFormationStruct
			}
		}), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_4_1 == "gve_formation_click_add_pet" then
		self._curSelectPos = arg_4_2.pos

		var_0_6:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpPetPop").new({
			itemUrl = "ui://gve/GveLineUpPetCell",
			isFilter = true,
			allList = var_0_3:getOwnPetArr(),
			isLineUpCall = handler(self, self._isLineupPetCall),
			clickCheckFunc = handler(self, self._clickLineupPet),
			cellParam = {
				formationStruct = self._curFormationStruct
			}
		}), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_4_1 == "gve_formation_click_add_succuba" then
		self._curSelectPos = arg_4_2.pos

		var_0_6:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
			itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
			isFilter = true,
			allList = var_0_4:getSuccubaList(),
			isLineUpCall = handler(self, self._isLineupSuccubaCall),
			clickCheckFunc = handler(self, self._clickLineupSuccuba),
			cellParam = {
				formationStruct = self._curFormationStruct
			}
		}), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_4_1 == "gve_click_preset_formation_index" then
		local var_4_0 = arg_4_2.formationIndex

		if arg_4_2.formationIndex ~= self._curFormationIndex then
			if self._curFormationStruct:isChangeFormation() then
				self:_openConfirmPop(function()
					self:setFormationIndexAndUpdateView(var_4_0)
				end, function()
					self._curFormationStruct:resetSvrData()
					self:setFormationIndexAndUpdateView(var_4_0)
				end)
			else
				self:setFormationIndexAndUpdateView(arg_4_2.formationIndex)
			end
		end
	elseif arg_4_1 == "common_lineup_knight_pop_goto" then
		if self._curFormationStruct:isChangeFormation() then
			self:_openConfirmPop(handler(self, self.pushSelectKnightPop), handler(self, self.pushSelectKnightPop))
		else
			self:pushSelectKnightPop()
		end
	end
end

function GveFormationPresetLayer:pushSelectKnightPop()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.Recruit_Jiesuan_Single_01)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_SELECT_KNIGHT)
end

function GveFormationPresetLayer:_isLineupPetCall(arg_8_1)
	return self._curFormationStruct:isPetLineUp(arg_8_1:getSid())
end

function GveFormationPresetLayer:_clickLineupPet(arg_9_1)
	if self._curSelectPos > 0 then
		self._curFormationStruct:lineupPet(self._curSelectPos, arg_9_1:getSid())
	end

	self.m_bottomComp:updatePresetBottomPetComp()

	return true
end

function GveFormationPresetLayer:_isLineupUniteCall(arg_10_1)
	return self._curFormationStruct:isUniteTokenLineUp(arg_10_1:getServerId())
end

function GveFormationPresetLayer:_clickLineupUnite(arg_11_1)
	if self._curSelectPos > 0 then
		self._curFormationStruct:lineupUniteToken(self._curSelectPos, arg_11_1:getAdvanceId())
	end

	self.m_bottomComp:updatePresetBottomUniteComp()

	return true
end

function GveFormationPresetLayer:_isLineupSuccubaCall(arg_12_1)
	return self._curFormationStruct:isSuccubaLineUp(arg_12_1:getSid())
end

function GveFormationPresetLayer:_clickLineupSuccuba(arg_13_1)
	if self._curSelectPos > 0 then
		self._curFormationStruct:lineupSuccuba(self._curSelectPos, arg_13_1:getSid())
	end

	self.m_bottomComp:updatePresetBottomComp()

	return true
end

function GveFormationPresetLayer:_clickLineup(arg_14_1)
	if self._curSelectPos > 0 then
		if arg_14_1:isElementLeader() then
			local var_14_0 = arg_14_1:getServerId()
			local var_14_1 = self._curFormationStruct:getKnightStationPos(var_14_0)

			for iter_14_0, iter_14_1 in ipairs((self._curFormationStruct:getKnightSidArr())) do
				if iter_14_1 > 0 and iter_14_1 ~= var_14_0 and iter_14_0 ~= self._curSelectPos and iter_14_0 ~= var_14_1 then
					local var_14_2 = self._formationData:getKnightByServerId(iter_14_1)

					if var_14_2 and var_14_2:isElementLeader() then
						var_0_6:tip(g.core.lang:get(200051))

						return false
					end
				end
			end
		end

		self._curFormationStruct:lineupKnight(self._curSelectPos, arg_14_1:getServerId())
	end

	self:updateKnightView()

	return true
end

function GveFormationPresetLayer:_isLineupCall(arg_15_1)
	return (self._curFormationStruct:isKnightLineUp(arg_15_1:getServerId()))
end

function GveFormationPresetLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_FLUSH, handler(self, self._onS2CPresetFormationFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_SAVE, handler(self, self._onS2CPresetFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, handler(self, self._onS2CPresetFormationSaveError), self)
	self._formationData:refreshAllKnightArtifact()

	if self._formationData:isGetPresetFormationData() then
		self:setFormationIndexAndUpdateView(self._curFormationIndex)
		self.m_teamDropList:updateListView()
	else
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Flush({
			tp = var_0_0.PRESET_FORMATION_TYPE.GVE
		})
	end

	self:checkFormationGuide()
end

function GveFormationPresetLayer:_onS2CPresetFormationFlush()
	self:setFormationIndexAndUpdateView(self._curFormationIndex)
	self.m_teamDropList:updateListView()
end

function GveFormationPresetLayer:_onS2CPresetFormationSaveError()
	self:setFormationIndexAndUpdateView(self._curFormationIndex)
	self:updateViewState()
end

function GveFormationPresetLayer:_onS2CPresetFormationSave()
	g.core.module.ModuleManager:tip(g.core.lang:get(308504))
	self:setFormationIndexAndUpdateView(self._curFormationIndex)
	self:updateViewState()
end

function GveFormationPresetLayer:updateViewState()
	if self._isClickReturn then
		self:newScheduleOnce(handler(self, self.closeView), 0)
	elseif self._isClickHome then
		self:newScheduleOnce(handler(self, self.switchHome), 0)
	end
end

function GveFormationPresetLayer:setFormationIndexAndUpdateView(arg_21_1)
	self._curFormationIndex = arg_21_1
	self._curFormationStruct = self._formationData:getPresetFormationStruct(self._curFormationIndex)

	self.m_bottomComp:setPresetFormationStruct(self._curFormationStruct)
	self:updatePreciousSuitBtn()
	self:updateKnightView()
	self.m_bottomComp:updatePresetBottomComp()
	self.m_teamDropList:setShowText(g.core.lang:get(309185, {
		index = self._curFormationIndex
	}))
end

function GveFormationPresetLayer:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 294)
		end

		self._preciousSuitBtn:setBtnFormationData(var_0_7.MulTeamType.PRE_FORMATION, self._curFormationIndex, var_0_0.PRESET_FORMATION_TYPE.GVE)
	end
end

function GveFormationPresetLayer:updateKnightView()
	for iter_23_0 = 1, var_0_1.LINEUP_MAX do
		local var_23_0 = self._curFormationStruct:getKnightSid(iter_23_0)

		self["m_knight" .. iter_23_0]:updateCompByPosAndKnight(iter_23_0, self._formationData:getKnightByServerId(var_23_0), self._formationData:getArtifactByKnightSid(var_23_0))
	end
end

function GveFormationPresetLayer:checkPosInComp(arg_24_1, arg_24_2, arg_24_3)
	for iter_24_0 = 1, var_0_1.LINEUP_MAX do
		if self["m_knight" .. iter_24_0] and self["m_knight" .. iter_24_0]:containPoint(arg_24_1) then
			if arg_24_3 then
				self["m_knight" .. iter_24_0]:setCompTouch(true)
			end

			if arg_24_2 or self["m_knight" .. iter_24_0]:hasKnight() then
				return iter_24_0, self["m_knight" .. iter_24_0]
			else
				return 0
			end
		end
	end

	return 0
end

function GveFormationPresetLayer:_onTouchBegin(arg_25_1)
	if self._isTouched then
		return
	end

	arg_25_1:captureTouch()

	local var_25_0 = arg_25_1:getInput():getTouch():getLocation()

	if self.m_isShowDropListController:getSelectedIndex() == 1 and not self.m_teamDropList:checkPosIsInComp(var_25_0) then
		self.m_isShowDropListController:setSelectedIndex(0)
	end

	self._touchStep = 0

	local var_25_1, var_25_2 = self:checkPosInComp(var_25_0, false, true)

	if var_25_1 > 0 and var_25_2 then
		self._isTouched = true
		self._touchIndex = var_25_1
		self._selectedComp = var_25_2

		if not self._moveComp then
			self._moveComp = fgui.UIPackage:createObject("gve", "GveFormationPresetKnightComp")

			self._moveComp:setTouchable(false)
			self:addChild(self._moveComp, 1)
		end

		self._moveComp:setVisible(false)

		local var_25_3 = self._curFormationStruct:getKnightSid(var_25_1)

		self._moveComp:updateCompByPosAndKnight(var_25_1, self._formationData:getKnightByServerId(var_25_3), self._formationData:getArtifactByKnightSid(var_25_3))

		local var_25_4 = var_25_2:getPosition()

		self._moveComp:setPosition(var_25_4)

		self._movePos = var_25_4

		arg_25_1:captureTouch()
	end
end

function GveFormationPresetLayer:_onTouchMove(arg_26_1)
	if not self._isTouched then
		return
	end

	local var_26_0 = arg_26_1:getInput():getTouch():getDelta()

	self._movePos.x = self._movePos.x + var_26_0.x
	self._movePos.y = self._movePos.y - var_26_0.y

	self._moveComp:setPosition(self._movePos)

	self._touchStep = self._touchStep + 1

	if self._touchStep > 6 then
		if self._selectedComp then
			self._selectedComp:setCompTouch(false)
			self._selectedComp:updateCompByPosAndKnight(0, nil, nil)

			self._selectedComp = nil
		end

		if self._moveComp then
			self._moveComp:setVisible(true)
		end
	end
end

function GveFormationPresetLayer:_onTouchEnd(arg_27_1)
	if self._isTouched then
		self._isTouched = false

		self._moveComp:setVisible(false)

		if self._touchIndex > 0 then
			local var_27_0, var_27_1 = self:checkPosInComp(arg_27_1:getInput():getTouch():getLocation(), true, false)

			if var_27_0 ~= self._touchIndex then
				if var_27_0 > 0 then
					self._curFormationStruct:lineupKnight(var_27_0, (self._curFormationStruct:getKnightSid(self._touchIndex)))
				else
					self._curFormationStruct:lineupKnight(self._touchIndex, 0)
				end
			end

			self._touchIndex = 0

			self:updateKnightView()
		end
	else
		self.m_bottomComp:checkIsTouchEnd(arg_27_1)
	end
end

function GveFormationPresetLayer:_onClickSaveBtn()
	if self._curFormationStruct:isChangeFormation() then
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
			formations = {
				(self._curFormationStruct:toOutBaseFormation())
			}
		})
		self._formationData:setNeedSaveFormation(self._curFormationStruct)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308504))
	end
end

function GveFormationPresetLayer:_openConfirmPop(arg_29_1, arg_29_2)
	local var_29_0

	if self._isClickHome or self._isClickReturn then
		do return end

		var_29_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	local var_29_1 = require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(309186),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
				formations = {
					(self._curFormationStruct:toOutBaseFormation())
				}
			})
			self._formationData:setNeedSaveFormation(self._curFormationStruct)

			if arg_29_1 then
				arg_29_1()
			end
		end,
		onCancel = arg_29_2
	})

	var_0_6:pushPopup(var_29_1)
	var_29_1:updateConfirmBtnText(g.core.lang:get(309187))
end

function GveFormationPresetLayer:_onClickClose()
	if self._curFormationStruct:isChangeFormation() then
		self:_openConfirmPop(handler(self, self.clickReturnClose), handler(self, self.closeView))
	else
		self:closeView()
	end
end

function GveFormationPresetLayer:_onClickHome()
	if self._curFormationStruct:isChangeFormation() then
		self:_openConfirmPop(handler(self, self.clickHomeClose), handler(self, self.switchHome))
	else
		self:switchHome()
	end
end

function GveFormationPresetLayer:clickReturnClose()
	self._isClickReturn = true
end

function GveFormationPresetLayer:clickHomeClose()
	self._isClickHome = true
end

function GveFormationPresetLayer:closeView()
	for iter_35_0 = 1, var_0_1.LINEUP_MAX do
		self["m_knight" .. iter_35_0]:setVisible(false)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GveFormationPresetLayer:switchHome()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GveFormationPresetLayer:checkFormationGuide()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "GVE_FORMATION",
			objects = {
				[2] = self.m_knight1,
				[3] = self.m_saveBtn,
				[4] = self.m_teamDropList
			}
		})
	end, 0)
end

return GveFormationPresetLayer
