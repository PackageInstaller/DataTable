local TransitionSkillSlotItem = class("TransitionSkillSlotItem", ReduxView)

function TransitionSkillSlotItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isInSlotView = arg_1_2

	self:Init()
end

function TransitionSkillSlotItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TransitionSkillSlotItem:InitUI()
	self:BindCfgUI()
	self:BuildContext()
end

function TransitionSkillSlotItem:BuildContext()
	self.controller = {
		comps = self.controller_,
		sel = {
			name = "sel",
			Select = "1",
			DeSelect = "0",
			comps = self.controller_:GetController("sel")
		},
		position = {
			Pos3 = "3",
			Pos5 = "5",
			Pos1 = "1",
			Pos2 = "2",
			Pos6 = "6",
			Pos4 = "4",
			name = "position",
			comps = self.controller_:GetController("position")
		},
		Activate = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "Activate",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = self.controller_:GetController("Activate")
		},
		lock = {
			name = "lock",
			Lock = "lock",
			Unlock = "unlock",
			comps = self.controller_:GetController("lock")
		}
	}
	self.data = {
		isLock = false,
		position = 1
	}
	self.constVar = {
		chipObjPrefix = "chip%dObj_",
		firstRefreshDirty = true,
		chipImgPrefix = "chip%dImg_",
		position = 1,
		icon1Anim = self.chip1Obj_:GetComponent(typeof(Animator)),
		icon2Anim = self.chip2Obj_:GetComponent(typeof(Animator)),
		effect1Anim = self.effect1Obj_:GetComponent(typeof(Animator)),
		effect2Anim = self.effect2Obj_:GetComponent(typeof(Animator)),
		slotEmpty = {
			true,
			true
		}
	}
	self.constVar.icon1Anim.enabled = false
	self.constVar.icon2Anim.enabled = false
end

function TransitionSkillSlotItem:InitAnim()
	SetActive(self.effect1Obj_, false)
	SetActive(self.effect2Obj_, false)

	self.constVar.firstRefreshDirty = true
end

function TransitionSkillSlotItem:AddUIListeners()
	self:AddBtnListener(self.JumpsBtn_, nil, function()
		self:OnJumpsClick()
	end)
end

function TransitionSkillSlotItem:Dispose()
	self:RemoveAllListeners()
	TransitionSkillSlotItem.super.Dispose(self)
end

function TransitionSkillSlotItem:RenderView(arg_9_1)
	self.data.param = arg_9_1

	local var_9_0 = 0

	self.constVar.firstRefreshDirty = false

	for iter_9_0 = 1, 2 do
		if arg_9_1.skills[iter_9_0] then
			local var_9_3

			if not arg_9_1.skills[iter_9_0].level then
				var_9_0 = var_9_0 + 1
				var_9_3 = self[string.format(self.constVar.chipImgPrefix, iter_9_0)]
			end

			var_9_3.sprite = getEquipSkillSprite(arg_9_1.skills[iter_9_0].skillId)

			if not self.constVar.firstRefreshDirty and self.isInSlotView then
				self.constVar[string.format("icon%dAnim", iter_9_0)].enabled = true

				SetActive(self[string.format("effect%dObj_", iter_9_0)], true)
			end

			SetActive(self[string.format(self.constVar.chipObjPrefix, iter_9_0)], true)

			if not self.constVar.slotEmpty[iter_9_0] then
				self.constVar.slotEmpty[iter_9_0] = true

				self.constVar[string.format("icon%dAnim", iter_9_0)]:Play("Fx_icon_cx")
				self.constVar[string.format("effect%dAnim", iter_9_0)]:Play("Fx_icon_chuandai")
			end
		else
			self.constVar.slotEmpty[iter_9_0] = false

			SetActive(self[string.format(self.constVar.chipObjPrefix, iter_9_0)], false)
		end
	end

	self:RenderLevel(var_9_0)
end

function TransitionSkillSlotItem:ClearSlot()
	for iter_10_0 = 1, 2 do
		self.constVar.slotEmpty[iter_10_0] = false

		SetActive(self[string.format(self.constVar.chipObjPrefix, iter_10_0)], false)
	end

	self:RenderLevel(0)
end

function TransitionSkillSlotItem:RenderPosition(arg_11_1)
	self.constVar.position = arg_11_1

	local var_11_0 = self.controller.position[string.format("Pos%d", arg_11_1)]

	if var_11_0 then
		self.controller.position.comps:SetSelectedState(var_11_0)
	end
end

function TransitionSkillSlotItem:RenderLevel(arg_12_1)
	local var_12_0 = self.controller.Activate[string.format("Stage%d", arg_12_1)]

	if var_12_0 then
		self.controller.Activate.comps:SetSelectedState(var_12_0)
	end
end

function TransitionSkillSlotItem:RenderLock(arg_13_1)
	self.data.isLock = arg_13_1

	if arg_13_1 then
		self.controller.lock.comps:SetSelectedState(self.controller.lock.Lock)
	else
		self.controller.lock.comps:SetSelectedState(self.controller.lock.Unlock)
	end
end

function TransitionSkillSlotItem:RenderSelect(arg_14_1)
	self.controller.sel.comps:SetSelectedState((not arg_14_1 or nil) and self.controller.sel.DeSelect)
end

function TransitionSkillSlotItem:RegisterClickListener(arg_15_1)
	self.constVar.clickCallback = arg_15_1
end

function TransitionSkillSlotItem:OnJumpsClick()
	if self.constVar.clickCallback then
		self.constVar.clickCallback(self.constVar.position)
	end
end

return TransitionSkillSlotItem
