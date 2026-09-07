local LevelStageComboPanel = class("LevelStageComboPanel", import("view.base.BaseSubPanel"))

function LevelStageComboPanel:getUIName()
	return "LevelStageComboPanel"
end

function LevelStageComboPanel:OnInit()
	self.tf_combo = self._tf:Find("combo/text")
	self.text_combo = self.tf_combo:GetComponent(typeof(Text))
	self.tf_perfect = self._tf:Find("perfect/text")
	self.text_perfect = self.tf_perfect:GetComponent(typeof(Text))
	self.tf_good = self._tf:Find("good/text")
	self.text_good = self.tf_good:GetComponent(typeof(Text))
	self.tf_miss = self._tf:Find("miss/text")
	self.text_miss = self.tf_miss:GetComponent(typeof(Text))
	self.anims = {}

	return
end

function LevelStageComboPanel:UpdateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	setText(self.text_combo, arg_3_1.combo or 0)

	if arg_3_1.scoreHistory then
		self.text_perfect.text = arg_3_1.scoreHistory[4] or 0
		self.text_good.text = (arg_3_1.scoreHistory[2] or 0) + (arg_3_1.scoreHistory[3] or 0)
		self.text_miss.text = (arg_3_1.scoreHistory[0] or 0) + (arg_3_1.scoreHistory[1] or 0)
	end

	return
end

function LevelStageComboPanel:UpdateViewAnimated(arg_4_1)
	if not arg_4_1 then
		return
	end

	self:SetTextAnim(self.tf_combo, self.text_combo, arg_4_1.combo or 0, 1)

	if arg_4_1.scoreHistory then
		self:SetTextAnim(self.tf_perfect, self.text_perfect, arg_4_1.scoreHistory[4] or 0, 2)
		self:SetTextAnim(self.tf_good, self.text_good, (arg_4_1.scoreHistory[2] or 0) + (arg_4_1.scoreHistory[3] or 0), 3)
		self:SetTextAnim(self.tf_miss, self.text_miss, (arg_4_1.scoreHistory[0] or 0) + (arg_4_1.scoreHistory[1] or 0), 4)
	end

	return
end

function LevelStageComboPanel:SetTextAnim(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if tonumber(arg_5_2.text) == arg_5_3 then
		return
	end

	local var_5_0 = false
	local var_5_1 = arg_5_1.localPosition
	local var_5_2 = arg_5_1.localPosition + Vector3(0, 30, 0)

	self.anims[arg_5_4] = LeanTween.value(go(arg_5_1), 0, 1, 0.3):setLoopPingPong(1):setOnUpdate(System.Action_float(function(arg_6_0)
		arg_5_1.localPosition = Vector3.Lerp(var_5_1, var_5_2, arg_6_0)

		if arg_6_0 >= 1 and not var_5_0 then
			arg_5_2.text = arg_5_3
			var_5_0 = true
		end

		return
	end)).id

	return
end

function LevelStageComboPanel:OnDestroy()
	for iter_7_0, iter_7_1 in pairs(self.anims) do
		LeanTween.cancel(iter_7_1)
	end

	table.clear(self.anims)

	return
end

return LevelStageComboPanel
