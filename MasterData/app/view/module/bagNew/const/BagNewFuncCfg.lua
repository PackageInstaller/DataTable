local var_0_0 = {}
local var_0_1 = g.core.const.ConstMgr

var_0_0.FUNC_TYPE = {
	EQUIPMENT = 2,
	PROP = 1,
	TREASURE = 3
}

function var_0_0:getLeftBtnCfgList()
	return {
		[var_0_0.FUNC_TYPE.PROP] = self.showProp(),
		[var_0_0.FUNC_TYPE.EQUIPMENT] = self.showEquipment(),
		[var_0_0.FUNC_TYPE.TREASURE] = self.showTreasure()
	}
end

function var_0_0:getShowFuncList()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs((self:getLeftBtnCfgList())) do
		if iter_2_1.show() then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_0.showProp(arg_3_0)
	local var_3_0 = {
		title = g.core.lang:get(200517),
		icons = {
			"icon_bb_daoju_1",
			"icon_bb_daoju_2",
			"icon_bb_daoju_3"
		},
		HelpType = var_0_1.HelpConst.HELP_TYPE.ITEM_BAG
	}

	var_3_0.resInfoId = 66
	var_3_0.tabType = var_0_0.FUNC_TYPE.PROP

	function var_3_0.show()
		return true
	end

	function var_3_0.getComp()
		return fgui.UIPackage:createObject("bagNew", "BagNewPropComp")
	end

	var_3_0.isRedPointShow = {}

	return var_3_0
end

function var_0_0.showEquipment(arg_6_0)
	local var_6_0 = {
		title = g.core.lang:get(200519),
		icons = {
			"icon_bb_lizhanhui_1",
			"icon_bb_lizhanhui_2",
			"icon_bb_lizhanhui_3"
		},
		HelpType = var_0_1.HelpConst.HELP_TYPE.EQUIP_BAG
	}

	var_6_0.resInfoId = 64
	var_6_0.tabType = var_0_0.FUNC_TYPE.EQUIPMENT

	function var_6_0.show()
		return true
	end

	function var_6_0.getComp()
		return fgui.UIPackage:createObject("bagNew", "BagNewEquipBagComp")
	end

	var_6_0.isRedPointShow = {}

	return var_6_0
end

function var_0_0.showTreasure(arg_9_0)
	local var_9_0 = {
		title = g.core.lang:get(200520),
		icons = {
			"icon_bb_ronghewu_1",
			"icon_bb_ronghewu_2",
			"icon_bb_ronghewu_3"
		},
		HelpType = var_0_1.HelpConst.HELP_TYPE.TREASURE_BAG
	}

	var_9_0.resInfoId = 65
	var_9_0.tabType = var_0_0.FUNC_TYPE.TREASURE

	function var_9_0.show()
		return true
	end

	function var_9_0.clickFunc()
		return
	end

	function var_9_0.getComp()
		return fgui.UIPackage:createObject("bagNew", "BagNewTreasureBagComp")
	end

	var_9_0.isRedPointShow = {}

	return var_9_0
end

function var_0_0.showArtifact(arg_13_0)
	local var_13_0 = {
		title = g.core.lang:get(200522),
		icons = {
			"icon_bb_gongming_1",
			"icon_bb_gongming_2",
			"icon_bb_ronghewu_3"
		},
		HelpType = var_0_1.HelpConst.HELP_TYPE.ARTIFACT
	}

	var_13_0.resInfoId = 93
	var_13_0.tabType = var_0_0.FUNC_TYPE.ARTIFACT

	function var_13_0.show()
		return (g.core.common.ModuleUnlock:isModuleShow(var_0_1.FUNCTION_TYPE.ARTIFACT))
	end

	function var_13_0.clickFunc()
		return
	end

	function var_13_0.getComp()
		return fgui.UIPackage:createObject("bagNew", "BagNewArtifactBagComp")
	end

	var_13_0.isRedPointShow = {}

	return var_13_0
end

return var_0_0
