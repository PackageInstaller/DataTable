local var_0_0 = class("SenrankaguraPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = {
	1,
	9,
	19
}
local var_0_2 = {
	"normal1",
	"normal2",
	"normal3"
}
local var_0_3 = {
	"action1",
	"action2"
}
local var_0_4 = {
	"hudongye_leijiPT_yin",
	"hudongye_leijiPT_jin"
}
local var_0_6 = "ui-faguang2"
local var_0_7 = 0.2

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.maskNode = arg_1_0.bg:Find("mask")
	arg_1_0.bgImgTf = arg_1_0.bg:Find("bg_img")
	arg_1_0.titleImgTf = arg_1_0.bg:Find("title_img")
	arg_1_0.role = arg_1_0.maskNode:Find("role")
	arg_1_0.title = arg_1_0.maskNode:Find("title")
	arg_1_0.spineAnim = GetComponent(arg_1_0.role, "SpineAnimUI")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0:GetBeiBeiStage((arg_2_0.ptData:GetLevelProgress()))

	arg_2_0:SetBgImage(var_2_0)
	arg_2_0.spineAnim:SetAction(var_0_2[var_2_0], 0)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		local var_3_0 = arg_2_0.ptData:GetAward()
		local var_3_1 = getProxy(PlayerProxy):getRawData()
		local var_3_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_3_3, var_3_4 = Task.StaticJudgeOverflow(var_3_1.gold, var_3_1.oil, var_3_2, true, true, {
			{
				var_3_0.type,
				var_3_0.id,
				var_3_0.count
			}
		})

		if var_3_3 then
			table.insert({}, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_3_4,
					onYes = arg_4_0
				})

				return
			end)
		end

		table.insert({}, function(arg_5_0)
			arg_2_0:PlayAnim(arg_5_0)

			return
		end)
		seriesAsync({}, function()
			local var_6_0, var_6_1 = arg_2_0.ptData:GetResProgress()

			arg_2_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_0.ptData:GetId(),
				arg1 = var_6_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	var_0_0.super.OnUpdateFlush(arg_7_0)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	if arg_8_0.spineAnim then
		arg_8_0.spineAnim:SetActionCallBack(nil)

		arg_8_0.spineAnim = nil
	end

	return
end

function var_0_0.GetBeiBeiStage(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(var_0_1) do
		if iter_9_1 <= arg_9_1 then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0.PlayAnim(arg_10_0, arg_10_1)
	if arg_10_0.spineAnim then
		local var_10_0 = arg_10_0.ptData:GetLevelProgress()
		local var_10_1 = var_0_2[arg_10_0:GetBeiBeiStage(var_10_0)]

		if arg_10_0.playing then
			return
		end

		local var_10_2 = table.indexof(var_0_1, var_10_0)

		if var_10_2 and var_10_2 > 1 then
			arg_10_0.spineAnim:SetAction(var_0_3[var_10_2 - 1], 0)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			arg_10_0.spineAnim:SetActionCallBack(function(arg_11_0)
				if arg_11_0 == "action" then
					arg_10_0.playing = true
				end

				if arg_11_0 == "finish" then
					arg_10_0.spineAnim:SetActionCallBack(nil)
					arg_10_0.spineAnim:SetAction(var_10_1, 0)

					arg_10_0.playing = false

					arg_10_0:SetBgImage(var_0, var_0_7, arg_10_1)
				end

				return
			end)
		else
			arg_10_1()
		end
	end

	return
end

function var_0_0.SetBgImage(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or 0

	for iter_12_0 = 1, 3 do
		local var_12_0 = findTF(arg_12_0.titleImgTf, "img" .. iter_12_0)

		LeanTween.alpha(findTF(arg_12_0.bgImgTf, "img" .. iter_12_0), iter_12_0 == arg_12_1 and 1 or 0, arg_12_2):setEase(LeanTweenType.easeOutQuad)
		LeanTween.alpha(var_12_0, var_12_1, arg_12_2):setEase(LeanTweenType.easeOutQuad)

		if arg_12_2 > 0 and arg_12_1 > 1 then
			setActive(arg_12_0.bg:Find(var_0_4[arg_12_1 - 1]), true)

			if arg_12_3 then
				LeanTween.delayedCall(1, System.Action(arg_12_3))
			end
		end
	end

	return
end

return var_0_0
