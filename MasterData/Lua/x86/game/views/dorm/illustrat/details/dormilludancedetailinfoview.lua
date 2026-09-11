local DormIlluDanceDetailInfoView = class("DormIlluDanceDetailInfoView", ReduxView)

function DormIlluDanceDetailInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormIlluDanceDetailInfoView:OnEnter(arg_2_1)
	self:UpdateView(arg_2_1)
end

function DormIlluDanceDetailInfoView:OnExit()
	self.danceID_ = 0
end

function DormIlluDanceDetailInfoView:Dispose()
	DormIlluDanceDetailInfoView.super.Dispose(self)
end

function DormIlluDanceDetailInfoView:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.danceID_ = 0
end

function DormIlluDanceDetailInfoView:UpdateView(arg_6_1)
	if self.danceID_ == arg_6_1 then
		return
	end

	self.danceID_ = arg_6_1
	self.isUnlock_ = IdolTraineeData:DanceDIYActionAvailable(self.danceID_)

	self.lockController_:SetSelectedIndex(self.isUnlock_ and 0 or 1)

	self.nameText_.text = IdolDanceDIYActionCfg[self.danceID_].name
	self.typeText_.text = GetTips(IdolTraineeConst.style[IdolDanceDIYActionCfg[self.danceID_].type])
	self.beatText_.text = IdolDanceDIYActionCfg[self.danceID_].beat
	self.timeText_.text = manager.time:DescCDTime4(self:TryGetActionDuration())

	if not self.isUnlock_ then
		if IdolDanceDIYActionCfg[self.danceID_] and IdolDanceDIYActionCfg[self.danceID_].unlock_condition then
			if ConditionCfg[IdolDanceDIYActionCfg[self.danceID_].unlock_condition] and ConditionCfg[IdolDanceDIYActionCfg[self.danceID_].unlock_condition].desc then
				self.lockText_.text = IdolDanceDIYActionCfg[self.danceID_].need ~= 0 and string.format(GetI18NText(ConditionCfg[IdolDanceDIYActionCfg[self.danceID_].unlock_condition].desc) .. "(%s/%s)", IdolDanceDIYActionCfg[self.danceID_].need, HistoryData:GetHistoryData(IdolDanceDIYActionCfg[self.danceID_].unlock_condition) or 0, IdolDanceDIYActionCfg[self.danceID_].need) or GetI18NText(ConditionCfg[IdolDanceDIYActionCfg[self.danceID_].unlock_condition].desc)
			end
		end
	end
end

function DormIlluDanceDetailInfoView:TryGetActionDuration()
	local var_7_0 = nullable(IdolDanceDIYActionCfg, self.danceID_, "duration")

	if var_7_0 and var_7_0 > 0 then
		return var_7_0
	end

	local var_7_1 = DanceGame.GetSequence(DormUtils.GetEntityData(DIYBridge.charaEID).cfgID, nil, self:GetAction()).duration

	var_7_1 = var_7_1 or 0

	return var_7_1
end

function DormIlluDanceDetailInfoView:GetAction()
	return nullable(IdolDanceDIYActionCfg, self.danceID_, "anime_action")
end

return DormIlluDanceDetailInfoView
