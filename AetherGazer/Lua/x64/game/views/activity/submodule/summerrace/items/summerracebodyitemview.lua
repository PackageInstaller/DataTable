local var_0_0 = class("SummerRaceBodyItemView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:GetOrAddComponent(arg_1_1, typeof(EventTriggerListener))

	var_1_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		arg_1_2()
	end))
	arg_1_0:SetListener(var_1_0)
end

function var_0_0.OnCtor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform

	arg_3_0:Init()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.lockController_ = arg_4_0.controllerEx_:GetController("lock")
	arg_4_0.selectController_ = arg_4_0.controllerEx_:GetController("select")
	arg_4_0.gouController_ = arg_4_0.controllerEx_:GetController("gou")

	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	var_0_1(arg_5_0, arg_5_0.clickGo_, function()
		if arg_5_0.clickHandler_ then
			arg_5_0.clickHandler_(arg_5_0.index_, arg_5_0.bodyData_, "select")
		end
	end)
end

function var_0_0.BindRedPoint(arg_7_0)
	if arg_7_0.bodyData_ ~= nil and arg_7_0.bodyData_.redPointKey ~= nil then
		manager.redPoint:bindUIandKey(arg_7_0.clickGo_.transform, arg_7_0.bodyData_.redPointKey)
	end
end

function var_0_0.UnbindRedPoint(arg_8_0)
	if arg_8_0.bodyData_ ~= nil and arg_8_0.bodyData_.redPointKey ~= nil then
		manager.redPoint:unbindUIandKey(arg_8_0.clickGo_.transform, arg_8_0.bodyData_.redPointKey)
	end
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:UnbindRedPoint()

	arg_9_0.bodyData_ = arg_9_1
	arg_9_0.index_ = arg_9_2
	arg_9_0.clickHandler_ = arg_9_3

	arg_9_0:BindRedPoint()
	arg_9_0:RefreshView()
end

function var_0_0.RefreshView(arg_10_0)
	local var_10_0 = tostring(arg_10_0.bodyData_.iconPath or "")

	arg_10_0.bodyIcon_.spriteSync = var_10_0 ~= "" and var_10_0 or nil
	arg_10_0.bodyNameText_.text = tostring(arg_10_0.bodyData_.bodyName or "")

	arg_10_0.lockController_:SetSelectedState(arg_10_0.bodyData_.isUnlocked and "false" or "true")
	arg_10_0.selectController_:SetSelectedState(arg_10_0.bodyData_.isSelected and "show" or "hide")
	arg_10_0.gouController_:SetSelectedState(arg_10_0.bodyData_.isSelected and "show" or "hide")
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:UnbindRedPoint()

	arg_11_0.bodyData_ = nil
	arg_11_0.clickHandler_ = nil

	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
