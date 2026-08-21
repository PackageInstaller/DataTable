local var_0_0 = class("BlackFridayPage", import("...base.BaseActivityPage"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.OnInit(arg_1_0)
	arg_1_0.shopBtn = arg_1_0._tf:Find("AD/shop_btn")
	arg_1_0.uiList = UIItemList.New(arg_1_0._tf:Find("AD/list"), arg_1_0._tf:Find("AD/list/award"))
	arg_1_0.finishCntTxt = arg_1_0._tf:Find("AD/Text"):GetComponent(typeof(Text))
	arg_1_0.helpBtn = arg_1_0._tf:Find("AD/help")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		arg_2_0.ptData:Update(arg_2_0.activity)
	else
		arg_2_0.ptData = ActivityPtData.New(arg_2_0.activity)
	end

	arg_2_0.endTime = arg_2_0.activity.stopTime

	local var_2_0 = arg_2_0.activity:getConfig("config_client")

	if var_2_0 and var_2_0[1] and type(var_2_0[1]) == "table" then
		arg_2_0.endTime = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_2_0[1])
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	if not IsNil(arg_3_0.helpBtn) then
		onButton(arg_3_0, arg_3_0.helpBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.blackfriday_help.tip
			})

			return
		end, SFX_PANEL)
	end

	onButton(arg_3_0, arg_3_0.shopBtn, function()
		if pg.TimeMgr.GetInstance():GetServerTime() >= arg_3_0.endTime then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		else
			arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP, {
				page = NewSkinShopScene.PAGE_RETURN
			})
		end

		return
	end, SFX_PANEL)
	arg_3_0.uiList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateAward(arg_6_1 + 1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_0.GetState(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 <= arg_7_0.finishCnt
	local var_7_1 = table.contains(arg_7_0.finishList, arg_7_0.ptData.targets[arg_7_1])

	if var_7_1 then
		return var_0_3
	elseif not var_7_1 and var_7_0 then
		return var_0_2
	else
		return var_0_1
	end

	return
end

function var_0_0.UpdateAward(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		type = arg_8_0.awards[arg_8_1][1],
		id = arg_8_0.awards[arg_8_1][2],
		count = arg_8_0.awards[arg_8_1][3]
	}

	updateDrop(arg_8_2, {
		type = arg_8_0.awards[arg_8_1][1],
		id = arg_8_0.awards[arg_8_1][2],
		count = arg_8_0.awards[arg_8_1][3]
	})
	setActive(arg_8_2:Find("icon_bg/count"), var_8_0.count > 0)

	arg_8_2:Find("icon_bg/frame"):GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0)

	local var_8_1 = arg_8_0:GetState(arg_8_1)

	setActive(arg_8_2:Find("got"), var_8_1 == var_0_3)
	setActive(arg_8_2:Find("get"), var_8_1 == var_0_2)
	setActive(arg_8_2:Find("lock"), var_8_1 == var_0_1)

	if var_8_1 == var_0_2 then
		onButton(arg_8_0, arg_8_2, function()
			arg_8_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_8_0.ptData:GetId(),
				arg1 = arg_8_0.ptData.targets[arg_8_1]
			})

			return
		end, SFX_PANEL)
	else
		onButton(arg_8_0, arg_8_2, function()
			arg_8_0:emit(BaseUI.ON_DROP, var_8_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0.awards = arg_11_0.ptData.dropList
	arg_11_0.finishCnt = arg_11_0.ptData.count
	arg_11_0.finishList = arg_11_0.ptData.activity.data1_list
	arg_11_0.finishCntTxt.text = "X" .. arg_11_0.finishCnt

	arg_11_0.uiList:align(#arg_11_0.awards)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
