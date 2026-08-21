local var_0_0 = class("KFCPTPage", import(".TemplatePage.PtTemplatePage"))

var_0_0.SpineCharName = {
	"lafei_11",
	"lingbo_14"
}
var_0_0.SpineCharActionName = "stand_normal"
var_0_0.SpineShopActionSpeed = {
	0.8,
	1,
	1.2
}

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.bg:Find("sdBtn"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.getBtn, function()
		local var_4_0 = arg_1_0.ptData:GetAward()
		local var_4_1 = getProxy(PlayerProxy):getRawData()
		local var_4_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_4_3, var_4_4 = Task.StaticJudgeOverflow(var_4_1.gold, var_4_1.oil, var_4_2, true, true, {
			{
				var_4_0.type,
				var_4_0.id,
				var_4_0.count
			}
		})

		if var_4_3 then
			table.insert({}, function(arg_5_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_4_4,
					onYes = arg_5_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			local var_6_0, var_6_1 = arg_1_0.ptData:GetResProgress()

			arg_1_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_1_0.ptData:GetId(),
				arg1 = var_6_1
			})
			arg_1_0:SetLocalData()

			return
		end)

		return
	end, SFX_PANEL)

	arg_1_0.sdContainer = arg_1_0.bg:Find("sdcontainer")
	arg_1_0.sdSpine = nil
	arg_1_0.sdName = arg_1_0.GetRandomName()
	arg_1_0.sdSpineLRQ = GetSpineRequestPackage.New(arg_1_0.sdName, function(arg_7_0)
		SetParent(arg_7_0, arg_1_0.sdContainer)

		arg_1_0.sdSpine = arg_7_0
		arg_1_0.sdSpine.transform.localScale = Vector3.one

		local var_7_0 = arg_1_0.sdSpine:GetComponent("SpineAnimUI")

		if var_7_0 then
			var_7_0:SetAction(var_0_0.SpineCharActionName, 0)
		end

		arg_1_0.sdSpineLRQ = nil

		return
	end):Start()
	arg_1_0.shopSpine = arg_1_0.bg:Find("shop/shop")
	arg_1_0.shopAnim = arg_1_0.shopSpine:GetComponent("SpineAnimUI")
	arg_1_0.shopGraphic = arg_1_0.shopSpine:GetComponent("SkeletonGraphic")

	arg_1_0.shopAnim:SetAction("normal", 0)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	var_0_0.super.OnUpdateFlush(arg_8_0)

	local var_8_0, var_8_1, var_8_2 = arg_8_0.ptData:GetResProgress()
	local var_8_3 = var_8_2 >= 1 and setColorStr(var_8_0, "#ffc563") or var_8_0

	setText(arg_8_0.progress, var_8_3 .. "/" .. var_8_1)

	if arg_8_0.ptData:CanGetMorePt() then
		arg_8_0:GetLocalData()

		if arg_8_0.finishCount == 0 then
			arg_8_0.shopAnim:SetAction("normal", 0)
		else
			arg_8_0.shopAnim:SetAction("action", 0)

			arg_8_0.shopGraphic.timeScale = var_0_0.SpineShopActionSpeed[arg_8_0.finishCount]
		end
	else
		arg_8_0.shopAnim:SetAction("action", 0)

		arg_8_0.shopGraphic.timeScale = var_0_0.SpineShopActionSpeed[#var_0_0.SpineShopActionSpeed]
	end

	return
end

function var_0_0.GetLocalData(arg_9_0)
	arg_9_0.playerId = getProxy(PlayerProxy):getData().id

	local var_9_0 = pg.TimeMgr.GetInstance()

	arg_9_0.curDay = var_9_0:DiffDay(arg_9_0.ptData.startTime, var_9_0:GetServerTime()) + 1
	arg_9_0.finishCount = PlayerPrefs.GetInt("kfc_pt_" .. arg_9_0.playerId .. "_day_" .. arg_9_0.curDay)

	return
end

function var_0_0.SetLocalData(arg_10_0)
	arg_10_0.finishCount = arg_10_0.finishCount + 1

	if #var_0_0.SpineShopActionSpeed > arg_10_0.finishCount then
		arg_10_0.finishCount = arg_10_0.finishCount or #var_0_0.SpineShopActionSpeed

		PlayerPrefs.SetInt("kfc_pt_" .. arg_10_0.playerId .. "_day_" .. arg_10_0.curDay, arg_10_0.finishCount)
		PlayerPrefs.Save()

		return
	end
end

function var_0_0.GetRandomName()
	return var_0_0.SpineCharName[math.random(#var_0_0.SpineCharName)]
end

function var_0_0.OnDestroy(arg_12_0)
	if arg_12_0.sdSpineLRQ then
		arg_12_0.sdSpineLRQ:Stop()

		arg_12_0.sdSpineLRQ = nil
	end

	if arg_12_0.sdSpine then
		arg_12_0.sdSpine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar(arg_12_0.sdName, arg_12_0.sdSpine)

		arg_12_0.sdSpine = nil
		arg_12_0.sdName = nil
	end

	return
end

return var_0_0
