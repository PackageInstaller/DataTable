local var_0_0 = {}

manager.net:Bind(30099, function(arg_1_0)
	BulletinAction.BulletinRefresh(arg_1_0)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(BulletinData.GetBulletinIDList()) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
			table.insert(var_1_0, tostring(iter_1_3))
		end
	end

	BulletinBoardMgr.inst:ClearCache(var_1_0)
end)

function var_0_0:BulletinRefresh()
	BulletinData.refreshBulletin(self)
	var_0_0.UpdateUnread()

	if self then
		for iter_2_0, iter_2_1 in ipairs(self.announcement_list) do
			if iter_2_1.type == 103 then
				for iter_2_2, iter_2_3 in pairs(iter_2_1.content) do
					if iter_2_3.content_type == 2 then
						local var_2_0 = SceneManager.GetActiveScene().name

						if GetIsInMainScene() then
							if BulletinData.GetIslogin() then
								BulletinData.SetCacheString(iter_2_1.id, iter_2_3.text)
								manager.rollTips:CountTipsAndCreate(iter_2_3.text, iter_2_1.id)
							else
								manager.rollTips:SetCachePop(true)
								BulletinData.SetCacheString(iter_2_1.id, iter_2_3.text)
							end
						else
							manager.rollTips:SetCachePop(true)
							BulletinData.SetCacheString(iter_2_1.id, iter_2_3.text)
						end
					end
				end
			end
		end
	end
end

function var_0_0.BulletinDelete(arg_3_0)
	BulletinData.deleteBulletin({
		id = arg_3_0
	})
	var_0_0.UpdateUnread()
	manager.notify:CallUpdateFunc(ON_BULLETIN_DELETE, BulletinData.GetBulletinPageList()[arg_3_0])
end

function var_0_0.BulletinRead(arg_4_0)
	BulletinData.SetReadFlagById(arg_4_0)
	BulletinData.SetReadFlag(not BulletinData.GetReadFlag())
	var_0_0.UpdateUnread()
end

function var_0_0.UpdateUnread()
	local var_5_0 = manager.time:GetServerTime()
	local var_5_1 = 0
	local var_5_2 = 0
	local var_5_3 = 0

	for iter_5_0, iter_5_1 in pairs(BulletinData.GetBulletinPageList()) do
		if not getData("bulletin", "bulletin_" .. iter_5_1.id) and var_5_0 < iter_5_1.endTime then
			if iter_5_1.type == 101 then
				var_5_1 = var_5_1 + 1
			elseif iter_5_1.type == 102 then
				var_5_2 = var_5_2 + 1
			elseif iter_5_1.type == 104 then
				var_5_3 = var_5_3 + 1
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_101, var_5_1)
	manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_102, var_5_2)
	manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_104, var_5_3)

	return 0
end

manager.notify:RegistListener(BULLETIN_QUITBATTLE, function()
	manager.rollTips:TryToCreatTips()
end)

function var_0_0.OpenOperationUrl(arg_7_0)
	OperationAction.OpenOperationUrlDirectly((string.format(arg_7_0, PlayerData:GetPlayerInfo().userID, PlayerData:GetPlayerInfo().signUserId)))
end

return var_0_0
