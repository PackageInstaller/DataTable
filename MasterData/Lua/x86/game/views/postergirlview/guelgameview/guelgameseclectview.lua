local GuelGameSeclectView = class("GuelGameSeclectView", ReduxView)

function GuelGameSeclectView:UIName()
	return "Widget/System/Main_T0SceneGame/102003/102003_Match3SeclectUI"
end

function GuelGameSeclectView:UIParent()
	return manager.ui.uiMain.transform
end

function GuelGameSeclectView:OnCtor()
	return
end

function GuelGameSeclectView:Init()
	self:InitUI()

	self.selectItem = {}
	self.selectIndex = 1
end

function GuelGameSeclectView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selControlller = self.match3seclectuiControllerexcollection_:GetController("selState")
	self.enterControlller = self.match3seclectuiControllerexcollection_:GetController("state")
	self.enterAniControlller = self.match3seclectuiControllerexcollection_:GetController("ani")
	self.cutsceneSubView = TZeroGameChangeView.BaseView.New(self.cutsceneSubView_)
end

function GuelGameSeclectView:SetSpineParent(arg_6_1, arg_6_2)
	local var_6_0 = {
		"spine1Go_",
		"spine2Go_"
	}
	local var_6_1 = {
		"rolepos1Go_",
		"rolepos2Go_"
	}
	local var_6_2

	if var_6_0[arg_6_1] then
		var_6_2 = var_6_0[arg_6_1] or var_6_0[1]

		local var_6_3

		if var_6_1[arg_6_2] then
			var_6_3 = var_6_1[arg_6_2] or var_6_1[1]
		end
	end

	self[var_6_2].transform:SetParent(self[var_6_3].transform)

	self[var_6_2].transform.localPosition = Vector3(0, 0, 0)
	self[var_6_2].transform.localScale = Vector3(arg_6_2 == 1 and 1 or -1, 1, 1)
end

function GuelGameSeclectView:AddListeners()
	self:AddBtnListener(self.btnconfirmBtn_, nil, function()
		if self.confirm then
			return
		end

		self:StopTime()
		self:PlayVoice(true)

		for iter_8_0 = 1, 2 do
			self.selectItem[iter_8_0]:UpdateSelect(false)
		end

		self.confirm = true
		self.timer3 = TimeTools.StartAfterSeconds(0.2, function()
			if self.selectIndex == 1 then
				self.selfSelectAni_:Play("select_role", 0, 0)
			else
				self.enemySelectAni_:Play("select_role", 0, 0)
			end

			manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose02", "")
		end, {})
		self.timer1 = TimeTools.StartAfterSeconds(3, function()
			self:UpdateOtherItem()
			self.selControlller:SetSelectedState("over")
			self.enemyNameAni_:Play("NameChange02", 0, 0)
			manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose01", "")

			for iter_10_0 = 1, 2 do
				self.selectItem[iter_10_0]:UpdateSelect(self.selectIndex ~= iter_10_0)
			end

			self.enemyCharName_.text = self.selectIndex == 1 and HeroCfg[1089].suffix or HeroCfg[1156].suffix

			self:PlayVoice(false)

			self.timer4 = TimeTools.StartAfterSeconds(1, function()
				if self.selectIndex == 1 then
					self.enemySelectAni_:Play("select_role", 0, 0)
				else
					self.selfSelectAni_:Play("select_role", 0, 0)
				end

				manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose02", "")

				for iter_11_0 = 1, 2 do
					self.selectItem[iter_11_0]:UpdateSelect(false)
				end
			end, {})
		end, {})
		self.timer2 = TimeTools.StartAfterSeconds(6, function()
			self.confirm = false

			self:GotoNext(self.selectIndex)
		end, {})
	end)
	self:AddBtnListener(self.continuemaskBtn_, nil, function()
		self.enterControlller:SetSelectedState("select")
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_in", "")
		self.panelAni_:Play("enter", -1, 0)
		self.panelAni_:Update(0)
		self:UpdateSelect()
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose01", "")
	end)
end

local var_0_1 = {
	2011,
	1021
}

function GuelGameSeclectView:PlayVoice(arg_14_1)
	local var_14_0 = var_0_1[math.random(1, 2)]

	HeroTools.PlayVoice(self:GetHeroIdForPlayVoice(var_14_0, arg_14_1), HeroVoiceCfg[var_14_0].file, HeroVoiceCfg[var_14_0].type)
end

function GuelGameSeclectView:GetHeroIdForPlayVoice(arg_15_1, arg_15_2)
	return self.selectIndex == 1 and (arg_15_2 and 1156 or 1089) or arg_15_2 and 1089 or 1156
end

function GuelGameSeclectView:GotoNext(arg_16_1)
	JumpTools.OpenPageByJump("GuelGameView", {
		chooseIndex = arg_16_1
	})
end

function GuelGameSeclectView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.confirm then
			return
		end

		self:Back()
	end)
end

function GuelGameSeclectView:OnTop()
	if self.cutsceneSubView:IsDuringCutscene() then
		manager.windowBar:HideBar()
	else
		self:ChangeBar()
	end
end

function GuelGameSeclectView:OnEnter()
	self.confirm = false

	manager.windowBar:HideBar()
	self.selControlller:SetSelectedState("in")
	self.enterControlller:SetSelectedState("entrance")

	for iter_20_0 = 1, 2 do
		if not self.selectItem[iter_20_0] then
			self.selectItem[iter_20_0] = GuelGameSeclectItem.New(self[string.format("character0%sGo_", iter_20_0)], self)

			self.selectItem[iter_20_0]:SetClickCallback(function()
				if self.confirm then
					return
				end

				if self.selectIndex ~= iter_20_0 then
					self.selectIndex = iter_20_0

					self:UpdateSelect()
					manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose01", "")
				end
			end)
		end

		self.selectItem[iter_20_0]:UpdateSelect(false)
	end

	self:ResetItem()

	function self.cutsceneSubView.onScreenFullyBlockedCallback()
		self.enterAniControlller:SetSelectedState("false")
		self.panelAni_:Play("102003_Match3SeclectUI", -1, 0)
		self.panelAni_:Update(0)
	end

	function self.cutsceneSubView.onFinishCallback()
		self:ChangeBar()
		self.cutsceneSubView.gameObject_:SetActive(false)
	end

	self.enterAniControlller:SetSelectedState("true")
	self.cutsceneSubView:OnEnter()
end

function GuelGameSeclectView:UpdateSelect()
	self.ani_panelAni_:Play("Match3SeclectUI_RoleChange", 0, 0)

	for iter_24_0 = 1, 2 do
		self.selectItem[iter_24_0] = self.selectItem[iter_24_0] or GuelGameSeclectItem.New(self[string.format("character0%sGo_", iter_24_0)])

		self.selectItem[iter_24_0]:UpdateSelect(self.selectIndex == iter_24_0)
	end

	self.selfNameAni_:Play("NameChange01", 0, 0)

	self.selfCharName_.text = self.selectIndex == 1 and HeroCfg[1156].suffix or HeroCfg[1089].suffix
	self.enemyCharName_.text = "???"

	self:SetSpineParent(1, self.selectIndex == 1 and 2 or 1)
	self:SetSpineParent(2, self.selectIndex)
	self:UpdateSelfItem()
end

function GuelGameSeclectView:UpdateOtherItem()
	self.selectItem[self.selectIndex == 1 and 2 or 1]:UpdateCamp(3)
end

function GuelGameSeclectView:UpdateSelfItem()
	self.selectItem[self.selectIndex == 1 and 2 or 1]:UpdateCamp(1)
	self.selectItem[self.selectIndex]:UpdateCamp(2)
end

function GuelGameSeclectView:ResetItem()
	for iter_27_0 = 1, 2 do
		self.selectItem[iter_27_0]:UpdateCamp(0)
	end
end

function GuelGameSeclectView:OnBehind()
	return
end

function GuelGameSeclectView:OnExit()
	GuelGameSeclectView.super.OnExit(self)
	self.cutsceneSubView:OnExit()
end

function GuelGameSeclectView:StopTime()
	if self.timer1 then
		self.timer1:Stop()

		self.timer1 = nil
	end

	if self.timer2 then
		self.timer2:Stop()

		self.timer2 = nil
	end

	if self.timer3 then
		self.timer3:Stop()

		self.timer3 = nil
	end

	if self.timer4 then
		self.timer4:Stop()

		self.timer4 = nil
	end
end

function GuelGameSeclectView:Dispose()
	self.cutsceneSubView:Dispose()
	GuelGameSeclectView.super.Dispose(self)

	for iter_31_0, iter_31_1 in ipairs(self.selectItem) do
		if iter_31_1 and iter_31_1.Dispose then
			iter_31_1:Dispose()
		end
	end

	self:StopTime()

	self.selectItem = nil
end

local Include = import("manager.posterGirl.tgame.GuelGame.States.Include")

function GuelGameSeclectView:GetPlayBackwardsAnimator()
	return self.cutsceneSubView:GetPlayBackwardsAnimator(function()
		self.enterAniControlller:SetSelectedState("true")

		if manager.posterGirl.actor then
			local var_33_0 = manager.posterGirl.actor:GetCurrentState()

			if var_33_0.gameInst and not var_33_0.gameInst.exit then
				var_33_0.gameInst:GoToState(Include.ExitState)
			end
		end
	end)
end

return GuelGameSeclectView
