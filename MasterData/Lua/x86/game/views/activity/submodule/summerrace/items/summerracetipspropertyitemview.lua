local SummerRaceTipsPropertyItemView = class("SummerRaceTipsPropertyItemView", ReduxView)
local var_0_1 = {
	ROF = true,
	Skill = true,
	HP = true,
	ATK = true,
	Cost = true
}

function SummerRaceTipsPropertyItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerRaceTipsPropertyItemView:Init()
	self:BindCfgUI()

	self.typeController_ = self.controllerEx_ and self.controllerEx_:GetController("type") or nil
end

function SummerRaceTipsPropertyItemView:SetData(arg_3_1)
	if arg_3_1 == nil then
		SetActive(self.gameObject_, false)

		return
	end

	local var_3_0 = tostring(arg_3_1.type or "")

	if var_0_1[var_3_0] ~= true then
		error("[SummerRaceTipsPropertyItemView] unsupported property type: " .. var_3_0)
	end

	SetActive(self.gameObject_, true)
	self.typeController_:SetSelectedState(var_3_0)

	self.text_num_.text = tostring(arg_3_1.value or "")

	local var_3_1 = tonumber(arg_3_1.currentValue) or 0
	local var_3_2 = tonumber(arg_3_1.maxValue) or 0

	if var_3_2 <= 0 then
		error("[SummerRaceTipsPropertyItemView] invalid max value for `" .. var_3_0 .. "`")
	end

	self.lightImage_.fillAmount = Mathf.Clamp01(var_3_1 / var_3_2)
end

function SummerRaceTipsPropertyItemView:Dispose()
	self.typeController_ = nil

	SummerRaceTipsPropertyItemView.super.Dispose(self)
end

return SummerRaceTipsPropertyItemView
