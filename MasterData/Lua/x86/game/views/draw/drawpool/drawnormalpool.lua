local DrawNormalPool = class("DrawNormalPool", DrawBasePool)

function DrawNormalPool:InitUI()
	DrawNormalPool.super.InitUI(self)

	self.firstController = ControllerUtil.GetController(self.transform_, "first")
end

function DrawNormalPool:Refresh()
	if DrawData:GetIsFirstSSR() then
		self.drawTime_.text = string.format("%d/%d", DrawData:GetPoolDrawTimes(self.poolId), GameSetting.draw_ssr_lucky_num_first_time.value[1])

		self.firstController:SetSelectedIndex(1)
	else
		self.firstController:SetSelectedIndex(0)
	end
end

return DrawNormalPool
