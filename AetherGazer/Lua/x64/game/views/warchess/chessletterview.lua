local var_0_0 = class("ChessLetterView", ReduxView)
local var_0_1 = {
	Playing = 2,
	Stop = 3,
	Init = 1
}
local var_0_2 = 40
local var_0_3 = 1
local var_0_4 = 1.5
local var_0_5 = 0.5
local var_0_6 = false

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessLetterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.typeTime_ = 0
	arg_3_0.textComs = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0.state_ == var_0_1.Playing then
			-- block empty
		elseif arg_5_0.state_ == var_0_1.Stop then
			if arg_5_0.contentID_ == 0 then
				arg_5_0:Back()
				arg_5_0.callBack()
			else
				arg_5_0.state_ = var_0_1.Init
				var_0_6 = false
			end
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.callBack = arg_7_0.params_.callBack

	if not arg_7_0.handle then
		arg_7_0.handle = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			arg_7_0:Update()
		end, -1, true)
	end

	var_0_6 = true
	arg_7_0.state_ = var_0_1.Init
	arg_7_0.contentID_ = arg_7_0.params_.ID
	arg_7_0.scrollbar_.value = 1
end

function var_0_0.OnExit(arg_9_0)
	if arg_9_0.handle then
		FuncTimerManager.inst:RemoveFuncTimer(arg_9_0.handle)

		arg_9_0.handle = nil
	end
end

function var_0_0.Update(arg_10_0)
	local var_10_0 = Time.deltaTime

	arg_10_0:Play(var_10_0)
end

function var_0_0.Play(arg_11_0, arg_11_1)
	if arg_11_0.state_ == var_0_1.Init then
		arg_11_0.pageText_ = ""
		arg_11_0.typeTime_ = 0

		local var_11_0 = 1
		local var_11_1 = -1

		while true do
			if arg_11_0.contentID_ == 0 then
				error("WarchessContentCfg配置错误")
			end

			local var_11_2 = WarchessContentCfg[arg_11_0.contentID_]
			local var_11_3 = var_11_2.alignment or 0

			if var_11_1 == -1 then
				arg_11_0.pageText_ = arg_11_0.pageText_ .. GetI18NText(var_11_2.content)
				var_11_1 = var_11_3
			elseif var_11_1 == var_11_3 then
				arg_11_0.pageText_ = arg_11_0.pageText_ .. "\n" .. GetI18NText(var_11_2.content)
			else
				arg_11_0:CreateText(var_11_0, var_11_1, arg_11_0.pageText_)

				arg_11_0.pageText_ = GetI18NText(var_11_2.content)
				var_11_0 = var_11_0 + 1
				var_11_1 = var_11_3
			end

			arg_11_0.contentID_ = var_11_2.next

			if var_11_2.page_end ~= 0 then
				arg_11_0:CreateText(var_11_0, var_11_1, arg_11_0.pageText_)

				break
			end
		end

		for iter_11_0 = var_11_0 + 1, #arg_11_0.textComs do
			SetActive(arg_11_0.textComs[iter_11_0].gameObject, false)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.textContent_)

		if var_0_6 then
			arg_11_0:SetTextColor(Color(1, 1, 1, 0))
		end

		arg_11_0.state_ = var_0_1.Playing
	elseif arg_11_0.state_ == var_0_1.Playing then
		arg_11_0.typeTime_ = arg_11_0.typeTime_ + arg_11_1

		if var_0_6 then
			if arg_11_0.typeTime_ > var_0_4 then
				arg_11_0.state_ = var_0_1.Stop
			else
				local var_11_4 = arg_11_0.typeTime_ / var_0_3

				arg_11_0:SetTextColor(Color(1, 1, 1, var_11_4 * var_11_4))
			end
		elseif arg_11_0.typeTime_ > var_0_5 then
			arg_11_0.state_ = var_0_1.Stop
		end
	elseif arg_11_0.state_ == var_0_1.Stop then
		-- block empty
	else
		error("错误的State")
	end
end

function var_0_0.CreateText(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_0.textComs[arg_12_1] then
		local var_12_0 = Object.Instantiate(arg_12_0.textText_, arg_12_0.textContent_)

		var_12_0.transform.sizeDelta = Vector2.New(arg_12_0.textContent_.rect.width, 0)
		arg_12_0.textComs[arg_12_1] = var_12_0:GetComponent(typeof(Text))
	end

	print("<color=#00ff00>CreateText</color> Network connected")

	local var_12_1 = arg_12_0.textComs[arg_12_1]

	SetActive(var_12_1.gameObject, true)

	var_12_1.alignment = arg_12_0:GetAlignmentNum(arg_12_2)
	var_12_1.text = GetI18NText(arg_12_3)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.textContent_)
end

function var_0_0.SetTextColor(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.textComs) do
		iter_13_1.color = arg_13_1
	end
end

function var_0_0.GetAlignmentNum(arg_14_0, arg_14_1)
	if arg_14_1 == 1 then
		return UnityEngine.TextAnchor.UpperCenter
	elseif arg_14_1 == 2 then
		return UnityEngine.TextAnchor.UpperRight
	else
		return UnityEngine.TextAnchor.UpperLeft
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.textComs = {}

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
