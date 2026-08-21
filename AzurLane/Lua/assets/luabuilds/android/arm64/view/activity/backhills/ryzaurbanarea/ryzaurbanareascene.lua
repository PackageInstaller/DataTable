local var_0_0 = class("RyzaUrbanAreaScene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "RyzaUrbanAreaUI"
end

var_0_0.edge2area = {
	default = "map_middle",
	["2_3"] = "map_front",
	["1_2"] = "map_front",
	["3_4"] = "map_front"
}

function var_0_0.init(arg_2_0)
	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._map = arg_2_0._tf:Find("map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_0 = arg_2_0._map:GetChild(iter_2_0)
		local var_2_1 = "map_" .. go(var_2_0).name

		arg_2_0[var_2_1] = var_2_0
	end

	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0.containers = {
		arg_2_0.map_front,
		arg_2_0.map_middle
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.RyzaUrbanAreaGraph"))
	arg_2_0.minigameCount = arg_2_0.top:Find("minigame/count")
	arg_2_0.puniAnim = arg_2_0._map:Find("huodongye/puni"):GetComponent("SpineAnimUI")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_btn"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_main_btn"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ryza_tip_main.tip
		})

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 43)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_PT)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huodongye", function()
		({}).id = var_3_1 and var_3_1.id

		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "lianjingongfang", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ATELIER_COMPOSITE)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "weituoban", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.RYZA_TASK)

		return
	end)
	arg_3_0:UpdateView()
	arg_3_0:AutoFitScreen()

	return
end

function var_0_0.UpdateView(arg_11_0)
	local var_11_0 = getProxy(ActivityProxy)
	local var_11_2 = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	setActive(arg_11_0.upper_xiaoyouxi:Find("tip"), (var_0_0.IsMiniActNeedTip(var_11_2 and var_11_2.id)))

	local var_11_3 = var_11_2 and getProxy(MiniGameProxy):GetHubByHubId(var_11_2:getConfig("config_id"))

	setText(arg_11_0.minigameCount, var_11_3.usedtime .. "/" .. var_11_3:getConfig("reward_need"))

	local var_11_4 = var_11_0:getActivityById(ActivityConst.RYZA_PT)

	setActive(arg_11_0.upper_huodongye:Find("tip"), var_11_4 and var_11_4:readyToAchieve())
	arg_11_0:UpdatePuniAnim(var_11_4)
	setActive(arg_11_0.upper_weituoban:Find("tip"), (getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.RYZA_TASK)))

	return
end

function var_0_0.UpdatePuniAnim(arg_12_0, arg_12_1)
	if not arg_12_1 then
		arg_12_0.puniAnim:SetAction("normal_" .. math.random(9), 0)
	else
		local var_12_0 = arg_12_1:getConfig("config_client").puni_phase
		local var_12_1 = ActivityPtData.New(arg_12_1):GetLevelProgress()
		local var_12_2 = 1

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			if iter_12_1 < var_12_1 then
				var_12_2 = var_12_2 + 1
			end
		end

		if var_12_2 == #var_12_0 then
			var_12_2 = math.random(#var_12_0)
		end

		arg_12_0.puniAnim:SetAction("normal_" .. var_12_2, 0)
	end

	return
end

function var_0_0.IsShowMainTip(arg_13_0)
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_RYZA)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_PT)))
	end)() or (function()
		return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.RYZA_TASK)
	end)()
end

function var_0_0.willExit(arg_17_0)
	arg_17_0:clearStudents()

	return
end

return var_0_0
