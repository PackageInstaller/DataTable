local var_0_0 = g.core.const.ConstMgr.PreciousConst
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local PreciousSuitDevSuccessLayer = class("PreciousSuitDevSuccessLayer", require("app.fairyGUI.precious.UI_PreciousSuitDevSuccessLayer"), function()
	return fgui.GComponent:create({
		resName = "PreciousSuitDevSuccessLayer",
		pkgPath = "ui/precious/precious",
		isFullScreen = true,
		pkgName = "precious"
	}, ...)
end)

function PreciousSuitDevSuccessLayer:ctor(arg_2_1)
	self._suitStruct = arg_2_1

	self:_initBtn()
	self:_initView()
end

function PreciousSuitDevSuccessLayer:onLoad()
	local var_3_0 = self.m_talentGroup:getPosition()
	local var_3_1 = self.m_skillGroup:getPosition()
	local var_3_2 = self.m_nameGroup:getPosition()

	self.m_enterTransition:changeParams({
		pt01 = {
			var_3_1.x - 20,
			var_3_1.y
		},
		pt02 = {
			var_3_1.x,
			var_3_1.y
		},
		pt03 = {
			var_3_0.x + 20,
			var_3_0.y
		},
		pt04 = {
			var_3_0.x,
			var_3_0.y
		},
		pt05 = {
			var_3_2.x,
			var_3_2.y + 20
		},
		pt06 = {
			var_3_2.x,
			var_3_2.y
		}
	})
	self.m_enterTransition:play()
	self:playEnterEffect()
end

function PreciousSuitDevSuccessLayer:playEnterEffect()
	local var_4_0

	if not self._suitStruct then
		do return end

		var_4_0 = {
			name = "eff_ui_precious_title",
			remove = true,
			isLoop = false
		}
	end

	var_4_0.anim = "play_" .. self._suitStruct:getQuality() + 1

	self.m_effTitle:addEffectSpine(var_4_0)
	self.m_suitComp:showEffect()
end

function PreciousSuitDevSuccessLayer:_initBtn()
	self:addClickListener(handler(self, self._onClick))
end

function PreciousSuitDevSuccessLayer:_initView()
	self:addBg("bg/precious/bg_gzp_xinxizhanshibg.png", nil, nil, 1)

	if not self._suitStruct then
		return
	end

	local var_6_0 = self._suitStruct:getStar()

	self.m_stateController:setSelectedIndex(var_6_0 == 0 and 0 or 1)
	self.m_suitComp:updateMainCell(self._suitStruct, {
		ignoreRedPoint = true,
		ignoreTouch = true
	})

	local var_6_1 = self._suitStruct:getCfg()

	self.m_suitNameText:setText(var_6_1.name)
	self.m_starComp:initStar({
		style = 2,
		index = 3,
		gap = 4,
		max = var_0_0.SUIT_MAX_STAR_NUM,
		num = var_6_0
	})

	local var_6_2 = self._suitStruct:getMaxStarTalentSkillList()

	for iter_6_0 = 1, #var_6_2 do
		if var_6_2[iter_6_0].star == var_6_0 then
			local var_6_3 = g.core.config.talent_skill_info.get(var_6_2[iter_6_0].skillId)

			self.m_talentNameText:setText(g.core.lang:get(421215, {
				name = var_6_3.name
			}))
			self.m_talentDescText:setText(var_6_3.description)

			break
		end
	end

	if var_6_1.passive_skill_id > 0 then
		self.m_showSkillController:setSelectedIndex(1)
		self.m_skillIcon:updateIcon({
			skillId = g.core.config.passive_skill_info.get(var_6_1.passive_skill_id).passive_skill_value
		})
	else
		self.m_showSkillController:setSelectedIndex(0)
	end

	local var_6_4 = self._suitStruct:getQuality()

	if var_6_4 > var_0_1.SSR then
		self.m_qualityzsBg:setURL("ui://base_new/pic_gzp_wupinyuandi" .. var_6_4 + 1)
		self.m_qualityxxzsBg:setURL("ui://base_new/pic_gzp_xinxizhanshidi" .. var_6_4 + 1)
	else
		self.m_qualityzsBg:setURL("ui://base_new/pic_gzp_wupinyuandi4")
		self.m_qualityxxzsBg:setURL("ui://base_new/pic_gzp_xinxizhanshidi4")
	end
end

function PreciousSuitDevSuccessLayer:_onClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PreciousSuitDevSuccessLayer
