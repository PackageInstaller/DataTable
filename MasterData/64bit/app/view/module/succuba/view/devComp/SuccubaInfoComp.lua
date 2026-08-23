local var_0_0 = g.core.config.passive_skill_info
local var_0_1 = g.core.config.skill_info
local var_0_2 = g.core.config.succuba_advance_info
local var_0_3 = g.core.const.ConstMgr.SuccubaConst
local var_0_4 = g.core.model.User.succubaData
local SuccubaInfoComp = class("SuccubaInfoComp", require("app.fairyGUI.succuba.UI_SuccubaInfoComp"))

function SuccubaInfoComp:ctor()
	self._succubaStruct = nil

	self:_initBtn()
end

function SuccubaInfoComp:_initBtn()
	return
end

function SuccubaInfoComp:updateView(arg_3_1)
	if not arg_3_1 or not arg_3_1.data or not arg_3_1.data.advId then
		return
	end

	local var_3_0 = var_0_4:getSuccubaByAdvanceId(arg_3_1.data.advId)

	if not var_3_0 then
		return
	end

	self._succubaStruct = var_3_0

	local var_3_1 = var_3_0:getCurLevelCfg()
	local var_3_2 = var_3_0:getCurStarCfg()

	self.m_lvText:setText(var_3_0:getLevel())

	for iter_3_0 = 1, 4 do
		self["m_attrComp" .. iter_3_0]:updateAttr({
			type = var_0_3.LV_ATTR_TYPE[iter_3_0].type,
			value = var_3_1[var_0_3.LV_ATTR_TYPE[iter_3_0].key] + var_3_2[var_0_3.STAR_ATTR_TYPE[iter_3_0].key]
		})
	end

	self.m_attrComp5:updateAttr({
		iconRes = "icon/attrIcon/icon_meilizhi.png",
		name = g.core.lang:get(431008),
		value = var_3_0:getCharm()
	})

	local var_3_3 = var_3_0:getStar()
	local var_3_4, var_3_5 = var_3_0:getStarMainSkillList()
	local var_3_6 = {}

	for iter_3_1 = 1, #var_3_4 do
		local var_3_7 = var_3_4[iter_3_1]
		local var_3_8 = g.core.config.skill_info.get(var_3_4[iter_3_1].skillId)
		local var_3_9 = var_3_3 >= var_3_4[iter_3_1].star and 0 or 1
		local var_3_10 = g.core.lang:get(431024, {
			name = var_3_8.curtain_name,
			lv = var_3_8.level
		})
		local var_3_11 = g.core.utils.String.formatSkillDesc(var_3_4[iter_3_1].skillId)

		if (var_3_3 >= var_3_4[iter_3_1].star and 0 or 1) == 1 then
			var_3_11 = var_3_11 .. g.core.lang:get(431011, {
				star = var_3_7.star
			})
		end

		table.insert(var_3_6, {
			state = var_3_9,
			level = var_3_10,
			text = var_3_11
		})
	end

	self.m_skillIcon1:openClick()
	self.m_skillIcon1:updateIcon({
		skillId = var_3_2.skill_id,
		skillDescList = var_3_6
	})
	self.m_skillNameText1:setText(g.core.lang:get(201029, {
		name = g.core.config.skill_info.get(var_3_2.skill_id).curtain_name
	}))
	self.m_skillDescText1:getChild("title"):setText(g.core.utils.String.formatSkillDesc(var_3_2.skill_id))

	local var_3_12 = {}

	for iter_3_2 = 1, #var_3_5 do
		local var_3_13 = var_3_5[iter_3_2]
		local var_3_14 = var_0_0.get(var_3_5[iter_3_2].skillId)
		local var_3_15 = var_3_3 >= var_3_5[iter_3_2].star and 0 or 1
		local var_3_16 = g.core.lang:get(431024, {
			name = var_0_1.get(var_3_14.passive_skill_value).curtain_name,
			lv = var_3_14.level
		})
		local var_3_17 = g.core.utils.String.formatPassiveSkillDesc(var_3_5[iter_3_2].skillId)

		if (var_3_3 >= var_3_5[iter_3_2].star and 0 or 1) == 1 then
			var_3_17 = var_3_17 .. g.core.lang:get(431011, {
				star = var_3_13.star
			})
		end

		table.insert(var_3_12, {
			state = var_3_15,
			level = var_3_16,
			text = var_3_17
		})
	end

	self.m_skillIcon2:openClick()
	self.m_skillIcon2:updateIcon({
		isPassive = true,
		skillId = var_3_2.passive_skill_1,
		skillDescList = var_3_12
	})

	local var_3_18, var_3_19 = g.core.utils.String.formatPassiveSkillDesc(var_3_2.passive_skill_1)

	self.m_skillNameText2:setText(g.core.lang:get(201029, {
		name = var_0_1.get(var_0_0.get(var_3_2.passive_skill_1).passive_skill_value).curtain_name
	}))
	self.m_skillDescText2:getChild("title"):setText(var_3_18)

	local var_3_20 = var_3_0:getAdvanceStageInfo()

	if var_3_20 and var_3_20.skill_id > 0 then
		self.m_skillGroup3:setVisible(true)

		local var_3_21 = var_3_0:getAdvanceId()
		local var_3_22 = var_3_0:getStage()
		local var_3_23 = {}
		local var_3_24 = {}
		local var_3_25
		local var_3_26 = ""

		for iter_3_3, iter_3_4 in var_0_2.ipairs() do
			if iter_3_4.advance_id == var_3_21 then
				local var_3_27 = iter_3_4.skill_id

				if iter_3_4.skill_id > 0 and not var_3_24[var_3_27] then
					var_3_24[var_3_27] = true

					local var_3_28 = var_0_0.get(var_3_27)
					local var_3_29 = var_3_22 >= iter_3_4.stage and 0 or 1
					local var_3_30 = g.core.lang:get(431024, {
						name = var_3_28.name,
						lv = var_3_28.level
					})
					local var_3_31 = g.core.utils.String.formatPassiveSkillDesc(var_3_27)

					if (var_3_22 >= iter_3_4.stage and 0 or 1) == 1 then
						var_3_31 = var_3_31 .. g.core.lang:get(431048, {
							stage = iter_3_4.stage
						})
					end

					table.insert(var_3_23, {
						state = var_3_29,
						level = var_3_30,
						text = var_3_31
					})

					if var_3_22 >= iter_3_4.stage then
						var_3_25 = var_3_28
						var_3_26 = var_3_31
					end
				end
			end
		end

		self.m_skillNameText3:setText(g.core.lang:get(201029, {
			name = var_0_1.get(var_3_25.passive_skill_value).curtain_name
		}))
		self.m_skillDescText3:getChild("title"):setText(var_3_26)
		self.m_skillIcon3:openClick()
		self.m_skillIcon3:updateIcon({
			isPassive = true,
			skillId = var_3_20.skill_id,
			skillDescList = var_3_23
		})
	else
		self.m_skillGroup3:setVisible(false)
	end
end

return SuccubaInfoComp
