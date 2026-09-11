local DrawUpPool = class("DrawUpPool", DrawBasePool)

function DrawUpPool:AddUIListener()
	DrawUpPool.super.AddUIListener(self)

	if self.m_changeBtn then
		self:AddBtnListener(self.m_changeBtn, nil, function()
			if DrawPoolCfg[self.poolId].pool_change == 0 or DrawData:GetPoolUpTimes(self.poolId) < DrawPoolCfg[self.poolId].pool_change then
				self:Go("/drawHeroSelect", {
					poolId = self.poolId
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function DrawUpPool:Refresh()
	DrawUpPool.super.Refresh(self)

	if self.m_changeCount then
		self.m_changeCount.text = DrawPoolCfg[self.poolId].pool_change == 0 and "" or string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[self.poolId].pool_change - DrawData:GetPoolUpTimes(self.poolId)))
	end
end

return DrawUpPool
