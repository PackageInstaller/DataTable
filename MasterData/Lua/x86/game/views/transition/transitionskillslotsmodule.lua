local TransitionSkillSlotsModule = class("TransitionSkillSlotsModule", ReduxView)

function TransitionSkillSlotsModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isInSlotView = arg_1_2 or false

	self:Init()

	if arg_1_2 then
		self.slotRootObj_:GetComponent(typeof(Animator)).enabled = false
	end
end

function TransitionSkillSlotsModule:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TransitionSkillSlotsModule:InitUI()
	self:BindCfgUI()
	self:BuildContext()

	self.ringController_ = self.discCon_:GetController("default0")
	self.itemController_ = self.itemCon_:GetController("default0")

	local var_3_0 = not self.isInSlotView

	self.ringController_:SetSelectedState(not self.isInSlotView and "B" or "A")
	self.itemController_:SetSelectedState(var_3_0 and "open" or "close")
end

function TransitionSkillSlotsModule:BuildContext()
	self.constVar = {
		selectLocked = false,
		slotPrefix = "slot%dObj_",
		jumpDuration = 0.5,
		showLocked = true,
		animLocked = true
	}
	self.slots = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = TransitionSkilSlotItem.New(self[string.format(self.constVar.slotPrefix, iter_4_0)], self.isInSlotView)

		self.slots[iter_4_0] = {
			viewModule = var_4_0
		}

		var_4_0:RenderPosition(iter_4_0)
		var_4_0:RegisterClickListener(handler(self, self.OnSlotClick))
	end

	self.data = {
		slotIdx = 1,
		heroID = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		slotContext = {
			slots = {}
		}
	}
end

function TransitionSkillSlotsModule:InitContext()
	self.data = {
		slotIdx = 1,
		heroID = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		slotContext = {
			slots = {}
		}
	}

	for iter_5_0 = 1, 6 do
		self.slots[iter_5_0].viewModule:InitAnim()
	end
end

function TransitionSkillSlotsModule:AddUIListeners()
	return
end

function TransitionSkillSlotsModule:Dispose()
	self:RemoveAllListeners()
	self:RemoveTween()

	for iter_7_0 = 1, 6 do
		self.slots[iter_7_0].viewModule:Dispose()

		self.slots[iter_7_0] = nil
	end

	TransitionSkillSlotsModule.super.Dispose(self)
end

function TransitionSkillSlotsModule:RenderView(arg_8_1)
	if arg_8_1.needRefresh then
		self:InitContext()

		if not self:GetJumpAnimLock() then
			self:JumpDirectly(5)
			self:JumpToSlot(arg_8_1.index or 1)
		end

		self:SelectSlot(0)
	end

	self.ringAAni_:Play(not self.isInSlotView and "UI_ringA" or "UI_ringB")
	self.ringAAni_:Update(0)

	self.data.heroID = arg_8_1.heroID

	if arg_8_1.proxy then
		self.data.heroDataProxy = arg_8_1.proxy
		self.data.type = self.data.heroDataProxy:GetViewDataType()
	else
		if not arg_8_1.type then
			self.data.type = HeroConst.HERO_DATA_TYPE.DEFAULT
		end

		self.data.heroDataProxy = HeroViewDataProxy.New(self.data.type)
	end

	if arg_8_1.slots then
		local var_8_1 = {
			slots = arg_8_1.slots
		}

		for iter_8_0 = 1, 6 do
			var_8_1.slots[iter_8_0] = var_8_1.slots[iter_8_0] or {
				totalPoint = 0,
				isLock = true,
				skills = {},
				slotIdx = iter_8_0
			}
		end

		self.data.slotContext = var_8_1

		for iter_8_1, iter_8_2 in ipairs(arg_8_1.slots) do
			self:RenderSlot(iter_8_1, iter_8_2)
		end
	else
		local var_8_2 = {
			slots = {}
		}

		for iter_8_3, iter_8_4 in ipairs((self.data.heroDataProxy:GetHeroTransitionInfoList(arg_8_1.heroID))) do
			local var_8_3 = iter_8_4.skill_list or {}
			local var_8_4 = {
				skills = {},
				slotIdx = iter_8_4.slot_id,
				isLock = self:GetSlotLockStatus(iter_8_4.slot_id)
			}

			var_8_4.totalPoint = iter_8_4.talent_points or 0
			var_8_2.slots[iter_8_4.slot_id] = var_8_4

			for iter_8_5, iter_8_6 in ipairs(var_8_3) do
				table.insert(var_8_4.skills, {
					skillId = iter_8_6.skill_id,
					level = iter_8_6.skill_level
				})
			end
		end

		for iter_8_7 = 1, 6 do
			var_8_2.slots[iter_8_7] = var_8_2.slots[iter_8_7] or {
				totalPoint = 0,
				skills = {},
				slotIdx = iter_8_7,
				isLock = self:GetSlotLockStatus(iter_8_7)
			}
		end

		self.data.slotContext = var_8_2

		for iter_8_8, iter_8_9 in pairs(var_8_2.slots) do
			self:RenderSlot(iter_8_8, iter_8_9)
		end
	end

	if self:GetShowLocked() then
		self:RenderLock()
	else
		self:ClearLock()
	end
end

function TransitionSkillSlotsModule:ClearLock()
	for iter_9_0 = 1, 6 do
		self.slots[iter_9_0].viewModule:RenderLock(false)
	end
end

function TransitionSkillSlotsModule:RenderLock()
	for iter_10_0 = 1, 6 do
		if self.data.slotContext.slots[iter_10_0] then
			self.slots[iter_10_0].viewModule:RenderLock(self.data.slotContext.slots[iter_10_0].isLock or false)
		end
	end
end

function TransitionSkillSlotsModule:RenderSlot(arg_11_1, arg_11_2)
	self.slots[arg_11_1].viewModule:RenderView(arg_11_2)
end

function TransitionSkillSlotsModule:RefreshSlot(arg_12_1)
	arg_12_1.heroId = self.data.heroID
	self.data.slotContext.slots[arg_12_1.slotIdx] = deepClone(arg_12_1)

	self:RenderSlot(arg_12_1.slotIdx, self.data.slotContext.slots[arg_12_1.slotIdx])
end

function TransitionSkillSlotsModule:ClearSlot(arg_13_1)
	self.slots[arg_13_1].viewModule:ClearSlot()
end

function TransitionSkillSlotsModule:LockJumpAnim(arg_14_1)
	self.constVar.animLocked = arg_14_1
end

function TransitionSkillSlotsModule:GetJumpAnimLock()
	return self.constVar.animLocked
end

function TransitionSkillSlotsModule:LockSelect(arg_16_1)
	self.constVar.selectLocked = arg_16_1

	if arg_16_1 then
		self:SelectSlot(0)
	end
end

function TransitionSkillSlotsModule:SetShowLocked(arg_17_1)
	self.constVar.showLocked = arg_17_1
end

function TransitionSkillSlotsModule:GetShowLocked()
	return self.constVar.showLocked
end

function TransitionSkillSlotsModule:GetSelectLock()
	return self.constVar.selectLocked
end

function TransitionSkillSlotsModule:RegisterSlotClickCallback(arg_20_1)
	self.constVar.slotClickCallback = arg_20_1
end

function TransitionSkillSlotsModule:GetAllSlotMessage(arg_21_1)
	return self.data.slotContext.slots
end

function TransitionSkillSlotsModule:GetCurEulerAngle()
	return self.slotRootObj_.transform.eulerAngles.z
end

function TransitionSkillSlotsModule:JumpDirectly(arg_23_1)
	self.slotRootObj_.transform.rotation = Quaternion.Euler(Vector3.New(0, 0, (2 - (arg_23_1 + 3) % 6) * 60))
	self.data.slotIdx = arg_23_1
end

function TransitionSkillSlotsModule:JumpToSlot(arg_24_1)
	if self.data.slotIdx ~= arg_24_1 then
		self:StartTween(arg_24_1)

		self.data.slotIdx = arg_24_1
	end
end

function TransitionSkillSlotsModule:GetAngle(arg_25_1)
	local var_25_0 = self:GetCurEulerAngle()

	if math.abs(var_25_0 - (2 - (arg_25_1 + 3) % 6) * 60) > math.abs(var_25_0 - ((2 - (arg_25_1 + 3) % 6) * 60 + 360)) then
		return (2 - (arg_25_1 + 3) % 6) * 60 + 360
	else
		return (2 - (arg_25_1 + 3) % 6) * 60
	end
end

function TransitionSkillSlotsModule:RemoveTween()
	if self.constVar.tweenRef then
		self.constVar.tweenRef:setOnComplete(nil)
		LeanTween.cancel(self.constVar.tweenRef.id)

		self.constVar.tweenRef = nil
	end
end

function TransitionSkillSlotsModule:StartTween(arg_27_1)
	if self:GetJumpAnimLock() then
		return
	end

	self:RemoveTween()
	manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")

	self.constVar.tweenRef = LeanTween.rotateLocal(self.slotRootObj_, Vector3.New(0, 0, (self:GetAngle(arg_27_1))), self.constVar.jumpDuration):setEase(LeanTweenType.easeOutCubic):setOnComplete(System.Action(function()
		self:OnTweenComplete()
		self:RemoveTween()
	end))
end

function TransitionSkillSlotsModule:OnTweenComplete()
	return
end

function TransitionSkillSlotsModule:SelectSlot(arg_30_1)
	for iter_30_0 = 1, 6 do
		if iter_30_0 == arg_30_1 then
			self.slots[iter_30_0].viewModule:RenderSelect(true)
		else
			self.slots[iter_30_0].viewModule:RenderSelect(false)
		end
	end
end

function TransitionSkillSlotsModule:ClearSelect()
	self:SelectSlot(0)
end

function TransitionSkillSlotsModule:OnSlotClick(arg_32_1)
	if self.constVar.slotClickCallback then
		if self.data.slotContext.slots[arg_32_1] then
			self.constVar.slotClickCallback(self.data.slotContext.slots[arg_32_1])
		end
	end

	if not self:GetSelectLock() then
		self:SelectSlot(arg_32_1)
	end
end

function TransitionSkillSlotsModule:GetSlotLockStatus(arg_33_1)
	local var_33_0 = self.data.heroDataProxy:GetEquipDataList(self.data.heroID)

	return ((var_33_0[arg_33_1] and var_33_0[arg_33_1].prefab_id and var_33_0[arg_33_1].prefab_id ~= 0 or nil) and var_33_0[arg_33_1]:GetLevel()) < GameSetting.exclusive_open_need.value[1]
end

return TransitionSkillSlotsModule
