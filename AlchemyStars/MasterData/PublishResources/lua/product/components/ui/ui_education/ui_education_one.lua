_class("UIEducationOne", UIController)
UIEducationOne = UIEducationOne

function UIEducationOne:Constructor()
  self._enableEducationChanged = true
end

function UIEducationOne:LoadDataOnEnter(TT, res, uiParams)
  self._data = UIEducationMain:GetData()
  self._result = self._data:One()
  self._atlasProperty = self:GetAsset("UIEducation.spriteatlas", LoadType.SpriteAtlas)
end

function UIEducationOne:OnShow(uiParams)
  self:UIWidget()
  self:InitMainLobbyTop()
  self:CreateElements()
  self:FlushElements()
  self:CreateCost()
  self:FlushCost()
  self:InAnimation()
  self:AttachEvent(GameEventType.EducationChanged, self.OnEducationChanged)
end

function UIEducationOne:OnHide()
end

function UIEducationOne:BtnCloseOnClick(go)
  self:OutAnimation(function()
    self:CloseDialog()
  end)
end

function UIEducationOne:BtnLevelUpOnClick(go)
  local idlist = {}
  local smeltlist = {}
  local count = ElementType.ElementType_Yellow
  for k = 1, count do
    local result = self._result:OneRet(k)
    local element = self._data:Get(k)
    local cur = element:GetCurrentLuaIndex()
    local nxt = result:GetIndex()
    if cur ~= nxt then
      local dataLevel = element:GetDataLevel(result:GetIndex())
      table.insert(idlist, dataLevel:GetCfg().ID)
    end
  end
  if #idlist == 0 then
    ToastManager.ShowToast(StringTable.Get("str_education_one_nolevel_toast"))
    return
  end
  local lstRet = self._result:GetResult()
  for k, v in pairs(lstRet) do
    table.insert(smeltlist, v)
  end
  local petModule = self:GetModule(PetModule)
  self:StartSafeTask("UIEducationOne::BtnLevelUpOnClick", function(lockName, TT)
    self:Lock(lockName)
    self._enableEducationChanged = false
    local res, retMsg = petModule:HandlePropertyCultivateLv(TT, smeltlist, idlist)
    self._enableEducationChanged = true
    if res:GetSucc() and retMsg ~= nil and retMsg.ret == PET_RESULT_CODE.PET_SUCCEED then
      self:OnEducationChanged()
    else
      Log.error("UIEducationOne:BtnLevelUpOnClick(go) error ->: ", retCode, "One")
    end
    self:UnLock(lockName)
  end)
end

function UIEducationOne:OnEducationChanged()
  if not self._enableEducationChanged then
    return
  end
  self._result = self._data:One()
  self:FlushElements()
  self:CreateCost()
  self:FlushCost()
end

function UIEducationOne:UIWidget()
  self._rtLobbyTop = self:GetUIComponent("UISelectObjectPath", "rtLobbyTop")
  self._pathTopTips = self:GetUIComponent("UISelectObjectPath", "topTips")
  self._smeltLayout = self:GetUIComponent("RectTransform", "smeltLayout")
  self._smeltValue = self:GetUIComponent("UILocalizationText", "smeltValue")
  self._coinValue = self:GetUIComponent("UILocalizationText", "coinValue")
  self._elementContent = self:GetUIComponent("UISelectObjectPath", "elementContent")
  self._itemContent = self:GetUIComponent("UISelectObjectPath", "itemContent")
  self._safeArea = self:GetUIComponent("RectTransform", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIEducationOne:InitMainLobbyTop()
  self._topTipsInfo = self._pathTopTips:SpawnObject("UITopTipsContext")
  self._widgetLobbyTop = self._rtLobbyTop:SpawnObject("UIMainLobbyTopIcon")
  self._widgetLobbyTop:SetData(self._topTipsInfo)
  self._widgetLobbyTop:SetPanelShow(true, false, false)
end

function UIEducationOne:NormalizeElement(uiWidget, preferredHeight, positionY)
  local rt = uiWidget:GetGameObject().transform
  rt.pivot = Vector2(0.5, 1)
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2(0.5, 1)
  rt.anchorMax = Vector2(0.5, 1)
  rt.sizeDelta = Vector2(100, preferredHeight)
  rt.anchoredPosition = Vector2(0, -positionY)
end

function UIEducationOne:CreateElements()
  self._lstNode = {}
  local count = ElementType.ElementType_Yellow
  local lstWidgets = self._elementContent:SpawnObjects("UIEducationOneElement", count)
  for k, v in pairs(lstWidgets) do
    local uiNode = {
      uiWidget = v,
      element = self._data:Get(k)
    }
    v:GetGameObject().name = k - 1
    v:SetData(uiNode.element, self._atlasProperty)
    self._lstNode[k] = uiNode
  end
end

function UIEducationOne:FlushElements()
  local preferredHeight = 0
  for k, v in pairs(self._lstNode) do
    local result = self._result:OneRet(k)
    v.uiWidget:Flush(result)
    self:NormalizeElement(v.uiWidget, v.uiWidget:PreferredHeight(), preferredHeight)
    preferredHeight = preferredHeight + v.uiWidget:PreferredHeight()
  end
  local trContent = self._elementContent:Engine().transform
  trContent.sizeDelta = Vector2(trContent.sizeDelta.x, preferredHeight)
end

function UIEducationOne:CreateCost()
  self._costItem = {}
  self._costGold = RoleAsset:New()
  self._costAtom = RoleAsset:New()
  self._costGold.assetid = RoleAssetID.RoleAssetGold
  self._costGold.count = 0
  self._costAtom.assetid = RoleAssetID.RoleAssetAtom
  self._costAtom.count = 0
  local srcCost = self._result:GetCost()
  for k, v in pairs(srcCost) do
    if self._costGold.assetid == v.assetid then
      self._costGold.count = v.count
    elseif self._costAtom.assetid == v.assetid then
      self._costAtom.count = v.count
    else
      table.insert(self._costItem, v)
    end
  end
  table.sort(self._costItem, function(a, b)
    local cfgItemA = Cfg.cfg_item[a.assetid]
    local cfgItemB = Cfg.cfg_item[b.assetid]
    if cfgItemA.Color ~= cfgItemB.Color then
      return cfgItemA.Color > cfgItemB.Color
    else
      return a.assetid < b.assetid
    end
    return false
  end)
  local count = #self._costItem
  local widgetAssets = self._itemContent:SpawnObjects("UIAsset", count)
  for k, v in pairs(widgetAssets) do
    v:SetData(1)
    v:SetScale(0.7)
    local tipsKey = k
    local eventComponent = v:AddComponent(UIAssetComponentEvent)
    eventComponent:SetClickCallBack(function(go)
      self:ShowCostItemTips(go, tipsKey)
    end)
  end
end

function UIEducationOne:FlushCost()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local widgetAssets = self._itemContent:GetAllSpawnList()
  for k, v in pairs(self._costItem) do
    local needAsset = v
    local uiAsset = widgetAssets[k]
    local haveCount = itemModule:GetItemCount(needAsset.assetid)
    local cfgItem = Cfg.cfg_item[needAsset.assetid]
    local icon = cfgItem.Icon
    local quality = cfgItem.Color
    local text = string.format("%d/%d", haveCount, needAsset.count)
    uiAsset:SetItemData({
      showBG = true,
      icon = icon,
      text = text,
      quality = quality
    })
  end
  self._smeltLayout.gameObject:SetActive(self._costAtom.count > 0)
  self._smeltValue:SetText(self._costAtom.count)
  self._coinValue:SetText(self._costGold.count)
end

function UIEducationOne:ShowCostItemTips(go, tipsKey)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  local needAsset = self._costItem[tipsKey]
  if needAsset ~= nil then
    self:ShowDialog("UICommonItemInfo", {
      assetid = needAsset.assetid
    }, deltaPosition)
  end
end

function UIEducationOne:InAnimation()
  self._animation:Play("uieff_UIEducationOne_in")
end

function UIEducationOne:OutAnimation(cbFinish)
  self:StartSafeTask("UIEducationOne::OutAnimation", function(lockName, TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIEducationOne_out")
    YIELD(TT, 233)
    if cbFinish then
      cbFinish()
    end
    self:UnLock(lockName)
  end)
end
