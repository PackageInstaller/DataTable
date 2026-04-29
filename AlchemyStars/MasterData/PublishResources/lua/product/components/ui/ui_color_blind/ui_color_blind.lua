_class("UIColorBlind", UIController)
UIColorBlind = UIColorBlind

function UIColorBlind:OnShow(uiParam)
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.pool = self:GetUIComponent("UISelectObjectPath", "s")
  self.btnConfirmObj = self:GetGameObject("btnConfirm")
  self.curSelectGroup = nil
  self.selectItemId = nil
  self.selectItemIsGot = false
  self:InitGroupBtn()
  self:InitCfgData()
  self:OnSelectGroupType(self.groupType.all)
end

function UIColorBlind:InitGroupBtn()
  self.groupType = {
    all = 0,
    default = 1,
    pay = 2
  }
  self.btnObjGroup = {
    [self.groupType.default] = self:GetGameObject("DefaultButton"),
    [self.groupType.pay] = self:GetGameObject("PayButton"),
    [self.groupType.all] = self:GetGameObject("AllButton")
  }
  for type, obj in pairs(self.btnObjGroup) do
    self:AddUICustomEventListener(UICustomUIEventListener.Get(obj), UIEvent.Click, function(go)
      self:OnSelectGroupType(type)
    end)
  end
end

function UIColorBlind:InitCfgData()
  self.chessCfg = Cfg.cfg_item_chess({})
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self.curPlayerSelectItemID = UIPropertyHelper:GetInstance():GetChessItemID()
  local selectCfgFilter = Cfg.cfg_item_chess({
    ID = self.curPlayerSelectItemID
  })
  if selectCfgFilter then
    self.curPlayerSelectItem = selectCfgFilter[1]
  else
    Log.exception("[UIColorBlind] not exist this itemID", self.curPlayerSelectItem)
  end
end

function UIColorBlind:OnSelectGroupType(type)
  if self.curSelectGroup == type then
    return
  end
  self.curSelectGroup = type
  self:RefreshSpawnItems()
  for t, v in pairs(self.btnObjGroup) do
    v.transform:Find("select").gameObject:SetActive(self.curSelectGroup == t)
  end
end

function UIColorBlind:GetCfgDataFromItemID(itemId)
  for _, v in pairs(self.chessCfg) do
    if v.ID == itemId then
      return v
    end
  end
end

function UIColorBlind:RefreshSpawnItems()
  local typeChessList
  local curSelectItemInType = self.curPlayerSelectItem.type == self.curSelectGroup
  if self.curSelectGroup == self.groupType.default then
    typeChessList = Cfg.cfg_item_chess({type = 1})
  elseif self.curSelectGroup == self.groupType.pay then
    typeChessList = Cfg.cfg_item_chess({type = 2})
  else
    typeChessList = Cfg.cfg_item_chess({})
    curSelectItemInType = true
  end
  if not typeChessList then
    return
  end
  local sortChessList = {}
  for _, cv in pairs(typeChessList) do
    local v = {
      ID = cv.ID,
      type = cv.type,
      order = cv.order,
      showNoSkin = cv.showNoSkin == 1,
      acquisitionPath = cv.acquisitionPath,
      icon = cv.icon
    }
    if curSelectItemInType and v.ID == self.curPlayerSelectItemID then
      v.order = 0
    end
    local count = self.itemModule:GetItemCount(v.ID)
    if count <= 0 then
      if v.showNoSkin then
        v.notGet = true
        v.order = v.order + 10000
        table.insert(sortChessList, v)
      end
    else
      local items = self.itemModule:GetItemByTempId(v.ID)
      for _, vitem in pairs(items) do
        self.item = vitem
      end
      if self.item and self.item:IsNewOverlay() then
        v.isNew = true
      else
        v.isNew = false
      end
      table.insert(sortChessList, v)
    end
  end
  table.sort(sortChessList, function(v1, v2)
    return v1.order < v2.order
  end)
  local len = #sortChessList
  self.pool:SpawnObjects("UIColorBlindItem", len)
  self.items = self.pool:GetAllSpawnList()
  for i = 1, len do
    local cfg = sortChessList[i]
    self.items[i]:Flush(cfg, function()
      self.selectItemId = sortChessList[i].ID
      local chessItemCfgs = Cfg.cfg_item({
        ID = self.selectItemId
      })
      if chessItemCfgs then
        local chessItemCfg = chessItemCfgs[1]
        if cfg.notGet then
          self.txtDesc:SetText(StringTable.Get(cfg.acquisitionPath))
          self.selectItemIsGot = false
        else
          self.txtDesc:SetText(StringTable.Get(chessItemCfg.Intro))
          self.selectItemIsGot = true
        end
        self.btnConfirmObj:SetActive(true)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ColorBlindSelect, cfg.ID)
    end)
  end
  if curSelectItemInType then
    self.items[1]:imgOnClick()
  else
    self.txtDesc:SetText("")
    self.btnConfirmObj:SetActive(false)
  end
end

function UIColorBlind:OnHide()
end

function UIColorBlind:bgOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ColorBlindUpdate)
  self:CloseDialog()
end

function UIColorBlind:btnConfirmOnClick(go)
  if not self.selectItemIsGot then
    ToastManager.ShowToast(StringTable.Get("str_set_color_locked"))
    return
  end
  self:Lock("SetItemListUnnew_btnConfirmOnClick")
  self:StartTask(function(TT)
    self.itemModule:HandleCEventChessItem(TT, self.selectItemId)
    self:UnLock("SetItemListUnnew_btnConfirmOnClick")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ColorBlindUpdate)
    self:CloseDialog()
  end)
end
