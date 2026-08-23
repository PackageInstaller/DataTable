local var_0_0 = g.core.model.User.ableFragmentData
local var_0_1 = g.core.const.ConstMgr.SuccubaConst
local var_0_2 = g.core.model.User.succubaData
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User.fragmentsData
local var_0_5 = g.core.const.ConstMgr.ShopConst
local SuccubaStarUpComp = class("SuccubaStarUpComp", require("app.fairyGUI.succuba.UI_SuccubaStarUpComp"))

function SuccubaStarUpComp:ctor()
	self._succubaStruct = nil

	self:_initBtn()
end

function SuccubaStarUpComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_STARUP, handler(self, self._onRecvStarUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, handler(self, self._onItemTransform), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, handler(self, self._onSell), self)
end

function SuccubaStarUpComp:_onSell()
	local var_3_0 = self._succubaStruct:getCurStarCfg().fragment

	self.m_overflowFragIcon:updateIcon({
		type = var_0_3.TYPE_FRAGMENT,
		value = var_3_0,
		size = var_0_4:getFragmentNumById(var_3_0)
	})
end

function SuccubaStarUpComp:_onItemTransform()
	local var_4_0 = self._succubaStruct:getCurStarCfg()
	local var_4_1 = var_0_4:getFragmentNumById(var_4_0.fragment)

	self.m_fragIcon:updateIcon({
		type = var_0_3.TYPE_FRAGMENT,
		value = var_4_0.fragment,
		size = var_4_1
	})
	self.m_fragNameText:setText(g.core.config.fragment_info.get(var_4_0.fragment).name)

	local var_4_2 = var_4_0.next_star_num
	local var_4_3 = math.min(var_4_1, var_4_0.next_star_num)

	self.m_progText:setText(var_4_3 .. "/" .. var_4_0.next_star_num)
	self.m_progBar:setPercent({
		init = 0,
		cur = var_4_3,
		max = var_4_2
	})
	self.m_enoughController:setSelectedIndex(var_4_2 <= var_4_3 and 1 or 0)
end

function SuccubaStarUpComp:_initBtn()
	self.m_baseAttrComp:addClickListener(handler(self, self._onBaseAttrClick))
	self.m_talentSkillComp:addClickListener(handler(self, self._onTalentSkillClick))
	self.m_charmLvComp:addClickListener(handler(self, self._onCharmLvClick))
	self.m_starUpBtn:addClickListener(handler(self, self._onStarUpBtnClick))
	self.m_fragBtn:addClickListener(handler(self, self._onFragBtnClick))
	self.m_fragSellBtn:addClickListener(handler(self, self._onFragSellBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
end

function SuccubaStarUpComp:_onFragBtnClick()
	local var_6_0 = self._succubaStruct:getCurStarCfg()
	local var_6_1 = var_0_4:getFragmentNumById(var_6_0.fragment)

	if var_6_1 >= var_6_0.next_star_num then
		g.core.module.ModuleManager:tip(g.core.lang:get(431050))

		return
	end

	local var_6_2 = var_6_0.fragment
	local var_6_3 = g.core.config.fragment_info.get(var_6_0.fragment)

	if #var_0_0:getAbleFragmentSuccubaList(var_6_3.quality, var_6_3.rare) > 0 then
		local AbleFragmentConvertPop = require("app.view.base.infoPop.AbleFragmentConvertPop")

		g.core.module.ModuleManager:pushPopup((AbleFragmentConvertPop.new({
			id = var_6_2,
			type = AbleFragmentConvertPop.SUCCUBA,
			num = var_6_0.next_star_num - var_6_1
		})))
	else
		local var_6_5 = var_0_0:getAbleFragmentId(var_6_2, var_0_1.ABLE_FRAGMENT_TYPE)

		if var_6_5 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_0_3.TYPE_ITEM,
				value = var_6_5,
				size = g.core.model.User.bagData:getOwnNum(var_0_3.TYPE_ITEM, var_6_5)
			})
		end
	end
end

function SuccubaStarUpComp:_onFragSellBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(var_0_2:getCanSellFrag(), {
		fragNameId = 431032,
		qualityArr = {
			g.core.const.ConstMgr.QUALITY_TYPE.MR,
			g.core.const.ConstMgr.QUALITY_TYPE.UR
		},
		title = g.core.lang:get(431031),
		emptyTitle = g.core.lang:get(431033)
	})))
end

function SuccubaStarUpComp:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_5.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_5.SHOP_TYPE.CRYSTAL
	})
end

function SuccubaStarUpComp:updateView(arg_9_1)
	if not arg_9_1 or not arg_9_1.data or not arg_9_1.data.advId then
		return
	end

	local var_9_0 = var_0_2:getSuccubaByAdvanceId(arg_9_1.data.advId)

	if not var_9_0 then
		return
	end

	self._succubaStruct = var_9_0

	local var_9_1 = var_9_0:getStar()

	self.m_starText:setText(var_9_1)
	self.m_starMaxText:setText(var_9_1)
	self.m_starNextText:setText(var_9_1 + 1)

	local var_9_2, var_9_3 = var_9_0:getStarMainSkillList()
	local var_9_4 = {}

	for iter_9_0 = 1, #var_9_2 do
		local var_9_5 = var_9_2[iter_9_0]
		local var_9_6 = g.core.config.skill_info.get(var_9_2[iter_9_0].skillId)
		local var_9_7 = var_9_1 >= var_9_2[iter_9_0].star and 0 or 1
		local var_9_8 = g.core.lang:get(431024, {
			name = var_9_6.curtain_name,
			lv = var_9_6.level
		})
		local var_9_9 = g.core.utils.String.formatSkillDesc(var_9_2[iter_9_0].skillId)

		if (var_9_1 >= var_9_2[iter_9_0].star and 0 or 1) == 1 then
			var_9_9 = var_9_9 .. g.core.lang:get(431011, {
				star = var_9_5.star
			})
		end

		table.insert(var_9_4, {
			state = var_9_7,
			level = var_9_8,
			text = var_9_9
		})
	end

	local var_9_10 = var_9_0:getCurStarCfg()

	self.m_skillIcon1:openClick()
	self.m_skillIcon1:updateIcon({
		skillId = var_9_10.skill_id,
		skillDescList = var_9_4
	})
	self.m_skillNameText1:setText(g.core.lang:get(201029, {
		name = g.core.config.skill_info.get(var_9_10.skill_id).curtain_name
	}))
	self.m_skillDescText1:getChild("title"):setText(g.core.utils.String.formatSkillDesc(var_9_10.skill_id))

	local var_9_11 = {}

	for iter_9_1 = 1, #var_9_3 do
		local var_9_12 = var_9_3[iter_9_1]
		local var_9_13 = g.core.config.passive_skill_info.get(var_9_3[iter_9_1].skillId)
		local var_9_14 = var_9_1 >= var_9_3[iter_9_1].star and 0 or 1
		local var_9_15 = g.core.lang:get(431024, {
			name = g.core.config.skill_info.get(var_9_13.passive_skill_value).curtain_name,
			lv = var_9_13.level
		})
		local var_9_16 = g.core.utils.String.formatPassiveSkillDesc(var_9_3[iter_9_1].skillId)

		if (var_9_1 >= var_9_3[iter_9_1].star and 0 or 1) == 1 then
			var_9_16 = var_9_16 .. g.core.lang:get(431011, {
				star = var_9_12.star
			})
		end

		table.insert(var_9_11, {
			state = var_9_14,
			level = var_9_15,
			text = var_9_16
		})
	end

	self.m_skillIcon2:openClick()
	self.m_skillIcon2:updateIcon({
		isPassive = true,
		skillId = var_9_10.passive_skill_1,
		skillDescList = var_9_11
	})

	local var_9_17, var_9_18 = g.core.utils.String.formatPassiveSkillDesc(var_9_10.passive_skill_1)

	self.m_skillNameText2:setText(g.core.lang:get(201029, {
		name = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(var_9_10.passive_skill_1).passive_skill_value).curtain_name
	}))
	self.m_skillDescText2:getChild("title"):setText(var_9_17)

	local var_9_19, var_9_20 = var_9_0:getCurStarTalentSkill()
	local var_9_21 = g.core.config.talent_skill_info.get(var_9_20)

	self.m_talentSkillComp:setTitle((var_9_0:isMaxLevel() or nil) and (g.core.lang:get(430715) or g.core.lang:get(431009, {
		name = var_9_21.name,
		desc = var_9_21.description
	})))

	local var_9_22 = var_9_10.fragment
	local var_9_23 = var_0_4:getFragmentNumById(var_9_10.fragment)

	self.m_fragIcon:updateIcon({
		type = var_0_3.TYPE_FRAGMENT,
		value = var_9_10.fragment,
		size = var_9_23
	})
	self.m_fragNameText:setText(g.core.config.fragment_info.get(var_9_22).name)

	local var_9_24 = var_9_10.next_star_num
	local var_9_25 = math.min(var_9_23, var_9_10.next_star_num)

	self.m_progText:setText(var_9_25 .. "/" .. var_9_10.next_star_num)
	self.m_progBar:setPercent({
		init = 0,
		cur = var_9_25,
		max = var_9_24
	})
	self.m_enoughController:setSelectedIndex(var_9_24 <= var_9_25 and 1 or 0)

	local var_9_26 = var_9_0:isMaxStar()

	self.m_isStarMaxController:setSelectedIndex(var_9_26 and 1 or 0)

	if var_9_26 then
		self.m_overflowFragIcon:updateIcon({
			type = var_0_3.TYPE_FRAGMENT,
			value = var_9_22,
			size = var_9_23
		})
	end
end

function SuccubaStarUpComp:_onBaseAttrClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	if not self._succubaStruct then
		return
	end

	local var_10_0 = self._succubaStruct:getCurStarCfg()
	local var_10_1 = self._succubaStruct:getNextStarCfg()
	local var_10_2 = self._succubaStruct:isMaxStar()
	local var_10_3 = {}

	for iter_10_0 = 1, 4 do
		table.insert(var_10_3, {
			type = var_0_1.STAR_ATTR_TYPE[iter_10_0].type,
			value = var_10_0[var_0_1.STAR_ATTR_TYPE[iter_10_0].key],
			nextValue = (not var_10_2 or nil) and var_10_1[var_0_1.STAR_ATTR_TYPE[iter_10_0].key]
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonAttrPop").new({
		attrList = var_10_3,
		isMax = var_10_2
	}), {
		touchDisappear = true
	})
end

function SuccubaStarUpComp:_onTalentSkillClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	if not self._succubaStruct then
		return
	end

	local var_11_0 = self._succubaStruct:getStar()
	local var_11_1 = self._succubaStruct:getStarTalentSkillList()
	local var_11_2 = {}

	for iter_11_0 = 1, #var_11_1 do
		local var_11_3 = var_11_1[iter_11_0]
		local var_11_4 = g.core.config.talent_skill_info.get(var_11_1[iter_11_0].skillId)
		local var_11_5 = var_11_0 >= var_11_1[iter_11_0].star and 0 or 1
		local var_11_6 = g.core.lang:get(430702, {
			name = var_11_4.name
		})
		local var_11_7 = ""

		var_11_7 = (var_11_0 >= var_11_1[iter_11_0].star and 0 or 1) == 1 and var_11_4.description .. g.core.lang:get(431011, {
			star = var_11_3.star
		}) or var_11_4.description

		table.insert(var_11_2, {
			descType = 0,
			titleType = 0,
			state = var_11_5,
			title = var_11_6,
			desc = var_11_7
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_11_2,
		title = g.core.lang:get(431013)
	}), {
		touchDisappear = true
	})
end

function SuccubaStarUpComp:_onCharmLvClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	local var_12_0, var_12_1, var_12_2, var_12_3

	if not self._succubaStruct then
		do return end

		var_12_0 = self._succubaStruct:getNextStarCfg()
		var_12_1 = self._succubaStruct:isMaxStar()
		var_12_2 = {}
		var_12_3 = {
			iconRes = "icon/attrIcon/icon_meilizhi.png",
			name = g.core.lang:get(431008)
		}
	end

	var_12_3.value = self._succubaStruct:getStarCharm(self._succubaStruct:getCurStarCfg().star)
	var_12_3.nextValue = var_12_0 and self._succubaStruct:getStarCharm(var_12_0.star) or 0
	var_12_2[1] = var_12_3

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonAttrPop").new({
		attrList = var_12_2,
		isMax = var_12_1,
		title = g.core.lang:get(431023)
	}), {
		touchDisappear = true
	})
end

function SuccubaStarUpComp:_onStarUpBtnClick()
	if not self._succubaStruct then
		return
	end

	if self._succubaStruct:isMaxStar() then
		return
	end

	local var_13_0 = self._succubaStruct:getCurStarCfg()

	if var_0_4:getFragmentNumById(var_13_0.fragment) < var_13_0.next_star_num then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_0_3.TYPE_FRAGMENT,
			value = var_13_0.fragment
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_Succuba_StarUp({
		id = self._succubaStruct:getSid()
	})
end

function SuccubaStarUpComp:_onRecvStarUp(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if not self._succubaStruct then
		return
	end

	local var_14_0 = self._succubaStruct:getStarUpSound()

	if var_14_0 ~= "" and var_14_0 ~= "0" then
		g.core.sound.SoundManager:playSound(var_14_0)
	end
end

return SuccubaStarUpComp
