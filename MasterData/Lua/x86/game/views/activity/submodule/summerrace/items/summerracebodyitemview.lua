local SummerRaceBodyItemView = class("SummerRaceBodyItemView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:GetOrAddComponent(arg_1_1, typeof(EventTriggerListener))

	var_1_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		arg_1_2()
	end))
	arg_1_0:SetListener(var_1_0)
end

function SummerRaceBodyItemView:OnCtor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform

	self:Init()
end

function SummerRaceBodyItemView:Init()
	self:BindCfgUI()

	self.lockController_ = self.controllerEx_:GetController("lock")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.gouController_ = self.controllerEx_:GetController("gou")

	self:AddUIListener()
end

function SummerRaceBodyItemView:AddUIListener()
	var_0_1(self, self.clickGo_, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_, self.bodyData_, "select")
		end
	end)
end

function SummerRaceBodyItemView:BindRedPoint()
	if self.bodyData_ ~= nil and self.bodyData_.redPointKey ~= nil then
		manager.redPoint:bindUIandKey(self.clickGo_.transform, self.bodyData_.redPointKey)
	end
end

function SummerRaceBodyItemView:UnbindRedPoint()
	if self.bodyData_ ~= nil and self.bodyData_.redPointKey ~= nil then
		manager.redPoint:unbindUIandKey(self.clickGo_.transform, self.bodyData_.redPointKey)
	end
end

function SummerRaceBodyItemView:SetData(arg_9_1, arg_9_2, arg_9_3)
	self:UnbindRedPoint()

	self.bodyData_ = arg_9_1
	self.index_ = arg_9_2
	self.clickHandler_ = arg_9_3

	self:BindRedPoint()
	self:RefreshView()
end

function SummerRaceBodyItemView:RefreshView()
	local var_10_1 = tostring(self.bodyData_.iconPath or "")

	self.bodyIcon_.spriteSync = var_10_1 ~= "" and var_10_1 or nil
	self.bodyNameText_.text = tostring(self.bodyData_.bodyName or "")

	self.lockController_:SetSelectedState(self.bodyData_.isUnlocked and "false" or "true")
	self.selectController_:SetSelectedState(self.bodyData_.isSelected and "show" or "hide")
	self.gouController_:SetSelectedState(self.bodyData_.isSelected and "show" or "hide")
end

function SummerRaceBodyItemView:Dispose()
	self:UnbindRedPoint()

	self.bodyData_ = nil
	self.clickHandler_ = nil

	self:RemoveAllListeners()
	SummerRaceBodyItemView.super.Dispose(self)
end

return SummerRaceBodyItemView
