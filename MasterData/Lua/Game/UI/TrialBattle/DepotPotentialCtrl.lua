local DepotPotentialCtrl = class("DepotPotentialCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local LocalData = require("GameCore.Data.LocalData")
DepotPotentialCtrl._mapNodeConfig = {
  goEmpty = {},
  PotentialCardRoot = {},
  PotentialCard = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  CharList = {},
  PotentialList = {
    nCount = 3,
    sCtrlName = "Game.UI.TrialBattle.CharPotentialListCtrl"
  },
  PotentialDepotItem = {},
  rtPotentialContent = {
    sNodeName = "PotentialContent",
    sComponentName = "RectTransform"
  },
  goSwitchFull = {},
  btnSwitchFull = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchFull"
  },
  SwitchFullOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Potential_ALL"
  },
  SwitchFullOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Potential_Has"
  },
  txtPotentialEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_PotentialEmpty"
  },
  switch_des = {},
  switch_img_bg = {
    sComponentName = "RectTransform"
  },
  switch_name = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  btnSwitch_on = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetDes"
  },
  btnSwitch_off = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetSimpleDes"
  }
}
DepotPotentialCtrl._mapEventConfig = {
  SelectDepotPotential = "OnEvent_SelectDepotPotential"
}
DepotPotentialCtrl._mapRedDotConfig = {}

function DepotPotentialCtrl:RefreshPotential(mapAllPotential, mapPotential)
  if self.bInit then
    return
  end
  self.bInit = true
  self.mapPotential = {}
  self.mapAllPotential = {}
  self.nSelectId = nil
  for k, v in ipairs(mapAllPotential) do
    local nCharId = v.nCharId
    local tbDepotPotential = mapPotential[nCharId] or {}
    for nId, nLevel in pairs(tbDepotPotential) do
      self.mapPotential[nId] = {nLevel = nLevel}
    end
    local tbPotentialAdd = self._panel.mapPotentialAddLevel[nCharId]
    local tbSortList = {}
    for style, tb in ipairs(v.tbPotential) do
      tbSortList[style] = {}
      for _, v in ipairs(v.tbPotential[style]) do
        local nUnlock = tbDepotPotential[v.nId] ~= nil and 1 or 0
        local nAddCount = tbPotentialAdd[v.nId] and tbPotentialAdd[v.nId] or 0
        local nLevel = tbDepotPotential[v.nId] or 0
        if nLevel == 0 then
          nAddCount = 0
        end
        local itemCfg = ConfigTable.GetData_Item(v.nId)
        if itemCfg == nil then
          return
        end
        local nSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential and 1 or 0
        table.insert(tbSortList[style], {
          nId = v.nId,
          nLevel = nLevel,
          nPotentialAdd = nAddCount,
          nAllLevel = nLevel + nAddCount,
          nSpecial = nSpecial,
          nRarity = itemCfg.Rarity,
          nUnlock = nUnlock
        })
      end
      table.sort(tbSortList[style], function(a, b)
        if a.nUnlock == b.nUnlock then
          if a.nSpecial == b.nSpecial then
            if a.nRarity == b.nRarity then
              if a.nAllLevel == b.nAllLevel then
                return a.nId < b.nId
              end
              return a.nAllLevel > b.nAllLevel
            end
            return a.nRarity < b.nRarity
          end
          return a.nSpecial > b.nSpecial
        end
        return a.nUnlock > b.nUnlock
      end)
      if self.nSelectId == nil then
        self.nSelectId = tbSortList[1][1].nId
      end
      table.insert(self.mapAllPotential, {
        nCharId = nCharId,
        tbPotential = tbSortList[style]
      })
    end
    self._mapNode.PotentialList[k]:RefreshPotential(nCharId, tbSortList, self.bPotentialAll, self._mapNode.PotentialDepotItem, k == 1)
  end
  self:SwitchPotentialAll()
  EventManager.Hit("SelectDepotPotential", self.nSelectId)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtPotentialContent)
  end
  
  cs_coroutine.start(wait)
  self:InitSwitch()
end

function DepotPotentialCtrl:SwitchPotentialAll()
  self._mapNode.btnSwitchFull[1].gameObject:SetActive(not self.bPotentialAll)
  self._mapNode.btnSwitchFull[2].gameObject:SetActive(self.bPotentialAll)
  self._mapNode.rtPotentialContent.anchoredPosition = Vector2(0, 0)
  for k, v in ipairs(self._mapNode.PotentialList) do
    v:SwitchPotentialAll(self.bPotentialAll)
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtPotentialContent)
  local bEmpty = false
  if not self.bPotentialAll then
    bEmpty = true
    for _, v in pairs(self.mapPotential) do
      bEmpty = bEmpty and 0 >= v.nLevel
    end
  end
  self._mapNode.goEmpty.gameObject:SetActive(bEmpty)
  self._mapNode.CharList.gameObject:SetActive(not bEmpty)
  self._mapNode.PotentialCardRoot.gameObject:SetActive(not bEmpty)
  self._mapNode.switch_des:SetActive(not bEmpty)
  if not self.bPotentialAll then
    self._mapNode.PotentialCard.gameObject:SetActive(self.nSelectId ~= nil and self.mapPotential[self.nSelectId] ~= nil)
    if self.mapPotential[self.nSelectId] == nil then
      self.nSelectId = nil
      for _, v in ipairs(self.mapAllPotential) do
        for _, data in ipairs(v.tbPotential) do
          if 0 < data.nLevel then
            self.nSelectId = data.nId
            EventManager.Hit("SelectDepotPotential", self.nSelectId)
            return
          end
        end
      end
    end
  end
  if nil == self.nSelectId then
    if next(self.mapAllPotential) and next(self.mapAllPotential[1].tbPotential) then
      self.nSelectId = self.mapAllPotential[1].tbPotential[1].nId
      EventManager.Hit("SelectDepotPotential", self.nSelectId)
    else
      self._mapNode.PotentialCardRoot.gameObject:SetActive(false)
    end
  end
end

function DepotPotentialCtrl:InitSwitch()
  local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  self._mapNode.btnSwitch_on.gameObject:SetActive(bSimple)
  self._mapNode.btnSwitch_off.gameObject:SetActive(not bSimple)
end

function DepotPotentialCtrl:Clear()
  self.bInit = false
  self.nSelectId = nil
  self._mapNode.PotentialDepotItem.gameObject:SetActive(false)
  self._mapNode.PotentialCard.gameObject:SetActive(false)
end

function DepotPotentialCtrl:Awake()
  self.bInit = false
  self.bPotentialAll = true
  local bPa = LocalData.GetPlayerLocalData("PotentialAllSwitch")
  if nil ~= bPa then
    self.bPotentialAll = bPa
  end
  self.nSelectId = nil
  self._mapNode.PotentialDepotItem.gameObject:SetActive(false)
  self._mapNode.PotentialCard.gameObject:SetActive(false)
end

function DepotPotentialCtrl:OnEnable()
end

function DepotPotentialCtrl:OnDisable()
end

function DepotPotentialCtrl:OnDestroy()
end

function DepotPotentialCtrl:OnRelease()
end

function DepotPotentialCtrl:OnBtnClick_SetSimpleDes(...)
  PlayerData.StarTower:SetPotentialDescSimple(true)
  EventManager.Hit("SelectDepotPotential", self.nSelectId)
  self._mapNode.btnSwitch_on.gameObject:SetActive(true)
  self._mapNode.btnSwitch_off.gameObject:SetActive(false)
end

function DepotPotentialCtrl:OnBtnClick_SetDes(...)
  PlayerData.StarTower:SetPotentialDescSimple(false)
  EventManager.Hit("SelectDepotPotential", self.nSelectId)
  self._mapNode.btnSwitch_on.gameObject:SetActive(false)
  self._mapNode.btnSwitch_off.gameObject:SetActive(true)
end

function DepotPotentialCtrl:OnBtnClick_SwitchFull()
  self.bPotentialAll = not self.bPotentialAll
  LocalData.SetPlayerLocalData("PotentialAllSwitch", self.bPotentialAll)
  self:SwitchPotentialAll()
end

function DepotPotentialCtrl:OnEvent_SelectDepotPotential(nPotentialId)
  self._mapNode.PotentialCard.gameObject:SetActive(true)
  local nLevel = 0
  if nil ~= self.mapPotential[nPotentialId] then
    nLevel = self.mapPotential[nPotentialId].nLevel or 0
  end
  nLevel = nLevel == 0 and 1 or nLevel
  self.nSelectId = nPotentialId
  local potentialCfg = ConfigTable.GetData("Potential", nPotentialId)
  if nil ~= potentialCfg then
    local nCharId = potentialCfg.CharId
    local nPotentialAddLv = self._panel.mapPotentialAddLevel[nCharId][nPotentialId] or 0
    local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
    self._mapNode.PotentialCard:SetPotentialItem(nPotentialId, nLevel, nil, bSimple, nil, nPotentialAddLv, AllEnum.PotentialCardType.StarTower)
    self._mapNode.PotentialCard:ChangeWordRaycast(true)
  end
end

return DepotPotentialCtrl
