local var_0_0 = class("SkuldTravelFinalResultItem", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/image/"

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

	arg_3_0.raskController_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.raskController_[iter_3_0] = ControllerUtil.GetController(arg_3_0["rasktrans_" .. iter_3_0], "statu")
	end

	arg_3_0.statucontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "statu")
	arg_3_0.isshowtaskController_ = ControllerUtil.GetController(arg_3_0.transform_, "isshowtask")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.index_ > 3 then
			if SkuldTravelData:GetEndingIsOpened(arg_4_0.endingid_) then
				local var_5_0 = GameSetting.travel_skuld_new_ending_stage_id.value[1]

				BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_5_0, 0)
			else
				SkuldTravelAction:OpenEnding(arg_4_0.endingid_)
			end
		elseif SkuldTravelData:GetEndingIsOpened(arg_4_0.endingid_) then
			JumpTools.OpenPageByJump("skuldTravelFinalPlotView", {
				endingid = arg_4_0.endingid_
			})
		elseif SkuldTravelData:GetEndingIsCanOpen(arg_4_0.endingid_) then
			SkuldTravelAction:OpenEnding(arg_4_0.endingid_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.index_ = arg_6_1
	arg_6_0.endingid_ = TravelSkuldEndingCfg.all[arg_6_1]
	arg_6_0.cfg_ = TravelSkuldEndingCfg[arg_6_0.endingid_]
	arg_6_0.endingname_.text = GetI18NText(arg_6_0.cfg_.story_name)

	local var_6_0 = var_0_1

	if SkuldTravelData:GetSkuldBtnIsBreach() then
		var_6_0 = var_6_0 .. TravelSkuldEndingCfg[arg_6_0.endingid_].destroy_picture
	else
		var_6_0 = var_6_0 .. TravelSkuldEndingCfg[arg_6_0.endingid_].picture
	end

	arg_6_0.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_6_0)

	if arg_6_1 > 3 then
		arg_6_0.isshowtaskController_:SetSelectedState("false")

		if SkuldTravelData:GetEndingIsOpened(arg_6_0.endingid_) then
			arg_6_0.statucontroller_:SetSelectedState("get")
		else
			arg_6_0.statucontroller_:SetSelectedState("canopen")
		end
	else
		arg_6_0.isshowtaskController_:SetSelectedState("true")
		arg_6_0.statucontroller_:SetSelectedState(SkuldTravelData:GetEndingStatu(arg_6_0.endingid_))

		local var_6_1 = 1
		local var_6_2 = SkuldTravelData:GetAttrib()

		for iter_6_0, iter_6_1 in pairs(arg_6_0.cfg_.unlock_attrib) do
			if iter_6_1 > 0 then
				if iter_6_1 <= var_6_2[iter_6_0] then
					arg_6_0.raskController_[var_6_1]:SetSelectedState("finish")
				else
					arg_6_0.raskController_[var_6_1]:SetSelectedState("unfinish")
				end

				arg_6_0["rasktext_" .. var_6_1].text = SkuldTravelData:AttribIndexToString(iter_6_0) .. "≥" .. iter_6_1
				var_6_1 = var_6_1 + 1
			end
		end

		for iter_6_2, iter_6_3 in pairs(arg_6_0.cfg_.unlock_story_collect) do
			arg_6_0["rasktext_" .. var_6_1].text = string.format(GetTips("TRAVEL_SKULD_STORY_GET_INFINAL"), GetI18NText(TravelSkuldStoryCfg[iter_6_3].story_name))

			if SkuldTravelData:GetPlotIsGeted(iter_6_3) then
				arg_6_0.raskController_[var_6_1]:SetSelectedState("finish")
			else
				arg_6_0.raskController_[var_6_1]:SetSelectedState("unfinish")
			end
		end
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
