ys = ys or {}

local var_0_0 = class("BattleEnmeyHpBarView")

ys.Battle.BattleEnmeyHpBarView = var_0_0
var_0_0.__name = "BattleEnmeyHpBarView"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._monsterTF = arg_1_1
	arg_1_0.orgPos = arg_1_1.anchoredPosition
	arg_1_0.HidePos = arg_1_0.orgPos + Vector2(0, 100)
	arg_1_0._hpBarTF = arg_1_1:Find("hpbar")
	arg_1_0._hpBar = arg_1_0._hpBarTF.gameObject
	arg_1_0._hpBarProgress = arg_1_0._hpBarTF:GetComponent(typeof(Image))
	arg_1_0._hpBarText = arg_1_0._hpBarTF:Find("Text"):GetComponent(typeof(Text))
	arg_1_0._nameTF = arg_1_1:Find("nameContain/name")
	arg_1_0._lvText = arg_1_1:Find("nameContain/Text"):GetComponent(typeof(Text))
	arg_1_0._level = arg_1_1:Find("level")
	arg_1_0._typeIcon = arg_1_1:Find("typeIcon/icon"):GetComponent(typeof(Image))
	arg_1_0._eliteLabel = arg_1_1:Find("grade/elite")
	arg_1_0._generalLabel = arg_1_1:Find("grade/general")
	arg_1_0._flag = true
	arg_1_0._isExistBoos = false

	arg_1_0:Show(false)

	return
end

function var_0_0.GetCurrentTarget(arg_2_0)
	return arg_2_0._targetUnit
end

function var_0_0.Show(arg_3_0, arg_3_1)
	if arg_3_0._curActive ~= arg_3_1 then
		arg_3_0._curActive = arg_3_1
		arg_3_0._monsterTF.anchoredPosition = arg_3_1 and arg_3_0.orgPos or arg_3_0.HidePos
	end

	return
end

function var_0_0.SetIconType(arg_4_0, arg_4_1)
	if arg_4_0._eliteType == arg_4_1 then
		return
	end

	arg_4_0._eliteType = arg_4_1

	setActive(arg_4_0._generalLabel, not arg_4_1)
	setActive(arg_4_0._eliteLabel, arg_4_1)

	return
end

function var_0_0.SwitchTarget(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_2) do
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

	arg_5_0._hpBarProgress.fillAmount = arg_5_1:GetHPRate()

	arg_5_0:UpdateHpText(arg_5_1)
	arg_5_0:SetIconType(arg_5_1:GetTemplate().icon_type ~= 0)

	arg_5_0._typeIcon.sprite = GetSpriteFromAtlas("shiptype", shipType2Battleprint(var_0.Battle.BattleDataFunction.GetEnemyTypeDataByType(arg_5_1:GetTemplate().type).type))

	arg_5_0._typeIcon:SetNativeSize()
	changeToScrollText(arg_5_0._nameTF, arg_5_1._tmpData.name)

	arg_5_0._lvText.text = " Lv." .. arg_5_1:GetLevel()

	return
end

function var_0_0.UpdateHpText(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0._targetUnit:GetHP()

	arg_6_0._hpBarText.text = tostring(math.floor(var_6_0) .. "/" .. math.floor(var_6_1))

	return
end

function var_0_0.UpdateHpBar(arg_7_0)
	if arg_7_0._flag == false or arg_7_0._isExistBoos == true then
		return
	end

	LeanTween.cancel(arg_7_0._hpBar)

	local var_7_0 = arg_7_0._targetUnit:GetHPRate()

	arg_7_0:UpdateHpText(target)

	if var_7_0 < arg_7_0._hpBarProgress.fillAmount then
		LeanTween.value(arg_7_0._hpBar, arg_7_0._hpBarProgress.fillAmount, var_7_0, 0.5):setOnUpdate(System.Action_float(function(arg_8_0)
			arg_7_0._hpBarProgress.fillAmount = arg_8_0

			return
		end))
	else
		arg_7_0._hpBarProgress.fillAmount = var_7_0
	end

	if var_7_0 == 0 then
		arg_7_0:RemoveUnit()
	end

	return
end

function var_0_0.RemoveUnit(arg_9_0, arg_9_1)
	arg_9_0._targetUnit = nil
	arg_9_0._flag = false

	local function var_9_0()
		arg_9_0._flag = true

		arg_9_0:Show(false)

		return
	end

	if arg_9_1 then
		arg_9_0._deathTimer = pg.TimeMgr.GetInstance():AddBattleTimer("death", 0, 1, function()
			var_9_0()
			pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_9_0._deathTimer)

			return
		end)
	else
		(function()
			arg_9_0._flag = true

			arg_9_0:Show(false)

			return
		end)()
	end

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:Show(false)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_12_0._deathTimer)
	LeanTween.cancel(arg_12_0._hpBar)

	arg_12_0._hpBarProgress = nil
	arg_12_0._hpBar = nil
	arg_12_0._hpBarTF = nil
	arg_12_0._monsterTF = nil
	arg_12_0._monster = nil

	return
end

return
