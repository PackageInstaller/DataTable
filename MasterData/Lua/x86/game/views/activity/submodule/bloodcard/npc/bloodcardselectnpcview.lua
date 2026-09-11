local BloodCardSelectNpcView = class("BloodCardSelectNpcView", ReduxView)

function BloodCardSelectNpcView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardSelectNPCUI"
end

function BloodCardSelectNpcView:UIParent()
	return manager.ui.uiMain.transform
end

function BloodCardSelectNpcView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.npcHeadList_ = LuaList.New(handler(self, self.IndexNpcHeadItem), self.npcHeadUIList_, BloodCardNpcHeadItem)
	self.deckList_ = LuaList.New(handler(self, self.IndexStageItem), self.deckUIList_, BloodCardStageEntraceItem)
end

function BloodCardSelectNpcView:AddListeners()
	return
end

function BloodCardSelectNpcView:OnEnter()
	self.activityID_ = BloodCardData:GetMainActivityID()
	self.isAllNpc_ = self.params_.isAllNpc
	self.selectNpc_ = self.params_.selectNpc or BloodCardData:GetSelectNpc()

	if self.isAllNpc_ then
		self.npcList_ = BloodCardGameNPCCfg.all
		self.isEnter_ = self.params_.isEnter

		if self.isEnter_ then
			self.selectNpc_ = BloodCardData:GetUnPassNpc() or BloodCardGameNPCCfg.all[1]
		end
	else
		self.npcList_ = {
			self.selectNpc_
		}
	end

	BloodCardData:SetCacheParams(self.params_)

	if self.isAllNpc_ then
		self.modelInitPosition_ = Vector3.New(self.params_.posX, self.params_.posY, self.params_.posZ)
		self.modelInitRotation_ = Quaternion.Euler(self.params_.rotationX, self.params_.rotationY, self.params_.rotationZ)
	end

	self:RefreshUI()
	BloodCardTools.CheckCacheUnlockCard()
end

function BloodCardSelectNpcView:RefreshUI()
	self.npcHeadList_:StartScroll(#self.npcList_)
	self:SelectNpc(self.selectNpc_)
end

function BloodCardSelectNpcView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLOOD_CARD_GAME_SELECT_NPC_RULE")
end

function BloodCardSelectNpcView:OnExit()
	manager.windowBar:HideBar()

	if self.model_ then
		GameObject.Destroy(self.model_)
		Asset.Unload("CharDorm/" .. BloodCardGameNPCCfg[self.selectNpc_].model)

		self.model_ = nil
	end

	self.params_.isEnter = false
end

function BloodCardSelectNpcView:IndexNpcHeadItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.npcList_[arg_9_1])
	arg_9_2:SetClickCallBack(function(arg_10_0)
		arg_9_2:CancelRedPoint()

		if arg_10_0 == self.selectNpc_ then
			return
		end

		self:SelectNpc(arg_10_0)
	end)
	arg_9_2:RefreshState(self.selectNpc_)
end

function BloodCardSelectNpcView:SelectNpc(arg_11_1)
	self.preSelectNpc_ = self.selectNpc_
	self.selectNpc_ = arg_11_1
	self.selectIndex_ = table.indexof(self.npcList_, self.selectNpc_)

	BloodCardData:SetSelectNpc(self.selectNpc_)

	self.params_.selectNpc = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(self.npcHeadList_:GetItemList()) do
		iter_11_1:RefreshState(arg_11_1)
	end

	self:RefreshDeck()

	self.tipsText_.text = self.cfg_.desc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsTextContent_)

	if self.isAllNpc_ then
		self:LoadNpcModle()
	end
end

function BloodCardSelectNpcView:LoadNpcModle()
	if self.model_ and self.preSelectNpc_ then
		GameObject.Destroy(self.model_)
		Asset.Unload("CharDorm/" .. BloodCardGameNPCCfg[self.preSelectNpc_].model)

		self.model_ = nil
	end

	self.model_ = Object.Instantiate(Asset.Load("CharDorm/" .. BloodCardGameNPCCfg[self.selectNpc_].model))

	Dorm.LuaBridge.MiniGameBridge.PlayEffect(self.modelInitPosition_, Quaternion.Euler(0, 0, 0), Vector3(0.1, 0.1, 0.1), "Effect/tongyong/fx_appear_UI", 1)
	manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_card_turn", "")

	self.model_.transform.localPosition = self.modelInitPosition_
	self.model_.transform.localRotation = self.modelInitRotation_
end

function BloodCardSelectNpcView:RefreshDeck()
	self.cfg_ = BloodCardGameNPCCfg[self.selectNpc_]

	self.deckList_:StartScroll(#self.cfg_.stage_list)
end

function BloodCardSelectNpcView:IndexStageItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.cfg_.stage_list[arg_14_1])
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

function BloodCardSelectNpcView:Dispose()
	if self.deckList_ then
		self.deckList_:Dispose()
	end

	if self.npcHeadList_ then
		self.npcHeadList_:Dispose()
	end

	BloodCardSelectNpcView.super.Dispose(self)
end

return BloodCardSelectNpcView
