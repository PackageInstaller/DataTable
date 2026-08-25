local FreeChoiceChestPanel, Super = System.NewClass("FreeChoiceChestPanel", UIBasePanel)
FreeChoiceChestPanel.uiResCls = UI_Events_Popup_OptionalResource

function FreeChoiceChestPanel:ctor(chestItemTid, confirmCallback, isPreview)
  Super.ctor(self)
  self.chestItemTid = chestItemTid
  self.confirmCallback = confirmCallback
  self.isPreview = isPreview or false
end

function FreeChoiceChestPanel:OnBind(binder)
  self.chestModel = binder:createModel(FreeChoiceChestModel, self.chestItemTid)
  self.binder = binder
  DataCenter.itemData.IsRewardRandom = 0
  if self.ui.Btn_Details then
    self.ui.Btn_Details:SetActive(false)
  end
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  self.ui.Group_Tips_Left:SetActive(not self.isPreview)
  self.ui.Group_Tips_Middle:SetActive(self.isPreview)
  if self.isPreview then
    if self.chestModel.isAwakerChest then
      binder:SetText(self.ui.Text_Title, LT.Text("AwakerPreviewTitle"))
      binder:SetText(self.ui.Text_Tips_Middle, LT.Text("AwakerSelectPreviewDetailTips"))
    elseif self.chestModel.isWeaponChest then
      binder:SetText(self.ui.Text_Title, LT.Text("WeaponPreviewTitle"))
      binder:SetText(self.ui.Text_Tips_Middle, LT.Text("WeaponSelectPreviewDetailTips"))
    else
      binder:SetText(self.ui.Text_Title, LT.Text("AwakerChipChestPreviewTitle"))
      binder:SetText(self.ui.Text_Tips_Middle, LT.Text("AwakerSelectPreviewDetailTips"))
    end
  elseif self.chestModel.isAwakerChest then
    binder:SetText(self.ui.Text_Title, LT.Text("AwakerSelectTitle"))
    binder:SetText(self.ui.Text_Tips_Left, LT.Text("AwakerSelectUseDetailTips"))
  elseif self.chestModel.isWeaponChest then
    binder:SetText(self.ui.Text_Title, LT.Text("WeaponSelectTitle"))
    binder:SetText(self.ui.Text_Tips_Left, LT.Text("WeaponSelectUseDetailTips"))
  else
    binder:SetText(self.ui.Text_Title, LT.Text("AwakerChipSelectTitle"))
    binder:SetText(self.ui.Text_Tips_Left, LT.Text("AwakerSelectUseDetailTips"))
  end
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return self.chestModel.itemInfos
  end, function(itemBinder, obj, idx)
    local itemInfo = self.chestModel.itemInfos[idx]
    itemBinder:BindComponent(FreeChoiceChestItem(obj, self.chestModel, itemInfo, idx, self.isPreview))
  end)
  self.ui.Btn_Receive:SetActive(not self.isPreview)
  if self.ui.Btn_Receive then
    binder:BindZ1Button(self.ui.Btn_Receive, function()
      local itemInfo = self.chestModel.itemInfos[self.chestModel.currSelectedIdx]
      if not itemInfo then
        Alert.Show(10650)
        return
      end
      local itemCfg = DT.Item[itemInfo.tid]
      local tipCfg = DT.TipsType[20107]
      local title = LT.Text(tipCfg.Title)
      local desc = LT.Textf(tipCfg.Desc, LT.Text(itemCfg.Name))
      local extraParams = {
        pickItems = {
          [self.chestItemTid] = {
            choose = itemInfo.tid
          }
        }
      }
      Alert.Show(20107, nil, function()
        if itemInfo.itemType == CommonDefine.ItemType.AwakerItem then
          local function _OnChooseAwaker(svrData)
            self:_OnUseItemSuccessful()
          end
          
          if itemInfo.maxPotency then
            local tipsId = 20097
            local awakerTid = itemInfo.awakerTid
            local normalAwakerList = DT.GetOriginalConstant("NonLimitedAwakerList")
            if not table.contains(normalAwakerList, awakerTid) then
              tipsId = "LimitAwakerEnlightenmentOverflowTips"
            end
            Alert.Show(tipsId, nil, function()
              if self.confirmCallback then
                self.confirmCallback(extraParams, _OnChooseAwaker)
                return
              end
              self.chestModel:RequestChooseItem(_OnChooseAwaker)
            end)
          else
            if self.confirmCallback then
              self.confirmCallback(extraParams, _OnChooseAwaker)
              return
            end
            self.chestModel:RequestChooseItem(_OnChooseAwaker)
          end
        elseif itemInfo.itemType == CommonDefine.ItemType.Weapon then
          local function _OnChooseWeapon(svrData)
            self:_OnUseItemSuccessful()
          end
          
          if self.confirmCallback then
            self.confirmCallback(extraParams, _OnChooseWeapon)
            return
          end
          self.chestModel:RequestChooseItem(_OnChooseWeapon)
        else
          local function _ClosePanel()
            self:_OnUseItemSuccessful()
          end
          
          if not self.confirmCallback then
            self.chestModel:RequestChooseItem(_ClosePanel)
          else
            self.confirmCallback(extraParams, _ClosePanel)
          end
        end
      end, title, desc)
    end, nil, function()
      do return LT.Text end
      return LT.Text, "CommonReceive"
    end)
  end
end

function FreeChoiceChestPanel:_OnUseItemSuccessful()
  self.CloseByTimer = true
  self.binder:BindTimer(1, 0, nil, function()
    self:Close()
  end)
end

function FreeChoiceChestPanel:Close()
  if not self.CloseByTimer then
    DataCenter.itemData.IsRewardRandom = nil
  end
  Super.Close(self)
end

return FreeChoiceChestPanel
