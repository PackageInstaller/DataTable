local var_0_0 = {}
local playermodel = require("model.playermodel")
local bit = require("bit")
local guide_data = require("data.guide_data")
local var_0_4 = {
	function(arg_1_0, arg_1_1)
		return tonumber(arg_1_1) <= GuideListener.getGuideClassInfo(arg_1_0)
	end,
	function(arg_2_0, arg_2_1)
		return true
	end,
	function(arg_3_0, arg_3_1)
		local var_3_0 = tonumber(arg_3_1)

		if not DormitoryLayer then
			return false
		end

		if not DormitoryLayer.getInstance() then
			return false
		end

		return DormitoryLayer.getInstance().groupId == var_3_0
	end,
	function(arg_4_0, arg_4_1)
		arg_4_0 = arg_4_0 or 2
		arg_4_1 = tonumber(arg_4_1)

		local var_4_0 = math.floor(arg_4_1 / 1000)

		if var_4_0 <= 0 then
			var_4_0 = 1
		end

		if arg_4_0 == 1 then
			return playermodel.levelmode[var_4_0].status < arg_4_1 % 1000
		elseif arg_4_0 == 2 then
			return playermodel.levelmode[var_4_0].status > arg_4_1 % 1000
		else
			return playermodel.levelmode[var_4_0].status == arg_4_1 % 1000
		end
	end,
	function(arg_5_0, arg_5_1)
		return playermodel.curMode == tonumber(arg_5_1)
	end,
	function(arg_6_0, arg_6_1)
		return arg_6_0 == playermodel.curMode and arg_6_1 == playermodel.curLevel:match("(%d+)-(%d+)")
	end,
	function(arg_7_0, arg_7_1)
		arg_7_1 = tonumber(arg_7_1)

		local var_7_0 = math.floor(arg_7_1 / 1000)

		if var_7_0 <= 0 then
			var_7_0 = 1
		end

		return playermodel.levelmode[var_7_0].status <= arg_7_1 % 1000
	end,
	function(arg_8_0, arg_8_1)
		if tonumber(arg_8_1) == 0 then
			return not playermodel.havequickfight
		else
			return playermodel.havequickfight
		end
	end,
	function(arg_9_0, arg_9_1)
		local var_9_0 = FightLayer.getInstance()
		local var_9_1 = bit.band(var_9_0:getShowStat(), tonumber(arg_9_1))

		return var_9_0 > 0
	end,
	function(arg_10_0, arg_10_1)
		if arg_10_0 == 1 then
			return playermodel.class < tonumber(arg_10_1)
		elseif arg_10_0 == 2 then
			return playermodel.class > tonumber(arg_10_1)
		else
			return playermodel.class == tonumber(arg_10_1)
		end
	end,
	function(arg_11_0, arg_11_1)
		require("view.Layer.HorcruxInfoLayerNew")

		if HorcruxInfoLayerNew and HorcruxInfoLayerNew.getInstance() then
			return HorcruxInfoLayerNew.getInstance():getShowStat() == tonumber(arg_11_1)
		end
	end,
	function(arg_12_0, arg_12_1)
		require("view.Sprite.ItemsPanel")

		if ItemsPanel and ItemsPanel.getInstance() then
			return ItemsPanel.getInstance():getShowStat() == tonumber(arg_12_1)
		end
	end,
	function(arg_13_0, arg_13_1)
		require("view.Layer.EquipLayer")

		if SoulsLayer and SoulsLayer.getInstance() then
			return SoulsLayer.getInstance():getShowStat() == tonumber(arg_13_1)
		end
	end,
	function(arg_14_0, arg_14_1)
		if LayerManager:getUIElement("LevelMapLayer") then
			return LayerManager:getUIElement("LevelMapLayer"):getCurCity() == tonumber(arg_14_1)
		end
	end,
	function(arg_15_0, arg_15_1)
		require("view.Layer.MarketLayer")

		if MarketLayer and MarketLayer.getInstance() then
			return MarketLayer.getInstance():getShowStat() == tonumber(arg_15_1)
		end
	end
}

function var_0_0.check_guide_conditions(arg_16_0)
	while guide_data[arg_16_0]["condition" .. 1] do
		if not var_0_4[guide_data[arg_16_0]["condition" .. 1]](guide_data[arg_16_0]["param" .. 1], guide_data[arg_16_0]["num" .. 1]) then
			return false
		end
	end

	return true
end

function var_0_0.check_guide_autofinish_condition(arg_17_0)
	assert(guide_data[arg_17_0], "curData id is nil: " .. arg_17_0)

	if not guide_data[arg_17_0].finishcondition1 then
		return false
	end

	local var_17_0 = 1

	while guide_data[arg_17_0]["finishcondition" .. var_17_0] do
		if not var_0_4[guide_data[arg_17_0]["finishcondition" .. var_17_0]](guide_data[arg_17_0]["finishparam" .. var_17_0], guide_data[arg_17_0]["finishnum" .. var_17_0]) then
			return false
		end

		var_17_0 = var_17_0 + 1
	end

	return true
end

local var_0_5 = {
	[503] = function(arg_18_0)
		return arg_18_0:selectServantSPOnGuide(28)
	end,
	[5062] = function(arg_19_0)
		return arg_19_0:selectDressOnGuide("11300")
	end,
	[5063] = function(arg_20_0)
		return arg_20_0:ButtonDressSureOnGuide()
	end
}

function var_0_0.getGuideUIFunc(arg_21_0)
	return var_0_5[arg_21_0]
end

return var_0_0
