local DrawServantPool = class("DrawServantPool", DrawBasePool)

function DrawServantPool:AddUIListener()
	self:AddBtnListener(self.replacebtnBtn_, nil, function()
		self:Go("/drawSelect")
	end)
	self:AddBtnListener(self.btnlook1Btn_, nil, function()
		local var_3_0 = table.indexof(DrawPoolCfg[self.poolId].optional_lists_poolId, self.showId)

		if var_3_0 and DrawPoolCfg[self.poolId].optional_detail[var_3_0] then
			self:Go("/showServantView", {
				state = "onlydetail",
				id = DrawPoolCfg[self.poolId].optional_detail[var_3_0]
			})
		end
	end)
	self:AddBtnListener(self.btnshow_, nil, function()
		DrawData:SetServantRedPoint(self.poolId, 0)
		self:Go("/weaponServantList", {
			race = self.showId - 200000
		})
	end)
end

function DrawServantPool:SetActive(arg_5_1)
	DrawServantPool.super.SetActive(self, arg_5_1)
	manager.redPoint:unbindUIandKey(self.btnshow_.transform)

	if arg_5_1 == true then
		manager.redPoint:bindUIandKey(self.btnshow_.transform, (string.format("%s_%d_%d", RedPointConst.WEAPON_SERVANT_POOL, self.poolId, DrawData:GetPollUpID(self.poolId))))
	end
end

return DrawServantPool
