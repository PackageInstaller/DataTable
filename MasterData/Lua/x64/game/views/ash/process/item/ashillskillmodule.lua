local AshILLSkillModule = class("AshILLSkillModule", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/SkillItemV2"

function AshILLSkillModule:Ctor(arg_1_1, arg_1_2)
	self.from = arg_1_2 or "DEFAULT"
	self.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	self.transform_ = self.gameObject_.transform
	self.transform_.parent = arg_1_1
	self.transform_.localPosition = Vector3.zero
	self.transform_.localRotation = Quaternion.identity
	self.transform_.localScale = Vector3.one

	self:Init()
end

function AshILLSkillModule:Init()
	self:BindCfgUI()

	self.lockController = self.controller_:GetController("lock")

	self:ShowSkill(false)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.skillCfg.unlockRate > AshSystemData:GetHomologyRate() then
			ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), self.skillCfg.unlockRate))
		else
			self:ShowSkill(not self.isShowSkill)
		end
	end)
end

function AshILLSkillModule:ShowSkill(arg_4_1)
	if arg_4_1 ~= self.isShowSkill then
		SetActive(self.descObj1_, arg_4_1)
		SetActive(self.descObj2_, arg_4_1)

		self.isShowSkill = arg_4_1
	end
end

function AshILLSkillModule:Render(arg_5_1)
	self.skillCfg = arg_5_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas(arg_5_1.cfg.icon)
	self.nameTxt_.text = GetI18NText(arg_5_1.cfg.name)
	self.descTxt_.text = GetI18NText(arg_5_1.cfg.desc)

	self:RenderLock()

	if self.skillCfg.unlockRate > AshSystemData:GetHomologyRate() or self.from == "PREPARE" then
		self:ShowSkill(false)
	else
		self:ShowSkill(true)
	end
end

function AshILLSkillModule:RenderLock()
	if self.skillCfg.unlockRate > AshSystemData:GetHomologyRate() then
		self.lockController:SetSelectedState("true")
	else
		self.lockController:SetSelectedState("false")

		if self.aniTimer_ then
			self.aniTimer_:Stop()

			self.aniTimer_ = nil
		end

		if not getData("ash", "CowbotSkillModuleLock" .. self.from .. self.skillCfg.id) then
			saveData("ash", "CowbotSkillModuleLock" .. self.from .. self.skillCfg.id, true)
			FrameTimer.New(function()
				self.aniTimer_ = Timer.New(function()
					if self.lockAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if self.aniTimer_ then
							self.aniTimer_:Stop()

							self.aniTimer_ = nil
						end

						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)
				self.lockAnim_:Play("SkillItem_unlock", 0, 0)
				self.aniTimer_:Start()
			end, 1, 1):Start()
		end
	end
end

function AshILLSkillModule:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	GameObject.DestroyImmediate(self.gameObject_)
	Asset.Unload(var_0_1)
	self.super.Dispose(self)
end

return AshILLSkillModule
