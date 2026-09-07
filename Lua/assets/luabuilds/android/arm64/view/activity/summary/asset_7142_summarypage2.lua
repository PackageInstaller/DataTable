local SummaryPage2 = class("SummaryPage2", import(".SummaryAnimationPage"))

function SummaryPage2:OnInit()
	setText(findTF(self._go, "name/Text"), self.summaryInfoVO.firstProposeName)

	local var_1_0 = findTF(self._go, "texts")

	self.textTFs = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_1 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_2 = go(var_1_1).name

		if var_1_2 ~= "label" then
			setText(var_1_1:Find("Text"), self.summaryInfoVO[var_1_2])
		end

		table.insert(self.textTFs, var_1_1)
	end

	setText(findTF(self._go, "name/date"), self.summaryInfoVO.firstLadyTime)
	setPaintingPrefabAsync(findTF(self._go, "painting"):Find("mask/painting"), Ship.New({
		configId = self.summaryInfoVO.firstLadyId
	}):getPainting(), "chuanwu")
	setActive(self._go, false)

	return
end

function SummaryPage2:Clear()
	return
end

return SummaryPage2
