local var_0_0 = class("StickerBubbleItem", ReduxView)
local var_0_1 = import("game.quiz.QuizFunction")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.isPlaying_ = false
	arg_3_0.sticker_ = ChatStickerItem.New(arg_3_0.stickerGo_)
	arg_3_0.uiFollow_ = arg_3_0.transform_:GetComponent("UIFollow")
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.sticker_:RefreshData(arg_6_2)
	arg_6_0:SetSticker(arg_6_1)
	SetActive(arg_6_0.gameObject_, true)

	arg_6_0.uiFollow_.enabled = true
	arg_6_0.isPlaying_ = true

	arg_6_0:SetTimer()
end

function var_0_0.SetSticker(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1:GetPlyerModel(arg_7_1):GetAttachEmoji()

	if not var_7_0 then
		return
	end

	arg_7_0.uiFollow_.origin = var_7_0

	arg_7_0.uiFollow_:UpdatePos()
end

function var_0_0.SetTimer(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = 0

	arg_8_0.timer_ = Timer.New(function()
		var_8_0 = var_8_0 + 1

		if var_8_0 >= 3 then
			SetActive(arg_8_0.gameObject_, false)

			arg_8_0.uiFollow_.enabled = false
			arg_8_0.isPlaying_ = false

			arg_8_0:StopTimer()
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:StopTimer()
	arg_11_0.sticker_:OnExit()

	arg_11_0.isPlaying_ = false

	arg_11_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0.sticker_:Dispose()

	arg_12_0.sticker_ = nil

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
