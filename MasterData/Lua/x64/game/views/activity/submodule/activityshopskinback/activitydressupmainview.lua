ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityDressUpMainView = class("ActivityDressUpMainView", ActivityMainBasePanel)

function ActivityDressUpMainView:GetUIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_DressUpUI/NorseUI_3_0_DressUpMainUI"
end

function ActivityDressUpMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityDressUpMainView:InitUI()
	self:BindCfgUI()

	self.isClick = false
	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function ActivityDressUpMainView:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 2
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	self.speedBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		self.stateCtrl:SetSelectedIndex(0)

		self.anim_1.speed = 2
		self.anim_2.speed = 2
	end))
	self.speedBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		self.anim_1.speed = 7
		self.anim_2.speed = 7

		self.stateCtrl:SetSelectedIndex(1)
	end))
end

function ActivityDressUpMainView:OnEnter()
	self:RefreshUI()
end

function ActivityDressUpMainView:Show(arg_9_1)
	if arg_9_1 then
		SetActive(self.gameObject_, arg_9_1)
		self.anim_1:Play("Fx_DressUpMainUI_cx", 0, self.normalizedTime_1 or 0)
		self.anim_1:Update(0)
		self.anim_2:Play("Fx_skin_loop_01", 0, self.normalizedTime_2 or 0)
		self.anim_2:Update(0)
	else
		if self.gameObject_.activeSelf == true then
			self.normalizedTime_1 = self.anim_1:GetCurrentAnimatorStateInfo(0).normalizedTime
			self.normalizedTime_2 = self.anim_2:GetCurrentAnimatorStateInfo(0).normalizedTime
		end

		SetActive(self.gameObject_, arg_9_1)
	end
end

function ActivityDressUpMainView:RefreshUI()
	self.skinList_ = GameSetting.skin_return.value

	for iter_10_0, iter_10_1 in ipairs(self.skinList_) do
		self["skinImg_" .. iter_10_0].sprite = pureGetSpriteWithoutAtlas("TextureBg/Version/NorseUI_3_0/NorseUI_3_0_DressUpMainUI/" .. iter_10_1)
	end

	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityID_).stopTime)
	self.pressTxt_.text = GetTips("LONG_PRESS_FILM_ACCELERATE")
	self.accelerateTxt_.text = GetTips("ACCELERATING")
end

function ActivityDressUpMainView:OnExit()
	return
end

function ActivityDressUpMainView:Dispose()
	self.super.Dispose(self)
end

function ActivityDressUpMainView:DonotPreDestroy()
	return true
end

return ActivityDressUpMainView
