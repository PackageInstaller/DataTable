local EquipBreakThroughtMaterialModeItem = class("EquipBreakThroughtMaterialModeItem", ReduxView)

function EquipBreakThroughtMaterialModeItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "chooseItem")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.chooseHandler_ = handler(self, self.ChooseMode)

	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)
end

function EquipBreakThroughtMaterialModeItem:Dispose()
	EquipBreakThroughtMaterialModeItem.super.Dispose(self)
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)

	self.chooseHandler_ = nil
end

function EquipBreakThroughtMaterialModeItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if table.keyof(EquipBreakThroughMaterialData:GetOpenModeList(), self.index_) == nil then
			ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_MODE_UNLOCK"), GetI18NText(EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialDifficultyCfg[self.index_].unlock_condition[2]].name)))

			return
		end

		manager.notify:Invoke(CHALLENGE_CHOOSE_MODE, self.index_)
	end)
end

function EquipBreakThroughtMaterialModeItem:ChooseMode(arg_5_1)
	if self.index_ == arg_5_1 then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function EquipBreakThroughtMaterialModeItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1

	SetSpriteWithoutAtlasAsync(self.bgImage_, SpritePathCfg.ChapterPaint.path .. EquipBreakThroughMaterialDifficultyCfg[arg_6_1].bg)

	if table.keyof(EquipBreakThroughMaterialData:GetOpenModeList(), arg_6_1) then
		self.lockController_:SetSelectedState("off")
	else
		self.lockController_:SetSelectedState("on")
	end

	self.difficultyImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", arg_6_1))

	self:ChooseMode(arg_6_2)
end

return EquipBreakThroughtMaterialModeItem
