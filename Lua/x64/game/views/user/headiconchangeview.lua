local var_0_0 = class("HeadIconChangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/AvatarSystemUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.page_ = {
		"portrait",
		"frame",
		"cardBg",
		"chatBubble",
		"appIcon"
	}
	arg_4_0.lockCon_ = ControllerUtil.GetController(arg_4_0.transform_, "lock")
	arg_4_0.pageCon_ = ControllerUtil.GetController(arg_4_0.transform_, "page")
	arg_4_0.btnCon_1 = arg_4_0.btn_1.transform:GetComponent("ControllerExCollection"):GetController("status")
	arg_4_0.btnCon_2 = arg_4_0.btn_2.transform:GetComponent("ControllerExCollection"):GetController("status")
	arg_4_0.btnCon_3 = arg_4_0.btn_3.transform:GetComponent("ControllerExCollection"):GetController("status")
	arg_4_0.btnCon_4 = arg_4_0.btn_4.transform:GetComponent("ControllerExCollection"):GetController("status")
	arg_4_0.btnCon_5 = arg_4_0.btn_5.transform:GetComponent("ControllerExCollection"):GetController("status")
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, UserHeadItem)
	arg_4_0.portraitModule = CommonHeadPortrait.New(arg_4_0.portraitObj_)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.curList_[arg_5_1].id
	local var_5_1 = arg_5_0:IsUsed(var_5_0)

	arg_5_2:SetUsed(var_5_1)
	arg_5_2:SetSelected(arg_5_0.curID_ == var_5_0)
	arg_5_2:RefreshItem(var_5_0, arg_5_0.curPage_)
	arg_5_2:RegisterClickListener(function()
		if arg_5_0.curID_ == var_5_0 then
			return
		end

		arg_5_0:SetCurID(var_5_0)

		if arg_5_0.curPage_ == "chatBubble" and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAT_BUBBLE_RANGE + var_5_0) then
			if table.keyof(PlayerData:GetUnlockChatBubbleIDList(), var_5_0) then
				RedPointAction.HandleRedPoint(RedPointConst.CHAT_BUBBLE_RANGE + var_5_0)
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAT_BUBBLE, var_5_0), 0)
			end
		elseif arg_5_0.curPage_ == "portrait" then
			PlayerData:ClearPortraitRed(var_5_0)
		elseif arg_5_0.curPage_ == "frame" then
			PlayerData:ClearFrameRed(var_5_0)
		elseif arg_5_0.curPage_ == "cardBg" then
			PlayerData:ClearCardBgRedItem(var_5_0)
		end

		arg_5_0.scrollHelper_:Refresh()
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.useBtn_, nil, function()
		if arg_7_0.curPage_ == "portrait" then
			PlayerAction.ChangePortrait(arg_7_0.curID_)
		elseif arg_7_0.curPage_ == "frame" then
			PlayerAction.ChangeFrameIcon(arg_7_0.curID_)
		elseif arg_7_0.curPage_ == "cardBg" then
			PlayerAction.ChangeCardBg(arg_7_0.curID_)
		elseif arg_7_0.curPage_ == "chatBubble" then
			PlayerAction.ChangeChatBubble(arg_7_0.curID_, function()
				ShowTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS")

				arg_7_0.chatBubbleID_ = PlayerData:GetCurChatBubbleID()

				arg_7_0:SetCurID(arg_7_0.curID_)
				arg_7_0.scrollHelper_:Refresh()
			end)
		elseif arg_7_0.curPage_ == "appIcon" then
			if GameToSDK.IsAndroidPlatform() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SET_APP_ICON"),
					OkCallback = function()
						LuaForUtil.SetAppIcon(ItemConst.APP_ICON_NAME[arg_7_0.curID_])
						PlayerData:SaveAppIcon(arg_7_0.curID_)
						arg_7_0:RefreshCurID()
						arg_7_0:SetCurID(arg_7_0.curID_)
						arg_7_0.scrollHelper_:Refresh()
					end
				})
			else
				LuaForUtil.SetAppIcon(ItemConst.APP_ICON_NAME[arg_7_0.curID_])
				PlayerData:SaveAppIcon(arg_7_0.curID_)
				arg_7_0:RefreshCurID()
				arg_7_0:SetCurID(arg_7_0.curID_)
				arg_7_0.scrollHelper_:Refresh()
			end
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.previewBtn_, nil, function()
		if arg_7_0.curPage_ == "cardBg" then
			JumpTools.OpenPageByJump("/newUserInfoPreviewPop", {
				previewID = arg_7_0.curID_
			})
		end
	end)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.page_) do
		arg_7_0:AddBtnListener(arg_7_0["btn_" .. iter_7_0], nil, function()
			arg_7_0.index_ = iter_7_0

			if arg_7_0.page_[iter_7_0] == arg_7_0.curPage_ then
				return
			end

			arg_7_0.curPage_ = arg_7_0.page_[iter_7_0]

			if arg_7_0.curPage_ == "portrait" then
				arg_7_0:SetCurID(arg_7_0.portraitID_)
			elseif arg_7_0.curPage_ == "frame" then
				arg_7_0:SetCurID(arg_7_0.frameID_)
			elseif arg_7_0.curPage_ == "cardBg" then
				arg_7_0:SetCurID(arg_7_0.cardBgID_)
			elseif arg_7_0.curPage_ == "chatBubble" then
				arg_7_0:SetCurID(arg_7_0.chatBubbleID_)
			elseif arg_7_0.curPage_ == "appIcon" then
				arg_7_0:SetCurID(arg_7_0.appIconID_)
			end

			arg_7_0:ChangeBtnController(iter_7_0)
			OperationRecorder.RecordButtonTouch("userinfo_headportrait_" .. arg_7_0.index_)
			arg_7_0.scrollHelper_:StartScroll(#arg_7_0.curList_)
		end)
	end
end

function var_0_0.ChangeBtnController(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.page_) do
		arg_14_0["btnCon_" .. iter_14_0]:SetSelectedIndex(iter_14_0 == arg_14_1 and 1 or 0)
	end
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:CheckExpiredList()

	arg_15_0.curList_ = {}

	if arg_15_0.params_.isEnter then
		arg_15_0.index_ = 1
		arg_15_0.params_.isEnter = nil
	end

	arg_15_0.index_ = arg_15_0.index_ or 1
	arg_15_0.curPage_ = arg_15_0.page_[arg_15_0.index_]

	arg_15_0:ChangeBtnController(arg_15_0.index_)
	arg_15_0:RefreshUI()

	local var_15_0 = true
	local var_15_1 = GameToSDK.IsPCPlatform()
	local var_15_2 = GameToSDK.clientInfo.env == "aud"

	if OperationAction.GetOperationUrl("ICON_CHANGE") and (OperationAction.GetOperationUrl("ICON_CHANGE") == "false" or OperationAction.GetOperationUrl("ICON_CHANGE") == false) or var_15_1 or var_15_2 or GameToSDK.PLATFORM_ID == 4 then
		var_15_0 = false
	end

	SetActive(arg_15_0.btn_5.gameObject, var_15_0)

	if arg_15_0.curPage_ == "portrait" then
		arg_15_0:SetCurID(arg_15_0.portraitID_)
	elseif arg_15_0.curPage_ == "frame" then
		arg_15_0:SetCurID(arg_15_0.frameID_)
	elseif arg_15_0.curPage_ == "cardBg" then
		arg_15_0:SetCurID(arg_15_0.cardBgID_)
	elseif arg_15_0.curPage_ == "chatBubble" then
		arg_15_0:SetCurID(arg_15_0.chatBubbleID_)
	elseif arg_15_0.curPage_ == "appIcon" then
		arg_15_0:SetCurID(arg_15_0.appIconID_)
	end

	arg_15_0.scrollHelper_:StartScroll(#arg_15_0.curList_)
	arg_15_0:BindRedPoint()
end

function var_0_0.CheckExpiredList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = PlayerData:GetOverdueFrameList()
	local var_16_2 = PlayerData:GetOverduePortraitList()
	local var_16_3 = PlayerData:GetOverdueChatBubbleList()
	local var_16_4 = PlayerData:GetOverdueCardBgList()

	table.insertto(var_16_0, var_16_1)
	table.insertto(var_16_0, var_16_2)
	table.insertto(var_16_0, var_16_3)
	table.insertto(var_16_0, var_16_4)

	local var_16_5 = ItemTools.SortRewardItemList(var_16_0)

	if #var_16_5 > 0 then
		JumpTools.OpenPageByJump("userExpiredPop", {
			expiredList = var_16_5
		})
	end
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0:RefreshData()
	arg_17_0:RefreshCurID()
end

function var_0_0.RefreshData(arg_18_0)
	arg_18_0:GetPortraitList()
	arg_18_0:GetFrameList()
	arg_18_0:GetCardBgList()
	arg_18_0:GetChatBubbleList()
	arg_18_0:GetAppIconList()
end

function var_0_0.RefreshCurID(arg_19_0)
	arg_19_0.portraitID_ = PlayerData:GetCurPortrait()
	arg_19_0.frameID_ = PlayerData:GetCurFrame()
	arg_19_0.cardBgID_ = PlayerData:GetCurCardBg()
	arg_19_0.chatBubbleID_ = PlayerData:GetCurChatBubbleID()
	arg_19_0.appIconID_ = PlayerData:GetCurAppIcon()
end

function var_0_0.SetCurID(arg_20_0, arg_20_1)
	arg_20_0.curID_ = arg_20_1

	arg_20_0.pageCon_:SetSelectedState(arg_20_0.curPage_)

	local var_20_0 = arg_20_0:IsUsed(arg_20_0.curID_)

	if arg_20_0.curPage_ ~= "chatBubble" then
		arg_20_0.portraitModule:RenderHead(arg_20_0.curPage_ == "portrait" and arg_20_0.curID_ or arg_20_0.portraitID_)

		local var_20_1 = arg_20_0.curPage_ == "frame" and arg_20_0.curID_ or arg_20_0.frameID_

		arg_20_0.portraitModule:RenderFrame(var_20_1)

		arg_20_0.cardBgIcon_.sprite = ItemTools.getItemSprite(arg_20_0.curPage_ == "cardBg" and arg_20_0.curID_ or arg_20_0.cardBgID_)

		arg_20_0.cardBgIcon_:SetNativeSize()

		arg_20_0.appIcon_.sprite = ItemTools.getItemSprite(arg_20_0.curID_)
	else
		arg_20_0:RefreshBubble()
	end

	arg_20_0.itemCfg_ = ItemCfg[arg_20_0.curID_]
	arg_20_0.nameTxt_.text = ItemTools.getItemName(arg_20_0.itemCfg_.id)
	arg_20_0.descTxt_.text = ItemTools.getItemDesc(arg_20_0.itemCfg_.id)
	arg_20_0.wayTxt_.text = GetI18NText(arg_20_0.itemCfg_.desc_source) or ""

	local var_20_2

	if arg_20_0.curPage_ == "portrait" then
		arg_20_0.curList_ = arg_20_0.portraitList_
		var_20_2 = PlayerData:GetPortrait(arg_20_0.curID_)
	elseif arg_20_0.curPage_ == "frame" then
		arg_20_0.curList_ = arg_20_0.frameList_
		var_20_2 = PlayerData:GetFrame(arg_20_0.curID_)
	elseif arg_20_0.curPage_ == "cardBg" then
		arg_20_0.curList_ = arg_20_0.cardBgList_
		var_20_2 = PlayerData:GetCardBg(arg_20_0.curID_)
	elseif arg_20_0.curPage_ == "chatBubble" then
		arg_20_0.curList_ = arg_20_0.chatBubbleList_
		var_20_2 = {
			unlock = table.keyof(PlayerData:GetUnlockChatBubbleIDList(), arg_20_0.curID_) and 1 or 0
		}
	elseif arg_20_0.curPage_ == "appIcon" then
		arg_20_0.curList_ = arg_20_0.appIconList_
		var_20_2 = {
			unlock = ItemTools.getItemNum(arg_20_0.curID_) > 0 and 1 or 0
		}
	end

	if var_20_2.lasted_time and var_20_2.lasted_time > 0 then
		arg_20_0.timeCntText_.text = manager.time:STimeDescS(var_20_2.lasted_time, "!%Y/%m/%d %H:%M")

		SetActive(arg_20_0.timeCntGo_, true)
	else
		SetActive(arg_20_0.timeCntGo_, false)
	end

	arg_20_0.lockCon_:SetSelectedState(var_20_2.unlock == 0 and "lock" or "default")

	if var_20_0 then
		arg_20_0.useBtn_.interactable = false

		arg_20_0.lockCon_:SetSelectedState("value_2")
	else
		arg_20_0.useBtn_.interactable = true
		arg_20_0.btnTxt_.text = GetTips("TIP_USE")
	end
end

function var_0_0.GetPortraitList(arg_21_0)
	arg_21_0.portraitList_ = AvatarTools.GetPortraitList()

	table.sort(arg_21_0.portraitList_, function(arg_22_0, arg_22_1)
		if arg_22_0.unlock ~= arg_22_1.unlock then
			return arg_22_0.unlock > arg_22_1.unlock
		end

		return arg_22_0.id < arg_22_1.id
	end)
end

function var_0_0.GetFrameList(arg_23_0)
	arg_23_0.frameList_ = AvatarTools.GetFrameList()

	table.sort(arg_23_0.frameList_, function(arg_24_0, arg_24_1)
		if arg_24_0.unlock ~= arg_24_1.unlock then
			return arg_24_0.unlock > arg_24_1.unlock
		end

		return arg_24_0.id < arg_24_1.id
	end)
end

function var_0_0.GetCardBgList(arg_25_0)
	arg_25_0.cardBgList_ = AvatarTools.GetCardBgList()

	table.sort(arg_25_0.cardBgList_, function(arg_26_0, arg_26_1)
		if arg_26_0.unlock ~= arg_26_1.unlock then
			return arg_26_0.unlock > arg_26_1.unlock
		end

		return arg_26_0.id < arg_26_1.id
	end)
end

function var_0_0.GetChatBubbleList(arg_27_0)
	arg_27_0.chatBubbleList_ = AvatarTools.GetChatBubbleList()

	table.sort(arg_27_0.chatBubbleList_, function(arg_28_0, arg_28_1)
		local var_28_0 = PlayerData:GetChatBubble(arg_28_0.id).unlock == 1
		local var_28_1 = PlayerData:GetChatBubble(arg_28_1.id).unlock == 1

		if var_28_0 and var_28_1 then
			return arg_28_0.id < arg_28_1.id
		elseif var_28_0 then
			return true
		elseif var_28_1 then
			return false
		else
			return arg_28_0.id < arg_28_1.id
		end
	end)
end

function var_0_0.GetAppIconList(arg_29_0)
	arg_29_0.appIconList_ = PlayerData:GetAllAppIconList()
end

function var_0_0.IsUsed(arg_30_0, arg_30_1)
	return arg_30_1 == arg_30_0.portraitID_ or arg_30_1 == arg_30_0.frameID_ or arg_30_1 == arg_30_0.cardBgID_ or arg_30_1 == arg_30_0.chatBubbleID_ or arg_30_1 == arg_30_0.appIconID_
end

function var_0_0.OnChangePortrait(arg_31_0)
	arg_31_0:RefreshCurID()
	arg_31_0:SetCurID(arg_31_0.curID_)
	arg_31_0.scrollHelper_:Refresh()
end

function var_0_0.OnChangeFrame(arg_32_0)
	arg_32_0:RefreshCurID()
	arg_32_0:SetCurID(arg_32_0.curID_)
	arg_32_0.scrollHelper_:Refresh()
end

function var_0_0.OnChangeCardBg(arg_33_0)
	arg_33_0:RefreshCurID()
	arg_33_0:SetCurID(arg_33_0.curID_)
	arg_33_0.scrollHelper_:Refresh()
end

function var_0_0.BindRedPoint(arg_34_0)
	manager.redPoint:bindUIandKey(arg_34_0.btn_1.transform, RedPointConst.PORTRAIT)
	manager.redPoint:bindUIandKey(arg_34_0.btn_2.transform, RedPointConst.FRAME)
	manager.redPoint:bindUIandKey(arg_34_0.btn_3.transform, RedPointConst.CARD_BG)
	manager.redPoint:bindUIandKey(arg_34_0.btn_4.transform, RedPointConst.CHAT_BUBBLE)
end

function var_0_0.UnbindRedPoint(arg_35_0)
	manager.redPoint:unbindUIandKey(arg_35_0.btn_1.transform, RedPointConst.PORTRAIT)
	manager.redPoint:unbindUIandKey(arg_35_0.btn_2.transform, RedPointConst.FRAME)
	manager.redPoint:unbindUIandKey(arg_35_0.btn_3.transform, RedPointConst.CARD_BG)
	manager.redPoint:unbindUIandKey(arg_35_0.btn_4.transform, RedPointConst.CHAT_BUBBLE)
end

function var_0_0.OnExit(arg_36_0)
	arg_36_0:UnbindRedPoint()

	for iter_36_0, iter_36_1 in pairs(arg_36_0.scrollHelper_:GetItemList()) do
		iter_36_1:OnExit()
	end
end

function var_0_0.Dispose(arg_37_0)
	arg_37_0:RemoveAllListeners()
	arg_37_0.portraitModule:Dispose()

	for iter_37_0, iter_37_1 in pairs(arg_37_0.scrollHelper_:GetItemList()) do
		iter_37_1:Dispose()
	end

	arg_37_0.scrollHelper_:Dispose()
	arg_37_0:DestroyBubble()
	var_0_0.super.Dispose(arg_37_0)
end

function var_0_0.RefreshBubble(arg_38_0)
	local var_38_0 = arg_38_0.curPage_ == "chatBubble" and arg_38_0.curID_ or arg_38_0.chatBubbleID_
	local var_38_1 = ChatBubbleCfg[var_38_0]

	if not var_38_1 then
		-- block empty
	end

	local var_38_2 = var_38_1.color2

	if var_38_1.type and var_38_1.type == 2 then
		SetActive(arg_38_0.chatBubbleCont_.gameObject, true)

		arg_38_0.chatBubbleImg_.enabled = false

		if arg_38_0.dynamicBubbleName_ ~= var_38_1.image1 then
			local var_38_3 = DynamicPortraitPool.GetInstance():GetBubble(var_38_1.image1, arg_38_0.chatBubbleCont_)

			if not isNil(arg_38_0.dynamicBubble_) then
				arg_38_0:DestroyBubble()
			end

			arg_38_0.dynamicBubbleName_ = var_38_1.image1
			arg_38_0.dynamicBubble_ = var_38_3
		end

		arg_38_0.chatBubblePrevImg_.color = LuaHelper.StringToColor("#" .. var_38_2)

		arg_38_0.chatBubblePrevImg_.transform:SetAsLastSibling()
	else
		if not isNil(arg_38_0.dynamicBubble_) then
			arg_38_0:DestroyBubble()
		end

		SetActive(arg_38_0.chatBubbleCont_.gameObject, false)

		arg_38_0.chatBubbleImg_.enabled = true
		arg_38_0.chatBubbleImg_.sprite = ItemTools.getItemSprite(var_38_0)

		local var_38_4 = ChatBubbleCfg[var_38_0].color1

		arg_38_0.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. var_38_4)
	end
end

function var_0_0.DestroyBubble(arg_39_0)
	if not isNil(arg_39_0.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(arg_39_0.dynamicBubbleName_, arg_39_0.dynamicBubble_)
	end

	arg_39_0.dynamicBubble_ = nil
	arg_39_0.dynamicBubbleName_ = nil
end

return var_0_0
