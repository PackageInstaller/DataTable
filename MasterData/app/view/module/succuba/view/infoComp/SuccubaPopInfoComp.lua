local var_0_0 = g.core.config.passive_skill_info
local var_0_1 = g.core.config.skill_info
local var_0_2 = g.core.config.succuba_advance_info
local var_0_3 = g.core.const.ConstMgr.SuccubaConst
local SuccubaPopInfoComp = class("SuccubaPopInfoComp", require("app.fairyGUI.succuba.UI_SuccubaPopInfoComp"))

function SuccubaPopInfoComp:ctor()
	self:_initBtn()
end

function SuccubaPopInfoComp:_initBtn()
	return
end

function SuccubaPopInfoComp:updateShow(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_1:getCurLevelCfg()
	local var_3_1 = arg_3_1:getCurStarCfg()

	for iter_3_0 = 1, 4 do
		self["m_attrComp" .. iter_3_0]:updateAttr({
			type = var_0_3.LV_ATTR_TYPE[iter_3_0].type,
			value = var_3_0[var_0_3.LV_ATTR_TYPE[iter_3_0].key] + var_3_1[var_0_3.STAR_ATTR_TYPE[iter_3_0].key]
		})
	end

	self.m_attrComp5:updateAttr({
		iconRes = "icon/attrIcon/icon_meilizhi.png",
		name = g.core.lang:get(431008),
		value = arg_3_1:getCharm()
	})

	local var_3_2 = arg_3_1:getStar()
	local var_3_3, var_3_4 = arg_3_1:getStarMainSkillList()
	local var_3_5 = {}

	for iter_3_1 = 1, #var_3_3 do
		local var_3_6 = var_3_3[iter_3_1]
		local var_3_7 = var_0_1.get(var_3_3[iter_3_1].skillId)
		local var_3_8 = var_3_2 >= var_3_3[iter_3_1].star and 0 or 1
		local var_3_9 = g.core.lang:get(431024, {
			name = var_3_7.curtain_name,
			lv = var_3_7.level
		})
		local var_3_10 = g.core.utils.String.formatSkillDesc(var_3_3[iter_3_1].skillId)

		if (var_3_2 >= var_3_3[iter_3_1].star and 0 or 1) == 1 then
			var_3_10 = var_3_10 .. g.core.lang:get(431011, {
				star = var_3_6.star
			})
		end

		table.insert(var_3_5, {
			state = var_3_8,
			level = var_3_9,
			text = var_3_10
		})
	end

	self.m_skillIcon1:openClick()
	self.m_skillIcon1:updateIcon({
		skillId = var_3_1.skill_id,
		skillDescList = var_3_5
	})

	local var_3_11 = {}

	for iter_3_2 = 1, #var_3_4 do
		local var_3_12 = var_3_4[iter_3_2]
		local var_3_13 = var_0_0.get(var_3_4[iter_3_2].skillId)
		local var_3_14 = var_3_2 >= var_3_4[iter_3_2].star and 0 or 1
		local var_3_15 = g.core.lang:get(431024, {
			name = var_0_1.get(var_3_13.passive_skill_value).curtain_name,
			lv = var_3_13.level
		})
		local var_3_16 = g.core.utils.String.formatPassiveSkillDesc(var_3_4[iter_3_2].skillId)

		if (var_3_2 >= var_3_4[iter_3_2].star and 0 or 1) == 1 then
			var_3_16 = var_3_16 .. g.core.lang:get(431011, {
				star = var_3_12.star
			})
		end

		table.insert(var_3_11, {
			state = var_3_14,
			level = var_3_15,
			text = var_3_16
		})
	end

	self.m_skillIcon2:openClick()
	self.m_skillIcon2:updateIcon({
		isPassive = true,
		skillId = var_3_1.passive_skill_1,
		skillDescList = var_3_11
	})

	local var_3_17 = arg_3_1:getAdvanceStageInfo()

	if var_3_17 and var_3_17.skill_id > 0 then
		self.m_skillIcon3:setVisible(true)

		local var_3_18 = arg_3_1:getAdvanceId()
		local var_3_19 = arg_3_1:getStage()
		local var_3_20 = {}
		local var_3_21 = {}

		for iter_3_3, iter_3_4 in var_0_2.ipairs() do
			if iter_3_4.advance_id == var_3_18 then
				local var_3_24 = iter_3_4.skill_id

				if iter_3_4.skill_id > 0 and not var_3_21[var_3_24] then
					var_3_21[var_3_24] = true

					local var_3_25 = var_0_0.get(var_3_24)
					local var_3_26 = var_3_19 >= iter_3_4.stage and 0 or 1
					local var_3_27 = g.core.lang:get(431024, {
						name = var_3_25.name,
						lv = var_3_25.level
					})
					local var_3_28 = g.core.utils.String.formatPassiveSkillDesc(var_3_24)

					if (var_3_19 >= iter_3_4.stage and 0 or 1) == 1 then
						var_3_28 = var_3_28 .. g.core.lang:get(431048, {
							stage = iter_3_4.stage
						})
					end

					table.insert(var_3_20, {
						state = var_3_26,
						level = var_3_27,
						text = var_3_28
					})

					if var_3_19 >= iter_3_4.stage then
						-- block empty
					end
				end
			end
		end

		self.m_skillIcon3:openClick()
		self.m_skillIcon3:updateIcon({
			isPassive = true,
			skillId = var_3_17.skill_id,
			skillDescList = var_3_20
		})
	else
		self.m_skillIcon3:setVisible(false)
	end

	self.m_descText:setText(var_3_1.des)
end

return SuccubaPopInfoComp
