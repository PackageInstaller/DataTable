local MonopolyNewLayer = class("MonopolyNewLayer", (require("view.Layer.BaseUILayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3
local MonopolyMapLayer = require("view.Layer.Monopoly.MonopolyMapLayer")
local RichTextPro = require("view.Sprite.RichTextPro")
local texture_manager = require("controller.texture_manager")

function MonopolyNewLayer:ctor()
	MonopolyNewLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.monopoly.monopoly_manager"):getInstance()
end

function MonopolyNewLayer:create(arg_2_1)
	local var_2_0 = MonopolyNewLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyNewLayer:onEnter()
	MonopolyNewLayer.super.onEnter(self)
	self.manager:requestInfo()
	self:playIntoAnima()
	RoleDefault:getInstance():setBoolForKey("monopoly_red_status_" .. self.manager:getActivityId(), false)
end

function MonopolyNewLayer:onExit()
	MonopolyNewLayer.super.onExit(self)

	local activity_manager = require("controller.activity_manager")

	activity_manager:fireEvent(activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT)
	texture_manager:removeLayerTextures({
		"Monopoly_" .. self.manager:getActivityId() .. "_MonopolyNewLayer"
	})
	texture_manager:unloadPopLayerTextures()
end

function MonopolyNewLayer:init(arg_5_1)
	if arg_5_1 then
		self._data = arg_5_1

		self.manager:setActivityId(self._data.activityid)
	end

	texture_manager:loadLayerTextures({
		"Monopoly_" .. self.manager:getActivityId() .. "_MonopolyNewLayer"
	})

	var_0_3 = "Monopoly_" .. self.manager:getActivityId() .. "/MonopolyNewLayer/"

	self:initLayer()
	self:initListener()

	return true
end

function MonopolyNewLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	TempWidget:CreateTempImg("mainScenebg/monopoly_" .. self.manager:getActivityId() .. "_bg.png", var_6_0, 0):align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

	local var_6_1 = MonopolyMapLayer:create({
		activityid = self.manager:getActivityId()
	})

	var_6_0:addChild(var_6_1)

	self._monopolyMapLayer = var_6_1

	local var_6_2 = TempWidget:CreateTempImg(var_0_3 .. "title.png", var_6_0)

	var_6_2:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h - 40)

	self._titleImg = var_6_2

	local var_6_3 = TempWidget:CreateTempLabel(L_MONOPOLY[38], FONT_DES, 22, var_6_2)

	var_6_3:align(cc.p(0.5, 0), var_6_2:size().w / 2, 10)

	local var_6_4 = self.manager:getAttrValue("time_color")

	if var_6_4 then
		var_6_3:_setColor(var_6_4)
	end

	self._remainTimeText = var_6_3

	self._remainTimeText:setVisible(true)

	local var_6_5 = TempWidget:CreateTempImg(var_0_3 .. "level_bg.png", var_6_2)

	var_6_5:align(cc.p(0.5, 0), var_6_2:size().w / 2, -50)

	local var_6_6 = TempWidget:CreateTempLabel("", FONT_DES, 22, var_6_5)

	var_6_6:align(cc.p(0.5, 0.5), var_6_5:size().w / 2, var_6_5:size().h / 2)

	self._levelText = var_6_6

	local var_6_7 = TempWidget:CreateTempImg(var_0_3 .. "enemy_bill_bg.png", var_6_2)

	var_6_7:setName("enemyBillBg")
	var_6_7:align(cc.p(0.5, 1), var_6_2:size().w / 2 + 160, var_6_6:pos().y - var_6_6:size().h - 80)

	local var_6_8 = TempWidget:CreateTempLabel("9999999", FONT_DES, 22, var_6_7)

	var_6_8:_setColor("44c4ff")

	local var_6_9 = self.manager:getAttrValue("enemy_money_color")

	if var_6_9 then
		var_6_8:_setColor(var_6_9)
	end

	var_6_8:align(cc.p(0, 0.5), 60, var_6_7:size().h / 2 - 4)

	self._aiBillText = var_6_8

	local var_6_10 = TempWidget:CreateTempImg(var_0_3 .. "our_bill_bg.png", var_6_2)

	var_6_10:setName("ourBillBg")
	var_6_10:align(cc.p(0.5, 1), var_6_2:size().w / 2 - 160, var_6_7:pos().y)

	local var_6_11 = TempWidget:CreateTempLabel("", FONT_DES, 22, var_6_10)

	var_6_11:align(cc.p(0, 0.5), 140, var_6_10:size().h / 2 - 3)
	var_6_11:_setColor("4e00ff")

	local var_6_12 = self.manager:getAttrValue("money_color")

	if var_6_12 then
		var_6_11:_setColor(var_6_12)
	end

	self._ourBillText = var_6_11

	local var_6_13 = TempWidget:CreateTempImg(var_0_3 .. "bottom_bg.png", var_6_0)

	var_6_13:setLocalZOrder(var_6_1:getLocalZOrder() + 1)
	var_6_13:align(cc.p(0.5, 0), var_6_0:size().w / 2, 0)

	self._bottomBg = var_6_13

	local var_6_14 = TempWidget:CreateTempBtn(var_0_3 .. "back_btn.png", var_6_13)

	var_6_14:align(cc.p(0, 0.5), 20, var_6_13:size().h / 2)

	self._backBtn = var_6_14

	local var_6_15 = TempWidget:CreateTempBtn(var_0_3 .. "buff_btn.png", var_6_13)

	var_6_15:align(cc.p(0.5, 0.5), var_6_13:size().w / 2 + 170, var_6_13:size().h + var_6_15:size().h / 2 + 50)

	self._buffBtn = var_6_15

	local var_6_16 = TempWidget:CreateTempImg(var_0_3 .. "auto_btn_off.png", var_6_13)

	var_6_16:hide()
	var_6_16:align(cc.p(0.5, 0.5), var_6_13:size().w / 2 - 90, var_6_13:size().h / 2)

	self._autoDiceBtn = var_6_16

	local var_6_17 = TempWidget:CreateTempBtn(var_0_3 .. "formation_btn.png", var_6_13)

	var_6_17:align(cc.p(0.5, 0.5), var_6_13:size().w / 2 + 90, var_6_13:size().h / 2)

	self._formationBtn = var_6_17

	local var_6_18 = TempWidget:CreateTempBtn(var_0_3 .. "dice_btn.png", var_6_13)

	var_6_18:align(cc.p(0.5, 0), var_6_13:size().w - var_6_18:size().w / 2 - 20, 0)
	var_6_18:setName("diceBtn")

	self._diceBtn = var_6_18

	local var_6_19 = var_6_18:getVirtualRenderer()
	local var_6_20 = TempWidget:CreateTempImg(var_0_3 .. "1to3_dice_img.png", var_6_19)

	var_6_20:align(cc.p(0.5, 0.5), var_6_18:size().w / 2 - 3, var_6_18:size().h / 2 + 7)
	var_6_20:setScale(0.65)

	self._diceTypeImg = var_6_20

	local var_6_21 = TempWidget:CreateTempBtn(var_0_3 .. "dice_switch_btn.png", var_6_18)

	var_6_21:align(cc.p(1, 1), var_6_18:size().w, var_6_18:size().h + 10)
	var_6_21:setName("diceSwitchBtn")

	self._diceSwitchBtn = var_6_21

	local var_6_22 = TempWidget:CreateTempImg(var_0_3 .. "dice_num_bg.png", var_6_19)

	var_6_22:align(cc.p(0, 0), -10, 10)

	self._diceNumBg = var_6_22

	local var_6_23 = TempWidget:CreateTempLabel("", FONT_DES, 18, var_6_22)

	var_6_23:align(cc.p(0.5, 0.5), var_6_22:size().w / 2, var_6_22:size().h / 2)
	var_6_23:_setColor("1c11ef")

	self._diceNumText = var_6_23

	local var_6_24 = TempWidget:CreateTempImg(var_0_3 .. "event_img.png", var_6_13)

	var_6_24:align(cc.p(0.5, 0.5), var_6_24:size().w / 2 + 10, var_6_13:size().h + var_6_24:size().h / 2 + 5)

	self._eventImg = var_6_24

	local var_6_25 = TempWidget:CreateTempImg(var_0_3 .. "event_text_bg.png", var_6_24)

	var_6_25:align(cc.p(0, 0.5), var_6_24:size().w - 10, var_6_24:size().h / 2)

	self._eventTextBg = var_6_25

	local var_6_26 = RichTextPro:create()

	var_6_26:setMaxWidth(var_6_25:size().w - 26)
	var_6_26:setSize(18)
	var_6_26:setText("")
	var_6_26:setPosition(10, var_6_25:size().h - 10)
	var_6_25:addChild(var_6_26)

	self._eventText = var_6_26
end

function MonopolyNewLayer:initListener()
	self._backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._buffBtn:_addEvent(function()
		LayerManager:pushInLayer("MonopolyBuffLayer")
	end)

	local var_7_0 = self._diceBtn

	self._diceBtn:_addEvent(function()
		if self.manager:getDiceType() == self.manager.DICE_TYPE.ANY then
			if self.manager:canThrow() then
				if self.manager:getAnyDiceItemNum() <= 0 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = self.manager:getAnyDiceItemId(),
						cancelcallback = function()
							require("controller.monopoly.monopoly_manager"):getInstance():updateDiceNumText()
						end
					})
				else
					LayerManager:pushInLayer("MonopolyDiceSelectLayer")
				end
			elseif self.manager._notes and self.manager._notes.type == self.manager.NOTES_TYPE.WIN then
				LayerManager:pushInLayer("MonopolyPlayerWinLayer")
			end
		else
			self.manager:requestThrow()
		end
	end)

	local var_7_1 = 0.1
	local var_7_2 = 10
	local var_7_3 = self._diceTypeImg

	self._diceBtn._isWobble = true

	function self._diceBtn._wobble()
		var_7_3:stopAllActions()
		var_7_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
			if not var_7_0._isWobble then
				var_7_3:stopAllActions()
			end
		end), cc.RotateTo:create(var_7_1, -var_7_2), cc.RotateTo:create(var_7_1, 0), cc.RotateTo:create(var_7_1, var_7_2), cc.RotateTo:create(var_7_1, 0), cc.RotateTo:create(var_7_1, -var_7_2), cc.RotateTo:create(var_7_1, 0), cc.RotateTo:create(var_7_1, var_7_2), cc.RotateTo:create(var_7_1, 0), cc.RotateTo:create(var_7_1, -var_7_2), cc.RotateTo:create(var_7_1, 0), cc.RotateTo:create(var_7_1, var_7_2), cc.RotateTo:create(var_7_1, 0))))
	end

	self._diceBtn._wobble()

	function self._diceBtn._stopWobble()
		var_7_0._isWobble = false
	end

	function self._diceBtn._startWobble()
		var_7_0._isWobble = true

		var_7_0._wobble()
	end

	self._diceSwitchBtn:_addEvent(function()
		self.manager:switchDiceType()
	end)
	self._formationBtn:_addEvent(function()
		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationMainLayer", {
			repeatChallenge = true,
			configcallback = function()
				print("refight")
			end
		})
	end)
	self._titleImg:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_monopoly_" .. self.manager:getActivityId()
		})
	end)
	self._eventImg:_addEvent(function()
		LayerManager:pushInLayer("MonopolyEventHistoryLayer")
	end)
	self._eventTextBg:_addEvent(function()
		LayerManager:pushInLayer("MonopolyEventHistoryLayer")
	end)
	self._autoDiceBtn:_addEvent(function()
		if self.manager:isAuto() then
			self.manager:setAuto(not self.manager:isAuto())
		else
			local var_22_0 = self.manager:getAllLevel()
			local var_22_1 = self.manager:getLevel()

			for iter_22_0 = 1, #var_22_0 do
				if self.manager:getLevelConfigByLevel(var_22_0[iter_22_0]).auto_dice == 1 then
					if var_22_1 < var_22_0[iter_22_0] then
						global_ShowBlockWords(string.format(L_MONOPOLY[39], iter_22_0))

						return
					end

					break
				end
			end

			LayerManager:pushInLayer("MonopolyAutoDiceSettingLayer")
		end
	end)
end

function MonopolyNewLayer:startWobble()
	self._diceBtn._startWobble()
end

function MonopolyNewLayer:stopWobble()
	self._diceBtn._stopWobble()
end

function MonopolyNewLayer:playIntoAnima()
	self._titleImg:move(self._root:size().w / 2, self._root:size().h + self._titleImg:size().h + 170)
	self._titleImg:runAction(cc.Sequence:create(cc.EaseBackOut:create(cc.MoveTo:create(0.4, cc.p(self._root:size().w / 2, self._root:size().h - 10)))))
	self._bottomBg:move(self._root:size().w / 2, -self._bottomBg:size().h)
	self._bottomBg:runAction(cc.Sequence:create(cc.EaseBackOut:create(cc.MoveTo:create(0.4, cc.p(self._root:size().w / 2, 0)))))
end

function MonopolyNewLayer:updateLayer()
	self:updateDiceImg()
	self:updateOurBillText()
	self:updateAiBillText()
	self:updateDiceNumText()
	self:updateLevelText()
	self:updateRemainTimeText()
	self:updateEventText()
	self:updateAutoDiceBtn()
	self._monopolyMapLayer:updateMapLayout()

	if self.manager:isAuto() then
		self.manager:requestThrow()
	end
end

function MonopolyNewLayer:updateRed()
	return
end

function MonopolyNewLayer:updateDiceImg()
	local var_28_0 = self.manager:getDiceType()

	if var_28_0 == self.manager.DICE_TYPE.ONE_TO_THREE then
		self._diceTypeImg:loadTextureEx(var_0_3 .. "1to3_dice_img.png")
	elseif var_28_0 == self.manager.DICE_TYPE.ANY then
		self._diceTypeImg:loadTextureEx(var_0_3 .. "any_dice_img.png")
	end

	self:updateDiceNumBgVisible()
end

function MonopolyNewLayer:updateDiceNumText()
	self._diceNumText:setString((self.manager:getAnyDiceItemNum()))
end

function MonopolyNewLayer:updateDiceNumBgVisible()
	self._diceNumBg:setVisible(self.manager:getDiceType() == self.manager.DICE_TYPE.ANY)
end

function MonopolyNewLayer:updateLevelText()
	self._levelText:setString(self.manager:getLevelTextStr())
end

function MonopolyNewLayer:updateOurBillText()
	self._ourBillText:setString(self.manager:getPlayerGold())
end

function MonopolyNewLayer:updateAiBillText()
	self._aiBillText:setString(self.manager:getAiGold())
end

function MonopolyNewLayer:updateRemainTimeText()
	self._remainTimeText:setString(self.manager:getActivateRemain())
end

function MonopolyNewLayer:addAiMoney(arg_35_1)
	self:goldChanegAnima(self._aiBillText, function()
		return self.manager:getAiGold()
	end, arg_35_1.data.money, function()
		self.manager:handleEvents()
	end)
end

function MonopolyNewLayer:loseAiMoney(arg_38_1)
	self:goldChanegAnima(self._aiBillText, function()
		return self.manager:getAiGold()
	end, -arg_38_1.data.money, function()
		self.manager:handleEvents()
	end)
end

function MonopolyNewLayer:transferMoney(arg_41_1)
	local var_41_0 = {
		player = false,
		ai = false
	}

	local function var_41_1(arg_42_0)
		if arg_42_0 == self._aiBillText then
			var_41_0.ai = true
		elseif arg_42_0 == self._ourBillText then
			var_41_0.player = true
		end

		if var_41_0.ai and var_41_0.player then
			self.manager:handleEvents()
		end
	end

	if arg_41_1.data.source == self.manager.EVENTS_TARGET_TYPE.AI then
		self:goldChanegAnima(self._aiBillText, function()
			return self.manager:getAiGold()
		end, -arg_41_1.data.money, var_41_1)
		self:goldChanegAnima(self._ourBillText, function()
			return self.manager:getPlayerGold()
		end, arg_41_1.data.money, var_41_1)
	elseif arg_41_1.data.source == self.manager.EVENTS_TARGET_TYPE.PLAYER then
		self:goldChanegAnima(self._ourBillText, function()
			return self.manager:getPlayerGold()
		end, -arg_41_1.data.money, var_41_1)
		self:goldChanegAnima(self._aiBillText, function()
			return self.manager:getAiGold()
		end, arg_41_1.data.money, var_41_1)
	end

	self:updateEventText(arg_41_1)
end

function MonopolyNewLayer:buildingIncome(arg_47_1)
	local var_47_0 = {
		player = false,
		ai = false
	}

	local function var_47_1(arg_48_0)
		if arg_48_0 == self._aiBillText then
			var_47_0.ai = true
		elseif arg_48_0 == self._ourBillText then
			var_47_0.player = true
		end

		if var_47_0.ai and var_47_0.player then
			self.manager:handleEvents()
		end
	end

	if arg_47_1.data.source == self.manager.EVENTS_TARGET_TYPE.AI then
		self:goldChanegAnima(self._aiBillText, function()
			return self.manager:getAiGold()
		end, -arg_47_1.data.money, var_47_1)
		self:goldChanegAnima(self._ourBillText, function()
			return self.manager:getPlayerGold()
		end, arg_47_1.data.money, var_47_1)
	elseif arg_47_1.data.source == self.manager.EVENTS_TARGET_TYPE.PLAYER then
		self:goldChanegAnima(self._ourBillText, function()
			return self.manager:getPlayerGold()
		end, -arg_47_1.data.money, var_47_1)
		self:goldChanegAnima(self._aiBillText, function()
			return self.manager:getAiGold()
		end, arg_47_1.data.money, var_47_1)
	end

	self:updateEventText(arg_47_1)
end

function MonopolyNewLayer:fightResult(arg_53_1)
	self:updateOurBillText()
	self:updateAiBillText()
	self:updateEventText(arg_53_1)
end

function MonopolyNewLayer:intoNextLevel()
	self:updateOurBillText()
	self:updateAiBillText()
	self:updateRemainTimeText()
	self:updateLevelText()
	self:updateDiceNumText()
	self._monopolyMapLayer:updateMapLayout()
end

function MonopolyNewLayer:goldChanegAnima(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local var_55_0 = arg_55_2()

	arg_55_1:setString(var_55_0 - arg_55_3)
	arg_55_1:stopAllActions()

	local var_55_2 = math.floor(arg_55_3 / 30)
	local var_55_3 = tonumber(arg_55_1:getString() + var_55_2)

	schedule(arg_55_1, function()
		local var_56_0 = false

		if arg_55_3 < 0 then
			if var_55_3 < var_55_0 then
				var_55_3 = var_55_0
				var_56_0 = true
			end
		elseif var_55_3 > var_55_0 then
			var_55_3 = var_55_0
			var_56_0 = true
		end

		arg_55_1:setString(var_55_3)

		if var_56_0 then
			arg_55_1:stopAllActions()

			if arg_55_4 then
				arg_55_4(arg_55_1)
			end
		else
			var_55_3 = var_55_3 + var_55_2
		end
	end, 0.016666666666666666)

	local var_55_4 = TempWidget:CreateTempLabel(tostring(arg_55_3), FONT_DES, 22, arg_55_1:getParent())

	var_55_4:setTextColor(arg_55_1:getTextColor())
	var_55_4:align(cc.p(0, 0), arg_55_1:getPositionX(), arg_55_1:getPositionY() + arg_55_1:getContentSize().height / 2)
	var_55_4:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, 100)), cc.FadeOut:create(2)), cc.DelayTime:create(2), cc.RemoveSelf:create()))
end

function MonopolyNewLayer:showDiceAnima(arg_57_1)
	if self.manager:isAnyDiceThrow() then
		self:anyDiceAnima(arg_57_1)
	else
		self:normalDiceAnima(arg_57_1)
	end
end

function MonopolyNewLayer:anyDiceAnima(arg_58_1)
	self.manager:setIsAnyDiceThrow(false)

	local var_58_0 = self._root:getChildByName("anyDiceSpine" .. arg_58_1.data.throw_num)
	local var_58_1 = self._root:getChildByName("anyDiceTipsBg" .. arg_58_1.data.throw_num)
	local var_58_2 = self._root:getChildByName("anyDiceTips" .. arg_58_1.data.throw_num)

	if not var_58_0 then
		var_58_0 = L2Skeleton:create(string.format("spine/monopoly/shaizi_%s.json", arg_58_1.data.throw_num), (string.format("spine/monopoly/shaizi_%s.atlas", arg_58_1.data.throw_num)))

		var_58_0:refreshSkeleton()
		var_58_0:setName("anyDiceSpine" .. arg_58_1.data.throw_num)
		var_58_0:setPosition(cc.p(self._root:getContentSize().width / 2, self._root:getContentSize().height / 2))
		self._root:addChild(var_58_0)
	end

	if not var_58_1 and not var_58_2 then
		var_58_1 = TempWidget:CreateTempImg(var_0_3 .. "go_bg.png", var_58_0)

		var_58_1:align(cc.p(0.5, 1), var_58_0:getContentSize().width / 2, -100)
		var_58_1:setName("anyDiceTipsBg" .. arg_58_1.data.throw_num)

		var_58_2 = ccui.TextBMFont:create("", "fonts/dice.fnt")

		var_58_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_58_2:setPosition(cc.p(var_58_1:getContentSize().width / 2, var_58_1:getContentSize().height / 2))
		var_58_2:setName("anyDiceTips" .. arg_58_1.data.throw_num)
		var_58_1:addChild(var_58_2)
	end

	var_58_1:setOpacity(0)
	var_58_2:setString(string.format(L_MONOPOLY[40], arg_58_1.data.throw_num))
	var_58_0:setVisible(true)
	var_58_0:play("animation", false)
	var_58_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_59_0)
		var_58_1:stopAllActions()
		var_58_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.3), cc.DelayTime:create(0.5), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
			var_58_0:setVisible(false)
			require("controller.monopoly.monopoly_move_manager"):getInstance():eventMove(arg_58_1)
		end)))
	end)
end

function MonopolyNewLayer:normalDiceAnima(arg_61_1)
	local var_61_0 = self._root:getChildByName("normalDiceSpine")
	local var_61_1 = self._root:getChildByName("normalDiceTipsBg")
	local var_61_2 = self._root:getChildByName("normalDiceTips")

	if not var_61_0 then
		var_61_0 = L2Skeleton:create("spine/monopoly/shaizi.json", "spine/monopoly/shaizi.atlas")

		var_61_0:refreshSkeleton()
		var_61_0:setName("normalDiceSpine")
		var_61_0:setScale(0.5)
		self._root:addChild(var_61_0)
		var_61_0:setPosition(cc.p(self._root:size().width / 2, self._root:size().height / 2))
	end

	if not var_61_1 and not var_61_2 then
		var_61_1 = TempWidget:CreateTempImg(var_0_3 .. "go_bg.png", var_61_0)

		var_61_1:align(cc.p(0.5, 1), var_61_0:getContentSize().width / 2, -100)
		var_61_1:setName("normalDiceTipsBg")

		var_61_2 = ccui.TextBMFont:create("", "fonts/dice.fnt")

		var_61_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_61_2:setPosition(cc.p(var_61_1:getContentSize().width / 2, var_61_1:getContentSize().height / 2))
		var_61_2:setName("normalDiceTips")
		var_61_1:addChild(var_61_2)
	end

	var_61_1:setOpacity(0)
	var_61_2:setString(string.format(L_MONOPOLY[40], arg_61_1.data.throw_num))
	var_61_0:setVisible(true)
	var_61_0:play(tostring(arg_61_1.data.throw_num), false)
	var_61_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_62_0)
		var_61_1:stopAllActions()
		var_61_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.3), cc.DelayTime:create(0.5), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
			var_61_0:setVisible(false)
			require("controller.monopoly.monopoly_move_manager"):getInstance():eventMove(arg_61_1)
		end)))
	end)
end

function MonopolyNewLayer:eventMove(arg_64_1)
	self:updateDiceNumText()
	self:showDiceAnima(arg_64_1)
end

function MonopolyNewLayer:eventBuffMove(arg_65_1)
	self:updateDiceNumText()
	require("controller.monopoly.monopoly_move_manager"):getInstance():eventBuffMove(arg_65_1)
end

function MonopolyNewLayer:showAnima()
	local var_66_0 = self._root:getChildByName("nextSpine")

	if not var_66_0 then
		var_66_0 = L2Skeleton:create("spine/monopoly/next.json", "spine/monopoly/next.atlas")

		var_66_0:refreshSkeleton()
		var_66_0:setName("nextSpine")
		var_66_0:setPosition(cc.p(self._root:getContentSize().width / 2, self._root:getContentSize().height / 2))
		self._root:addChild(var_66_0)
	end

	var_66_0:setVisible(true)
	var_66_0:play("animation", true)
	var_66_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_67_0)
		return
	end)
end

function MonopolyNewLayer:levelUpTile(arg_68_1)
	self:updateOurBillText()
	self:updateAiBillText()
	self:updateEventText(arg_68_1)
end

function MonopolyNewLayer:updateEventText(arg_69_1)
	self._eventText:clearText()
	self._eventText:setText(self.manager:getEventTextStr())
end

function MonopolyNewLayer:updateAutoDiceBtn()
	local var_70_1 = self._autoDiceBtn

	self._autoDiceBtn:loadTextureEx(self.manager:isAuto() and var_0_3 .. "auto_btn_on.png" or var_0_3 .. "auto_btn_off.png")
	var_70_1:show()
end

return MonopolyNewLayer
