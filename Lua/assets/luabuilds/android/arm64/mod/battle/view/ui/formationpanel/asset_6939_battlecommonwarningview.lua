ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleSkillEditCustomWarning
local BattleCommonWarningView = class("BattleCommonWarningView")

ys.Battle.BattleCommonWarningView = BattleCommonWarningView
BattleCommonWarningView.__name = "BattleCommonWarningView"
BattleCommonWarningView.WARNING_TYPE_SUBMARINE = "submarine"
BattleCommonWarningView.WARNING_TYPE_ARTILLERY = "artillery"

function BattleCommonWarningView:Ctor(arg_1_1)
	self._submarineCount = 0
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._subIcon = self._tf:Find("submarineIcon")
	self._tips = self._tf:Find("warningTips")
	self._subWarn = self._tf:Find("submarineWarningTips")
	self._warningRequestTable = {
		{
			flag = false,
			type = BattleCommonWarningView.WARNING_TYPE_ARTILLERY,
			tf = self._tips
		},
		{
			flag = false,
			type = BattleCommonWarningView.WARNING_TYPE_SUBMARINE,
			tf = self._subWarn
		}
	}
	self._customWarningTpl = self._tf:Find("customWarningTpl")
	self._customWarningContainer = self._tf:Find("customWarningContainer")
	self._customWarningList = {}

	return
end

function BattleCommonWarningView:UpdateHostileSubmarineCount(arg_2_1)
	if arg_2_1 > 0 and self._submarineCount <= 0 then
		self:activeSubmarineWarning()
	elseif self._submarineCount > 0 and arg_2_1 <= 0 then
		self:deactiveSubmarineWarning()
	end

	self._submarineCount = arg_2_1

	return
end

function BattleCommonWarningView:GetCount()
	return self._submarineCount
end

function BattleCommonWarningView:ActiveWarning(arg_4_1)
	local var_4_0 = #self._warningRequestTable

	for iter_4_0, iter_4_1 in ipairs(self._warningRequestTable) do
		if arg_4_1 == iter_4_1.type then
			iter_4_1.flag = true

			if not false then
				SetActive(iter_4_1.tf, true)

				var_4_0 = iter_4_0
			else
				break
			end
		elseif iter_4_1.flag and var_4_0 < iter_4_0 then
			SetActive(iter_4_1.tf, false)
		end
	end

	return
end

function BattleCommonWarningView:DeactiveWarning(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._warningRequestTable) do
		if arg_5_1 == iter_5_1.type then
			iter_5_1.flag = false

			SetActive(iter_5_1.tf, false)
		elseif iter_5_1.flag then
			self:ActiveWarning(iter_5_1.type)

			break
		end
	end

	return
end

function BattleCommonWarningView:EditCustomWarning(arg_6_1)
	if arg_6_1.op == var_0_2.OP_ADD then
		local var_6_0 = var_0_0.Battle.BattleCustomWarningLabel.New((cloneTplTo(self._customWarningTpl, self._customWarningContainer)))

		var_6_0:ConfigData(arg_6_1)

		self._customWarningList[arg_6_1.key] = var_6_0
	elseif arg_6_1.op == var_0_2.OP_REMOVE then
		if self._customWarningList[arg_6_1.key] then
			self._customWarningList[arg_6_1.key]:SetExpire()
		end
	elseif arg_6_1.op == var_0_2.OP_REMOVE_PERMANENT then
		for iter_6_0, iter_6_1 in pairs(self._customWarningList) do
			if iter_6_1:GetDuration() <= 0 then
				iter_6_1:SetExpire()
			end
		end
	elseif arg_6_1.op == var_0_2.OP_REMOVE_TEMPLATE then
		for iter_6_2, iter_6_3 in pairs(self._customWarningList) do
			if iter_6_3:GetDuration() > 0 then
				iter_6_3:SetExpire()
			end
		end
	end

	return
end

function BattleCommonWarningView:Update()
	for iter_7_0, iter_7_1 in pairs(self._customWarningList) do
		iter_7_1:Update()

		if iter_7_1:IsExpire() then
			iter_7_1:Dispose()

			self._customWarningList[iter_7_0] = nil
		end
	end

	return
end

function BattleCommonWarningView:activeSubmarineWarning()
	SetActive(self._subIcon, true)
	self:ActiveWarning(BattleCommonWarningView.WARNING_TYPE_SUBMARINE)
	LeanTween.cancel(go(self._subIcon))
	LeanTween.alpha(rtf(self._subIcon), 1, 2):setFrom(0)

	return
end

function BattleCommonWarningView:deactiveSubmarineWarning()
	LeanTween.cancel(go(self._subIcon))
	LeanTween.alpha(rtf(self._subIcon), 0, 1):setFrom(1):setOnComplete(System.Action(function()
		SetActive(self._subIcon, false)
		self:DeactiveWarning(BattleCommonWarningView.WARNING_TYPE_SUBMARINE)

		return
	end))

	return
end

function BattleCommonWarningView:Dispose()
	for iter_11_0, iter_11_1 in pairs(self._customWarningList) do
		iter_11_1:Dispose()

		self._customWarningList[iter_11_0] = nil
	end

	self._customWarningList = nil
	self._go = nil
	self._tf = nil
	self._icon = nil
	self._tips = nil

	return
end

return
