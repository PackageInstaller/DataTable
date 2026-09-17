local buff_data = require("data.buff_data")
local var_0_2 = "skill_new/buff_frame_up.png"
local var_0_3 = "skill_new/buff_frame_down.png"
local var_0_4 = config._DEBUG and 0 or 1
local BuffSP = class("BuffSP", function()
	return cc.Node:create()
end)

function BuffSP:create(arg_2_1, arg_2_2)
	local var_2_0 = BuffSP.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function BuffSP:init(arg_3_1, arg_3_2)
	self._buffid = arg_3_1
	self._count = arg_3_2

	local var_3_0 = buff_data[arg_3_1]

	if buff_data[arg_3_1].buff_or_debuff == 0 then
		local var_3_1 = var_0_3 or var_0_2
		local var_3_2

		if config._DEBUG then
			var_3_2 = cc.Sprite:create(var_3_1) or cc.Sprite:createWithSpriteFrameName(var_3_1)
		end
	end

	self:addChild(var_3_2)

	local var_3_3 = ccui.ImageView:create("skill_new/skill/" .. var_3_0.buff_image .. ".png", var_0_4)

	var_3_3:setTouchEnabled(true)
	var_3_3:setScale(0.2777777777777778)
	self:addChild(var_3_3)
	self:initCountLabel()
end

function BuffSP:initCountLabel()
	self.countlabel = cc.Label:createWithTTF("", "fonts/W5.ttf", 20)

	self.countlabel:setAnchorPoint(cc.p(1, 0))
	self.countlabel:setPosition(cc.p(20, -20))
	self:addChild(self.countlabel, 1)
	self:updateCountLabel()
end

function BuffSP:updateCountLabel()
	if self._count > 1 then
		self.countlabel:setVisible(true)
		self.countlabel:setString("X" .. self._count)
	else
		self.countlabel:setVisible(false)
	end
end

function BuffSP:pushBuff(arg_6_1)
	arg_6_1 = arg_6_1 or 1
	self._count = self._count + arg_6_1

	self:updateCountLabel()
end

function BuffSP:removeBuff(arg_7_1)
	arg_7_1 = arg_7_1 or 1
	self._count = self._count - arg_7_1

	self:updateCountLabel()
end

function BuffSP:getBuffCount()
	return self._count
end

function BuffSP:getSize()
	return cc.size(40, 40)
end

function BuffSP:getID()
	return self._buffid
end

local FightBuffPanel = class("FightBuffPanel", function()
	return cc.Node:create()
end)

function FightBuffPanel:create()
	local var_12_0 = FightBuffPanel.new()

	var_12_0:init()

	return var_12_0
end

function FightBuffPanel:init()
	self.buffs = {}
	self.anchorpoint = 0.5
end

function FightBuffPanel:setAnchor(arg_14_1)
	self.anchorpoint = arg_14_1
end

function FightBuffPanel:pushBuff(arg_15_1, arg_15_2)
	if not buff_data[arg_15_1] or not buff_data[arg_15_1].buff_image or buff_data[arg_15_1].image_show and buff_data[arg_15_1].image_show == 0 then
		return
	end

	arg_15_2 = arg_15_2 or 1

	local var_15_0 = self:findBuff(arg_15_1)

	if var_15_0 then
		self.buffs[var_15_0]:pushBuff(arg_15_2)
	elseif #self.buffs < 10 then
		local var_15_1 = BuffSP:create(arg_15_1, arg_15_2)

		self:addChild(var_15_1)
		table.insert(self.buffs, var_15_1)
		self:updateBuffPos()
	end
end

function FightBuffPanel:removeBuff(arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or 1

	local var_16_0 = self:findBuff(arg_16_1)

	if not var_16_0 then
		return
	end

	local var_16_1 = self.buffs[var_16_0]

	self.buffs[var_16_0]:removeBuff(arg_16_2)

	if var_16_1:getBuffCount() <= 0 then
		var_16_1:removeFromParent()
		table.remove(self.buffs, var_16_0)
		self:updateBuffPos()
	end
end

function FightBuffPanel:updateBuffPos()
	for iter_17_0, iter_17_1 in ipairs(self.buffs) do
		iter_17_1:setPosition(cc.p(15 + 35 * (iter_17_0 - 1) - self.anchorpoint * 35 * (#self.buffs - 1), 0))
	end
end

function FightBuffPanel:findBuff(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self.buffs) do
		if iter_18_1:getID() == arg_18_1 then
			return iter_18_0
		end
	end

	return nil
end

function FightBuffPanel:removeAllBuff()
	for iter_19_0, iter_19_1 in pairs(self.buffs) do
		iter_19_1:removeFromParent()
	end

	self.buffs = {}
end

local PlayerFightBuffPanel = class("PlayerFightBuffPanel", FightBuffPanel)
local model_data = require("data.model_data")

function PlayerFightBuffPanel:create()
	local var_20_0 = PlayerFightBuffPanel.new()

	var_20_0:init()

	return var_20_0
end

function PlayerFightBuffPanel:init()
	self.modelid = nil

	self.super.init(self)
	self:initRoleUI()
end

function PlayerFightBuffPanel:initRoleUI()
	self.imgFrame = ccui.ImageView:create("FightLayer/bg_head_buff.png", var_0_4)

	self.imgFrame:setVisible(false)
	self.imgFrame:setPosition(cc.p(-45, -20))
	self:addChild(self.imgFrame, 5)

	self.imgRole = ccui.ImageView:create()

	self.imgRole:setScale(0.28)
	self.imgRole:setAnchorPoint(cc.p(0.5, 0))
	self.imgRole:setPosition(cc.p(self.imgFrame:getContentSize().width / 2, self.imgFrame:getContentSize().height / 2 - 20))
	self.imgFrame:addChild(self.imgRole)

	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(150, 50))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_22_0:setAnchorPoint(cc.p(0, 0.5))
	var_22_0:setPosition(cc.p(-50, 0))
	self:addChild(var_22_0, 10)
	var_22_0:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if FightManager.getFightState() ~= FIGHTSTATE_FIGHTING then
			return
		end

		if config._DEVELOP_MODE == "FIGHTDEV" then
			FightManager.pauseBattleField()
			require("view.Layer.Pops.PopBaseLayer")
			FightLayer.getInstance():addChild(PopBuffPanel:create(), 99)
		else
			if FightManager.getFightType() == FIGHTTYPE_ARENA then
				return
			end

			FightManager.pauseBattleField()
			arg_23_0:setTouchEnabled(false)
			LayerManager:pushInLayer("PopBuffPanel", {
				exitcallback = function()
					arg_23_0:setTouchEnabled(true)
				end
			})
		end
	end)

	self.touchPanel = var_22_0
end

function PlayerFightBuffPanel:reset()
	self.imgFrame:setVisible(false)
	self.touchPanel:setTouchEnabled(true)
end

function PlayerFightBuffPanel:registerFightBinding(arg_26_1, arg_26_2)
	self.modelid = arg_26_1

	self.imgRole:loadTexture("role/wuji/" .. model_data[arg_26_1].head_image .. ".png")
end

function PlayerFightBuffPanel:unregisterFightBinding()
	self.modelid = nil

	self.imgFrame:setVisible(false)
	self:removeAllBuff()
end

function PlayerFightBuffPanel:pushBuff(arg_28_1, arg_28_2)
	if not buff_data[arg_28_1] or not buff_data[arg_28_1].buff_image or buff_data[arg_28_1].image_show and buff_data[arg_28_1].image_show == 0 then
		return
	end

	self.super.pushBuff(self, arg_28_1, arg_28_2)
	self.imgFrame:setVisible(true)
end

function PlayerFightBuffPanel:removeBuff(arg_29_1, arg_29_2)
	self.super.removeBuff(self, arg_29_1, arg_29_2)

	if #self.buffs <= 0 then
		self.imgFrame:setVisible(false)
	end
end

local BuffSPV2 = class("BuffSPV2")

function BuffSPV2:create(arg_30_1, arg_30_2)
	local var_30_0 = BuffSPV2.new()

	var_30_0:init(arg_30_1, arg_30_2)

	return var_30_0
end

function BuffSPV2:init(arg_31_1, arg_31_2)
	self._buffid = arg_31_1
	self._count = arg_31_2
	self._icon = nil
	self._countlabel = nil
end

function BuffSPV2:pushBuff(arg_32_1)
	arg_32_1 = arg_32_1 or 1
	self._count = self._count + arg_32_1

	self:updateCountLabel()
end

function BuffSPV2:removeBuff(arg_33_1)
	arg_33_1 = arg_33_1 or 1
	self._count = self._count - arg_33_1

	self:updateCountLabel()
end

function BuffSPV2:getBuffCount()
	return self._count
end

function BuffSPV2:getSize()
	return cc.size(40, 40)
end

function BuffSPV2:getID()
	return self._buffid
end

function BuffSPV2:canShowIcon()
	if not buff_data[self._buffid] then
		return false
	end

	if not buff_data[self._buffid].buff_image then
		return false
	end

	if buff_data[self._buffid].image_show == 0 then
		return false
	end

	return true
end

function BuffSPV2:createBuffIcon()
	local var_38_0 = buff_data[self._buffid]

	self._icon = cc.Node:create()

	self._icon:addChild((ccui.ImageView:create("FightLayer/buff_bg.png", var_0_4)))

	local var_38_1 = cc.ClippingNode:create()

	var_38_1:setInverted(false)
	var_38_1:setAlphaThreshold(0.1)
	self._icon:addChild(var_38_1, 1)
	var_38_1:setStencil((config._DEBUG or nil) and (cc.Sprite:create("FightLayer/buff_stencil.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/buff_stencil.png")))

	local var_38_2 = ccui.ImageView:create("skill_new/skill/" .. var_38_0.buff_image .. ".png", var_0_4)

	var_38_2:setScale(0.38)
	var_38_1:addChild(var_38_2)
	self:initCountLabel()

	return self._icon
end

function BuffSPV2:initCountLabel()
	self._countlabel = cc.Label:createWithTTF("", "fonts/name.ttf", 12)

	self._countlabel:setAnchorPoint(cc.p(1, 0))
	self._countlabel:setPosition(cc.p(15, -15))
	self._icon:addChild(self._countlabel, 2)
	self:updateCountLabel()
end

function BuffSPV2:updateCountLabel()
	if not self._countlabel then
		return
	end

	if self._count > 1 then
		self._countlabel:setVisible(true)
		self._countlabel:setString("X" .. self._count)
	else
		self._countlabel:setVisible(false)
	end
end

function BuffSPV2:getBuffIcon()
	return self._icon
end

function BuffSPV2:isShowIcon()
	return self._icon ~= nil
end

function BuffSPV2:removeBuffIcon()
	if not self._icon then
		return
	end

	self._icon:removeFromParent()

	self._icon = nil
	self._countlabel = nil
end

local FightBuffPanelV2 = class("FightBuffPanelV2", function()
	return cc.Node:create()
end)

function FightBuffPanelV2:create()
	local var_45_0 = FightBuffPanelV2.new()

	var_45_0:init()

	return var_45_0
end

FightBuffPanelV2.PANELDIRECTION = {
	HORIZONTAL = 0,
	VERTICAL = 1
}

function FightBuffPanelV2:init()
	self.buffs = {}
	self._direction = FightBuffPanelV2.PANELDIRECTION.HORIZONTAL
	self._anchorpoint = 0.5
	self._skew = 0
	self._maxshowcount = 3
	self._showcount = 0
	self._interval = 38
	self._intervaly = 0
end

function FightBuffPanelV2:setAnchor(arg_47_1)
	self._anchorpoint = arg_47_1
end

function FightBuffPanelV2:setDirection(arg_48_1)
	self._direction = arg_48_1
end

function FightBuffPanelV2:setSkew(arg_49_1)
	self._skew = arg_49_1
end

function FightBuffPanelV2:setShowCount(arg_50_1)
	self._maxshowcount = arg_50_1
end

function FightBuffPanelV2:setInterval(arg_51_1)
	self._interval = arg_51_1
end

function FightBuffPanelV2:setIntervalY(arg_52_1)
	self._intervaly = arg_52_1
end

function FightBuffPanelV2:pushBuff(arg_53_1, arg_53_2)
	arg_53_2 = arg_53_2 or 1

	local var_53_0 = self:findBuff(arg_53_1)

	if var_53_0 then
		self.buffs[var_53_0]:pushBuff(arg_53_2)
	else
		local var_53_1 = BuffSPV2:create(arg_53_1, arg_53_2)

		table.insert(self.buffs, var_53_1)

		if self._showcount < self._maxshowcount and var_53_1:canShowIcon() then
			self:addChild((var_53_1:createBuffIcon()))

			self._showcount = self._showcount + 1

			self:update()
		end
	end
end

function FightBuffPanelV2:removeBuff(arg_54_1, arg_54_2)
	arg_54_2 = arg_54_2 or 1

	local var_54_0 = self:findBuff(arg_54_1)

	if not var_54_0 then
		return
	end

	local var_54_1 = self.buffs[var_54_0]

	self.buffs[var_54_0]:removeBuff(arg_54_2)

	if var_54_1:getBuffCount() <= 0 then
		table.remove(self.buffs, var_54_0)

		if var_54_1:isShowIcon() then
			var_54_1:removeBuffIcon()

			self._showcount = self._showcount - 1

			if self._showcount < self._maxshowcount then
				local var_54_2 = self:findNextBuffIcon(var_54_0)

				if var_54_2 then
					self:addChild((self.buffs[var_54_2]:createBuffIcon()))

					self._showcount = self._showcount + 1
				end
			end

			self:update()
		end
	end
end

function FightBuffPanelV2:findBuff(arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(self.buffs) do
		if iter_55_1:getID() == arg_55_1 then
			return iter_55_0
		end
	end

	return nil
end

function FightBuffPanelV2:findNextBuffIcon(arg_56_1)
	local var_56_0

	arg_56_1 = arg_56_1 or 1

	for iter_56_0 = arg_56_1, #self.buffs do
		if self.buffs[iter_56_0]:canShowIcon() and not self.buffs[iter_56_0]:isShowIcon() then
			var_56_0 = iter_56_0

			break
		end
	end

	return var_56_0
end

function FightBuffPanelV2:removeAllBuff()
	for iter_57_0, iter_57_1 in ipairs(self.buffs) do
		iter_57_1:removeBuffIcon()
	end

	self._showcount = 0
	self.buffs = {}
end

function FightBuffPanelV2:update()
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in ipairs(self.buffs) do
		if iter_58_1:isShowIcon() then
			var_58_0 = var_58_0 + 1

			iter_58_1:getBuffIcon():setPosition(cc.p(15 + self._interval * (var_58_0 - 1) - self._anchorpoint * self._interval * (self._showcount - 1), self._intervaly * (var_58_0 - 1) - self._anchorpoint * self._intervaly * (self._showcount - 1)))

			if var_58_0 >= self._showcount then
				break
			end
		end
	end
end

local PlayerFightBuffPanelV2 = class("PlayerFightBuffPanelV2", FightBuffPanelV2)

function PlayerFightBuffPanelV2:create()
	local var_59_0 = PlayerFightBuffPanelV2.new()

	var_59_0:init()

	return var_59_0
end

function PlayerFightBuffPanelV2:init()
	self.super.init(self)

	local var_60_0 = ccui.Layout:create()

	var_60_0:setTouchEnabled(true)
	var_60_0:setContentSize(cc.size(150, 50))
	var_60_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_60_0:setAnchorPoint(cc.p(0, 0.5))
	var_60_0:setPosition(cc.p(-50, 0))
	self:addChild(var_60_0, 10)
	var_60_0:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		if FightManager.getFightState() ~= FIGHTSTATE_FIGHTING then
			return
		end

		if config._DEVELOP_MODE == "FIGHTDEV" then
			FightManager.pauseBattleField()
			require("view.Layer.Pops.PopBaseLayer")
			FightLayer.getInstance():addChild(PopBuffPanel:create(), 99)
		else
			if FightManager.getFightType() == FIGHTTYPE_ARENA then
				return
			end

			FightManager.pauseBattleField()
			arg_61_0:setTouchEnabled(false)
			LayerManager:pushInLayer("PopBuffPanel", {
				exitcallback = function()
					arg_61_0:setTouchEnabled(true)
				end
			})
		end
	end)

	self.touchPanel = var_60_0
end

function PlayerFightBuffPanelV2:reset()
	self.touchPanel:setTouchEnabled(true)
	self:removeAllBuff()
end

function PlayerFightBuffPanelV2:registerFightBinding(arg_64_1, arg_64_2)
	return
end

function PlayerFightBuffPanelV2:unregisterFightBinding()
	self:removeAllBuff()
end

return {
	create = function(arg_66_0)
		return FightBuffPanel:create()
	end,
	createPlayer = function(arg_67_0)
		return PlayerFightBuffPanel:create()
	end,
	createPlayerV2 = function(arg_68_0)
		return PlayerFightBuffPanelV2:create()
	end
}
