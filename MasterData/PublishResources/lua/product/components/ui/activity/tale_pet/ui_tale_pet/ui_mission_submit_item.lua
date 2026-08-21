_class("UIMissionSubmitItem", UIController)
UIMissionSubmitItem = UIMissionSubmitItem

function UIMissionSubmitItem:OnShow(uiParams)
  self.itemId = uiParams[1]
  self.taskDesc = uiParams[2]
  self.taskNum = uiParams[3]
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
  self:RefreshInfo()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
end

function UIMissionSubmitItem:OnHide()
end

function UIMissionSubmitItem:InitWidget()
  self.txtMission = self:GetUIComponent("UILocalizationText", "txtMission")
  self.itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self.missionNum = self:GetUIComponent("UILocalizationText", "missionNum")
  self.allNum = self:GetUIComponent("UILocalizationText", "allNum")
  self.txtCancel = self:GetUIComponent("UILocalizationText", "txtCancel")
  self.txtSubmit = self:GetUIComponent("UILocalizationText", "txtSubmit")
  self.txtSubmit:SetText(StringTable.Get("str_tale_pet_btn_submit_name"))
  self.txtCancel:SetText(StringTable.Get("str_tale_pet_btn_cancel"))
  self.infoRect = self:GetUIComponent("RectTransform", "itemIcon")
  self.itemTips = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self.tips = self.itemTips:SpawnObject("UISelectInfo")
  self.quality = self:GetUIComponent("Image", "quality")
  self.qualityGo = self:GetGameObject("quality")
end

function UIMissionSubmitItem:RefreshInfo()
  local cfg = Cfg.cfg_item({
    ID = self.itemId
  })
  if cfg == nil then
    return
  end
  self.txtMission:SetText(self.taskDesc)
  self.itemIcon:LoadImage(cfg[1].Icon)
  local itemCount = self.itemModule:GetItemCount(self.itemId)
  self.allNum:SetText(StringTable.Get("str_tale_pet_item_own", itemCount))
  if itemCount < self.taskNum then
    self.countNotEnough = true
    self.allNum.color = Color(1, 0, 0, 1)
  else
    self.countNotEnough = false
    self.allNum.color = Color(1, 1, 1, 1)
  end
  self:SetQuality(cfg[1].Color)
end

function UIMissionSubmitItem:SetQuality(quality)
  if quality <= 0 then
    self.qualityGo:SetActive(false)
    return
  end
  local qualityName = UIEnum.ItemColorFrame(quality)
  if qualityName ~= "" then
    self.qualityGo:SetActive(true)
    self.quality.sprite = self._uiCommonAtlas:GetSprite(qualityName)
  else
    self.qualityGo:SetActive(false)
  end
end

function UIMissionSubmitItem:BtnSubmitOnClick()
  if self.countNotEnough then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_submit_fail"))
  else
    self:Lock("UIMissionSubmitItem:SubmitItem")
    GameGlobal.TaskManager():StartTask(self.SubmitItem, self)
  end
end

function UIMissionSubmitItem:SubmitItem(TT)
  local itemAsset = self.itemModule:GetItemByTempId(self.itemId)
  local pstid
  for key, value in pairs(itemAsset) do
    pstid = value:GetID()
  end
  local items = {}
  local item = ItemAsset:New()
  item.assetid = pstid
  item.count = self.taskNum
  table.insert(items, item)
  local res = self.itemModule:ReqTaskSubmitItem(TT, items)
  if res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_submit_succ"))
    self:CloseDialog()
  else
    ToastManager.ShowToast(res:GetResult())
  end
  self:UnLock("UIMissionSubmitItem:SubmitItem")
end

function UIMissionSubmitItem:BtnCancelOnClick()
  self:CloseDialog()
end

function UIMissionSubmitItem:BtnInfoOnClick()
  self:ShowDialog("UIItemGetPathController", self.itemId)
end

function UIMissionSubmitItem:OnItemCountChanged()
  self:RefreshInfo()
end
