local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.config.gve_boss_info
local var_0_4 = g.core.config.monster_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local GveInstituteBossComp = class("GveInstituteBossComp", require("app.fairyGUI.gve.UI_GveInstituteBossComp"))

function GveInstituteBossComp:ctor()
	var_0_1 = var_0_0:getGveData()
end

function GveInstituteBossComp:updateByBossData(arg_2_1)
	local var_2_0 = var_0_3.get(arg_2_1.boss_id)
	local var_2_1 = var_0_2.get(var_2_0.image)
	local var_2_2 = KnightStruct.new(var_2_1.advance_id)

	var_2_2:addCfgInfo(var_2_1)
	self.m_knightIcon:updateIcon({
		struct = var_2_2
	})
	self.m_posTxt:setText("W" .. var_2_0.x .. ",E" .. var_2_0.y)
	self.m_levelTxt:setText(var_2_0.boss_equip_lv)
	self.m_itemIcon:setURL((g.core.common.Path:getHalidomResourceById(var_0_0:getGveBagData():getBranchCfgByBranchId(0).small_grey_icon)))

	local var_2_3 = var_0_1:getBossData(arg_2_1.boss_id)
	local var_2_4 = var_2_3:getInfo().boss_team_elite
	local var_2_5 = var_2_3:getBossData().monsterTeamInfo["monster_" .. var_2_4]

	if var_2_5 > 0 then
		self.m_hpBar:setMax(var_0_4.get(var_2_5).initial_hp)
		self.m_hpBar:setValue(arg_2_1.boss_hp[var_2_4])
	end

	if var_2_3:isDeadByIndex() then
		self.m_isDeadController:setSelectedIndex(1)
	elseif var_0_1:getTargetPath({
		x = var_2_0.x,
		y = var_2_0.y
	}) then
		self.m_isDeadController:setSelectedIndex(0)
	else
		self.m_isDeadController:setSelectedIndex(2)
	end
end

function GveInstituteBossComp:playSelectEff()
	self.m_effSelect:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = "eff_ui_gveII_select",
		remove = true
	})
	self.m_selectTransition:play()
end

return GveInstituteBossComp
