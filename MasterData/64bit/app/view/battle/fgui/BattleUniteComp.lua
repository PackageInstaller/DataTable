local BattleConst = require("app.view.battle.const.BattleConst")
local BattleAttr = require("battle.const.BattleAttr")
local var_0_2 = 12
local var_0_3 = 0.5
local BattleUniteComp = class("BattleUniteComp", require("app.fairyGUI.battle.UI_BattleUniteComp"))

function BattleUniteComp:ctor()
	self._data = {}
	self._skillBtnList = {}
	self._tokenDataList = {}
	self._comboMax = 0
	self._comboValue = 0
	self._tokenStateList = {
		2,
		2,
		2,
		2
	}
	self._uniteFullAnimation = nil
	self._addUniteAnimation = nil
	self._canTouch = true
	self._isLoopActon = false
	self._proAnimation = nil
	self._actionName = "play"
	self._triggerClick = false
	self._tipComp = nil
	self._clickButton = nil
	self._guideVisible = nil
	self._guideComp = nil

	self:_initBtn()
	self:_initData()
end

function BattleUniteComp:updateUniteView(arg_2_1, arg_2_2)
	self._battleLayer = arg_2_2
	self._data = arg_2_1

	local var_2_0 = arg_2_1.attrs or {}

	for iter_2_0 = 1, #var_2_0 do
		if var_2_0[iter_2_0].type == BattleAttr.MAXIMUM_COMBO then
			self._comboMax = var_2_0[iter_2_0].value
		elseif var_2_0[iter_2_0].type == BattleAttr.INITIAL_COMBO then
			self._comboValue = var_2_0[iter_2_0].value
		end
	end

	self._comboMax = math.min(self._comboMax, var_0_2)
	self._comboValue = math.min(self._comboMax, self._comboValue)
end

function BattleUniteComp:_initBtn()
	for iter_3_0 = 1, BattleConst.UNITE_SKILL_NUM do
		self["m_skillComp" .. iter_3_0].tag = iter_3_0

		self["m_skillComp" .. iter_3_0]:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onUniteTouchBegin))
		self["m_skillComp" .. iter_3_0]:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onUniteTouchMove))
		self["m_skillComp" .. iter_3_0]:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onUniteTouchEnd))
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_PLAY_UNITE_TOKEN_SKILL, handler(self, self._onGuideClickSkillIcon), self)
		table.insert(self._skillBtnList, self["m_skillComp" .. iter_3_0])
	end
end

function BattleUniteComp:_onUniteTouchBegin(arg_4_1)
	self._clickButton = arg_4_1:getSender()

	arg_4_1:captureTouch()

	self._touchSchedule = self:newScheduleOnce(handler(self, function()
		if not self._clickButton then
			return
		end

		self._touchSchedule = nil

		if self._clickButton:getHaveToken() then
			self:showBattleUniteTip()
		end
	end), var_0_3)
end

function BattleUniteComp:_onUniteTouchMove(arg_6_1)
	return
end

function BattleUniteComp:_onUniteTouchEnd(arg_7_1)
	if self._touchSchedule then
		self:cancelSchedule(self._touchSchedule)

		if self._clickButton and self._clickButton.tag then
			self:_onClickSkillIcon(self._clickButton.tag)
		end
	end

	self:closeBattleUniteTip()

	self._clickButton = nil
end

function BattleUniteComp:_onGuideClickSkillIcon(arg_8_1, arg_8_2, arg_8_3)
	if not g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_8_0 = arg_8_3.target

	if arg_8_3.target and var_8_0.tag then
		self:_onClickSkillIcon(var_8_0.tag)
	end

	self:_onUniteTouchEnd()
end

function BattleUniteComp:showBattleUniteTip()
	self._touchSchedule = nil

	if not self._tipComp then
		self._tipComp = fgui.UIPackage:createObject("battle", "BattleUniteTipComp")

		self.m_tipPlaceHolder:addChild(self._tipComp)
	end

	self.m_tipPlaceHolder:setPosition(self._clickButton:getPosition().x, self._clickButton:getHeight() + 24)
	self.m_tipPlaceHolder:setVisible(true)
	self._tipComp:updateView((self._clickButton:getTokenId()))
end

function BattleUniteComp:closeBattleUniteTip()
	self.m_tipPlaceHolder:setVisible(false)
end

function BattleUniteComp:_initData()
	for iter_11_0 = 1, BattleConst.UNITE_SKILL_NUM do
		local var_11_0 = {
			isUnLock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. iter_11_0])
		}

		if not var_11_0.isUnLock then
			var_11_0.unLockLv = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. iter_11_0])
		end

		table.insert(self._tokenDataList, var_11_0)
	end
end

function BattleUniteComp:initUniteSkill(arg_12_1)
	arg_12_1 = arg_12_1 or {}

	for iter_12_0 = 1, BattleConst.UNITE_SKILL_NUM do
		self._tokenDataList[iter_12_0].tokenId = arg_12_1[iter_12_0] and arg_12_1[iter_12_0] or nil

		self._skillBtnList[iter_12_0]:initUniteSkill(self._tokenDataList[iter_12_0])
	end
end

function BattleUniteComp:updateUniteCostNum(arg_13_1)
	for iter_13_0 = 1, BattleConst.UNITE_SKILL_NUM do
		self._skillBtnList[iter_13_0]:updateCost(arg_13_1)
	end
end

function BattleUniteComp:updateUniteSkillCD(arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0 = 1, BattleConst.UNITE_SKILL_NUM do
		local var_14_0 = self._skillBtnList[iter_14_0]

		if (arg_14_3 and var_14_0:getSkillId() or var_14_0:getTokenId()) == arg_14_1 then
			var_14_0:updateRoundCD(arg_14_2)

			return
		end
	end
end

function BattleUniteComp:updateUniteAdvCD(arg_15_1, arg_15_2)
	for iter_15_0 = 1, BattleConst.UNITE_SKILL_NUM do
		if self._skillBtnList[iter_15_0]:getAdvId() == arg_15_1 then
			self._skillBtnList[iter_15_0]:updateRoundCD(arg_15_2)

			return
		end
	end
end

function BattleUniteComp:updateUniteCostMod(arg_16_1, arg_16_2)
	for iter_16_0 = 1, BattleConst.UNITE_SKILL_NUM do
		if self._skillBtnList[iter_16_0] and self._skillBtnList[iter_16_0]:getAdvId() == arg_16_1 then
			self._skillBtnList[iter_16_0]:setCostMod(arg_16_2)

			return
		end
	end
end

function BattleUniteComp:_onClickSkillIcon(arg_17_1)
	if not self._tokenDataList[arg_17_1].isUnLock then
		g.core.module.ModuleManager:tip(g.core.lang:get(110031, {
			level = self._tokenDataList[arg_17_1].unLockLv
		}))
	elseif self._tokenDataList[arg_17_1].tokenId and not self._skillBtnList[arg_17_1]:isFakeHide() then
		if self._skillBtnList[arg_17_1]:getCurCDRound() > 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(110035))

			return
		end

		local var_17_0 = self._skillBtnList[arg_17_1]:getCostNum()

		if var_17_0 > self._comboValue then
			g.core.module.ModuleManager:tip(g.core.lang:get(110036))

			return
		end

		if self._canTouch then
			self:dispatchCompEvent("BattleCtrl_Unite", {
				skillId = self._skillBtnList[arg_17_1]:getSkillId(),
				cost = var_17_0
			})

			self._canTouch = false
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(110034))
	end
end

function BattleUniteComp:_onAddEvent(arg_18_1)
	if arg_18_1.animation == "play1" and self._comboValue == var_0_2 then
		return
	end

	if arg_18_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._addUniteAnimation:setAnimation(0, "play3", true)
	end
end

function BattleUniteComp:addUniteValue(arg_19_1)
	self._comboValue = math.max(self._comboValue + arg_19_1, 0)

	self:updateCurUnite(self._comboValue)

	if self._comboValue == var_0_2 then
		if not self._isLoopActon then
			self._actionName = "play2"

			self.m_fullTransition:play(-1, 0)
			self.m_fullTransition:setHook("play2", handler(self, self._playAddUniteEffect))

			self._isLoopActon = true
		end
	else
		self._isLoopActon = false

		self.m_fullTransition:stop()

		if arg_19_1 > 0 then
			self._actionName = "play"

			self.m_refreshTransition:play()
			self.m_refreshTransition:setHook("play", handler(self, self._playAddUniteEffect))
		end
	end
end

function BattleUniteComp:_playAddUniteEffect()
	if not self._proAnimation then
		self._proAnimation = self.m_effPro:addEffectSpine({
			name = "eff_ui_battle_pro",
			isLoop = false
		})

		self._proAnimation:setAnimation(0, self._actionName, false)
	else
		self._proAnimation:setAnimation(0, self._actionName, false)
	end
end

function BattleUniteComp:updateCurUnite(arg_21_1)
	self._comboValue = math.max(arg_21_1, 0)

	self.m_uniteNumberText:setText(self._comboValue)
	self.m_proComp:updateView({
		value = self._comboValue
	})
	self:updateUniteCostNum(self._comboValue)
	self:_checkUniteGuide(self._comboValue)
end

function BattleUniteComp:getTokenIds()
	local var_22_0 = {}

	self._data.tokens = self._data.tokens or {}

	for iter_22_0 = 1, #self._data.tokens do
		var_22_0[iter_22_0] = self._data.tokens[iter_22_0]
	end

	return var_22_0
end

function BattleUniteComp:_checkUniteGuide(arg_23_1)
	local var_23_0 = {}
	local var_23_1 = false

	for iter_23_0, iter_23_1 in ipairs(self._skillBtnList) do
		if iter_23_1:isCanUse() and iter_23_1:getTokenId() > 0 then
			table.insert(var_23_0, (iter_23_1:getTokenId()))

			if iter_23_0 == 1 then
				var_23_1 = true
			end
		end
	end

	if #var_23_0 > 0 then
		g.core.battle.BattleProxy:dispatchEvent(g.core.event.enum.EVENT_BATTLE_NEW_SKILL, {
			list = var_23_0,
			value = arg_23_1
		})
	end

	self:_checkWakeGuide(var_23_1)
end

function BattleUniteComp:_checkWakeGuide(arg_24_1)
	if arg_24_1 == nil then
		if self._skillBtnList[1]:isCanUse() and self._skillBtnList[1]:getTokenId() > 0 then
			-- block empty
		end
	end

	if arg_24_1 and not g.core.model.User.dungeonData:isStagePassed(200104) then
		self:_showTipGuide()
	elseif not arg_24_1 and self._guideComp then
		self._guideComp:setVisible(false)
	end
end

function BattleUniteComp:setSkillShow(arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(self._skillBtnList) do
		if iter_25_1:getTokenId() == arg_25_1 then
			iter_25_1:setFakeVisible(arg_25_2)

			if not arg_25_2 then
				self._tokenStateList[iter_25_0] = nil
			end

			break
		end
	end
end

function BattleUniteComp:setUniteBtnTouchEnable()
	self._canTouch = true
end

function BattleUniteComp:_showTipGuide()
	if not self._guideComp then
		fgui.UIPackage:addPackage("ui/guide/guide")

		self._guideComp = fgui.UIPackage:createObject("guide", "GuideTouchComp")

		self._guideComp:setTouchable(false)
		self._guideComp:setPosition((cc.p(self.m_skillComp1:getSize().width / 2, self.m_skillComp1:getSize().height / 2)))
		self._guideComp:updateView()
		self.m_skillComp1:addChild(self._guideComp)
		self.m_skillComp1:addClickListener(handler(self, self._hideGuideTip))
	end

	if self._guideVisible == nil then
		self._guideVisible = true

		self._guideComp:setVisible(true)
	else
		self._guideComp:setVisible(self._guideVisible)
	end
end

function BattleUniteComp:setGuideUIVisible(arg_28_1)
	self._guideVisible = arg_28_1

	if self._guideComp and not arg_28_1 then
		self._guideComp:setVisible(arg_28_1)
	else
		self:_checkWakeGuide()
	end
end

function BattleUniteComp:_hideGuideTip()
	self:setGuideUIVisible(false)
end

function BattleUniteComp:_playFullAction()
	return
end

function BattleUniteComp:_removeFullAction()
	return
end

return BattleUniteComp
