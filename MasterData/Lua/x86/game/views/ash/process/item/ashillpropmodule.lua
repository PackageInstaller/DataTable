local AshILLPropModule = class("AshILLPropModule", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/PropItem"

function AshILLPropModule:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.from = arg_1_3 or "DEFAULT"

	if not arg_1_2 then
		self.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
		self.transform_ = self.gameObject_.transform
		self.transform_.parent = arg_1_1
		self.transform_.localPosition = Vector3.zero
		self.transform_.localRotation = Quaternion.identity
		self.transform_.localScale = Vector3.one
		self.isCustomObj = false
	else
		self.gameObject_ = arg_1_2
		self.transform_ = self.gameObject_.transform
		self.isCustomObj = true
	end

	self:Init()
end

function AshILLPropModule:Init()
	self:BindCfgUI()

	self.lockController = self.controller_:GetController("lock")

	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.propCfg.unlockRate > AshSystemData:GetHomologyRate() then
			ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), self.propCfg.unlockRate))
		end
	end)
end

function AshILLPropModule:Render(arg_4_1)
	self.propCfg = arg_4_1

	if not self.propCfg then
		self.lockController:SetSelectedState("true")

		return
	end

	if self.propCfg.unlockRate > AshSystemData:GetHomologyRate() then
		self.lockController:SetSelectedState("true")
		SetActive(self.lockAniObj_, true)
	else
		self.lockController:SetSelectedState("false")
		SetActive(self.lockAniObj_, false)

		local var_4_0 = "CowbotPropLock" .. self.from .. self.propCfg.id

		if self.aniTimer_ then
			self.aniTimer_:Stop()

			self.aniTimer_ = nil
		end

		if not getData("ash", "CowbotPropLock" .. self.from .. self.propCfg.id) then
			FrameTimer.New(function()
				SetActive(self.lockAniObj_, true)
				saveData("ash", var_4_0, true)

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
				self.lockAnim_:Play("PropItem_unlock", 0, 0)
				self.aniTimer_:Start()
			end, 1, 1):Start()
		end
	end

	local var_4_1 = arg_4_1.cfg

	self.icon_.sprite = pureGetSpriteWithoutAtlas(arg_4_1.cfg.icon)
	self.nameText_.text = GetI18NText(var_4_1.name)
	self.descTxt_.text = GetI18NText(var_4_1.desc)
end

function AshILLPropModule:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	if not self.isCustomObj then
		GameObject.DestroyImmediate(self.gameObject_)
		Asset.Unload(var_0_1)
	end

	self.super.Dispose(self)
end

return AshILLPropModule
