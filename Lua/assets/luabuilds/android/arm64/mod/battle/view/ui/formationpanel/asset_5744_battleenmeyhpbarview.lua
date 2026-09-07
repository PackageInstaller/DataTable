ys = ys or {}

local var_0_0 = ys
local BattleEnmeyHpBarView = class("BattleEnmeyHpBarView")

ys.Battle.BattleEnmeyHpBarView = BattleEnmeyHpBarView
BattleEnmeyHpBarView.__name = "BattleEnmeyHpBarView"

function BattleEnmeyHpBarView:Ctor(arg_1_1)
	self._monsterTF = arg_1_1
	self.orgPos = arg_1_1.anchoredPosition
	self.HidePos = self.orgPos + Vector2(0, 100)
	self._hpBarTF = arg_1_1:Find("hpbar")
	self._hpBar = self._hpBarTF.gameObject
	self._hpBarProgress = self._hpBarTF:GetComponent(typeof(Image))
	self._hpBarText = self._hpBarTF:Find("Text"):GetComponent(typeof(Text))
	self._nameTF = arg_1_1:Find("nameContain/name")
	self._lvText = arg_1_1:Find("nameContain/Text"):GetComponent(typeof(Text))
	self._level = arg_1_1:Find("level")
	self._typeIcon = arg_1_1:Find("typeIcon/icon"):GetComponent(typeof(Image))
	self._eliteLabel = arg_1_1:Find("grade/elite")
	self._generalLabel = arg_1_1:Find("grade/general")
	self._flag = true
	self._isExistBoos = false

	self:Show(false)

	return
end

function BattleEnmeyHpBarView:GetCurrentTarget()
	return self._targetUnit
end

function BattleEnmeyHpBarView:Show(arg_3_1)
	if self._curActive ~= arg_3_1 then
		self._curActive = arg_3_1
		self._monsterTF.anchoredPosition = arg_3_1 and self.orgPos or self.HidePos
	end

	return
end

function BattleEnmeyHpBarView:SetIconType(arg_4_1)
	if self._eliteType == arg_4_1 then
		return
	end

	self._eliteType = arg_4_1

	setActive(self._generalLabel, not arg_4_1)
	setActive(self._eliteLabel, arg_4_1)

	return
end

function BattleEnmeyHpBarView:SwitchTarget(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_2) do
		if iter_5_1:IsBoss() then
			self._isExistBoos = true

			break
		end
	end

	if self._flag == false or self._isExistBoos == true then
		self:Show(false)

		return
	end

	self._targetUnit = arg_5_1

	self:Show(true)

	self._hpBarProgress.fillAmount = arg_5_1:GetHPRate()

	self:UpdateHpText(arg_5_1)
	self:SetIconType(arg_5_1:GetTemplate().icon_type ~= 0)

	self._typeIcon.sprite = GetSpriteFromAtlas("shiptype", shipType2Battleprint(var_0_0.Battle.BattleDataFunction.GetEnemyTypeDataByType(arg_5_1:GetTemplate().type).type))

	self._typeIcon:SetNativeSize()
	changeToScrollText(self._nameTF, arg_5_1._tmpData.name)

	self._lvText.text = " Lv." .. arg_5_1:GetLevel()

	return
end

function BattleEnmeyHpBarView:UpdateHpText()
	local var_6_0, var_6_1 = self._targetUnit:GetHP()

	self._hpBarText.text = tostring(math.floor(var_6_0) .. "/" .. math.floor(var_6_1))

	return
end

function BattleEnmeyHpBarView:UpdateHpBar()
	if self._flag == false or self._isExistBoos == true then
		return
	end

	LeanTween.cancel(self._hpBar)

	local var_7_0 = self._targetUnit:GetHPRate()

	self:UpdateHpText(target)

	if var_7_0 < self._hpBarProgress.fillAmount then
		LeanTween.value(self._hpBar, self._hpBarProgress.fillAmount, var_7_0, 0.5):setOnUpdate(System.Action_float(function(arg_8_0)
			self._hpBarProgress.fillAmount = arg_8_0

			return
		end))
	else
		self._hpBarProgress.fillAmount = var_7_0
	end

	if var_7_0 == 0 then
		self:RemoveUnit()
	end

	return
end

function BattleEnmeyHpBarView:RemoveUnit(arg_9_1)
	self._targetUnit = nil
	self._flag = false

	local function var_9_0()
		self._flag = true

		self:Show(false)

		return
	end

	if arg_9_1 then
		self._deathTimer = pg.TimeMgr.GetInstance():AddBattleTimer("death", 0, 1, function()
			var_9_0()
			pg.TimeMgr.GetInstance():RemoveBattleTimer(self._deathTimer)

			return
		end)
	else
		var_9_0()
	end

	return
end

function BattleEnmeyHpBarView:Dispose()
	self:Show(false)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._deathTimer)
	LeanTween.cancel(self._hpBar)

	self._hpBarProgress = nil
	self._hpBar = nil
	self._hpBarTF = nil
	self._monsterTF = nil
	self._monster = nil

	return
end

return
