local RelationType = require("app.core.fairygui.RelationType")
local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local var_0_2 = {
	{
		progress = "progress",
		resInfoId = 5,
		resName = "WarriorsMainComp",
		name = "Label_main",
		packageName = "warriorsOfFate",
		redPointId = 14,
		showMap = true,
		type = WarriorsConst.MAIN,
		title = g.core.lang:get(105001),
		isShow = function()
			return true
		end,
		adaptiveStyle = {
			RelationType.Center_Center,
			RelationType.Middle_Middle
		}
	},
	{
		progress = "progress",
		resInfoId = 6,
		resName = "WarriorsGeneralComp",
		packageName = "warriorsOfFate",
		redPointId = 15,
		showMap = true,
		type = WarriorsConst.GENERAL,
		title = g.core.lang:get(105002),
		isShow = function()
			return true
		end,
		adaptiveStyle = {
			RelationType.Center_Center,
			RelationType.Middle_Middle
		}
	},
	{
		resName = "WarriorsMainComp",
		progress = "nightmareProgress",
		showMap = false,
		packageName = "warriorsOfFate",
		type = WarriorsConst.NIGHTMARE,
		title = g.core.lang:get(105003),
		isShow = function()
			return false
		end,
		adaptiveStyle = {
			RelationType.Center_Center,
			RelationType.Middle_Middle
		}
	},
	{
		progress = "nightmareProgress",
		packageName = "warriorsOfFate",
		resName = "NightmareComp",
		locked = true,
		showMap = false,
		type = WarriorsConst.NIGHTMARE_ACTIVATY,
		title = g.core.lang:get(105004),
		isShow = function()
			return false
		end,
		adaptiveStyle = {
			RelationType.Center_Center,
			RelationType.Middle_Middle
		}
	}
}

function var_0_2.getTabDataByType(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	for iter_5_0, iter_5_1 in pairs(var_0_2) do
		if iter_5_1.type == arg_5_1 then
			return clone(iter_5_1)
		end
	end
end

return var_0_2
