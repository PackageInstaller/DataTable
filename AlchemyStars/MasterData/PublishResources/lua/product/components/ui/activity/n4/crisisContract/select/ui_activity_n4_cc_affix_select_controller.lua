_class("UIActivityN4CCAffixSelectController", UIController)
UIActivityN4CCAffixSelectController = UIActivityN4CCAffixSelectController

function UIActivityN4CCAffixSelectController:OnShow(uiParams)
  self:InitWidget()
  self._context = uiParams[1]
  self._cfg = uiParams[2]
  self._missionId = self._cfg.CampaignMissionId
  self._selectAffix = {}
  self._curSelectNum = 0
  self._maxSelectNum = self._cfg.AffixNum
  local ids = self._context:GetAffix(self._missionId)
  if ids and 0 < #ids then
    for k, id in pairs(ids) do
      if not self._selectAffix[id] then
        self._selectAffix[id] = true
        self._curSelectNum = self._curSelectNum + 1
      end
    end
  end
  self:OnValue()
end

function UIActivityN4CCAffixSelectController:InitWidget()
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self.txtEffValue = self:GetUIComponent("UILocalizationText", "txtEffValue")
  local colPool = self:GetUIComponent("UISelectObjectPath", "cols")
  self.columns = colPool:SpawnObjects("UIActivityN4CCAffixSelectColumn", 3)
  self._guideRow1Btn = self:GetGameObject("GuideRow1Btn")
  self._guideRow1Btn:SetActive(false)
end

function UIActivityN4CCAffixSelectController:OnValue()
  local affixDataArray = {}
  local subArray = {}
  for i, v in ipairs(self._cfg.Affix) do
    if #subArray == 3 then
      subArray = {}
    end
    if #subArray == 0 then
      table.insert(affixDataArray, subArray)
    end
    table.insert(subArray, v[1])
  end
  if not affixDataArray or #affixDataArray ~= 3 then
    Log.fatal("UIActivityN4CCAffixSelectController cfg_component_challenge_mission  Affix config err : ", self._cfg.ID)
    return
  end
  self.affixItems = {}
  for i, columnItem in ipairs(self.columns) do
    local data = affixDataArray[i]
    columnItem:SetData(self.affixItems, data, function(item)
      self:OnAffixItemSelected(item)
    end)
  end
  self:_RefreshAffixItemsState()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideProcess(8114001) then
    self._guideRow1Btn:SetActive(true)
  end
  self.Lock("UIActivityN4CCAffixSelectController_Enter_Ani")
  self:StartTask(function(TT)
    for i, columnItem in ipairs(self.columns) do
      columnItem:PlayEnterAni()
      YIELD(TT, 60)
    end
    self.UnLock("UIActivityN4CCAffixSelectController_Enter_Ani")
  end)
end

function UIActivityN4CCAffixSelectController:_RefreshAffixItemsState()
  for k, affixItem in pairs(self.affixItems) do
    local affixId = affixItem:GetAffixId()
    if self._selectAffix[affixId] then
      affixItem:SetState(true, true)
    elseif self._curSelectNum >= self._maxSelectNum then
      affixItem:SetState(false, false)
    else
      local canSelect = true
      local cfgs = Cfg.cfg_component_mission_affix({AffixID = affixId})
      if cfgs and 0 < #cfgs then
        local preId = cfgs[1].LockID
        if preId and 0 < preId and not self._selectAffix[preId] then
          canSelect = false
        end
      end
      affixItem:SetState(false, canSelect)
    end
  end
  self.txtEffValue:SetText(self._curSelectNum .. "/" .. self._maxSelectNum)
end

function UIActivityN4CCAffixSelectController:OnAffixItemSelected(item)
  local isSelect, canSelect = item:GetState()
  if not canSelect then
    if self._curSelectNum >= self._maxSelectNum then
      ToastManager.ShowToast(StringTable.Get("str_crisis_contract_affix_max_limit"))
    else
      ToastManager.ShowToast(StringTable.Get("str_crisis_contract_affix_unlock_pre"))
    end
    return
  end
  local clickId = item:GetAffixId()
  local isSelect = self._selectAffix[clickId]
  if not isSelect then
    self._selectAffix[clickId] = true
    self._curSelectNum = self._curSelectNum + 1
  else
    self._selectAffix[clickId] = nil
    self._curSelectNum = self._curSelectNum - 1
    local depenList = {clickId}
    self:_RemoveDependency(depenList)
  end
  self:_RefreshAffixItemsState()
end

function UIActivityN4CCAffixSelectController:_RemoveDependency(depenList)
  local len = #depenList
  if len < 1 then
    return
  end
  local depenId = depenList[len]
  table.remove(depenList, len)
  for affixId, v in pairs(self._selectAffix) do
    local cfgs = Cfg.cfg_component_mission_affix({AffixID = affixId})
    if cfgs and 0 < #cfgs and cfgs[1].LockID == depenId then
      table.insert(depenList, affixId)
      self._selectAffix[affixId] = nil
      self._curSelectNum = self._curSelectNum - 1
    end
  end
  if 0 < #depenList then
    self:_RemoveDependency(depenList)
  end
end

function UIActivityN4CCAffixSelectController:BtnConformOnClick(go)
  local ids = {}
  for k, v in pairs(self._selectAffix) do
    table.insert(ids, k)
  end
  table.sort(ids)
  self._context:SetAffix(self._missionId, ids)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCCAffixChanged)
  self:CloseDialog()
end

function UIActivityN4CCAffixSelectController:GuideRow1BtnOnClick(go)
  local item = self.affixItems[1]
  self:OnAffixItemSelected(item)
end
