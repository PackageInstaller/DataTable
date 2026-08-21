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

function var_0_0.BulletinRefresh(arg_2_0)
	BulletinData.refreshBulletin(arg_2_0)
	var_0_0.UpdateUnread()

	if arg_2_0 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.announcement_list) do
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
	local var_3_0 = BulletinData.GetBulletinPageList()[arg_3_0]

	BulletinData.deleteBulletin({
		id = arg_3_0
	})
	var_0_0.UpdateUnread()
	manager.notify:CallUpdateFunc(ON_BULLETIN_DELETE, var_3_0)
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
	local var_5_4 = 0

	for iter_5_0, iter_5_1 in pairs(BulletinData.GetBulletinPageList()) do
		if not getData("bulletin", "bulletin_" .. iter_5_1.id) and var_5_0 < iter_5_1.endTime then
			if iter_5_1.type == 101 then
				var_5_2 = var_5_2 + 1
			elseif iter_5_1.type == 102 then
				var_5_3 = var_5_3 + 1
			elseif iter_5_1.type == 104 then
				var_5_4 = var_5_4 + 1
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_101, var_5_2)
	manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_102, var_5_3)
	manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_104, var_5_4)

	return var_5_1
end

manager.notify:RegistListener(BULLETIN_QUITBATTLE, function()
	manager.rollTips:TryToCreatTips()
end)

function var_0_0.OpenOperationUrl(arg_7_0)
	local var_7_0 = PlayerData:GetPlayerInfo().userID
	local var_7_1 = PlayerData:GetPlayerInfo().signUserId
	local var_7_2 = ""
	local var_7_3 = string.format(arg_7_0, var_7_0, var_7_1)

	OperationAction.OpenOperationUrlDirectly(var_7_3)
end

return var_0_0
