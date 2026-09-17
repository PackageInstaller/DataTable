local TowerDefenceListPanel = class("TowerDefenceListPanel", function()
	return ccui.Layout:create()
end)
local playermodel = require("model.playermodel")
local tower_defence_manager = require("controller.tower_defence_manager")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local l2utils = require("controller.l2utils")
local var_0_7 = require("controller/urban_defense_manager"):getInstance()
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = "TowerDefenceListPanel/"
local var_0_12 = cc.c4b(100, 100, 100, 90)
local var_0_13 = {
	{
		x = 4,
		y = 4
	},
	{
		x = 28,
		y = 100
	},
	{
		x = 124,
		y = 100
	},
	{
		x = 100,
		y = 4
	}
}

function TowerDefenceListPanel:create()
	local var_2_0 = TowerDefenceListPanel.new()

	var_2_0:init()

	return var_2_0
end

function TowerDefenceListPanel:init()
	self:initData()
	self:initBasicUI()
	self:initListUI()
	self:addInitFightRoles()
end

function TowerDefenceListPanel:initData()
	self.listData = tower_defence_manager:getRoleList()
	self.xpWaitingList = {}
	self.selectList = {}
end

function TowerDefenceListPanel:initBasicUI()
	self.limitLabel = cc.Label:createWithTTF("", FONT_NAME, 24)

	self.limitLabel:setPosition(570, 360)
	self.limitLabel:enableShadow(var_0_12, cc.size(3, -3))
	self.limitLabel:setRotation(-2)
	self:addChild(self.limitLabel)

	local var_5_0 = cc.Label:createWithTTF(L_TOWER_LIST[1], FONT_W5, 24)

	var_5_0:setAnchorPoint(1, 0.5)
	var_5_0:setPosition(340, 360 - 10)
	var_5_0:enableShadow(var_0_12, cc.size(0, -4))
	self:addChild(var_5_0)

	self.costNumLabel = cc.Label:createWithTTF("", FONT_W5, 24)

	self.costNumLabel:setAnchorPoint(cc.p(0, 0.5))
	self.costNumLabel:setPosition(340, 360 - 10)
	self.costNumLabel:setColor(cc.c3b(250, 255, 170))
	self.costNumLabel:enableShadow(var_0_12, cc.size(0, -4))
	self:addChild(self.costNumLabel)
	var_5_0:setVisible(false)
	self.costNumLabel:setVisible(false)

	self.reflagBtn = ccui.Button:create("TowerDefenceListPanel/reflag_btn.png", nil, "TowerDefenceListPanel/reflag_btn.png", var_0_10)

	self.reflagBtn:setAnchorPoint(cc.p(0, 0.5))
	self.reflagBtn:setPosition(0, 0.7922535211267606 * GameDisplay.height)
	self:addChild(self.reflagBtn)
	self.reflagBtn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.globalTouchLock then
			return
		end

		if tower_defence_manager:getReflagItemNumEx() <= 0 then
			global_ShowBlockWords(L_DO_ACTIVITY_STUDY[4])

			return
		end

		self:switchSpecialPanel("reflag")
	end)

	local var_5_1 = cc.Label:createWithTTF("", FONT_W5, 20)

	var_5_1:setAnchorPoint(cc.p(0, 0.5))
	var_5_1:setName("label")
	var_5_1:setPosition(68, 13)
	self.reflagBtn:addChild(var_5_1)
	self.reflagBtn:setVisible(true)

	self.xpBtn = ccui.Button:create("TowerDefenceListPanel/xp_btn.png", nil, "TowerDefenceListPanel/xp_btn.png", var_0_10)

	self.xpBtn:setAnchorPoint(cc.p(0, 0.5))
	self.xpBtn:setName("xpBtn")
	self.xpBtn:setPosition(0, (900 - self.reflagBtn:getContentSize().height) / 1136 * GameDisplay.height)
	self:addChild(self.xpBtn)
	self.xpBtn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.globalTouchLock then
			return
		end

		if tower_defence_manager:getXPItemNumEx() + tower_defence_manager:getXPFreeCount() <= 0 then
			global_ShowBlockWords(L_DO_ACTIVITY_STUDY[4])

			return
		end

		self:switchSpecialPanel("xp")
	end)

	local var_5_2 = cc.Label:createWithTTF("", FONT_W5, 20)

	var_5_2:setName("label")
	var_5_2:setAnchorPoint(cc.p(0, 0.5))
	var_5_2:setPosition(68, 13)
	self.xpBtn:addChild(var_5_2)
	self:initSpecialPanel()
	self:updateUI()
end

function TowerDefenceListPanel:updateUI()
	self.limitLabel:setString(TOWER_ROLE_LIMIT .. tower_defence_manager:getCurRoleNum() .. "/" .. tower_defence_manager:getRoleTotalLimitNum())
	self.limitLabel:setColor(tower_defence_manager:getCurRoleNum() >= tower_defence_manager:getRoleTotalLimitNum() and cc.c3b(255, 85, 85) or cc.c3b(255, 255, 255))
	self.costNumLabel:setString(tower_defence_manager:getCurTotalCost())
	self.reflagBtn:getChildByName("label"):setString(tower_defence_manager:getReflagItemNum())
	self.xpBtn:getChildByName("label"):setString(tower_defence_manager:getXPItemNum() .. "+" .. tower_defence_manager:getXPFreeCount())
end

local var_0_14 = 110
local var_0_16 = 580
local var_0_17 = 220

function TowerDefenceListPanel:createSp(arg_9_1)
	local var_9_0 = self.listData[arg_9_1]
	local var_9_1 = ccui.Button:create(var_0_11 .. "role_bg2.png", var_0_11 .. "role_bg2.png", var_0_11 .. "role_bg2.png", var_0_10)

	var_9_1:setAnchorPoint(0, 0)
	var_9_1:setSwallowTouches(false)

	local var_9_2 = ccui.ImageView:create(ROLE_PORTRAIT_PATH .. model_data[servant_data[var_9_0].modelid].portrait_image .. ".png")

	var_9_2:setScale(0.9)
	var_9_2:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
	var_9_1:addChild(var_9_2, 1)

	if tower_defence_manager:getDefenceType() == 1 and var_0_7:getDefendGirls()[var_9_0] then
		l2utils:shaderNode(var_9_2:getVirtualRenderer(), true)
	end

	local var_9_3 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_11 .. "unused_mask.png") or cc.Sprite:createWithSpriteFrameName(var_0_11 .. "unused_mask.png")))

	var_9_3:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_9_3:setBarChangeRate(cc.p(0, 1))
	var_9_3:setMidpoint(cc.p(0, 1))
	var_9_3:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
	var_9_1:addChild(var_9_3, 2)

	local var_9_4 = ccui.ImageView:create(var_0_11 .. "cost_bg.png", var_0_10)

	var_9_4:setAnchorPoint(cc.p(0, 0))
	var_9_4:setPosition(5, 0)
	var_9_1:addChild(var_9_4, 3)

	local var_9_5 = cc.Label:createWithTTF("", FONT_W5, 26)

	var_9_5:setAnchorPoint(cc.p(1, 0))
	var_9_5:setColor(cc.c3b(250, 255, 170))
	var_9_5:setPosition(var_9_4:getContentSize().width - 5, -2)
	var_9_4:addChild(var_9_5)

	local var_9_6 = cc.Label:createWithTTF("", FONT_NAME, 16)

	var_9_6:setAnchorPoint(cc.p(0, 0))
	var_9_6:setPosition(0, 0)
	var_9_4:addChild(var_9_6)

	local var_9_7 = ccui.ImageView:create(var_0_11 .. "dead_mask.png", var_0_10)

	var_9_7:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
	var_9_1:addChild(var_9_7, 4)

	local var_9_8 = cc.Label:createWithTTF("", FONT_W5, 24)

	var_9_8:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
	var_9_7:addChild(var_9_8, 4)

	local var_9_9 = ccui.ImageView:create(var_0_11 .. "bar_bg.png", var_0_10)

	var_9_9:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
	var_9_7:addChild(var_9_9, 4)

	local var_9_10 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_11 .. "bar.png") or cc.Sprite:createWithSpriteFrameName(var_0_11 .. "bar.png")))

	var_9_10:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_9_10:setPosition(var_9_9:getContentSize().width / 2, var_9_9:getContentSize().height / 2)
	var_9_9:addChild(var_9_10)

	local var_9_11 = ccui.ImageView:create(var_0_11 .. "selected_frame.png", var_0_10)

	var_9_11:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
	var_9_1:addChild(var_9_11, 5)
	var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_10_0

		if self.globalTouchLock then
			do return end

			var_10_0 = arg_10_0:getTouchEndPosition()
		end

		if math.abs(arg_10_0:getTouchBeganPosition().x - var_10_0.x) > 50 then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_13, (arg_10_0:convertToNodeSpace(var_10_0))) then
			return
		end

		if self.special_type then
			self:playerSpecialTouchEvent(arg_10_0.id, arg_10_0.servantid)

			return
		end

		if tower_defence_manager:isRoleDead(var_9_0) then
			return
		end

		if tower_defence_manager:isRoleFighting(var_9_0) then
			return
		end

		if tower_defence_manager:getDefenceType() == 1 and var_0_7:getDefendGirls()[var_9_0] then
			global_ShowBlockWords(L_URBANDEFENSE[6])

			return
		end

		if tower_defence_manager:addRoleByManual(arg_10_0.id) then
			GlobalPlayRoleSound(global_get_servant_skin(var_9_1.servantid), ROLE_SOUND_TYPE.fight)
		end
	end)

	var_9_1.id = arg_9_1
	var_9_1.servantid = var_9_0
	var_9_1.unusedMask = var_9_3
	var_9_1.costBg = var_9_4
	var_9_1.costNum = var_9_5
	var_9_1.roleLv = var_9_6
	var_9_1.deadMask = var_9_7
	var_9_1.deadTime = var_9_8
	var_9_1.barBg = var_9_9
	var_9_1.bar = var_9_10
	var_9_1.selectedLogo = var_9_11

	return var_9_1
end

function TowerDefenceListPanel:updateSp(arg_11_1)
	local var_11_0 = arg_11_1.servantid
	local var_11_1 = tower_defence_manager:isRoleFighting(arg_11_1.servantid)

	arg_11_1:loadTextures(var_0_11 .. (var_11_1 and "role_bg2.png" or "role_bg1.png"), var_0_11 .. (var_11_1 and "role_bg2.png" or "role_bg1.png"), var_0_11 .. (var_11_1 and "role_bg2.png" or "role_bg1.png"), var_0_10)
	arg_11_1.costBg:setVisible(false)
	arg_11_1.costNum:setString(tower_defence_manager:get_servant_cost(var_11_0))
	arg_11_1.unusedMask:setVisible(false)
	arg_11_1.unusedMask:setPercentage(tower_defence_manager:getRoleCostPercent(var_11_0))
	arg_11_1.deadMask:setVisible(tower_defence_manager:isRoleDead(var_11_0))
	arg_11_1.deadTime:setString(tower_defence_manager:getRoleDeadTime(var_11_0))
	arg_11_1.bar:setPercentage(tower_defence_manager:getRoleDeadTimePercent(var_11_0))
	arg_11_1.selectedLogo:setVisible(var_11_1)

	if role_false_level_manager:isRoleFalseLevelMember(var_11_0, FightManager.getFightType()) then
		local var_11_2, var_11_3, var_11_4, var_11_5 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_11_0)

		if var_11_2 == core_manager:getServantCoreRank(var_11_0) and playermodel.cores[var_11_0].level == var_11_3 then
			-- block empty
		elseif not arg_11_1.roleLv.action_playing then
			arg_11_1.roleLv:setColor(cc.c3b(206, 255, 167))
			arg_11_1.roleLv:setString(L_FAVOR_EVENT[1] .. var_11_3 + var_11_5)

			arg_11_1.roleLv.action_playing = true

			local var_11_6 = true

			arg_11_1.roleLv:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
				if var_11_6 then
					arg_11_1.roleLv:setString(L_EXPLORE_OFFER_POP[3])
				else
					arg_11_1.roleLv:setString(L_FAVOR_EVENT[1] .. var_11_3 + var_11_5)
				end

				var_11_6 = not var_11_6
			end), cc.FadeIn:create(2))))
		end
	else
		arg_11_1.roleLv:setOpacity(255)
		arg_11_1.roleLv:stopAllActions()
		arg_11_1.roleLv:setColor(cc.c3b(255, 255, 255))
		arg_11_1.roleLv:setString(L_FAVOR_EVENT[1] .. core_manager:getCoreLv(var_11_0))
	end

	if self.special_type == "xp" then
		local var_11_7 = "players@" .. arg_11_1.id + #tower_defence_manager:getPlayerBaseConf()
		local var_11_8 = FightManager.getCharacter(var_11_7)

		var_11_8 = var_11_8 and FightManager.getCharacter(var_11_7):checkXPStatusOnTower("xp")

		arg_11_1:setOpacity(var_11_1 and var_11_8 and 255 or 80)
	elseif self.special_type == "reflag" then
		arg_11_1:setOpacity(tower_defence_manager:isRoleDead(var_11_0) and 255 or 80)
	elseif self.special_type == "select" then
		arg_11_1:setOpacity((var_11_1 or tower_defence_manager:isRoleDead(var_11_0)) and 80 or 255)

		if self.selectList[var_11_0] then
			arg_11_1.selectedLogo:setVisible(true)
		else
			arg_11_1.selectedLogo:setVisible(false)
		end
	else
		arg_11_1:setOpacity(255)
	end
end

function TowerDefenceListPanel:initListUI()
	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(var_0_16, var_0_17))
	self.scrollView:setName("tower_defence_view")
	self.scrollView:setDirection(ccui.ScrollViewDir.horizontal)
	self.scrollView:setPosition(40, 100)
	self:addChild(self.scrollView)
	self:resetListUI()
end

function TowerDefenceListPanel:resetListUI()
	self.scrollView:removeAllChildren()
	self.scrollView:setInnerContainerSize(cc.size(math.ceil(#self.listData / 2) * var_0_14 + 20, var_0_17))

	for iter_14_0, iter_14_1 in ipairs(self.listData) do
		local var_14_0 = self:createSp(iter_14_0)

		var_14_0:setPosition((math.ceil(iter_14_0 / 2) - 1) * var_0_14, iter_14_0 % 2 == 0 and 10 or var_14_0:getContentSize().height + 20)
		var_14_0:setName("sp" .. iter_14_0)
		var_14_0:setTag(var_14_0.servantid)
		self.scrollView:addChild(var_14_0)
	end

	self.scrollView:jumpToLeft()
end

function TowerDefenceListPanel:updatePanelSp(arg_15_1)
	local var_15_0 = self.scrollView:getChildByTag(arg_15_1)

	if not var_15_0 then
		return
	end

	self:updateSp(var_15_0)
end

function TowerDefenceListPanel:updatePanel()
	self.costNumLabel:setString(tower_defence_manager:getCurTotalCost())

	for iter_16_0, iter_16_1 in pairs(self.scrollView:getChildren()) do
		self:updateSp(iter_16_1)
	end
end

function TowerDefenceListPanel:resetPanel()
	self:initData()
	self:updateUI()
	self:resetListUI()
end

function TowerDefenceListPanel:switchSpecialPanel(arg_18_1)
	if FightManager.getFightState() ~= FIGHTSTATUS_FIGHTING then
		return
	end

	if require("fight.xp.xp_effect_manager").getIsLockOnXPEffect() then
		return
	end

	self.special_type = arg_18_1

	self.maskPanel:setVisible(true)
	FightManager.pauseBattleField()

	self.selectList = {}

	self:updatePanel()
	self:updateSpecialPanel()
end

function TowerDefenceListPanel:initSpecialPanel()
	self.maskPanel = ccui.Layout:create()

	self.maskPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.maskPanel:setTouchEnabled(true)
	self.maskPanel:setVisible(false)
	self.maskPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.maskPanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.maskPanel:setBackGroundColorOpacity(150)
	self:addChild(self.maskPanel)
	self.maskPanel:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exitSpecial()
	end)
	;(function()
		local var_21_0 = ccui.Layout:create()

		var_21_0:setName("select")
		self.maskPanel:addChild(var_21_0)

		local var_21_1 = ccui.Button:create(var_0_11 .. "select_sure_btn.png", nil, var_0_11 .. "select_sure_btn.png", var_0_10)

		var_21_1:setAnchorPoint(cc.p(1, 0))
		var_21_1:setPosition(640, 400)
		var_21_0:addChild(var_21_1)
		var_21_1:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:batchAddRoles()
		end)

		function var_21_0.updateChildPanel(arg_23_0)
			return
		end
	end)()
	;(function()
		local var_24_0 = ccui.Layout:create()

		var_24_0:setName("xp")
		self.maskPanel:addChild(var_24_0)

		local var_24_1 = ccui.ImageView:create("public/currency/888888.png", var_0_10)

		var_24_1:setVisible(false)
		var_24_1:setAnchorPoint(cc.p(1, 0.5))
		var_24_1:setPosition(520 - 4, 600)
		var_24_0:addChild(var_24_1)

		local var_24_2 = cc.Label:createWithTTF("×" .. global_trans_number(playermodel.diamond), FONT_NAME, 24)

		var_24_2:setVisible(false)
		var_24_2:setAnchorPoint(cc.p(0, 0.5))
		var_24_2:setPosition(520 + 4, 600)
		var_24_0:addChild(var_24_2)

		local var_24_3 = ccui.ImageView:create("equipment/19900001.png")

		var_24_3:setScale(0.4)
		var_24_3:setAnchorPoint(cc.p(1, 0.5))
		var_24_3:setPosition(520 - 4, 540)
		var_24_0:addChild(var_24_3)

		local var_24_4 = cc.Label:createWithTTF("×" .. item_manager:getItemNumber(19900001), FONT_NAME, 24)

		var_24_4:setAnchorPoint(cc.p(0, 0.5))
		var_24_4:setPosition(520 + 4, 540)
		var_24_0:addChild(var_24_4)

		local var_24_5 = cc.Label:createWithTTF(L_TOWER_DEFENCE_FREE_XP_STR .. tower_defence_manager:getXPFreeCount(), FONT_NAME, 24)

		var_24_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_5:setPosition(520 - 28, 480)
		var_24_0:addChild(var_24_5)

		function var_24_0.updateChildPanel()
			var_24_2:setString("×" .. global_trans_number(playermodel.diamond))
			var_24_4:setString("×" .. item_manager:getItemNumber(19900001))
			var_24_5:setString(L_TOWER_DEFENCE_FREE_XP_STR .. tower_defence_manager:getXPFreeCount())
		end
	end)()
end

function TowerDefenceListPanel:updateSpecialPanel()
	for iter_26_0, iter_26_1 in pairs(self.maskPanel:getChildren()) do
		if iter_26_1:getName() == self.special_type then
			iter_26_1:setVisible(true)
			iter_26_1:updateChildPanel()
		else
			iter_26_1:setVisible(false)
		end
	end
end

function TowerDefenceListPanel:exitSpecial()
	self.special_type = nil

	self.maskPanel:setVisible(false)
	FightManager.resumeBattleField()
	self:updateUI()
end

function TowerDefenceListPanel:playerSpecialTouchEvent(arg_28_1, arg_28_2)
	if self.special_lock then
		return
	end

	local var_28_0 = "players@" .. arg_28_1 + #tower_defence_manager:getPlayerBaseConf()

	if self.special_type == "xp" then
		(function()
			if not tower_defence_manager:isRoleFighting(arg_28_2) then
				global_ShowBlockWords(L_TOWER_LIST[2])

				return
			end

			if self.xpWaitingList[arg_28_2] then
				return
			end

			self.xpWaitingList[arg_28_2] = true

			if FightManager.getCharacter(var_28_0) then
				if FightManager.getCharacter(var_28_0):checkXPStatusOnTower("xp") and FightManager.getEnemyCount() > 0 then
					self.special_lock = true

					tower_defence_manager:costSpecialItem(self.special_type, function(arg_30_0)
						if arg_30_0.result == 1 then
							FightManager.getCharacter(var_28_0):useSkillManual("xp")
							self:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
								self.xpWaitingList[arg_28_2] = nil
							end)))
							self:exitSpecial()

							self.special_lock = false

							self.xpBtn:getChildByName("label"):setString(tower_defence_manager:getXPItemNum() .. "+" .. tower_defence_manager:getXPFreeCount())
						elseif arg_30_0.result == 6 then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 1
							})

							self.special_lock = false
							self.xpWaitingList[arg_28_2] = nil
						else
							self.special_lock = false
							self.xpWaitingList[arg_28_2] = nil

							self:exitSpecial()
						end
					end)

					goto label_29_0
				end
			end

			global_ShowBlockWords(L_TOWER_LIST[3])

			self.xpWaitingList[arg_28_2] = nil

			::label_29_0::
		end)()
	elseif self.special_type == "reflag" then
		(function()
			if not tower_defence_manager:isRoleDead(arg_28_2) then
				global_ShowBlockWords(L_TOWER_LIST[4])

				return
			end

			if tower_defence_manager.totalCost - tower_defence_manager:get_servant_cost(arg_28_2) < 0 then
				global_ShowBlockWords(L_TOWER_LIST[5])

				return
			end

			self.special_lock = true

			tower_defence_manager:costSpecialItem(self.special_type, function(arg_33_0)
				if arg_33_0.result == 1 then
					tower_defence_manager._dead[arg_28_2] = nil

					tower_defence_manager:addRoleByManual(arg_28_1)
					self:exitSpecial()

					self.special_lock = false

					self.reflagBtn:getChildByName("label"):setString(tower_defence_manager:getReflagItemNum())
				elseif arg_33_0.result == 6 then
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 1
					})

					self.special_lock = false
				else
					self:exitSpecial()

					self.special_lock = false
				end
			end)
		end)()
	elseif self.special_type == "select" then
		(function()
			if self.selectList[arg_28_2] then
				self.selectList[arg_28_2] = nil
			else
				if not self:checkSelectCost(arg_28_2) then
					global_ShowBlockWords(L_TOWER_LIST[5])

					return
				end

				if not self:checkSelectRoleLimit() then
					global_ShowBlockWords(L_TOWER_LIST[6])

					return
				end

				self.selectList[arg_28_2] = arg_28_1
			end

			self:updatePanelSp(arg_28_2)
			self.limitLabel:setString(TOWER_ROLE_LIMIT .. self:getSelectRoleNum() .. "/" .. tower_defence_manager:getRoleTotalLimitNum())
			self.limitLabel:setColor(self:getSelectRoleNum() >= tower_defence_manager:getRoleTotalLimitNum() and cc.c3b(255, 85, 85) or cc.c3b(255, 255, 255))
			self.costNumLabel:setString(self:getSelectTotalCost())
		end)()
	end
end

function TowerDefenceListPanel:updateXpCountUI()
	self.xpBtn:getChildByName("label"):setString(tower_defence_manager:getXPItemNum() .. "+" .. tower_defence_manager:getXPFreeCount())
end

function TowerDefenceListPanel:updateTotalCostUI()
	self.costNumLabel:setString(tower_defence_manager:getCurTotalCost())
end

function TowerDefenceListPanel:batchAddRoles()
	if next(self.selectList) == nil then
		global_ShowBlockWords(L_TOWER_LIST[7])

		return
	end

	if not self:checkSelectCost() then
		global_ShowBlockWords(L_TOWER_LIST[5])

		return
	end

	if not self:checkSelectRoleLimit() then
		global_ShowBlockWords(L_TOWER_LIST[6])

		return
	end

	for iter_37_0, iter_37_1 in pairs(self.selectList) do
		tower_defence_manager:addRoleByManual(iter_37_1)
	end

	self:exitSpecial()
end

function TowerDefenceListPanel:getSelectTotalCost(arg_38_1)
	local var_38_0 = tower_defence_manager:getCurTotalCost()

	for iter_38_0, iter_38_1 in pairs(self.selectList) do
		var_38_0 = var_38_0 - tower_defence_manager:get_servant_cost(iter_38_0)
	end

	if arg_38_1 then
		var_38_0 = var_38_0 - tower_defence_manager:get_servant_cost(arg_38_1)
	end

	return var_38_0
end

function TowerDefenceListPanel:getSelectRoleNum()
	return tower_defence_manager:getCurRoleNum() + table.nums(self.selectList)
end

function TowerDefenceListPanel:checkSelectCost(arg_40_1)
	return self:getSelectTotalCost(arg_40_1) >= 0
end

function TowerDefenceListPanel:checkSelectRoleLimit()
	return self:getSelectRoleNum() <= tower_defence_manager:getRoleTotalLimitNum()
end

function TowerDefenceListPanel:showMonsterDropSp(arg_42_1)
	local var_42_0
	local var_42_1
	local var_42_2

	if arg_42_1 == "xp" then
		var_42_0 = "equipment/19900001.png"
		var_42_1 = -50
		var_42_2 = cc.p(self.xpBtn:getPosition())
	elseif arg_42_1 == "cost" then
		var_42_0 = "equipment/tower_defence_cost.png"
		var_42_1 = 50
		var_42_2 = cc.p(self.costNumLabel:getPosition())
	end

	local var_42_3 = cc.Sprite:create(var_42_0)

	var_42_3:setPosition(320 + var_42_1, GameDisplay.height / 2 - 200)
	var_42_3:setOpacity(0)
	self:addChild(var_42_3)
	var_42_3:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.4), cc.MoveBy:create(0.4, cc.p(0, 200))), cc.DelayTime:create(0.6), cc.Spawn:create(cc.FadeTo:create(0.4, 80), cc.MoveTo:create(0.4, var_42_2)), cc.Hide:create(), cc.RemoveSelf:create()))
end

function TowerDefenceListPanel:setGlobalTouchLock(arg_43_1)
	self.globalTouchLock = arg_43_1
end

function TowerDefenceListPanel:addInitFightRoles()
	self:setGlobalTouchLock(true)

	local var_44_0 = 1
	local var_44_1 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		if tower_defence_manager.initFightRoles[var_44_0] then
			tower_defence_manager:addRoleByManual(tower_defence_manager.initFightRoles[var_44_0])
		else
			self:stopActionByTag(148)
			self:setGlobalTouchLock(false)
		end

		var_44_0 = var_44_0 + 1
	end)))

	var_44_1:setTag(148)
	self:runAction(var_44_1)
end

return TowerDefenceListPanel
