local SixthAnniversaryIslandProxy = class("SixthAnniversaryIslandProxy", import(".NetProxy"))

function SixthAnniversaryIslandProxy:register()
	self.nodeDic = nil
	self.timeStamp = 0

	return
end

function SixthAnniversaryIslandProxy:CheckValid()
	local var_2_0 = pg.TimeMgr.GetInstance()

	return self.nodeDic and var_2_0:IsSameDay(self.timeStamp, var_2_0:GetServerTime())
end

function SixthAnniversaryIslandProxy:GetNodeDic()
	if self:CheckValid() then
		return self.nodeDic
	else
		return {}
	end

	return
end

function SixthAnniversaryIslandProxy:CheckAndRequest(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

	if var_4_1 and not var_4_1:isEnd() and not self:CheckValid() then
		table.insert(var_4_0, function(arg_5_0)
			self:sendNotification(GAME.REQUEST_NODE_LIST, {
				act_id = var_4_1.id,
				callback = arg_5_0
			})

			return
		end)
	end

	seriesAsync(var_4_0, arg_4_1)

	return
end

function SixthAnniversaryIslandProxy:GetNode(arg_6_1)
	return self.nodeDic[arg_6_1]
end

function SixthAnniversaryIslandProxy:GetNodeIds()
	local var_7_0 = underscore.keys(self.nodeDic)

	table.sort(var_7_0)

	return var_7_0
end

return SixthAnniversaryIslandProxy
