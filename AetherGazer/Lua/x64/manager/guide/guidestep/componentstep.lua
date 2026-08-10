local var_0_0 = class("ComponentStep", BaseStep)

function var_0_0.Init(arg_1_0, arg_1_1)
	local var_1_0 = GuideStepCfg[arg_1_0._stepId]

	arg_1_0._guideComponentCfg = var_1_0.guide_component
	arg_1_0._maskComponentCfg = var_1_0.mask_component
	arg_1_0._params = var_1_0.params

	if var_1_0.mask_scale == "" then
		arg_1_0._maskScale = Vector3.New(1, 1, 1)
	else
		arg_1_0._maskScale = Vector3.New(var_1_0.mask_scale[1] or 1, var_1_0.mask_scale[2] or 1, 1)
	end

	arg_1_0.isHideMask = var_1_0.has_mask == 1
end

function var_0_0.OnStepEnd(arg_2_0)
	var_0_0.super.OnStepEnd(arg_2_0)

	arg_2_0._component = nil
end

function var_0_0.Check(arg_3_0)
	return arg_3_0:Component() ~= nil
end

function var_0_0.GetShowMask(arg_4_0)
	return true
end

function var_0_0.Play(arg_5_0)
	manager.guide.view:Init()

	local var_5_0 = arg_5_0:Component()

	arg_5_0:ShowTalk()

	local var_5_1 = arg_5_0:AnalyzeComponentCfg(arg_5_0._maskComponentCfg)
	local var_5_2 = var_5_1 and var_5_1.gameObject or var_5_0.gameObject

	manager.guide.view:ShowHoldMask(var_5_2, arg_5_0._maskScale, arg_5_0._params, arg_5_0.isHideMask)
end

function var_0_0.Component(arg_6_0)
	if arg_6_0._component == nil then
		arg_6_0:SetSpecialParams()

		arg_6_0._component = arg_6_0:AnalyzeComponentCfg(arg_6_0._guideComponentCfg)
	end

	return arg_6_0._component
end

function var_0_0.AnalyzeComponentCfg(arg_7_0, arg_7_1)
	if arg_7_1 == "" or #arg_7_1 == 0 then
		return nil
	end

	local var_7_0 = arg_7_1[1]
	local var_7_1 = string.split(var_7_0, "_")
	local var_7_2 = var_7_1[1]
	local var_7_3 = var_7_1[2] and var_7_1[2] == "getcom"

	if var_7_2 == "common" then
		local var_7_4 = arg_7_1[2]
		local var_7_5 = arg_7_1[3]
		local var_7_6 = arg_7_1[4]
		local var_7_7 = arg_7_0:GetViewComponent(var_7_4, var_7_5)

		if var_7_7 and var_7_3 then
			return var_7_7:GetComponent(var_7_6)
		end

		return var_7_7
	elseif var_7_2 == "child" then
		local var_7_8 = arg_7_1[2]
		local var_7_9 = arg_7_1[3]
		local var_7_10 = arg_7_1[4]
		local var_7_11 = arg_7_1[5]
		local var_7_12 = arg_7_0:GetViewComponent(var_7_8, var_7_9)

		if var_7_12 then
			local var_7_13 = var_7_12.transform:Find(var_7_10)

			if var_7_13 and var_7_3 then
				return var_7_13:GetComponent(var_7_11)
			end

			return var_7_13
		end
	elseif var_7_2 == "listIndex" then
		local var_7_14 = arg_7_1[2]
		local var_7_15 = arg_7_1[3]
		local var_7_16 = arg_7_1[4]
		local var_7_17 = arg_7_1[5]
		local var_7_18 = arg_7_1[6]
		local var_7_19 = arg_7_0:GetViewComponent(var_7_14, var_7_15)

		if var_7_19 then
			local var_7_20 = var_7_19:GetItemList()

			if var_7_20 and var_7_20[var_7_16] then
				local var_7_21 = arg_7_0:GetComponentPath(var_7_20[var_7_16], var_7_17)

				if var_7_21 and var_7_3 then
					return var_7_21:GetComponent(var_7_18)
				end

				return var_7_21
			end
		end
	elseif var_7_2 == "windowBar" then
		if manager.windowBar:GetIsShow() then
			local var_7_22 = arg_7_1[2]

			return manager.windowBar[var_7_22]
		end

		return nil
	elseif var_7_2 == "windowBarCurrency" then
		if manager.windowBar:GetIsShow() then
			local var_7_23 = arg_7_1[2]
			local var_7_24 = manager.windowBar.barGo_[var_7_23]
			local var_7_25 = arg_7_1[3]
			local var_7_26 = arg_7_1[4]

			if var_7_24 then
				local var_7_27 = arg_7_0:GetComponentPath(var_7_24, var_7_25)

				if var_7_27 and var_7_3 then
					return var_7_27:GetComponent(var_7_26)
				end

				return var_7_27
			end
		end

		return nil
	elseif var_7_2 == "messageBox" then
		local var_7_28 = manager.messageBox:GetItemList()

		if var_7_28 then
			for iter_7_0, iter_7_1 in pairs(var_7_28) do
				for iter_7_2, iter_7_3 in pairs(iter_7_1 or {}) do
					if not iter_7_3:IsFree() then
						return iter_7_3[arg_7_1[2]]
					end
				end
			end
		end

		return nil
	elseif var_7_2 == "treeGroup" then
		local var_7_29 = arg_7_1[2]
		local var_7_30 = arg_7_1[3]
		local var_7_31 = arg_7_1[4]
		local var_7_32 = arg_7_0:GetViewComponent(var_7_29, var_7_30)

		if var_7_32 then
			local var_7_33 = var_7_32:GetGroupGameObjectById(var_7_31)

			if var_7_33 then
				local var_7_34 = var_7_33:GetComponent("UITreeGroup")

				if var_7_34 then
					return var_7_34.toggle
				end
			end
		end
	elseif var_7_2 == "treeGroupChild" then
		local var_7_35 = arg_7_1[2]
		local var_7_36 = arg_7_1[3]
		local var_7_37 = arg_7_1[4]
		local var_7_38 = arg_7_1[5]
		local var_7_39 = arg_7_0:GetViewComponent(var_7_35, var_7_36)

		if var_7_39 then
			local var_7_40 = var_7_39:GetGroupGameObjectById(var_7_37)

			if var_7_40 then
				return var_7_40.transform:Find(var_7_38)
			end
		end
	elseif var_7_2 == "treeItem" then
		local var_7_41 = arg_7_1[2]
		local var_7_42 = arg_7_1[3]
		local var_7_43 = arg_7_1[4]
		local var_7_44 = arg_7_1[5]
		local var_7_45 = arg_7_0:GetViewComponent(var_7_41, var_7_42)

		if var_7_45 then
			local var_7_46 = var_7_45:GetItemGameObjectById(var_7_43, var_7_44)

			if var_7_46 then
				local var_7_47 = var_7_46:GetComponent("UITreeItem")

				if var_7_47 then
					return var_7_47.toggle
				end
			end
		end
	elseif var_7_2 == "rogueTeamBottomBar" then
		local var_7_48 = arg_7_1[2]

		return manager.rogueTeamInGameInfoBox[var_7_48]
	elseif var_7_2 == "rogueTeamMechanismBar" then
		local var_7_49 = arg_7_1[2]

		return manager.rogueTeamMechanismBar[var_7_49]
	else
		error("guide unknown way to get component" .. var_7_2)
	end
end

function var_0_0.SetSpecialParams(arg_8_0)
	if arg_8_0._params[1] == "chapterMapContent" then
		BattleFieldAction.ChangeSelectChapterID(arg_8_0._params[2])
	elseif arg_8_0._params[1] == "chapterMap" then
		BattleFieldData:SetCacheChapterClient(arg_8_0._params[2], arg_8_0._params[3])
		manager.notify:Invoke(CHANGE_DUNGEON)
	elseif arg_8_0._params[1] == "draw" then
		arg_8_0._guideComponentCfg[4] = GuideTool.GetPoolIndex(arg_8_0._params[2])
		arg_8_0._maskComponentCfg[4] = GuideTool.GetPoolIndex(arg_8_0._params[2])
	elseif arg_8_0._params[1] == "chess" then
		local var_8_0 = manager.ChessBoardManager

		if var_8_0 and #var_8_0:GetHeroProp() > 1 then
			arg_8_0._guideComponentCfg[3][3] = arg_8_0._params[3]
		end
	end
end

function var_0_0.GetViewComponent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gameContext:GetOpenPageHandler(arg_9_1)

	if var_9_0 then
		return arg_9_0:GetComponentPath(var_9_0, arg_9_2)
	end

	return nil
end

function var_0_0.GetComponentPath(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = #arg_10_2
	local var_10_1 = 1
	local var_10_2

	while var_10_1 <= var_10_0 do
		local var_10_3 = arg_10_2[var_10_1]
		local var_10_4

		if var_10_1 == 1 then
			var_10_4 = arg_10_1[var_10_3]
		else
			var_10_4 = var_10_2[var_10_3]
		end

		if var_10_4 then
			var_10_2 = var_10_4
			var_10_1 = var_10_1 + 1
		else
			return nil
		end
	end

	return var_10_2
end

return var_0_0
