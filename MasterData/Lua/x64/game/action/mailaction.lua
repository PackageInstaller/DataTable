local var_0_0 = {}

manager.net:Bind(30001, function(arg_1_0)
	MailData.MailInit(arg_1_0)
	var_0_0.UpdateMailUnread()
end)
manager.net:Bind(30013, function(arg_2_0)
	MailData.DeleteMail(arg_2_0.del_id_list)
	var_0_0.UpdateMailUnread()
end)

function var_0_0.TryToGetMailListFromServer()
	local var_3_0 = {}

	manager.net:SendWithLoadingNew(30002, var_3_0, 30003, var_0_0.OnGetMailListFromServer)
	manager.net:SendWithLoadingNew(30020, var_3_0, 30021, var_0_0.OnGetCollectMailListFromServer)
end

function var_0_0.OnGetMailListFromServer(arg_4_0, arg_4_1)
	MailData.OnGetMailListFromServer(arg_4_0)
	var_0_0.UpdateMailUnread()
end

function var_0_0.OnGetCollectMailListFromServer(arg_5_0, arg_5_1)
	MailData.OnGetCollectMailListFromServer(arg_5_0)
end

function var_0_0.TryToGetMailDetailFromServer(arg_6_0)
	manager.net:SendWithLoadingNew(30008, {
		id = arg_6_0
	}, 30009, var_0_0.OnGetMailDetailFromServer)
end

function var_0_0:OnGetMailDetailFromServer(arg_7_1)
	if isSuccess(self.result) then
		MailData.OnGetMailDetailFromServer(self)
	else
		MailData.DeleteMail({
			arg_7_1.id
		})
		ShowTips("TIP_MAIL_EXPIRED")
	end
end

function var_0_0.TryToGetCollectMailDetailFromServer(arg_8_0)
	manager.net:SendWithLoadingNew(30022, {
		mail_id = arg_8_0
	}, 30023, var_0_0.OnGetCollectMailDetailFromServer)
end

function var_0_0:OnGetCollectMailDetailFromServer(arg_9_1)
	if isSuccess(self.result) then
		MailData.OnGetCollectMailDetailFromServer(self)
	end
end

function var_0_0.ReadMail(arg_10_0)
	MailData.CacheReadFlag(arg_10_0)
end

function var_0_0.DeleteOneMail(arg_11_0)
	manager.net:SendWithLoadingNew(30006, {
		id = arg_11_0
	}, 30007, var_0_0.OnDeleteMail)
end

function var_0_0.TryToDeteleMail()
	return manager.net:SendWithLoadingNew(30006, {
		id = 0
	}, 30007, var_0_0.OnDeleteMail)
end

function var_0_0:OnDeleteMail(arg_13_1)
	if #self.id_list <= 0 then
		ShowTips("NO_MAIL_CAN_BE_DELETED")

		return
	end

	ShowTips("SUCCESS_DELETE_MAIL")
	MailData.DeleteMail(self.id_list)
	manager.notify:CallUpdateFunc(ON_MAIL_DELETE, self.id_list)
end

function var_0_0.TryToGetMailAttachment(arg_14_0, arg_14_1)
	manager.net:SendWithLoadingNew(30004, {
		id = arg_14_0
	}, 30005, function(arg_15_0, arg_15_1)
		var_0_0.OnGetMailAttachment(arg_15_0, arg_15_1, arg_14_1)
	end)
end

function var_0_0:OnGetMailAttachment(arg_16_1, arg_16_2)
	if isSuccess(self.result) then
		MailData.GetMailAttachment(self.success_mail_ids)

		if #self.attachment_list > 0 then
			local var_16_0 = {}

			for iter_16_0, iter_16_1 in ipairs(self.attachment_list) do
				if ItemCfg[iter_16_1.id].sub_type == 404 or ItemCfg[iter_16_1.id].sub_type == 1702 then
					table.insert(var_16_0, {
						ItemCfg[iter_16_1.id].param[1],
						iter_16_1.num,
						0,
						(ItemTools.GetItemExpiredTimeByID(iter_16_1.id))
					})
				elseif ItemCfg[iter_16_1.id].type == ItemConst.ITEM_TYPE.SCENE then
					table.insert(var_16_0, iter_16_1)
				else
					table.insert(var_16_0, iter_16_1)
				end
			end

			getReward((mergeReward((formatRewardCfgList(var_16_0)))))

			if arg_16_2 then
				arg_16_2()
			end
		end
	elseif self.result == TipsCfg.get_id_list_by_define.ERROR_EQUIP_EXCEED_LIMIT then
		showBagFullBox()
	elseif self.result == TipsCfg.get_id_list_by_define.ERROR_SERVANT_EXCEED_LIMIT then
		ShowMessageBox({
			content = GetTips("SERVANT_NUM_MAX"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/weaponServantList")
			end,
			CancelCallback = function()
				return
			end
		})
	else
		if self.result == 2100 then
			-- block empty
		end

		ShowTips(self.result)
	end
end

function var_0_0.ReceiveAllMails()
	if #MailData.GetMailSort() < MailData.GetTotal() then
		MailData.GetMailListFromServer(handler(self, function()
			var_0_0.TryToGetMailAttachment(0)
		end))
	else
		var_0_0.TryToGetMailAttachment(0)
	end
end

function var_0_0.SortMailManual()
	MailData.SortMailManual()
end

function var_0_0.UpdateMailUnread()
	local var_22_0 = false
	local var_22_1 = false
	local var_22_2 = MailData.GetClickTime()

	var_22_0 = MailData.GetUnread() > 0 and (manager.time:IsToday(var_22_2) and var_22_2 < MailData.GetArriveTime() or true) or false

	for iter_22_0, iter_22_1 in pairs(MailData.GetMailSort()) do
		local var_22_3 = MailData.GetMail(iter_22_1)

		if var_22_3 and (var_22_3.read_flag == 1 or var_22_3.attach_flag == 1) then
			var_22_1 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.MAIL_UNREAD, (var_22_0 or var_22_1) and 1 or 0)
end

function var_0_0.SetMailCollect(arg_23_0, arg_23_1)
	manager.net:SendWithLoadingNew(30014, {
		mail_id = arg_23_0,
		opt = arg_23_1
	}, 30015, var_0_0.OnSetMailCollectCallback)
end

function var_0_0:OnSetMailCollectCallback(arg_24_1)
	if isSuccess(self.result) then
		MailData.SetMailCollect(arg_24_1.mail_id, arg_24_1.opt, self.collect_mail)
	else
		ShowTips(GetTips(self.result))
	end
end

return var_0_0
