ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityValentineGameV3MainView = class("ActivityValentineGameV3MainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_VALENTINE_V3_DES"

function ActivityValentineGameV3MainView:GetUIName()
	return "Widget/Version/Alone_ValentineUI/Alone_Valentine_MainUI"
end

function ActivityValentineGameV3MainView:Init()
	ActivityValentineGameV3MainView.super.Init(self)

	self.btnController_ = self.btnControllerEx_:GetController("statelock01")

	if self.bg_ then
		self.bg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Version/Alone_ValentineUI/Valentine_bg_ST05")
	end
end

function ActivityValentineGameV3MainView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/valentineGameV3SelectHeroView", {
			activityID = self.activityID_
		})
	end)
	self:BindHelpBtn(var_0_1)
end

function ActivityValentineGameV3MainView:OnEnter()
	ActivityValentineGameV3MainView.super.OnEnter(self)

	self.btnText_.text = GetTips("ACTIVITY_VALENTINE_V3_BTN")

	self:UpdatePreview()
	manager.redPoint:bindUIandKey(self.btn_.transform, RedPointConst.VALENTINE_GAME_ENTER .. "_" .. self.activityID_)
end

function ActivityValentineGameV3MainView:OnExit()
	ActivityValentineGameV3MainView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn_.transform, RedPointConst.VALENTINE_GAME_ENTER .. "_" .. self.activityID_)
end

function ActivityValentineGameV3MainView:isHasLeftTimeDes()
	return false
end

function ActivityValentineGameV3MainView:RefreshAcvanceStatus(arg_8_1)
	if arg_8_1 then
		self.btnController_:SetSelectedState("normal01")
	else
		self.btnController_:SetSelectedState("lock01")
	end
end

return ActivityValentineGameV3MainView
