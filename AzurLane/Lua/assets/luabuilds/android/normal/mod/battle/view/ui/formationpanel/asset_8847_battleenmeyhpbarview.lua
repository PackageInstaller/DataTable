ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleEnmeyHpBarView")

var_0.Battle.BattleEnmeyHpBarView = var_0_1
var_0_1.__name = "BattleEnmeyHpBarView"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._monsterTF = arg_1_1
	arg_1_0.orgPos = arg_1_1.anchoredPosition

	local var_1_0 = arg_1_0.orgPos

	Vector2 = var_1_10003
	arg_1_0.HidePos = var_1_0 + var_1_10003(0, 100)
	arg_1_0._hpBarTF = arg_1_1:Find("hpbar")
	arg_1_0._hpBar = arg_1_0._hpBarTF.gameObject

	local var_1_1 = arg_1_0._hpBarTF
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0._hpBarProgress = var_1_2(var_1_1, var_4(var_5))

	local var_1_3 = arg_1_0._hpBarTF
	local var_1_4 = var_2.Find(var_1_3, "Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0._hpBarText = var_1_5(var_1_4, var_4(var_5))
	arg_1_0._nameTF = arg_1_1:Find("nameContain/name")

	local var_1_6 = arg_1_1:Find("nameContain/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0._lvText = var_1_7(var_1_6, var_4(var_5))
	arg_1_0._level = arg_1_1:Find("level")

	local var_1_8 = arg_1_1:Find("typeIcon/icon")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0._typeIcon = var_1_9(var_1_8, var_4(var_5))
	arg_1_0._eliteLabel = arg_1_1:Find("grade/elite")
	arg_1_0._generalLabel = arg_1_1:Find("grade/general")
	arg_1_0._flag = true
	arg_1_0._isExistBoos = false

	arg_1_0:Show(false)

	return
end

function var_0_1.GetCurrentTarget(arg_2_0)
	return arg_2_0._targetUnit
end

function var_0_1.Show(arg_3_0, arg_3_1)
	if arg_3_0._curActive ~= arg_3_1 then
		arg_3_0._curActive = arg_3_1

		if arg_3_1 then
			arg_3_0._monsterTF.anchoredPosition = arg_3_0.orgPos
		else
			arg_3_0._monsterTF.anchoredPosition = arg_3_0.HidePos
		end
	end

	return
end

function var_0_1.SetIconType(arg_4_0, arg_4_1)
	if arg_4_0._eliteType == arg_4_1 then
		return
	end

	arg_4_0._eliteType = arg_4_1
	setActive = var_2

	var_2(arg_4_0._generalLabel, not arg_4_1)

	setActive = var_2

	var_2(arg_4_0._eliteLabel, arg_4_1)

	return
end

function var_0_1.SwitchTarget(arg_5_0, arg_5_1, arg_5_2)
	pairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_2) do
		if iter_5_1:IsBoss() then
			arg_5_0._isExistBoos = true

			break
		end
	end

	if arg_5_0._flag == false or arg_5_0._isExistBoos == true then
		arg_5_0:Show(false)

		return
	end

	arg_5_0._targetUnit = arg_5_1

	arg_5_0:Show(true)

	local var_5_0 = arg_5_1:GetHPRate()

	arg_5_0._hpBarProgress.fillAmount = var_5_0

	arg_5_0:UpdateHpText(arg_5_1)

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.SetIconType
	local var_5_3 = arg_5_1

	var_5_2(var_5_1, arg_5_1.GetTemplate(var_5_3).icon_type ~= 0)

	local var_5_4 = var_0.Battle.BattleDataFunction.GetEnemyTypeDataByType(arg_5_1:GetTemplate().type).type

	GetSpriteFromAtlas = var_5

	local var_5_5 = "shiptype"

	shipType2Battleprint = var_5_3

	local var_5_6 = var_5(var_5_5, var_5_3(var_5_4))

	arg_5_0._typeIcon.sprite = var_5_6

	local var_5_7 = arg_5_0._typeIcon

	var_6.SetNativeSize(var_5_7)

	changeToScrollText = var_6

	var_6(arg_5_0._nameTF, arg_5_1._tmpData.name)

	arg_5_0._lvText.text = " Lv." .. arg_5_1:GetLevel()

	return
end

function var_0_1.UpdateHpText(arg_6_0)
	local var_6_0 = arg_6_0._targetUnit
	local var_6_1, var_6_2 = var_1.GetHP(var_6_0)
	local var_6_3 = arg_6_0._hpBarText

	tostring = var_1_10004
	math = var_1_10005

	local var_6_4 = var_1_10005.floor(var_6_1)
	local var_6_5 = "/"

	math = var_1_10007
	var_6_3.text = var_1_10004(var_6_4 .. var_6_5 .. var_1_10007.floor(var_6_2))

	return
end

function var_0_1.UpdateHpBar(arg_7_0)
	if arg_7_0._flag == false or arg_7_0._isExistBoos == true then
		return
	end

	LeanTween = var_1

	var_1.cancel(arg_7_0._hpBar)

	local var_7_0 = arg_7_0._targetUnit
	local var_7_1 = var_1.GetHPRate(var_7_0)
	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.UpdateHpText

	target = var_1_10004

	var_7_3(var_7_2, var_1_10004)

	if var_7_1 < arg_7_0._hpBarProgress.fillAmount then
		LeanTween = var_7_2

		local var_7_4 = var_7_2.value(arg_7_0._hpBar, var_2, var_7_1, 0.5)
		local var_7_5 = var_3.setOnUpdate

		System = var_5

		var_7_5(var_7_4, var_5.Action_float(function(arg_8_0)
			arg_7_0._hpBarProgress.fillAmount = arg_8_0

			return
		end))
	else
		arg_7_0._hpBarProgress.fillAmount = var_7_1
	end

	if var_7_1 == 0 then
		arg_7_0:RemoveUnit()
	end

	return
end

function var_0_1.RemoveUnit(arg_9_0, arg_9_1)
	arg_9_0._targetUnit = nil
	arg_9_0._flag = false

	local function var_9_0()
		arg_9_0._flag = true

		local var_10_0 = arg_9_0

		var_0.Show(var_10_0, false)

		return
	end

	if arg_9_1 then
		pg = var_1_10003

		local var_9_1 = var_1_10003.TimeMgr.GetInstance()

		arg_9_0._deathTimer = var_3.AddBattleTimer(var_9_1, "death", 0, 1, function()
			var_9_0()

			pg = var_0

			local var_11_0 = var_0.TimeMgr.GetInstance()

			var_0.RemoveBattleTimer(var_11_0, arg_9_0._deathTimer)

			return
		end)
	else
		var_9_0()
	end

	return
end

function var_0_1.Dispose(arg_12_0)
	arg_12_0:Show(false)

	pg = var_1

	local var_12_0 = var_1.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_12_0, arg_12_0._deathTimer)

	LeanTween = var_1

	var_1.cancel(arg_12_0._hpBar)

	arg_12_0._hpBarProgress = nil
	arg_12_0._hpBar = nil
	arg_12_0._hpBarTF = nil
	arg_12_0._monsterTF = nil
	arg_12_0._monster = nil

	return
end

return
