ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction

class = var_0_10002

local var_0_2 = var_0_10002("BattleAirStrikeIconView")

var_0.Battle.BattleAirStrikeIconView = var_0_2
var_0_2.__name = "BattleAirStrikeIconView"
var_0_2.DEFAULT_ICON_NAME = "99shijianbao"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._iconList = {}

	arg_1_0:ConfigIconSkin(arg_1_1)

	return
end

function var_0_2.ConfigIconSkin(arg_2_0, arg_2_1)
	arg_2_0._iconTpl = arg_2_1
	arg_2_0._iconContainer = arg_2_1.parent

	return
end

function var_0_2.AppendIcon(arg_3_0, arg_3_1, arg_3_2)
	cloneTplTo = var_1_10003

	local var_3_0 = var_1_10003(arg_3_0._iconTpl, arg_3_0._iconContainer).gameObject.transform
	local var_3_1 = var_4.Find(var_3_0, "FighterIcon")

	var_3:SetActive(true)
	arg_3_0:setIconNumber(var_3_1, arg_3_2.totalNumber)

	local var_3_2

	if not var_0_1.GetAircraftTmpDataFromID(arg_3_2.templateID).icon then
		var_3_2 = var_0_2.DEFAULT_ICON_NAME
	end

	local var_3_3 = var_0.Battle.BattleResourceManager.GetInstance()
	local var_3_4 = var_6.GetAircraftIcon(var_3_3, var_3_2)

	setImageSprite = var_8

	var_8(var_3_1, var_3_4)

	arg_3_0._iconList[arg_3_1] = var_3

	local var_3_5 = var_3
	local var_3_6 = var_3.GetComponent

	typeof = var_11
	Animation = var_1_10013

	if var_3_6(var_3_5, var_11(var_1_10013)) then
		quickPlayAnimation = var_3_3

		var_3_3(var_3, "anim_skinui_AFC_in")
	end

	return
end

function var_0_2.RemoveIcon(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._iconList[arg_4_1] then
		return
	end

	if arg_4_2.totalNumber <= 0 then
		local function var_4_0()
			Object = var_2_10000

			var_2_10000.Destroy(var_0)

			arg_4_0._iconList[arg_4_1] = nil

			return
		end

		local var_4_1 = var_3
		local var_4_2 = var_3.GetComponent

		typeof = var_1_10008
		Animation = var_1_10010

		if var_4_2(var_4_1, var_1_10008(var_1_10010)) then
			local var_4_3 = var_3:GetComponent("DftAniEvent")

			var_6.SetEndEvent(var_4_3, function(arg_6_0)
				var_4_0()

				return
			end)

			quickPlayAnimation = var_7

			var_7(var_3, "anim_skinui_AFC_out")
		else
			var_4_0()
		end
	else
		local var_4_4 = arg_4_0
		local var_4_5 = arg_4_0.setIconNumber
		local var_4_6 = var_3.transform

		var_4_5(var_4_4, var_7.Find(var_4_6, "FighterIcon"), arg_4_2.totalNumber)
	end

	return
end

function var_0_2.Dispose(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._iconList) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_7_1)
	end

	arg_7_0._iconList = nil

	return
end

function var_0_2.setIconNumber(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.transform
	local var_8_1 = var_3.Find(var_8_0, "FighterNum")
	local var_8_2 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_8_2(var_8_1, var_6(var_1_10008)).text = "X" .. arg_8_2

	return
end

return
