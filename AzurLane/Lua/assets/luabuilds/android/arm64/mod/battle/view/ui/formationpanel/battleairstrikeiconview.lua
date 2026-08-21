ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = class("BattleAirStrikeIconView")

ys.Battle.BattleAirStrikeIconView = var_0_1
var_0_1.__name = "BattleAirStrikeIconView"
var_0_1.DEFAULT_ICON_NAME = "99shijianbao"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._iconList = {}

	arg_1_0:ConfigIconSkin(arg_1_1)

	return
end

function var_0_1.ConfigIconSkin(arg_2_0, arg_2_1)
	arg_2_0._iconTpl = arg_2_1
	arg_2_0._iconContainer = arg_2_1.parent

	return
end

function var_0_1.AppendIcon(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = cloneTplTo(arg_3_0._iconTpl, arg_3_0._iconContainer).gameObject
	local var_3_1 = var_3_0.transform:Find("FighterIcon")

	var_3_0:SetActive(true)
	arg_3_0:setIconNumber(var_3_1, arg_3_2.totalNumber)

	local var_3_2 = var_0_0.GetAircraftTmpDataFromID(arg_3_2.templateID).icon or var_0_1.DEFAULT_ICON_NAME
	local var_3_3 = var_0.Battle.BattleResourceManager.GetInstance()

	setImageSprite(var_3_1, (var_3_3:GetAircraftIcon(var_3_2)))

	arg_3_0._iconList[arg_3_1] = var_3_0

	if var_3_0:GetComponent(typeof(Animation)) then
		quickPlayAnimation(var_3_0, "anim_skinui_AFC_in")
	end

	return
end

function var_0_1.RemoveIcon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._iconList[arg_4_1]

	if not arg_4_0._iconList[arg_4_1] then
		return
	end

	if arg_4_2.totalNumber <= 0 then
		local function var_4_1()
			Object.Destroy(var_4_0)

			arg_4_0._iconList[arg_4_1] = nil

			return
		end

		if arg_4_0._iconList[arg_4_1]:GetComponent(typeof(Animation)) then
			arg_4_0._iconList[arg_4_1]:GetComponent("DftAniEvent"):SetEndEvent(function(arg_6_0)
				var_4_1()

				return
			end)
			quickPlayAnimation(arg_4_0._iconList[arg_4_1], "anim_skinui_AFC_out")
		else
			(function()
				Object.Destroy(var_4_0)

				arg_4_0._iconList[arg_4_1] = nil

				return
			end)()
		end
	else
		arg_4_0:setIconNumber(arg_4_0._iconList[arg_4_1].transform:Find("FighterIcon"), arg_4_2.totalNumber)
	end

	return
end

function var_0_1.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._iconList) do
		Object.Destroy(iter_7_1)
	end

	arg_7_0._iconList = nil

	return
end

function var_0_1.setIconNumber(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.transform:Find("FighterNum"):GetComponent(typeof(Text)).text = "X" .. arg_8_2

	return
end

return
