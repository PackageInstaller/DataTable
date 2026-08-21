local var_0_0 = class("IdolPTPage", import(".TemplatePage.PtTemplatePage"))

var_0_0.RefreshTime = 300

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.lableList = arg_1_0.bg:Find("list")
	arg_1_0.lableItems = {}

	for iter_1_0 = 0, arg_1_0.lableList.childCount - 1 do
		table.insert(arg_1_0.lableItems, arg_1_0.lableList:GetChild(iter_1_0))
	end

	arg_1_0.linkBtn = arg_1_0.bg:Find("btn_link")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return (var_0_0.super.OnDataSetting(arg_2_0))
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.displayBtn, function()
		arg_3_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = arg_3_0.ptData.type,
			dropList = arg_3_0.ptData.dropList,
			targets = arg_3_0.ptData.targets,
			level = arg_3_0.ptData.level,
			count = arg_3_0.ptData.count,
			resId = arg_3_0.ptData.resId
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		local var_6_0, var_6_1 = arg_3_0.ptData:GetResProgress()

		arg_3_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.ptData:GetId(),
			arg1 = var_6_1
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.linkBtn, function()
		arg_3_0:emit(ActivityMediator.OPEN_LAYER, Context.New({
			viewComponent = InstagramLayer,
			mediator = InstagramMediator,
			data = {
				id = ActivityConst.IDOL_INS_ID
			}
		}))

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	var_0_0.super.OnUpdateFlush(arg_8_0)

	if arg_8_0.linkAct and not arg_8_0.linkAct:isEnd() then
		for iter_8_0 = 1, math.floor(#arg_8_0.linkAct.data1_list / 2) do
			local var_8_0 = ({})[arg_8_0.linkAct.data1_list[2 * iter_8_0 - 1]]

			if not ({})[arg_8_0.linkAct.data1_list[2 * iter_8_0 - 1]] then
				var_8_0 = 0
			end

			local var_8_1 = arg_8_0.linkAct.data1_list[2 * iter_8_0] or 0

			;({})[arg_8_0.linkAct.data1_list[2 * iter_8_0 - 1]] = var_8_0 + var_8_1
		end

		for iter_8_1, iter_8_2 in pairs({}) do
			table.insert({}, {
				name = iter_8_1,
				count = iter_8_2
			})
		end

		table.sort({}, function(arg_9_0, arg_9_1)
			if arg_9_0.count == arg_9_1.count then
				return arg_9_0.name < arg_9_1.name
			else
				return arg_9_0.count > arg_9_1.count
			end

			return
		end)

		local var_8_2 = math.min(#{}, #arg_8_0.lableItems)

		for iter_8_3 = 1, var_8_2 do
			setText(arg_8_0.lableItems[iter_8_3]:Find("name"), "#" .. tostring(ShipGroup.getDefaultShipNameByGroupID(({})[iter_8_3].name)) .. "#")
			setText(arg_8_0.lableItems[iter_8_3]:Find("Text"), arg_8_0:TransFormat(({})[iter_8_3].count))
		end

		for iter_8_4 = var_8_2 + 1, #arg_8_0.lableItems do
			setText(arg_8_0.lableItems[iter_8_4]:Find("name"), "")
			setText(arg_8_0.lableItems[iter_8_4]:Find("Text"), "0")
		end
	end

	arg_8_0:GetWorldRank(arg_8_0.RefreshTime)

	return
end

function var_0_0.TransFormat(arg_10_0, arg_10_1)
	arg_10_1 = tonumber(arg_10_1) or 0

	local var_10_0 = math.floor(arg_10_1 / 1000)

	if var_10_0 >= 1 then
		local var_10_1 = var_10_0

		if arg_10_1 % 10 > 0 then
			local var_10_2 = "." .. arg_10_1 % 10 or ""

			do return var_10_1 .. var_10_2 .. "K" end

			if false then
				return arg_10_1
			end

			return
		end
	end
end

function var_0_0.GetWorldRank(arg_11_0, arg_11_1)
	if not arg_11_0.linkAct or arg_11_0.linkAct:isEnd() then
		return
	end

	local var_11_0 = arg_11_0.linkAct.id
	local var_11_1 = getProxy(ActivityProxy).requestTime[arg_11_0.linkAct.id] or 0

	if arg_11_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_11_1 then
		arg_11_0:emit(ActivityMediator.FETCH_INSTARGRAM, {
			activity_id = var_11_0
		})
	end

	return
end

function var_0_0.NeedTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.IDOL_PT_ID)

	if var_12_0 and not var_12_0:isEnd() then
		return var_12_0:readyToAchieve()
	end

	return
end

return var_0_0
