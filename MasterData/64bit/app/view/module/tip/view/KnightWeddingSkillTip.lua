local var_0_0 = g.core.config.passive_skill_info
local var_0_1 = g.core.model.User.weddingData
local var_0_2 = g.core.config.wedding_vow_info
local var_0_3 = g.core.model.User.knightsData
local KnightWeddingSkillTip = class("KnightWeddingSkillTip", require("app.fairyGUI.tip.UI_KnightWeddingSkillTip"), function()
	return fgui.GComponent:create({
		pkgName = "tip",
		pkgPath = "ui/tip/tip",
		resName = "KnightWeddingSkillTip"
	})
end)

function KnightWeddingSkillTip:ctor(arg_2_1)
	if arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
	elseif arg_2_1 then
		self._knightStruct = var_0_3:getKnight(arg_2_1)
	end

	self._curVowInfo = var_0_2.get(self._knightStruct:getAdvanceId())
	self._skillsDescData = {}

	self:showAtCenter()
	self:initView()
end

function KnightWeddingSkillTip:initView()
	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onItemRenderer), 0.1, false)
end

function KnightWeddingSkillTip:_onItemRenderer(arg_4_1, arg_4_2)
	if self._skillsDescData[arg_4_1 + 1] then
		arg_4_2:updateCell(self._skillsDescData[arg_4_1 + 1])
	end
end

function KnightWeddingSkillTip:onLoad()
	self:updateView()
end

function KnightWeddingSkillTip:updateView()
	self._skillsDescData = {}

	local var_6_0 = var_0_1:getCurFavorInfo(self._knightStruct:getAdvanceId())
	local var_6_1 = 0
	local var_6_2 = {}

	while var_0_2.hasKey("skill_" .. var_6_1) do
		local var_6_3 = self._curVowInfo["skill_" .. var_6_1]

		if self._curVowInfo["skill_" .. var_6_1] > 0 and not var_6_2[var_6_3] then
			var_6_2[var_6_3] = true

			local var_6_4 = var_0_0.get(var_6_3)
			local var_6_5 = ""
			local var_6_6 = var_6_1 <= var_6_0.level

			var_6_5 = var_6_1 <= var_6_0.level and g.core.lang:get(2052, {
				level = var_6_4.level
			}) or g.core.lang:get(412030, {
				level = var_6_4.level,
				needLevel = var_6_1
			})

			table.insert(self._skillsDescData, {
				text = g.core.utils.String.formatPassiveSkillDesc(var_6_3),
				level = var_6_5,
				state = var_6_6 and 0 or 1
			})
		end

		var_6_1 = var_6_1 + 1
	end

	self.m_descList:setNumItems1(#self._skillsDescData)
	self.m_skillIcon:updateIcon({
		isPassive = true,
		skillId = self._curVowInfo["skill_" .. var_6_0.level]
	})
	self.m_descText:getChild("title"):enableRich()
	self.m_descText:setTitle(g.core.utils.String.formatPassiveSkillDesc(self._curVowInfo["skill_" .. var_6_0.level]))

	local var_6_7 = g.core.config.passive_skill_info.get(self._curVowInfo["skill_" .. var_6_0.level])

	self.m_bgPanel:setTitle(var_6_7.name)

	local var_6_8 = g.core.config.skill_info.get(var_6_7.passive_skill_value)

	if var_6_8.split_description_2 ~= "" and var_6_8.split_description_2 ~= "0" then
		self.m_numController:setSelectedIndex(1)
		self.m_descText2:setText((g.core.utils.String.formatSkillSplitDesc(var_6_8.id)))
	else
		self.m_numController:setSelectedIndex(0)
	end
end

return KnightWeddingSkillTip
