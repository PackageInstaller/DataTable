local var_0_0 = class("OsirisPlayGameChapterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = arg_3_0.controllerEx_:GetController("status")
	arg_3_0.starCon_1 = arg_3_0.starCtrl_1:GetController("star")
	arg_3_0.starCon_2 = arg_3_0.starCtrl_2:GetController("star")
	arg_3_0.starCon_3 = arg_3_0.starCtrl_3:GetController("star")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.index > 1 and not OsirisPlayGameData:IsPassChaptersById(arg_4_0.index - 1) then
			ShowTips("CAPTURE_GAME_PRE_SECTION_UNREACHED")

			return
		end

		JumpTools.OpenPageByJump("/osirisPlayGameStageView", {
			chapterID = arg_4_0.index
		})
	end)
end

function var_0_0.StopTimer(arg_6_0)
	if arg_6_0.timer_ then
		arg_6_0.timer_:Stop()

		arg_6_0.timer_ = nil
	end
end

function var_0_0.RefreshView(arg_7_0)
	for iter_7_0 = 1, 3 do
		arg_7_0["starCon_" .. iter_7_0]:SetSelectedIndex(0)
	end

	arg_7_0.firstUnlockChapterId = OsirisPlayGameData:GetFirstUnlock()

	local var_7_0 = ActivityGeneralityChapterCfg[arg_7_0.index]

	arg_7_0.anim_:Play("UI_unlock_cx_01", -1, 0)
	arg_7_0.anim_:Update(0)

	if arg_7_0.index == 1 then
		arg_7_0.stateCon_:SetSelectedIndex(1)
	elseif OsirisPlayGameData:IsPassChaptersById(arg_7_0.index - 1) then
		if arg_7_0.firstUnlockChapterId == arg_7_0.index then
			arg_7_0.stateCon_:SetSelectedIndex(0)

			arg_7_0.timer_ = Timer.New(function()
				arg_7_0:StopTimer()
				arg_7_0.stateCon_:SetSelectedIndex(1)
				arg_7_0.anim_:Play("UI_unlock_cx_01", -1, 0)
				arg_7_0.anim_:Update(0)
				OsirisPlayGameData:SetFirstUnlock(0)
			end, 1.8, 1)

			arg_7_0.timer_:Start()
		else
			arg_7_0.stateCon_:SetSelectedIndex(1)
		end
	else
		arg_7_0.stateCon_:SetSelectedIndex(0)
	end

	local var_7_1 = OsirisPlayGameData:GetPassStagesNumByChapterId(arg_7_0.index)
	local var_7_2 = var_7_1 > 3 and 3 or var_7_1

	for iter_7_1 = 1, var_7_2 do
		arg_7_0["starCon_" .. iter_7_1]:SetSelectedIndex(1)
	end

	if var_7_0 then
		arg_7_0.skillTxt_1.text = GetI18NText(var_7_0.chapter_name)
		arg_7_0.skillTxt_2.text = GetI18NText(var_7_0.chapter_name)
		arg_7_0.skillImg_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_7_0.icon)
		arg_7_0.skillImg_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_7_0.icon)
	end
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopTimer()
	var_0_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
