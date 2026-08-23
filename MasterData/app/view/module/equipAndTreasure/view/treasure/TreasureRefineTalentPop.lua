local TreasureRefineTalentPop = class("TreasureRefineTalentPop", require("app.fairyGUI.equipAndTreasure.UI_TreasureRefineTalentPop"), function()
	return fgui.GComponent:create({
		resName = "TreasureRefineTalentPop",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	}, ...)
end)
local var_0_1 = g.core.config.treasure_info
local var_0_2 = g.core.config.talent_skill_info
local var_0_3 = g.core.config.parameter_info

function TreasureRefineTalentPop:ctor(arg_2_1)
	local var_2_0 = not arg_2_1.isOther and g.core.model.User.treasureData:getTreasureData()[arg_2_1.id] or g.core.model.User.playerInfoData:getTreasureBySid(arg_2_1.id)

	if var_2_0 then
		self._treasureId = var_2_0.base_id or 0
	end

	if var_2_0 then
		self._curLv = var_2_0.refining_level or 0
	end

	self._talentData = {}

	self:_initData()
	self:_initView()
	self:showAtCenter()
end

function TreasureRefineTalentPop:_initData()
	local var_3_0 = var_0_1.get(self._treasureId)
	local var_3_1 = var_0_3.get(19006).parameter
	local var_3_2 = 0

	self._talentData = {}

	for iter_3_0 = 1, 10 do
		if var_3_0["talent_skill_" .. iter_3_0] ~= 0 then
			if self._curLv < var_0_2.get(var_3_0["talent_skill_" .. iter_3_0]).open_value then
				var_3_2 = var_3_2 + 1
			end

			if var_3_2 <= var_3_1 then
				table.insert(self._talentData, {
					skill = var_3_0["talent_skill_" .. iter_3_0],
					level = self._curLv
				})
			end
		end
	end
end

function TreasureRefineTalentPop:_initView()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_talentList:setNumItems(#self._talentData)
end

function TreasureRefineTalentPop:_onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateView(self._talentData[arg_5_1 + 1])
end

return TreasureRefineTalentPop
