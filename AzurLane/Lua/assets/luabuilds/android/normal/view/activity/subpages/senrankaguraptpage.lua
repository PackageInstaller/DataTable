class = var_0_10000

local var_0_0 = "SenrankaguraPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))
local var_0_2 = {
	1,
	9,
	19
}
local var_0_3 = {
	"normal1",
	"normal2",
	"normal3"
}
local var_0_4 = {
	"action1",
	"action2"
}
local var_0_5 = {
	"hudongye_leijiPT_yin",
	"hudongye_leijiPT_jin"
}
local var_0_6 = "ui/activityuipage/senrankaguraptpage_atlas"
local var_0_7 = "ui-faguang2"
local var_0_8 = 0.2

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.maskNode = var_1.Find(var_1_0, "mask")

	local var_1_1 = arg_1_0.bg

	arg_1_0.bgImgTf = var_1.Find(var_1_1, "bg_img")

	local var_1_2 = arg_1_0.bg

	arg_1_0.titleImgTf = var_1.Find(var_1_2, "title_img")

	local var_1_3 = arg_1_0.maskNode

	arg_1_0.role = var_1.Find(var_1_3, "role")

	local var_1_4 = arg_1_0.maskNode

	arg_1_0.title = var_1.Find(var_1_4, "title")
	GetComponent = var_1
	arg_1_0.spineAnim = var_1(arg_1_0.role, "SpineAnimUI")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.ptData
	local var_2_1 = var_1.GetLevelProgress(var_2_0)
	local var_2_2 = arg_2_0:GetBeiBeiStage(var_2_1)

	arg_2_0:SetBgImage(var_2_2)

	local var_2_3 = var_0_3[var_2_2]
	local var_2_4 = arg_2_0.spineAnim

	var_4.SetAction(var_2_4, var_2_3, 0)

	onButton = var_4

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.getBtn

	local function var_2_7()
		local var_3_0 = {}
		local var_3_1 = arg_2_0.ptData
		local var_3_2 = var_1.GetAward(var_3_1)

		getProxy = var_3_1
		PlayerProxy = var_2_10003

		local var_3_3 = var_3_1(var_2_10003)
		local var_3_4 = var_2.getRawData(var_3_3)

		pg = var_3_3

		local var_3_5 = var_3_3.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10005

		if var_2_10005 then
			var_2_10005 = 0
		else
			getProxy = var_2_10005
			BagProxy = var_2_10006
			var_2_10006 = var_2_10005(var_2_10006)
			var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_3_5)
		end

		Task = var_2_10006

		local var_3_6, var_3_7 = var_2_10006.StaticJudgeOverflow(var_3_4.gold, var_3_4.oil, var_2_10005, true, true, {
			{
				var_3_2.type,
				var_3_2.id,
				var_3_2.count
			}
		})

		if var_3_6 then
			table = var_8

			var_8.insert(var_3_0, function(arg_4_0)
				pg = var_3_10001

				local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_4_1 = var_1.ShowMsgBox
				local var_4_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_4_2.type = var_3_10004
				i18n = var_3_10004
				var_4_2.content = var_3_10004("award_max_warning")
				var_4_2.items = var_3_7
				var_4_2.onYes = arg_4_0

				var_4_1(var_4_0, var_4_2)

				return
			end)
		end

		table = var_8

		var_8.insert(var_3_0, function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.PlayAnim(var_5_0, arg_5_0)

			return
		end)

		seriesAsync = var_8

		var_8(var_3_0, function()
			local var_6_0 = arg_2_0.ptData
			local var_6_1, var_6_2 = var_0.GetResProgress(var_6_0)
			local var_6_3 = arg_2_0
			local var_6_4 = var_2.emit

			ActivityMediator = var_3_10004

			local var_6_5 = var_3_10004.EVENT_PT_OPERATION
			local var_6_6 = {
				cmd = 1
			}
			local var_6_7 = arg_2_0.ptData

			var_6_6.activity_id = var_6.GetId(var_6_7)
			var_6_6.arg1 = var_6_2

			var_6_4(var_6_3, var_6_5, var_6_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_2_5, var_2_6, var_2_7, var_1_10008)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	var_0_1.super.OnUpdateFlush(arg_7_0)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	if arg_8_0.spineAnim then
		local var_8_0 = arg_8_0.spineAnim

		var_1.SetActionCallBack(var_8_0, nil)

		arg_8_0.spineAnim = nil
	end

	return
end

function var_0_1.GetBeiBeiStage(arg_9_0, arg_9_1)
	local var_9_0 = 0

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_0_2) do
		if iter_9_1 <= arg_9_1 then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_1.PlayAnim(arg_10_0, arg_10_1)
	if arg_10_0.spineAnim then
		local var_10_0 = arg_10_0.ptData
		local var_10_1 = var_2.GetLevelProgress(var_10_0)
		local var_10_2 = arg_10_0:GetBeiBeiStage(var_10_1)
		local var_10_3 = var_0_3[var_10_2]

		if arg_10_0.playing then
			return
		end

		table = var_5

		if var_5.indexof(var_0_2, var_10_1) and var_5 > 1 then
			local var_10_4 = arg_10_0.spineAnim

			var_6.SetAction(var_10_4, var_0_4[var_5 - 1], 0)

			pg = var_6

			local var_10_5 = var_6.CriMgr.GetInstance()

			var_6.PlaySoundEffect_V3(var_10_5, var_0_7)

			local var_10_6 = arg_10_0.spineAnim

			var_6.SetActionCallBack(var_10_6, function(arg_11_0)
				if arg_11_0 == "action" then
					arg_10_0.playing = true
				end

				if arg_11_0 == "finish" then
					local var_11_0 = arg_10_0.spineAnim

					var_1.SetActionCallBack(var_11_0, nil)

					local var_11_1 = arg_10_0.spineAnim

					var_1.SetAction(var_11_1, var_10_3, 0)

					arg_10_0.playing = false

					local var_11_2 = arg_10_0

					var_1.SetBgImage(var_11_2, var_10_2, var_0_8, arg_10_1)
				end

				return
			end)
		else
			arg_10_1()
		end
	end

	return
end

function var_0_1.SetBgImage(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or 0

	for iter_12_0 = 1, 3 do
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_12_0.bgImgTf, "img" .. iter_12_0)
		findTF = var_9

		local var_12_0 = var_9(arg_12_0.titleImgTf, "img" .. iter_12_0)
		local var_12_1 = iter_12_0 == arg_12_1 and 1 or 0

		LeanTween = var_11

		local var_12_2 = var_11.alpha(var_1_10008, var_12_1, arg_12_2)
		local var_12_3 = var_11.setEase

		LeanTweenType = var_13

		var_12_3(var_12_2, var_13.easeOutQuad)

		LeanTween = var_12_3

		local var_12_4 = var_12_3.alpha(var_12_0, var_12_1, arg_12_2)
		local var_12_5 = var_11.setEase

		LeanTweenType = var_13

		var_12_5(var_12_4, var_13.easeOutQuad)

		if arg_12_2 > 0 and 1 < arg_12_1 then
			setActive = var_11

			local var_12_6 = arg_12_0.bg

			var_11(var_12.Find(var_12_6, var_0_5[arg_12_1 - 1]), true)

			if arg_12_3 then
				LeanTween = var_11

				local var_12_7 = var_11.delayedCall
				local var_12_8 = 1

				System = var_13

				var_12_7(var_12_8, var_13.Action(arg_12_3))
			end
		end
	end

	return
end

return var_0_1
