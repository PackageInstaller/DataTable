local FireWorkMakeView = class("FireWorkMakeView", ReduxView)

function FireWorkMakeView:UIName()
	return "UI/EmptyDream/Firework/FireworkMakeUI"
end

function FireWorkMakeView:UIParent()
	return manager.ui.uiMain.transform
end

function FireWorkMakeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FireWorkMakeView:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function FireWorkMakeView:AddUIListener()
	self:AddBtnListener(self.m_makeBtn, nil, function()
		self:StartGame()
	end)
	self.m_fishEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		if self.stateController:GetSelectedState() == "1" then
			self:EndQte()
		end
	end))
	self:AddBtnListener(self.m_mask, nil, function()
		if self.stateController:GetSelectedState() == "1" then
			return
		end

		self:Back()
	end)
end

function FireWorkMakeView:OnTop()
	manager.windowBar:SwitchBar({})
end

function FireWorkMakeView:OnEnter()
	if not self.params_.start then
		return
	end

	self.params_.start = false

	self:NewGame()

	if not getData("FireWork", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			startIndex = 2,
			pages = (GameSetting.activity_firework_describe or nil) and (GameSetting.activity_firework_describe.value or {})
		})
		saveData("FireWork", "showHelp", 1)
	end
end

function FireWorkMakeView:OnUpdate()
	if not self.params_.start then
		return
	end

	self.params_.start = false

	self:NewGame()
end

function FireWorkMakeView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:RemoveTween()
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function FireWorkMakeView:NewGame()
	self.activity_id = self.params_.fire_activity_id
	self.m_name.text = GetI18NText(ActivityFireWorkCfg[self.activity_id].name)
	self.m_des.text = GetI18NText(ActivityFireWorkCfg[self.activity_id].desc)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/" .. ActivityFireWorkCfg[self.activity_id].icon)
	self.m_arror.localRotation = Quaternion.Euler(0, 0, 0)
	self.m_circle.localRotation = Quaternion.Euler(0, 0, 0)
	self.m_countDownLab.text = ""
	self.m_countDownProgress.fillAmount = 0
	self.m_countLab.text = ""

	self.stateController:SetSelectedIndex(0)
	SetActive(self.m_baozu, false)
end

function FireWorkMakeView:StartGame()
	self.countDown = 3

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:RefreshCountDown()

	self.timer = Timer.New(function()
		self.countDown = self.countDown - 1

		self:RefreshCountDown()

		if self.countDown <= 0 then
			self:StartQte()
		end
	end, 1, 3)

	self.timer:Start()
	self.stateController:SetSelectedIndex(4)

	self.tagret = self:RandomAngle()
	self.m_circle.localRotation = Quaternion.Euler(0, 0, self.tagret)

	self.m_circleAnimator:Play("circle", 0, 0)

	self.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. "1/3"

	SetActive(self.m_baozu, true)

	self.m_countDownProgress.fillAmount = 1

	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_leader", "")
end

function FireWorkMakeView:RefreshCountDown()
	self.m_countDownLab.text = self.countDown > 0 and self.countDown or ""

	if self.countDown == 3 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_three", "")
	elseif self.countDown == 2 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_two", "")
	elseif self.countDown == 1 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_one", "")
	else
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_pointer", "")
	end
end

function FireWorkMakeView:StartQte()
	self:RemoveTween()

	self.max = 3
	self.count = 1
	self.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. self.count .. "/" .. self.max

	self:DoTween(self.tagret)
	self.stateController:SetSelectedIndex(1)
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_pointer", "")
end

function FireWorkMakeView:DoTween(arg_18_1)
	self.tagret = arg_18_1
	self.m_circle.localRotation = Quaternion.Euler(0, 0, self.tagret)
	self.m_countDownProgress.transform.localRotation = Quaternion.Euler(0, 0, self.m_arror.localEulerAngles.z)
	self.tween = LeanTween.rotateAroundLocal(self.m_arror.gameObject, Vector3.New(0, 0, -1), 360, 2):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
		self.m_countDownProgress.fillAmount = (360 - arg_19_0) / 360
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()
		self:GotoFail()
	end))
end

function FireWorkMakeView:EndQte()
	if (self.tagret + 360 - (self.m_arror.localEulerAngles.z + 360) % 360) % 360 <= 35 or (self.tagret + 360 - (self.m_arror.localEulerAngles.z + 360) % 360) % 360 >= 325 then
		if (self.tagret + 360 - (self.m_arror.localEulerAngles.z + 360) % 360) % 360 <= 15 or (self.tagret + 360 - (self.m_arror.localEulerAngles.z + 360) % 360) % 360 >= 345 then
			self.count = self.count + 1

			SDKTools.SendMessageToSDK("activity_firework_opt", {
				result = 2,
				activity_id = self.activity_id
			})

			self.m_effectTransform.localRotation = self.m_arror.localRotation

			self.m_animator:Play("arrow", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_sign", "")
		else
			SDKTools.SendMessageToSDK("activity_firework_opt", {
				result = 1,
				activity_id = self.activity_id
			})
		end

		if self.max < self.count then
			self:RemoveTween()
			self:GotoWin()
		else
			self.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. self.count .. "/" .. self.max

			self:RemoveTween()
			self:DoTween((self:RandomAngle()))
			self.m_circleAnimator:Play("circle", 0, 0)
		end
	else
		SDKTools.SendMessageToSDK("activity_firework_opt", {
			result = 0,
			activity_id = self.activity_id
		})
		self:RemoveTween()
		self:GotoFail()
	end
end

function FireWorkMakeView:GotoFail()
	self.stateController:SetSelectedIndex(1)
	JumpTools.OpenPageByJump("fireWorkResult", {
		isWin = false,
		fire_activity_id = self.activity_id
	})
	SDKTools.SendMessageToSDK("activity_firework_over", {
		is_success = 0,
		activity_id = self.activity_id
	})
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function FireWorkMakeView:GotoWin()
	self.stateController:SetSelectedIndex(1)

	if FireWorkData:GetInvited(self.activity_id) then
		JumpTools.OpenPageByJump("fireWorkResult", {
			isWin = true,
			fire_activity_id = self.activity_id
		})
	else
		FireWorkAction.QueryInvite(self.activity_id)
	end

	SDKTools.SendMessageToSDK("activity_firework_over", {
		is_success = 1,
		activity_id = self.activity_id
	})
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function FireWorkMakeView:RemoveTween()
	if self.tween then
		self.tween:setOnComplete(nil)
		LeanTween.cancel(self.m_arror.gameObject)

		self.tween = nil
	end
end

function FireWorkMakeView:RandomAngle()
	return -((-self.m_arror.localEulerAngles.z + 360) % 360 + math.random(120, 300)) % 360
end

function FireWorkMakeView:Dispose()
	FireWorkMakeView.super.Dispose(self)
end

return FireWorkMakeView
