local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.config.skin_info
local var_0_2 = g.core.model.User.warriorsOfFateData
local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local WarriorsStarItem = class("WarriorsStarItem", require("app.fairyGUI.warriorsOfFate.UI_WarriorsStarItem"))

function WarriorsStarItem:updateInfo(arg_1_1)
	local var_1_0 = {
		UPGRADE_QULITY = 1,
		UPGRADE_SKIN = 3,
		UPGRADE_STAR = 2
	}
	local var_1_1 = arg_1_1.type or WarriorsConst.MAIN
	local var_1_2 = arg_1_1.index
	local var_1_3 = arg_1_1.num
	local var_1_4 = var_0_2:getStageInfoByType(var_1_1)[arg_1_1.index + 1]
	local var_1_5 = arg_1_1.selectIndex == arg_1_1.index
	local var_1_6 = {
		index = arg_1_1.index
	}

	if var_1_4 then
		if var_1_4.function_type == var_1_0.UPGRADE_QULITY then
			var_1_6.type = 1
			var_1_6.qualityURL = g.core.common.Path:getQualityArtTxtURL(var_1_4.function_value) or ""
		elseif var_1_4.function_type == var_1_0.UPGRADE_STAR then
			var_1_6.type = 0
			var_1_6.starNum = var_1_4.function_value
		elseif var_1_4.function_type == var_1_0.UPGRADE_SKIN then
			var_1_6.type = 2

			local var_1_7 = g.core.model.User.knightsData:getMainKnight():getBaseInfo().sex
			local var_1_8

			for iter_1_0, iter_1_1 in pairs((g.core.common.Drops:getGoodsArray(var_1_4.drop))) do
				if iter_1_1.type == var_0_0.TYPE_SKIN then
					local var_1_9 = var_0_1.get(iter_1_1.value)

					if var_1_9.sex == var_1_7 then
						var_1_8 = var_1_9

						break
					end
				end
			end

			var_1_6.quality = var_1_8.quality
			var_1_6.skinURL = g.core.common.Path:getKnightIconById(var_1_8.icon)
		end
	end

	local var_1_10 = var_0_2:getNextActStage(var_1_1)

	if var_1_5 then
		self.m_sizeController:setSelectedIndex(1)

		var_1_6.state = 1
	else
		self.m_sizeController:setSelectedIndex(0)

		var_1_6.state = 0
	end

	self.m_starComp:updateInfo(var_1_6)

	if var_1_10 > var_1_4.id then
		self.m_showLineController:setSelectedIndex(1)
	else
		self.m_showLineController:setSelectedIndex(0)
	end

	self.m_line:setVisible(var_1_2 + 1 ~= var_1_3)
	self.m_isDescFlipController:setSelectedIndex(var_1_2 + 1 ~= var_1_3 and 0 or 1)

	local var_1_11 = ""

	if var_1_4.function_type == var_1_0.UPGRADE_SKIN then
		var_1_11 = var_1_4.activation_text
	else
		local var_1_12 = {}

		var_1_12.num = g.core.utils.Number.toChineseNumber((var_0_2:getLandByStage(1, var_1_4.id)))
		var_1_11 = g.core.lang:get(105010, var_1_12)
	end

	self.m_descText:setText(var_1_11)
	self.m_descLableGroup:setVisible(var_1_5)

	self.m_descLableGroup.index = var_1_2
end

return WarriorsStarItem
