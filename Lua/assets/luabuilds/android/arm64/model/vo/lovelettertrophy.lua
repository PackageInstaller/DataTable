local var_0_0 = class("LoveLetterTrophy", import(".Trophy"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.level = arg_1_0.id % 100
	arg_1_0.groupId = math.floor(arg_1_0.id % 0 / 100)
	arg_1_0.ll = getProxy(LoveLetterProxy):GetGroupData(arg_1_0.groupId)
	arg_1_0.oll = setmetatable({
		level = arg_1_0.level
	}, {
		__index = arg_1_0.ll
	})
	arg_1_0.isMax = arg_1_0.level + 10 > arg_1_0.ll:GetMaxLevel()
	arg_1_0.groupName = arg_1_0.ll:GetName()
	arg_1_0.paint = arg_1_0.ll:GetPainting()
	arg_1_0.subTrophyList = {}

	arg_1_0:update(arg_1_1)

	return
end

function var_0_0.getConfigTable(arg_2_0)
	if not arg_2_0.configTable then
		local var_2_0 = {}

		if not arg_2_0.isMax then
			var_2_0.next = arg_2_0.id + 10 or nil
			arg_2_0.configTable = var_2_0

			return arg_2_0.configTable
		end
	end
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.timestamp = 1

	return
end

function var_0_0.isComplexTrophy(arg_4_0)
	return false
end

function var_0_0.getTargetID(arg_5_0)
	return arg_5_0:getConfig("target_id")
end

function var_0_0.getHideType(arg_6_0)
	return arg_6_0:getConfig("hide")
end

function var_0_0.isHide(arg_7_0)
	return false
end

function var_0_0.isMaxLevel(arg_8_0)
	return arg_8_0.isMax
end

function var_0_0.getName(arg_9_0)
	return i18n("loveactivity_ui_14", arg_9_0.groupName)
end

function var_0_0.GetPrefabName(arg_10_0)
	return arg_10_0.oll:GetPrefabName()
end

function var_0_0.GetPainting(arg_11_0)
	return arg_11_0.paint
end

function var_0_0.GetDisplayLevelMark(arg_12_0)
	return arg_12_0.oll:GetDisplayLevelMark()
end

return var_0_0
