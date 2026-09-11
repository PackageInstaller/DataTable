local OathConditionItem = class("OathConditionItem", ReduxView)

function OathConditionItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.stateController = self.controllers_:GetController("lock")
	self.showIconController = self.controllers_:GetController("showIcon")
	self.showJumpController = self.controllers_:GetController("btn")

	self:AddBtnListener(self.jumpBtn_, nil, function()
		if self.jumpLink then
			local var_2_0, var_2_1 = JumpTools.GetSystemLockedText(self.jumpLink)

			if var_2_0 then
				ShowTips(var_2_1)

				return
			end

			DestroyLua()
			LuaExchangeHelper.GoToMain(CustomLoadingConst.Oath_Loading)
			manager.windowBar:ClearWhereTag()
			OpenPageUntilLoaded("/oathMainView", {
				selectHeroID = self.heroID,
				enterCallback = function()
					JumpTools.JumpToPage(self.jumpLink)
				end
			})
		end
	end)
end

function OathConditionItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.conditionID = arg_4_1
	self.jumpLink = arg_4_2
	self.heroID = arg_4_3

	self:RefreshUI()
end

function OathConditionItem:RefreshUI()
	self.desc_.text = GetI18NText(ConditionCfg[self.conditionID].desc)

	if ConditionCfg[self.conditionID].type == 330001 then
		self:SetShowIcon(true)

		self.icon_.spriteSync = ItemTools.getItemSprite(ConditionCfg[self.conditionID].params[1], nil, true)
	else
		self:SetShowIcon(false)
	end

	self.stateController:SetSelectedState(IsConditionAchieved(self.conditionID) and "unlock" or "lock")
	self.showJumpController:SetSelectedState(IsConditionAchieved(self.conditionID) and "off" or "on")
end

function OathConditionItem:SetShowIcon(arg_6_1)
	self.showIconController:SetSelectedState(arg_6_1 and "true" or "false")
end

function OathConditionItem:Dispose()
	self:RemoveAllListeners()
	OathConditionItem.super.Dispose(self)
end

return OathConditionItem
