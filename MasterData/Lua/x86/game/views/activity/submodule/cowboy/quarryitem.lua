local QuarryItem = class("QuarryItem", ReduxView)

function QuarryItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function QuarryItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function QuarryItem:InitUI()
	self:BindCfgUI()

	self.ani_ = self.transform_:GetComponent("Animator")
	self.smokeAni_ = self.smokeGo_.transform:GetComponent("Animator")
	self.texture_ = self.transform_:GetComponent("SpriteRenderer").sprite.texture
	self.script_ = self.transform_:GetComponent(typeof(CowRun))
end

function QuarryItem:AddUIListeners()
	return
end

function QuarryItem:OnEnter()
	return
end

function QuarryItem:Pause()
	self.ani_.enabled = false
	self.smokeAni_.enabled = false

	self:SetPause(true)
end

function QuarryItem:Continue()
	self.ani_.enabled = true
	self.smokeAni_.enabled = true

	self:SetPause(false)
end

function QuarryItem:SetState(arg_8_1)
	self.ani_:Play(arg_8_1)

	if arg_8_1 == "fall" then
		self:SetSpeed(self.fallSpeed_)
		SetActive(self.scoreGo_, true)

		local var_8_0 = 0

		self.timer_ = FrameTimer.New(function()
			if var_8_0 > 0 then
				local var_9_0 = self.ani_:GetCurrentAnimatorStateInfo(0).speed

				TimeTools.StartAfterSeconds(self.fallTime_ / (var_9_0 * var_9_0) * 0.714, function()
					SetActive(self.smokeGo_, true)
					self.smokeAni_:Play("smoke")
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_fall", "")
				end, {})
			end

			var_8_0 = var_8_0 + 1
		end, 1, 2)

		self.timer_:Start()
	end
end

function QuarryItem:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.data_ = arg_11_1
	self.speed_ = arg_11_2 or 100
	self.fallSpeed_ = arg_11_3 or 100

	self:SetSpeed(self.speed_)

	local var_11_0 = self.gameObject_:GetComponent("SpriteRenderer").sprite.texture
	local var_11_1 = self.gameObject_:GetComponent("SpriteRenderer").size

	self.hitTrans_ = {}
	self.hitTrans_ = {
		hitLeft = var_11_1.x / 2 - arg_11_1.hitLeft * (var_11_1.x / var_11_0.width),
		hitRight = var_11_1.x / 2 - arg_11_1.hitRight * (var_11_1.x / var_11_0.width)
	}
	self.width_ = var_11_1.x

	for iter_11_0 = 1, self.ani_.runtimeAnimatorController.animationClips.Length do
		if self.ani_.runtimeAnimatorController.animationClips[iter_11_0].name == "fall" then
			self.fallTime_ = self.ani_.runtimeAnimatorController.animationClips[iter_11_0].length

			break
		end
	end

	self.isHitOrTaunt_ = false
	self.isPass_ = false

	SetActive(self.scoreGo_, false)
	SetActive(self.smokeGo_, false)
end

function QuarryItem:SetIsHitOrTaunt()
	self.isHitOrTaunt_ = true
end

function QuarryItem:GetIsHitOrTaunt()
	return self.isHitOrTaunt_
end

function QuarryItem:SetIsPass()
	self.isPass_ = true
end

function QuarryItem:GetIsPass()
	return self.isPass_
end

function QuarryItem:GetData()
	return self.data_
end

function QuarryItem:GetWidth()
	return self.width_
end

function QuarryItem:GetHitRect()
	return self.hitTrans_
end

function QuarryItem:SetSpeed(arg_19_1)
	if self.script_ then
		self.script_:SetSpeed(arg_19_1)
	end
end

function QuarryItem:SetPause(arg_20_1)
	if self.script_ then
		self.script_:SetPause(arg_20_1)
	end
end

function QuarryItem:SetStop(arg_21_1)
	if self.script_ then
		self.script_:SetStop(arg_21_1)
	end
end

function QuarryItem:OnExit()
	Object.Destroy(self.gameObject_)
end

function QuarryItem:Dispose()
	self:RemoveAllListeners()
	QuarryItem.super.Dispose(self)
end

return QuarryItem
