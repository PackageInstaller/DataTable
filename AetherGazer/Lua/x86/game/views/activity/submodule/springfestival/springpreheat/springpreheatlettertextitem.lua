local var_0_0 = class("SpringPreheatLetterTextItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.richText_ = arg_1_0:FindCom("RichText", "", arg_1_1.transform)

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0.richText_:AddListener(function(arg_3_0, arg_3_1)
		if arg_3_0 == "1" then
			local var_3_0 = tonumber(arg_3_1)

			arg_2_0:SelectLetter(arg_2_0.paragIdx_, var_3_0)
		end
	end)

	if arg_2_0.btn_ then
		local var_2_0 = arg_2_0.richText_.gameObject
		local var_2_1 = arg_2_0:GetOrAddComponent(var_2_0, typeof(EventTriggerListener))
		local var_2_2 = var_2_0:GetComponent("RectTransform")

		var_2_1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_4_0, arg_4_1)
			local var_4_0 = LuaHelper.ScreenToLocal(var_2_2, arg_4_1.position, arg_4_1.enterEventCamera)
			local var_4_1 = arg_2_0:FindNearestUnderlineIndex(var_4_0.x)

			arg_2_0:SelectLetter(arg_2_0.paragIdx_, var_4_1)
		end))
	end
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.richText_:RemoveAllListeners()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.isSelecting_ = arg_6_4

	arg_6_0.richText_:AddSprite("selecting", arg_6_2)
	arg_6_0.richText_:AddSprite("selected", arg_6_3)

	if arg_6_0.paragIdx_ ~= arg_6_1 then
		arg_6_0.paragIdx_ = arg_6_1

		arg_6_0:InitLetterInfo()
	end

	arg_6_0:UpdateRichText()
end

function var_0_0.SetPreviewMode(arg_7_0, arg_7_1)
	arg_7_0.previewMode_ = arg_7_1
end

function var_0_0.SetSendingMode(arg_8_0, arg_8_1)
	arg_8_0.sendingMode_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:UpdateRichText()
end

function var_0_0.UpdateRichText(arg_10_0)
	local var_10_0 = SpringPreheatData:GetPlayerLetter()
	local var_10_1 = arg_10_0.richText_
	local var_10_2 = arg_10_0.paragIdx_
	local var_10_3 = 1
	local var_10_4 = 1
	local var_10_5 = ""
	local var_10_6 = GetTips("SPRING_PREHEAT_WORD_BRACKET")
	local var_10_7 = GameDisplayCfg.spring_preheat_select_color.value[1]
	local var_10_8 = 1

	for iter_10_0 = 1, #arg_10_0.letterInfo_ do
		local var_10_9 = arg_10_0.letterInfo_[iter_10_0]

		if SpringPreheatData:IsEnableOption(var_10_0.id, var_10_2, iter_10_0) then
			local var_10_10

			if var_10_9 ~= 0 then
				var_10_10 = GetTips(var_10_9)
			else
				var_10_10 = arg_10_0.previewMode_ and "______" or "______"
			end

			local var_10_11 = var_10_9 == 0 and var_10_7 or nil

			if arg_10_0.sendingMode_ then
				var_10_5 = var_10_5 .. var_10_10
			elseif var_10_11 then
				local var_10_12 = string.format("<material=underline c=%s h=-1.5 event=1 args=%d>%s</material>", var_10_11, var_10_8, var_10_10)
				local var_10_13 = string.format("<color=%s>%s</color>", var_10_11, var_10_6)

				var_10_5 = var_10_5 .. string.format(var_10_13, var_10_12)
			else
				local var_10_14 = string.format("<material=underline h=1.5 event=1 args=%d>%s</material>", var_10_8, var_10_10)

				var_10_5 = var_10_5 .. string.format(var_10_6, var_10_14)
			end

			var_10_8 = var_10_8 + 1
		else
			var_10_5 = var_10_5 .. GetTips(var_10_9)
		end
	end

	var_10_1.text = var_10_5
	arg_10_0.underlineCount_ = var_10_8 - 1

	arg_10_0:CalcUnderlineData()
end

function var_0_0.InitLetterInfo(arg_11_0)
	local var_11_0 = SpringPreheatData:GetPlayerLetter()
	local var_11_1 = arg_11_0.paragIdx_

	arg_11_0.letterInfo_ = {}
	arg_11_0.richTextList_ = {}
	arg_11_0.hasOption_ = false

	for iter_11_0 = 1, #var_11_0.option_button_list[var_11_1] do
		if SpringPreheatData:IsEnableOption(var_11_0.id, var_11_1, iter_11_0) then
			arg_11_0.letterInfo_[iter_11_0] = 0
			arg_11_0.hasOption_ = true
		else
			arg_11_0.letterInfo_[iter_11_0] = SpringPreheatData:GetLetterFixedText(var_11_0.id, var_11_1, iter_11_0)
		end
	end
end

function var_0_0.SetLetterInfo(arg_12_0, arg_12_1)
	local var_12_0 = SpringPreheatData:GetPlayerLetter()
	local var_12_1 = arg_12_0.paragIdx_

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if SpringPreheatData:IsEnableOption(var_12_0.id, var_12_1, iter_12_0) then
			arg_12_0.letterInfo_[iter_12_0] = iter_12_1
		end
	end
end

function var_0_0.SelectLetter(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0.hasOption_ or arg_13_0.sendingMode_ then
		return
	end

	local var_13_0 = {
		isStickerMode = false,
		paragIdx = arg_13_1,
		optionIdx = arg_13_2,
		letterInfo = arg_13_0:GetLetterInfo()
	}

	if not arg_13_0.previewMode_ then
		function var_13_0.onChangeFullLetter(arg_14_0)
			arg_13_0:SetLetterInfo(arg_14_0)
			arg_13_0:RefreshUI()
		end
	else
		var_13_0.updateAni = true
	end

	JumpTools.OpenPageByJump("springPreheatLetterSelect", var_13_0)
end

function var_0_0.ResetLetterInfo(arg_15_0)
	arg_15_0:InitLetterInfo()
	arg_15_0:UpdateRichText()
end

function var_0_0.GetLetterInfo(arg_16_0)
	return arg_16_0.letterInfo_
end

function var_0_0.IsComplete(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.letterInfo_) do
		if iter_17_1 == 0 then
			return false
		end
	end

	return true
end

function var_0_0.CalcUnderlineData(arg_18_0)
	Timer.New(function()
		local var_19_0 = arg_18_0.richText_.gameObject:GetComponentsInChildren(typeof(RectTransform))
		local var_19_1 = math.min(var_19_0.Length - 1, arg_18_0.underlineCount_)

		arg_18_0.underlinePos_ = {}

		local var_19_2 = arg_18_0.richText_.transform.rect.center.x

		for iter_19_0 = 1, var_19_1 do
			local var_19_3 = var_19_2 + var_19_0[iter_19_0].anchoredPosition.x

			table.insert(arg_18_0.underlinePos_, var_19_3)
		end
	end, 0.5, 0):Start()
end

function var_0_0.FindNearestUnderlineIndex(arg_20_0, arg_20_1)
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.underlinePos_ or {}) do
		if math.abs(iter_20_1 - arg_20_1) <= math.abs(arg_20_0.underlinePos_[var_20_0] - arg_20_1) then
			var_20_0 = iter_20_0
		end
	end

	return var_20_0
end

function var_0_0.UpdateAnim(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.ani_ then
		arg_21_0.ani_.enabled = arg_21_1

		SetActive(arg_21_0.aniGo_, arg_21_1)

		if arg_21_1 then
			arg_21_0.ani_:Play(arg_21_2, -1, 0)
		end
	end
end

return var_0_0
