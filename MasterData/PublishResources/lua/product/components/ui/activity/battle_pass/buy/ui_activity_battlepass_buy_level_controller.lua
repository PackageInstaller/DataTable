_class("UIActivityBattlePassBuyLevelController", UIController)
UIActivityBattlePassBuyLevelController = UIActivityBattlePassBuyLevelController

function UIActivityBattlePassBuyLevelController:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassBuyLevelController:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassBuyLevelController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassBuyLevelController:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassBuyLevelController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end)
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtTitle2 = self:GetUIComponent("UILocalizationText", "txtTitle2")
  self._txtNum = self:GetUIComponent("UILocalizationText", "txtNum")
  self._icon = self:GetUIComponent("Image", "imgBuyBtn")
  self._txtBuyBtn = self:GetUIComponent("UILocalizationText", "txtBuyBtn")
end

function UIActivityBattlePassBuyLevelController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityBattlePassBuyLevelController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  if uiParams then
    self.callback = uiParams[1]
  end
  self:_GetComponents()
  self.saleType = RoleAssetID.RoleAssetGlow
  self._giftNum = 1
  self:_Refresh()
end

function UIActivityBattlePassBuyLevelController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassBuyLevelController:_Refresh()
  if self._isOpen then
    self:_SetTitle()
    self:_SetBuyNum()
    self:_SetBuyBtnIcon()
    self:_SetBuyBtnPrice()
    self:_SetDynamicList()
  end
end

function UIActivityBattlePassBuyLevelController:_SetTitle()
  local componentInfo = self:_GetLVRewardComponentInfo()
  local _max = componentInfo.m_max_level - componentInfo.m_current_level
  local content = StringTable.Get("str_activity_battlepass_tab_reward_buy_level_btn")
  local colorStr = "EFF9FD"
  local formatStr = "<color=#%s>%s</color>"
  local showStr = string.format(formatStr, colorStr, content)
  self._txtTitle:SetText(showStr)
  self._txtTitle2:SetText(StringTable.Get("str_activity_battlepass_buy_level_desc", componentInfo.m_current_level, componentInfo.m_current_level + self._giftNum))
end

function UIActivityBattlePassBuyLevelController:_SetBuyNum()
  self._txtNum:SetText(tostring(self._giftNum))
end

function UIActivityBattlePassBuyLevelController:_SetBuyBtnIcon()
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._icon.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.saleType))
end

function UIActivityBattlePassBuyLevelController:_SetBuyBtnPrice()
  local component = self:_GetBuyGiftComponent()
  local giftType = CampaignGiftType.ECGT_BPLEVEL
  local giftId = component:GetFirstGiftIDByType(giftType)
  local gift = Cfg.cfg_shop_common_goods[giftId]
  self._price = gift.NewPrice * self._giftNum
  self._txtBuyBtn:SetText(tostring(self._price))
end

function UIActivityBattlePassBuyLevelController:_UpdateBuyNum(n)
  local componentInfo = self:_GetLVRewardComponentInfo()
  local _max = componentInfo.m_max_level - componentInfo.m_current_level
  local _min = 1
  local next = self._giftNum + n
  next = math.max(next, _min)
  next = math.min(next, _max)
  self._giftNum = next
  self:_Refresh()
end

function UIActivityBattlePassBuyLevelController:_SetDynamicListData()
  local component = self:_GetLVRewardComponent()
  local componentInfo = self:_GetLVRewardComponentInfo()
  local rewards
  local curLv = componentInfo.m_current_level
  if componentInfo.m_unlock_advanced_reward then
    rewards = component:GetSortAdvancedRewards(curLv + 1, curLv + self._giftNum)
  else
    rewards = component:GetSortNormalRewards(curLv + 1, curLv + self._giftNum)
  end
  self._dynamicListInfo = {}
  for i = 1, #rewards do
    table.insert(self._dynamicListInfo, rewards[i])
  end
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 7
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIActivityBattlePassBuyLevelController:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._dynamicList)
  end
end

function UIActivityBattlePassBuyLevelController:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:RefreshAllShownItem()
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityBattlePassBuyLevelController:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityBattlePassItemIcon", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UIActivityBattlePassBuyLevelController:_SetListItemData(listItem, index)
  local info = self._dynamicListInfo[index]
  if info ~= nil then
    listItem:SetData(i, info, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
    end, UIItemScale.Level1)
  end
end

function UIActivityBattlePassBuyLevelController:_ShowBuyConfirm(price, giftNum)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_activity_battlepass_pay_gb_2_lv_gift", price, giftNum), function(param)
    if not ClientShop.CheckBuy(self.saleType, price) then
      return
    end
    self:_Start_HandleApplyBuyGiftReq()
  end, nil, nil, nil)
end

function UIActivityBattlePassBuyLevelController:_Start_HandleApplyBuyGiftReq()
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  local component = self:_GetBuyGiftComponent()
  local giftId = component:GetFirstGiftIDByType(CampaignGiftType.ECGT_BPLEVEL)
  component:BuyGift(giftId, self._giftNum)
end

function UIActivityBattlePassBuyLevelController:Dec10BtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  Log.info("UIActivityBattlePassBuyLevelController:Dec10BtnOnClick")
  self:_UpdateBuyNum(-10)
end

function UIActivityBattlePassBuyLevelController:DecBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  Log.info("UIActivityBattlePassBuyLevelController:DecBtnBtnOnClick")
  self:_UpdateBuyNum(-1)
end

function UIActivityBattlePassBuyLevelController:IncBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  Log.info("UIActivityBattlePassBuyLevelController:IncBtnOnClick")
  self:_UpdateBuyNum(1)
end

function UIActivityBattlePassBuyLevelController:Inc10BtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  Log.info("UIActivityBattlePassBuyLevelController:Inc10BtnOnClick")
  self:_UpdateBuyNum(10)
end

function UIActivityBattlePassBuyLevelController:BuyBtnOnClick(go)
  Log.info("UIActivityBattlePassBuyLevelController:BuyBtnOnClick")
  self:_ShowBuyConfirm(self._price, self._giftNum)
end

function UIActivityBattlePassBuyLevelController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityNormalBuyResult, self._OnNormalBuyResult)
end

function UIActivityBattlePassBuyLevelController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityNormalBuyResult, self._OnNormalBuyResult)
end

function UIActivityBattlePassBuyLevelController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityBattlePassBuyLevelController:_OnNormalBuyResult(gift_id, res)
  if self.view == nil then
    return
  end
  local component = self:_GetBuyGiftComponent()
  local giftId = component:GetFirstGiftIDByType(CampaignGiftType.ECGT_BPLEVEL)
  if giftId ~= gift_id then
    return
  end
  if res:GetSucc() then
    if self.callback then
      self.callback()
    end
    self:CloseDialog()
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
      self:_Refresh()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
end
