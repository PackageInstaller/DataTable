local SummerRaceBodyTipsView = class("SummerRaceBodyTipsView", ReduxView)

function SummerRaceBodyTipsView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerRaceBodyTipsView:Init()
	self:BindCfgUI()
end

function SummerRaceBodyTipsView:SetData(arg_3_1)
	if arg_3_1 == nil then
		SetActive(self.rootGo_, false)

		return
	end

	SetActive(self.rootGo_, true)

	self.titleText_.text = tostring(arg_3_1.title or "")
	self.hpText_.text = tostring(arg_3_1.hpText or arg_3_1.hp or "0")
	self.costText_.text = tostring(arg_3_1.costText or arg_3_1.cost or "0")
	self.descText_.text = tostring(arg_3_1.desc or "")
end

return SummerRaceBodyTipsView
