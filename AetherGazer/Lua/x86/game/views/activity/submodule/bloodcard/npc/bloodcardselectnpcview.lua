local var_0_0 = class("BloodCardSelectNpcView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardSelectNPCUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.npcHeadList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexNpcHeadItem), arg_3_0.npcHeadUIList_, BloodCardNpcHeadItem)
	arg_3_0.deckList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexStageItem), arg_3_0.deckUIList_, BloodCardStageEntraceItem)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activityID_ = BloodCardData:GetMainActivityID()
	arg_5_0.isAllNpc_ = arg_5_0.params_.isAllNpc
	arg_5_0.selectNpc_ = arg_5_0.params_.selectNpc or BloodCardData:GetSelectNpc()

	if arg_5_0.isAllNpc_ then
		arg_5_0.npcList_ = BloodCardGameNPCCfg.all
		arg_5_0.isEnter_ = arg_5_0.params_.isEnter

		if arg_5_0.isEnter_ then
			arg_5_0.selectNpc_ = BloodCardData:GetUnPassNpc() or BloodCardGameNPCCfg.all[1]
		end
	else
		arg_5_0.npcList_ = {
			arg_5_0.selectNpc_
		}
	end

	BloodCardData:SetCacheParams(arg_5_0.params_)

	if arg_5_0.isAllNpc_ then
		arg_5_0.modelInitPosition_ = Vector3.New(arg_5_0.params_.posX, arg_5_0.params_.posY, arg_5_0.params_.posZ)
		arg_5_0.modelInitRotation_ = Quaternion.Euler(arg_5_0.params_.rotationX, arg_5_0.params_.rotationY, arg_5_0.params_.rotationZ)
	end

	arg_5_0:RefreshUI()
	BloodCardTools.CheckCacheUnlockCard()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.npcHeadList_:StartScroll(#arg_6_0.npcList_)
	arg_6_0:SelectNpc(arg_6_0.selectNpc_)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLOOD_CARD_GAME_SELECT_NPC_RULE")
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()

	if arg_8_0.model_ then
		GameObject.Destroy(arg_8_0.model_)
		Asset.Unload("CharDorm/" .. BloodCardGameNPCCfg[arg_8_0.selectNpc_].model)

		arg_8_0.model_ = nil
	end

	arg_8_0.params_.isEnter = false
end

function var_0_0.IndexNpcHeadItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.npcList_[arg_9_1])
	arg_9_2:SetClickCallBack(function(arg_10_0)
		arg_9_2:CancelRedPoint()

		if arg_10_0 == arg_9_0.selectNpc_ then
			return
		end

		arg_9_0:SelectNpc(arg_10_0)
	end)
	arg_9_2:RefreshState(arg_9_0.selectNpc_)
end

function var_0_0.SelectNpc(arg_11_0, arg_11_1)
	arg_11_0.preSelectNpc_ = arg_11_0.selectNpc_
	arg_11_0.selectNpc_ = arg_11_1
	arg_11_0.selectIndex_ = table.indexof(arg_11_0.npcList_, arg_11_0.selectNpc_)

	BloodCardData:SetSelectNpc(arg_11_0.selectNpc_)

	arg_11_0.params_.selectNpc = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.npcHeadList_:GetItemList()) do
		iter_11_1:RefreshState(arg_11_1)
	end

	arg_11_0:RefreshDeck()

	arg_11_0.tipsText_.text = arg_11_0.cfg_.desc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.tipsTextContent_)

	if arg_11_0.isAllNpc_ then
		arg_11_0:LoadNpcModle()
	end
end

function var_0_0.LoadNpcModle(arg_12_0)
	if arg_12_0.model_ and arg_12_0.preSelectNpc_ then
		GameObject.Destroy(arg_12_0.model_)
		Asset.Unload("CharDorm/" .. BloodCardGameNPCCfg[arg_12_0.preSelectNpc_].model)

		arg_12_0.model_ = nil
	end

	arg_12_0.model_ = Object.Instantiate(Asset.Load("CharDorm/" .. BloodCardGameNPCCfg[arg_12_0.selectNpc_].model))

	Dorm.LuaBridge.MiniGameBridge.PlayEffect(arg_12_0.modelInitPosition_, Quaternion.Euler(0, 0, 0), Vector3(0.1, 0.1, 0.1), "Effect/tongyong/fx_appear_UI", 1)
	manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_card_turn", "")

	arg_12_0.model_.transform.localPosition = arg_12_0.modelInitPosition_
	arg_12_0.model_.transform.localRotation = arg_12_0.modelInitRotation_
end

function var_0_0.RefreshDeck(arg_13_0)
	arg_13_0.cfg_ = BloodCardGameNPCCfg[arg_13_0.selectNpc_]

	arg_13_0.deckList_:StartScroll(#arg_13_0.cfg_.stage_list)
end

function var_0_0.IndexStageItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.cfg_.stage_list[arg_14_1])
	arg_14_2:SetClickCallBack(function(arg_15_0)
		BloodCardData:SetSelectStageID(arg_15_0)

		if table.indexof(BloodCardConst.guideStageList, arg_15_0) then
			LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(function()
				OpenPageUntilLoaded("/bloodCardGame")
			end))
		else
			JumpTools.OpenPageByJump("/bloodCardDeckCheck")
		end
	end)
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.deckList_ then
		arg_17_0.deckList_:Dispose()
	end

	if arg_17_0.npcHeadList_ then
		arg_17_0.npcHeadList_:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
