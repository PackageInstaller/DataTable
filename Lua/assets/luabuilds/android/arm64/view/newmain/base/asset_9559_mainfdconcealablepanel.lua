local MainFdConcealablePanel = class("MainFdConcealablePanel", import(".MainConcealablePanel"))

function MainFdConcealablePanel:FillEmptySlot(arg_1_1)
	for iter_1_0 = 1, #arg_1_1 do
		arg_1_1[iter_1_0].localPosition = self.initPosition[iter_1_0]
	end

	return
end

return MainFdConcealablePanel
