local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.PetConst.DevType
local PetMainCompCfg = require("app.view.module.pet.const.PetMainCompCfg")
local var_0_4 = 300
local var_0_5 = 50
local var_0_6 = g.core.model.User.petsData
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.const.ConstMgr.QUALITY_TYPE
local PetMainLayer = class("PetMainLayer", require("app.fairyGUI.pet.UI_PetMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/pet/pet",
		resName = "PetMainLayer",
		pkgName = "pet",
		isFullScreen = true
	}, ...)
end)

function PetMainLayer:ctor(arg_2_1)
	self._devType = var_0_2.INFO
	self._curPetIdx = 1
	self._petIdxOnEnter = 1
	self._maxPetIdx = 1
	self._oldLv = 1
	self._petSpineX = self.m_petSpineDadComp:getX()
	self._leftPetSpineX = self.m_leftPetSpineDadComp:getX()
	self._rightPetSpineX = self.m_rightPetSpineDadComp:getX()
	self._touchOffsetX = nil
	self._canTouchPet = true
	self._enterAfterCreate = true
	self._isChangeUIAction = false
	self._switching = false
	self._petStruct = nil
	self._showPetArr = {}

	self:_initData(arg_2_1)
	self:_initUI()
end

function PetMainLayer:_initData(arg_3_1)
	arg_3_1 = arg_3_1 or {}

	if not table.keyof(var_0_2, self._devType) then
		self._devType = var_0_2.INFO
	end

	self._petStruct = arg_3_1.petSid and var_0_6:getPetBySid(arg_3_1.petSid) or var_0_6:getPetByPos(1)
	self._oldLv = self._petStruct:getLevel()
	self._showPetArr = self:_getShowPetArr(arg_3_1.onlyLineup)
	self._maxPetIdx = #self._showPetArr

	local var_3_1 = 1

	for iter_3_0, iter_3_1 in ipairs(self._showPetArr) do
		if iter_3_1 == self._petStruct then
			var_3_1 = iter_3_0
		end
	end

	self._curPetIdx = var_3_1
	self._petIdxOnEnter = var_3_1
end

function PetMainLayer:_initUI()
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_topBar:setResInfoById(185)
	self.m_bgLoader:setURL("pic/base_new/bg_yht_rightdi.png")
	self.m_showBtn:addClickListener(handler(self, self._onClickShowBtn))
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftRightBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickLeftRightBtn))
	self.m_domainBtn:addClickListener(handler(self, self._onClickDomainBtn))
	self.m_blankBg:addClickListener(handler(self, self._onClickBlankBg))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	local var_4_0 = self:_isTherePetToChange()

	self.m_leftBtn:setVisible(var_4_0)
	self.m_rightBtn:setVisible(var_4_0)
end

function PetMainLayer:onLoad()
	var_0_7:addEventListener(var_0_0.EVENT_NET_S2C_PET_ONEKEY_LEVELUP, self._onS2CPetLvUp, self)
	var_0_7:addEventListener(var_0_0.EVENT_NET_S2C_PET_STARUP, self._onS2CPetStarUp, self)
	var_0_7:addEventListener(var_0_0.EVENT_NET_S2C_PET_STAGEUP, self._onS2CPetStageUp, self)
	self:updateView(self._curPetIdx)

	if self._enterAfterCreate and self._petStruct:isLineup() then
		self.m_enter_lineupTransition:play()
	else
		self.m_enterTransition:play()
	end

	self._enterAfterCreate = false
end

function PetMainLayer:onUnload()
	self:_onSwitchTransitionEnd()

	if self._curPetIdx ~= self._petIdxOnEnter then
		var_0_7:dispatchEvent(var_0_0.EVENT_SELECTED_PET_CHANGE, true, (self._petStruct:getLineupPos()))
	end
end

function PetMainLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "BaseDevelopPanelComp_tab" then
		self._devType = arg_7_2.tabType

		self.m_topBar:setResInfoById(arg_7_2.tabData.resInfoId)
	elseif arg_7_1 == "lock_switch" then
		-- block empty
	elseif arg_7_1 == "CompEventBigStageUpAniEnd" then
		self:setTouchable(true)
		self:_openStageUpSuccessPop()
	elseif arg_7_1 == "CompEventExpUpAniEnd" then
		self:setTouchable(true)

		if arg_7_2 then
			self:_openLevelUpSuccessPop()
		end
	end
end

function PetMainLayer:_getShowPetArr(arg_8_1)
	local var_8_0 = {}

	if arg_8_1 then
		var_8_0 = var_0_6:getOwnPetArrByFilter(function(arg_9_0)
			return arg_9_0:isLineup()
		end)

		table.sort(var_8_0, function(arg_10_0, arg_10_1)
			return arg_10_0:getLineupPos() < arg_10_1:getLineupPos()
		end)
	else
		var_8_0 = var_0_6:getOwnPetArr()

		table.sort(var_8_0, var_0_6:getSortFunc())
	end

	return var_8_0
end

function PetMainLayer:updateView(arg_11_1)
	self._curPetIdx = arg_11_1
	self._petStruct = self._showPetArr[arg_11_1]
	self._oldLv = self._petStruct:getLevel()

	self.m_nameComp:updateComp(self._petStruct)
	self:_updatePetSpine(self.m_petSpineDadComp, self._petStruct)
	self:_updatePetSpine(self.m_rightPetSpineDadComp, self._showPetArr[(self._curPetIdx < self._maxPetIdx or nil) and (self._curPetIdx + 1 or 1)])
	self.m_rightPetSpineDadComp:setAlpha(0)
	self:_updatePetSpine(self.m_leftPetSpineDadComp, self._showPetArr[(self._curPetIdx > 1 or nil) and (self._curPetIdx - 1 or self._maxPetIdx)])
	self.m_leftPetSpineDadComp:setAlpha(0)
	self:_updateDevPanel()
	self.m_domainBtn:setVisible(self._petStruct:getQuality() >= var_0_8.UR)
	self.m_isHelpClickController:setSelectedIndex(0)
end

function PetMainLayer:_updateDevPanel()
	self.m_devComp:updateDevPanel({
		tabData = PetMainCompCfg.DEV_ARR,
		initTabType = self._devType,
		data = {
			sid = self._petStruct:getSid()
		},
		customData = {
			advId = self._petStruct:getAdvanceId()
		}
	})
end

function PetMainLayer:_updatePetSpine(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:getAdvanceId()
	local var_13_1 = arg_13_1:getChild("DrawPet")

	if var_13_1 and var_13_0 == var_13_1:getAdvId() then
		return
	end

	local var_13_2 = require("app.view.common.DrawPet").new({
		isShowBg = true,
		scale = 1.4,
		advId = var_13_0
	})

	arg_13_1:removeChildren()
	arg_13_1:addChild(var_13_2)

	local var_13_3 = arg_13_1:getSize()

	var_13_2:setPosition(var_13_3.width / 2, var_13_3.height / 2)
end

function PetMainLayer:_onClickLeftRightBtn(arg_14_1)
	if arg_14_1:getSender() == self.m_leftBtn then
		self:_onSwitchLeft(false)
	else
		self:_onSwitchRight(false)
	end
end

function PetMainLayer:_onClickDomainBtn()
	self.m_isHelpClickController:setSelectedIndex(1)
end

function PetMainLayer:_onClickBlankBg()
	self.m_isHelpClickController:setSelectedIndex(0)
end

function PetMainLayer:_onSwitchLeft(arg_17_1)
	if self._switching then
		return
	end

	self._switching = true

	self:setTouchable(false)
	self:updateView((self._curPetIdx - 1 < 1 or nil) and self._maxPetIdx)

	if arg_17_1 then
		self.m_uishowTransition:play(handler(self, self._onSwitchTransitionEnd))
	else
		self.m_left_inTransition:play(handler(self, self._onSwitchTransitionEnd))
	end
end

function PetMainLayer:_onSwitchRight(arg_18_1)
	if self._switching then
		return
	end

	self._switching = true

	self:setTouchable(false)
	self:updateView((self._curPetIdx + 1 > self._maxPetIdx or nil) and 1)

	if arg_18_1 == true then
		self.m_uishowTransition:play(handler(self, self._onSwitchTransitionEnd))
	else
		self.m_right_inTransition:play(handler(self, self._onSwitchTransitionEnd))
	end
end

function PetMainLayer:_onSwitchTransitionEnd()
	self._canTouchPet = true
	self._switching = false

	self:setTouchable(true)
end

function PetMainLayer:_onClickShowBtn()
	self.m_topBar:playHideAction()
	self.m_styleController:setSelectedIndex(1)
end

function PetMainLayer:_onReturnBtnClick()
	self.m_topBar:playShowAction()
	self.m_styleController:setSelectedIndex(0)
end

function PetMainLayer:_onS2CPetLvUp(arg_22_1, arg_22_2, arg_22_3)
	self:setTouchable(false)

	local var_22_0 = self._petStruct:getLevel()
	local var_22_1 = var_22_0 > self._oldLv

	if var_22_0 > self._oldLv then
		self._oldLv = var_22_0

		self.m_nameComp:updateComp(self._petStruct)
	end

	local var_22_2 = self.m_devComp:getDevCompByType(var_0_2.INFO)

	if var_22_2 and var_22_2:isVisible() then
		var_22_2:onS2CPetLvUp(var_22_1)
	elseif var_22_1 then
		self:_openLevelUpSuccessPop()
	end
end

function PetMainLayer:_onS2CPetStarUp(arg_23_1, arg_23_2, arg_23_3)
	var_0_7:dispatchEvent(var_0_0.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "petStarUp",
				func = function()
					return g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetStarUpSuccessPop").new({
						petSid = arg_23_3.id
					}), {
						withoutAni = true,
						touchDisappear = true
					})
				end
			}
		}
	})
	self.m_nameComp:updateComp(self._petStruct)
	self:_updateDevPanel()
end

function PetMainLayer:_onS2CPetStageUp(arg_25_1, arg_25_2, arg_25_3)
	self:setTouchable(false)
	self.m_nameComp:updateComp(self._petStruct)

	local var_25_0 = self.m_devComp:getDevCompByType(var_0_2.ADVANCE)

	if arg_25_3.next_node == 0 then
		if var_25_0 and var_25_0:isVisible() then
			var_25_0:onS2CPetStageUp()
		else
			self:_openStageUpSuccessPop()
		end
	elseif var_25_0 and var_25_0:isVisible() then
		var_25_0:onS2CPetSmallNodeUp()
		self:setTouchable(true)
	end
end

function PetMainLayer:_onTouchBegin(arg_26_1)
	if self.m_styleController:getSelectedIndex() == 1 then
		self:_onReturnBtnClick()

		return
	end

	local var_26_0 = arg_26_1:getInput():getTouch():getLocation()

	if self._canTouchPet and self.m_petSpineDadComp:containPoint(var_26_0) then
		self._touchOffsetX = self._petSpineX - var_26_0.x

		arg_26_1:captureTouch()
	end
end

function PetMainLayer:_onTouchMove(arg_27_1)
	if not self._canTouchPet or not self._touchOffsetX then
		return
	end

	local var_27_0 = arg_27_1:getInput():getTouch():getLocation()
	local var_27_1 = math.abs(var_27_0.x + self._touchOffsetX - self._petSpineX)
	local var_27_2 = math.min(var_27_1, var_0_4) / var_0_4

	if self._isChangeUIAction then
		if var_27_0.x + self._touchOffsetX - self._petSpineX > 0 then
			self.m_leftPetSpineDadComp:setAlpha(var_27_2)
			self.m_leftPetSpineDadComp:setX(self._leftPetSpineX + (var_27_0.x + self._touchOffsetX - self._petSpineX))
		else
			self.m_rightPetSpineDadComp:setAlpha(var_27_2)
			self.m_rightPetSpineDadComp:setX(self._rightPetSpineX + (var_27_0.x + self._touchOffsetX - self._petSpineX))
		end
	elseif var_27_1 >= var_0_5 then
		self._isChangeUIAction = true

		self.m_uihideTransition:play()
		self.m_rightPetSpineDadComp:setAlpha(0)
		self.m_leftPetSpineDadComp:setAlpha(0)
	end

	self.m_petSpineDadComp:setX(var_27_0.x + self._touchOffsetX)
	self.m_petSpineDadComp:setAlpha(1 - var_27_2)
end

function PetMainLayer:_onTouchEnd(arg_28_1)
	if not self._canTouchPet or not self._touchOffsetX then
		return
	end

	self._canTouchPet = false

	local var_28_0 = arg_28_1:getInput()
	local var_28_1 = var_28_0:getTouch():getLocation().x + self._touchOffsetX - self._petSpineX

	if math.abs(var_28_0) >= var_0_4 and self:_isTherePetToChange() then
		if var_28_1 > 0 then
			self:_onSwitchLeft(true)
		else
			self:_onSwitchRight(true)
		end

		self.m_petSpineDadComp:setX(self._petSpineX)
		self.m_petSpineDadComp:setAlpha(1)
	else
		self.m_petSpineDadComp:runAction((cc.Sequence:create(cc.Spawn:create(cc.EaseSineOut:create((cc.MoveBy:create(0.5, cc.p(-var_28_1, 0)))), (cc.FadeIn:create(0.3))), (cc.CallFunc:create(handler(self, function()
			self._canTouchPet = true
		end))))))

		if self._isChangeUIAction then
			self.m_uishowTransition:play()
		end
	end

	self._isChangeUIAction = false

	self.m_rightPetSpineDadComp:setAlpha(0)
	self.m_leftPetSpineDadComp:setAlpha(0)

	self._touchOffsetX = nil
end

function PetMainLayer:_openStageUpSuccessPop()
	local var_30_0 = self._petStruct:getSid()

	var_0_7:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "petStageUp",
				func = function()
					return require("app.view.module.show.ShowFactory"):showFeedBackTipsPop({
						title = g.core.lang:get(201010),
						petSid = var_30_0,
						showComp = fgui.UIPackage:createObject("pet", "PetAdvSuccessPopComp")
					}, {
						hideContinue = true
					})
				end
			}
		}
	})
end

function PetMainLayer:_openLevelUpSuccessPop()
	var_0_7:dispatchEvent(var_0_0.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_1.BaseShowTypeConst.PET_LEVEL_UP
		}
	})
end

function PetMainLayer:_isTherePetToChange()
	return self._maxPetIdx > 1
end

return PetMainLayer
