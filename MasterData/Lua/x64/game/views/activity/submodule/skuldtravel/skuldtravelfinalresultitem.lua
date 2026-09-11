local SkuldTravelFinalResultItem = class("SkuldTravelFinalResultItem", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/image/"

function SkuldTravelFinalResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkuldTravelFinalResultItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelFinalResultItem:InitUI()
	self:BindCfgUI()

	self.raskController_ = {}

	for iter_3_0 = 1, 3 do
		self.raskController_[iter_3_0] = ControllerUtil.GetController(self["rasktrans_" .. iter_3_0], "statu")
	end

	self.statucontroller_ = ControllerUtil.GetController(self.transform_, "statu")
	self.isshowtaskController_ = ControllerUtil.GetController(self.transform_, "isshowtask")
end

function SkuldTravelFinalResultItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.index_ > 3 then
			if SkuldTravelData:GetEndingIsOpened(self.endingid_) then
				BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, GameSetting.travel_skuld_new_ending_stage_id.value[1], 0)
			else
				SkuldTravelAction:OpenEnding(self.endingid_)
			end
		elseif SkuldTravelData:GetEndingIsOpened(self.endingid_) then
			JumpTools.OpenPageByJump("skuldTravelFinalPlotView", {
				endingid = self.endingid_
			})
		elseif SkuldTravelData:GetEndingIsCanOpen(self.endingid_) then
			SkuldTravelAction:OpenEnding(self.endingid_)
		end
	end)
end

function SkuldTravelFinalResultItem:SetData(arg_6_1)
	self.index_ = arg_6_1
	self.endingid_ = TravelSkuldEndingCfg.all[arg_6_1]
	self.cfg_ = TravelSkuldEndingCfg[self.endingid_]
	self.endingname_.text = GetI18NText(self.cfg_.story_name)

	local var_6_0 = var_0_1

	var_6_0 = SkuldTravelData:GetSkuldBtnIsBreach() and var_6_0 .. TravelSkuldEndingCfg[self.endingid_].destroy_picture or var_6_0 .. TravelSkuldEndingCfg[self.endingid_].picture
	self.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_6_0)

	if arg_6_1 > 3 then
		self.isshowtaskController_:SetSelectedState("false")

		if SkuldTravelData:GetEndingIsOpened(self.endingid_) then
			self.statucontroller_:SetSelectedState("get")
		else
			self.statucontroller_:SetSelectedState("canopen")
		end
	else
		self.isshowtaskController_:SetSelectedState("true")
		self.statucontroller_:SetSelectedState(SkuldTravelData:GetEndingStatu(self.endingid_))

		local var_6_1 = 1
		local var_6_2 = SkuldTravelData:GetAttrib()

		for iter_6_0, iter_6_1 in pairs(self.cfg_.unlock_attrib) do
			if iter_6_1 > 0 then
				if iter_6_1 <= var_6_2[iter_6_0] then
					self.raskController_[var_6_1]:SetSelectedState("finish")
				else
					self.raskController_[var_6_1]:SetSelectedState("unfinish")
				end

				self["rasktext_" .. var_6_1].text = SkuldTravelData:AttribIndexToString(iter_6_0) .. "≥" .. iter_6_1
				var_6_1 = var_6_1 + 1
			end
		end

		for iter_6_2, iter_6_3 in pairs(self.cfg_.unlock_story_collect) do
			self["rasktext_" .. var_6_1].text = string.format(GetTips("TRAVEL_SKULD_STORY_GET_INFINAL"), GetI18NText(TravelSkuldStoryCfg[iter_6_3].story_name))

			if SkuldTravelData:GetPlotIsGeted(iter_6_3) then
				self.raskController_[var_6_1]:SetSelectedState("finish")
			else
				self.raskController_[var_6_1]:SetSelectedState("unfinish")
			end
		end
	end
end

function SkuldTravelFinalResultItem:OnExit()
	return
end

function SkuldTravelFinalResultItem:Dispose()
	SkuldTravelFinalResultItem.super.Dispose(self)
end

return SkuldTravelFinalResultItem
