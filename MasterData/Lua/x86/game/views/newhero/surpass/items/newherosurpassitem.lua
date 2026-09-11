local NewHeroSurpassItem = class("NewHeroSurpassItem", ReduxView)
local var_0_1 = {
	lockState = {
		selectLock = "1",
		name = "lock",
		normalLock = "2"
	},
	selectState = {
		name = "select",
		use = "2",
		unUse = "1"
	},
	useLockState = {
		name = "on",
		lock = "2",
		unlock = "1"
	},
	titleState = {
		lock = "2",
		name = "title",
		noTitle = "1",
		unlock = "3"
	},
	upState = {
		name = "up",
		noUp = "state0",
		canUp = "state1"
	}
}

function NewHeroSurpassItem:OnCtor(arg_1_1, arg_1_2)
	self.parent_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitUI()
end

function NewHeroSurpassItem:InitUI()
	self:BindCfgUI()

	self.lockController = self.controllerexcollection_:GetController(var_0_1.lockState.name)
	self.selectController = self.controllerexcollection_:GetController(var_0_1.selectState.name)
	self.useLockController = self.controllerexcollection_:GetController(var_0_1.useLockState.name)
	self.titleController = self.controllerexcollection_:GetController(var_0_1.titleState.name)
	self.upController = self.controllerexcollection_:GetController(var_0_1.upState.name)

	self:AddBtnListener(self.btnbigitemBtn_, nil, function()
		if self.clickCallBack then
			self.clickCallBack()
		end
	end)

	self.beginAlpha = self:GetAlpha()
	self.beginScale = self:GetScale()

	self:PlayLessenAni()
end

function NewHeroSurpassItem:ChangeLockState(arg_4_1)
	local var_4_0 = true

	for iter_4_0, iter_4_1 in pairs(self.starIdList or {}) do
		if iter_4_1 <= arg_4_1 + 1 then
			var_4_0 = false
		end
	end

	self.lockController:SetSelectedState((self.isGrow or nil) and (var_0_1.lockState.selectLock or var_0_1.lockState.normalLock))

	if var_4_0 ~= self.isLock then
		self.useLockController:SetSelectedState((var_4_0 or nil) and (var_0_1.useLockState.lock or var_0_1.useLockState.unlock))
	end

	self.isLock = var_4_0

	self:UpdateTitleState()
end

function NewHeroSurpassItem:RefreshUI(arg_5_1)
	if not self.starStage then
		return
	end

	local var_5_0 = arg_5_1.star

	self:ChangeLockState(arg_5_1.star)
	self.selectController:SetSelectedState(var_0_1.selectState.unUse)
	SurpassTools.UpdateSliImageFill(self.slistateblackImg_, self.starStage, var_5_0)
	self.upController:SetSelectedState((checkGold(HeroStarCfg[var_5_0].gold_cost, false) and arg_5_1.piece >= HeroStarCfg[var_5_0].star_up and SurpassTools.GetNextSurpassStarID(var_5_0) == self.starIdList[1] or nil) and var_0_1.upState.canUp)

	if HeroStarCfg[HeroCfg[arg_5_1.id].unlock_star].star == self.starStage then
		self.isBeginStarStage = true
	end
end

function NewHeroSurpassItem:SetStarStage(arg_6_1)
	self.starStage = arg_6_1
	self.starIdList = HeroStarCfg.get_id_list_by_star[arg_6_1]

	SurpassTools.ChangeIconStarSpirte(self.iconImg_, arg_6_1)
end

function NewHeroSurpassItem:SetClickCallBack(arg_7_1)
	self.clickCallBack = arg_7_1
end

function NewHeroSurpassItem:GetStarIdList()
	return self.starIdList
end

function NewHeroSurpassItem:GetTransform()
	return self.transform_
end

function NewHeroSurpassItem:GetPosition()
	return self.transform_.anchoredPosition
end

function NewHeroSurpassItem:SetPosition(arg_11_1, arg_11_2)
	self.transform_.anchoredPosition = Vector2(arg_11_1, arg_11_2)
end

function NewHeroSurpassItem:SetActive(arg_12_1)
	self.gameObject_:SetActive(arg_12_1)
end

function NewHeroSurpassItem:GetStarStage()
	return self.starStage
end

function NewHeroSurpassItem:ChangeAlpha(arg_14_1)
	self.canvasgroup_.alpha = arg_14_1
end

function NewHeroSurpassItem:GetAlpha()
	return self.canvasgroup_.alpha
end

function NewHeroSurpassItem:GetBeginAlpha()
	return self.beginAlpha
end

function NewHeroSurpassItem:GetScale()
	return self.transform_.localScale
end

function NewHeroSurpassItem:SetScale(arg_18_1)
	if arg_18_1 and arg_18_1.x and arg_18_1.x < 1 then
		self.animator_.enabled = false
	end

	self.transform_.localScale = arg_18_1
end

function NewHeroSurpassItem:GetBeginScale()
	return self.beginScale
end

function NewHeroSurpassItem:PlayLessenAni()
	self.animator_:SetFloat("speed", -1)
	self.animator_:Play("Fx_btnbigItem_cx", 0, 0.4)
end

function NewHeroSurpassItem:PlayScaleAni(arg_21_1)
	self.isGrow = arg_21_1
	self.animator_.enabled = not (self:GetScale().x <= 1.1 and not arg_21_1)

	local var_21_0 = arg_21_1 and 1 or -1

	if (arg_21_1 and 1 or -1) == self.animator_:GetFloat("speed") then
		return
	end

	self.animator_:SetFloat("speed", var_21_0)

	local var_21_1, var_21_2 = self:GetClipTimes()

	if arg_21_1 then
		self.animator_:Play("Fx_btnbigItem_cx", 0, var_21_2 - var_21_1)
	else
		self.animator_:Play("Fx_btnbigItem_cx", 0, var_21_1)
	end

	if not arg_21_1 then
		self:PlaySelectAni(false)
	end

	self.lockController:SetSelectedState((arg_21_1 or nil) and (var_0_1.lockState.selectLock or var_0_1.lockState.normalLock))
	self:UpdateTitleState()
end

function NewHeroSurpassItem:UpdateTitleState()
	self.titleController:SetSelectedState((self.isGrow or nil) and (self.isLock and var_0_1.titleState.lock or var_0_1.titleState.unlock))
end

function NewHeroSurpassItem:PlaySelectAni(arg_23_1)
	if self.isBeginStarStage then
		self.selectController:SetSelectedState(var_0_1.selectState.unUse)

		return
	end

	if arg_23_1 then
		self.selectController:SetSelectedState(var_0_1.selectState.use)
	else
		self.selectController:SetSelectedState(var_0_1.selectState.unUse)
	end
end

function NewHeroSurpassItem:GetClipTimes()
	local var_24_0 = self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime
	local var_24_1 = self.animator_:GetCurrentAnimatorClipInfo(0)

	if self.animator_:GetCurrentAnimatorClipInfoCount(0) <= 0 then
		return 0, 0
	end

	local var_24_2 = var_24_1[0].clip.length

	return (var_24_0 < 1 and var_24_0 > 0 or nil) and var_24_2 * var_24_0, var_24_2
end

function NewHeroSurpassItem:Dispose()
	NewHeroSurpassItem.super.Dispose(self)
end

return NewHeroSurpassItem
