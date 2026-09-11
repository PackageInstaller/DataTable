local AdvanceMonsterMultipleAffixItem = class("AdvanceMonsterMultipleAffixItem", (import("game.views.osiris.raceTrial.CustomBox")))

function AdvanceMonsterMultipleAffixItem:IndexItem(arg_1_1, arg_1_2)
	arg_1_2:RefreshUI(self.customList_[arg_1_1], (table.indexof(self.customSelectList_, self.customList_[arg_1_1])))
	arg_1_2:RegisterClickListener(self.clickFunc_)
end

function AdvanceMonsterMultipleAffixItem:RefreshUI(arg_2_1, arg_2_2)
	local var_2_0 = self.uilistTrs_:GetComponent("ScrollRectEx")

	self.customList_ = arg_2_1
	self.customSelectList_ = arg_2_2
	var_2_0.enabled = true

	self.scrollHelper_:SetAppearType(0)
	self.scrollHelper_:StartScroll(#self.customList_)

	var_2_0.enabled = false

	local var_2_1 = math.ceil(#self.customList_ / math.floor(self.uilistTrs_.rect.width / 123))

	self.uilistTrs_.sizeDelta = Vector2(self.uilistTrs_.sizeDelta.x, var_2_1 * 166)
	self.transform_.sizeDelta = Vector2(self.transform_.sizeDelta.x, var_2_1 * 166 + 20)
	self.bg01Trs_.sizeDelta = Vector2(self.bg01Trs_.sizeDelta.x, var_2_1 * 166 + 10)
end

return AdvanceMonsterMultipleAffixItem
