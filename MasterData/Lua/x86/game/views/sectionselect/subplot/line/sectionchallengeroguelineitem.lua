local SectionChallengeRogueLineItem = class("SectionChallengeRogueLineItem", ReduxView)
local var_0_1 = 400

function SectionChallengeRogueLineItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.lineGo1_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.lineTf1_ = self.lineGo1_:GetComponent("RectTransform")
	self.straightLineImg_ = self.lineGo1_:GetComponent(typeof(Image))
	self.curveLineGo_ = self.lineGo1_.transform:Find("curveline")
	self.gameObject_ = self.lineGo1_

	self:BindCfgUI()

	self.lockController_ = self.controller_:GetController("unlock")
end

function SectionChallengeRogueLineItem:RefreshUI(arg_2_1, arg_2_2)
	self:RefreshLine1(arg_2_1, arg_2_2)
end

function SectionChallengeRogueLineItem:RefreshLine1(arg_3_1, arg_3_2)
	local var_3_0 = var_0_1
	local var_3_1 = math.abs(arg_3_2.x - arg_3_1.x)

	if var_3_1 < var_0_1 then
		var_3_0 = var_3_1
	end

	if math.abs(arg_3_1.y - arg_3_2.y) == 0 then
		self.lineTf1_.localPosition = Vector3(arg_3_1.x + var_3_0 / 2, arg_3_1.y, 0)
		self.lineTf1_.sizeDelta = Vector2(var_3_0, 10)
		self.lineTf1_.localEulerAngles = Vector3(0, 0, 0)

		self.lineTf1_:SetAsFirstSibling()

		self.straightLineImg_.enabled = true

		SetActive(self.curveLineGo_, false)
	elseif math.abs(arg_3_1.y) > math.abs(arg_3_2.y) then
		self.lineTf1_.localPosition = Vector3(arg_3_1.x + var_3_0 / 2, 0, 0)
		self.lineTf1_.sizeDelta = Vector2(var_3_0, 10)
		self.lineTf1_.localEulerAngles = arg_3_1.y > arg_3_2.y and Vector3(0, 180, 0) or Vector3(0, 0, 180)

		self.lineTf1_:SetAsFirstSibling()

		self.straightLineImg_.enabled = false

		SetActive(self.curveLineGo_, true)
	else
		self.lineTf1_.localPosition = Vector3(arg_3_1.x + var_3_0 / 2, arg_3_1.y, 0)
		self.lineTf1_.sizeDelta = Vector2(var_3_0, 10)
		self.lineTf1_.localEulerAngles = Vector3(180 * (arg_3_1.y - arg_3_2.y > 0 and 1 or 0), 0, 0)

		self.lineTf1_:SetAsFirstSibling()

		self.straightLineImg_.enabled = false

		SetActive(self.curveLineGo_, true)
	end
end

function SectionChallengeRogueLineItem:Show(arg_4_1)
	SetActive(self.lineGo1_, arg_4_1)
end

function SectionChallengeRogueLineItem:SetUnlockState(arg_5_1)
	self.lockController_:SetSelectedState(tostring(arg_5_1))
end

function SectionChallengeRogueLineItem:Dispose()
	SectionChallengeRogueLineItem.super.Dispose(self)
	Object.Destroy(self.lineGo1_)

	self.lineTf1_ = nil
	self.lineGo1_ = nil
end

return SectionChallengeRogueLineItem
