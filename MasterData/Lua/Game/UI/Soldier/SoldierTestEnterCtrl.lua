local SoldierTestEnterCtrl = class("SoldierTestEnterCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
SoldierTestEnterCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  chessId = {
    nCount = 9,
    sComponentName = "Dropdown",
    callback = "OnDropDownChanged_Chess"
  },
  chessLv = {
    nCount = 9,
    sComponentName = "Dropdown",
    callback = "OnDropDownChanged_Chess"
  },
  btnAttr = {
    nCount = 9,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Attr"
  },
  txtCharPartner = {nCount = 9, sComponentName = "TMP_Text"},
  goPartner = {},
  goAttr = {},
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  goAttrList = {},
  txtAttrTitle = {sComponentName = "TMP_Text"},
  tc_property = {},
  goPartnerItem = {},
  PartnerLayouts = {},
  btnTechnology = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tech"
  },
  btnEnterSoldier = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnterSoldier"
  }
}
SoldierTestEnterCtrl._mapEventConfig = {}
SoldierTestEnterCtrl._mapRedDotConfig = {}

local function _SortPartner(a, b)
  local aActive = 0 < (a.mapData.nActiveLevel or 0)
  local bActive = 0 < (b.mapData.nActiveLevel or 0)
  if aActive ~= bActive then
    return aActive
  end
  local aNum = a.mapData.nCurNum or 0
  local bNum = b.mapData.nCurNum or 0
  if aNum ~= bNum then
    return aNum > bNum
  end
  return a.nType < b.nType
end

function SoldierTestEnterCtrl:RefreshChess()
  self._tbDeployedChess = {}
  local tbIdUsed = {}
  for i = 1, 9 do
    local nIdIndex = NovaAPI.GetDropDownValue(self._mapNode.chessId[i])
    local nId = self.tbChessIdList[nIdIndex + 1] or 0
    if nId ~= 0 then
      local mapCfg = ConfigTable.GetData("SoldierCharacter", nId)
      if mapCfg == nil then
        printError(string.format("格子 %s 棋子Id错误！！！", i))
        return false
      end
      if tbIdUsed[nId] then
        EventManager.Hit(EventId.OpenMessageBox, "不能选择重复棋子")
        return false
      end
      tbIdUsed[nId] = true
    end
    local nLvIndex = NovaAPI.GetDropDownValue(self._mapNode.chessLv[i])
    local nLevel = nLvIndex + 1
    nLevel = math.min(nLevel, 3)
    local nPositionType = i <= 3 and GameEnum.SoldierPositionType.FightPosition or GameEnum.SoldierPositionType.SupportPosition
    local nIndex = i <= 3 and i or i - 3
    table.insert(self._tbDeployedChess, {
      nPositionType = nPositionType,
      nIndex = nIndex,
      nId = nId,
      nStar = nLevel
    })
  end
  return true
end

function SoldierTestEnterCtrl:InitChessDropdowns()
  self.tbChessIdList = {0}
  local tbIds = {}
  
  local function foreachTable(line)
    table.insert(tbIds, line.Id)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierCharacter"), foreachTable)
  for _, nId in ipairs(tbIds) do
    table.insert(self.tbChessIdList, nId)
  end
  local ListString = CS.System.Collections.Generic.List(CS.System.String)
  local listChessId = ListString()
  listChessId:Add("无")
  for _, nId in ipairs(tbIds) do
    local mapCfg = ConfigTable.GetData("SoldierCharacter", nId)
    local sName = mapCfg ~= nil and mapCfg.Name or ""
    listChessId:Add(string.format("%s - %s", nId, sName))
  end
  local listChessLv = ListString()
  listChessLv:Add("1")
  listChessLv:Add("2")
  listChessLv:Add("3")
  for i = 1, 9 do
    NovaAPI.ClearDropDownOptions(self._mapNode.chessId[i])
    NovaAPI.DropDownAddOptions(self._mapNode.chessId[i], listChessId)
    NovaAPI.SetDDValueWithoutNotify(self._mapNode.chessId[i], 0)
    NovaAPI.ClearDropDownOptions(self._mapNode.chessLv[i])
    NovaAPI.DropDownAddOptions(self._mapNode.chessLv[i], listChessLv)
    NovaAPI.SetDDValueWithoutNotify(self._mapNode.chessLv[i], 0)
  end
end

function SoldierTestEnterCtrl:RefreshCharPartner()
  for i = 1, 9 do
    local chess = self._tbDeployedChess[i]
    local sText = ""
    if chess and chess.nId and chess.nId ~= 0 then
      local tbPartnerTypes = SoldierAttrData.GetPartnerGroupsByChessId(chess.nId)
      if tbPartnerTypes then
        local tbNames = {}
        for _, nType in ipairs(tbPartnerTypes) do
          local mapCfg = CacheTable.GetData("_SoldierPartnerGroup", nType)
          if mapCfg and mapCfg.Name then
            table.insert(tbNames, mapCfg.Name)
          end
        end
        sText = table.concat(tbNames, "/")
      end
    end
    NovaAPI.SetTMPText(self._mapNode.txtCharPartner[i], sText)
  end
end

function SoldierTestEnterCtrl:RefreshPartner()
  local tbActivePartner, tbUIData = SoldierAttrData.CalcActivePartners(self._tbDeployedChess)
  self.tbPartner = tbActivePartner
  local tbSorted = {}
  if tbUIData ~= nil then
    for _, mapData in pairs(tbUIData) do
      table.insert(tbSorted, {
        nType = mapData.nType,
        mapData = mapData
      })
    end
    table.sort(tbSorted, _SortPartner)
  end
  self:_RefreshPartnerItems(tbSorted)
end

function SoldierTestEnterCtrl:_RefreshPartnerItems(tbSorted)
  self:_ClearPartnerItems()
  local tmpl = self._mapNode.goPartnerItem
  local layout = self._mapNode.PartnerLayouts
  if tmpl == nil or layout == nil then
    return
  end
  if tbSorted == nil or #tbSorted == 0 then
    return
  end
  local trParent = layout.transform
  for _, info in ipairs(tbSorted) do
    local goItem = instantiate(tmpl, trParent)
    goItem:SetActive(true)
    self:_SetupPartnerItem(goItem, info)
    table.insert(self._tbPartnerItemGo, goItem)
  end
end

function SoldierTestEnterCtrl:_SetupPartnerItem(goItem, info)
  local trItem = goItem.transform
  local nType = info.nType
  local mapData = info.mapData or {}
  local trName = trItem:Find("btnPartnerItem/AnimRoot/txtPartnerName")
  if trName ~= nil then
    local mapCfg = CacheTable.GetData("_SoldierPartnerGroup", nType)
    local sName = mapCfg and mapCfg.Name or ""
    NovaAPI.SetTMPText(trName:GetComponent("TMP_Text"), sName)
  end
  local trLevel = trItem:Find("btnPartnerItem/AnimRoot/txtPartnerLevel")
  if trLevel ~= nil then
    local nActiveLevel = mapData.nActiveLevel or 0
    local nLevelCount = #(mapData.tbNumList or {})
    local sLevel = ""
    for j = 1, nLevelCount do
      local sPart = j == nActiveLevel and string.format("<color=#D85054>%d</color>", j) or tostring(j)
      sLevel = j == 1 and sPart or sLevel .. "/" .. sPart
    end
    NovaAPI.SetTMPText(trLevel:GetComponent("TMP_Text"), sLevel)
  end
  local trBtn = trItem:Find("btnPartnerItem")
  if trBtn ~= nil then
    local btn = trBtn:GetComponent("UIButton") or trBtn:GetComponent("Button")
    if btn ~= nil then
      btn.onClick:RemoveAllListeners()
      btn.onClick:AddListener(function()
        self:OnPartnerItemClicked(trItem, mapData)
      end)
    end
  end
end

function SoldierTestEnterCtrl:_ClearPartnerItems()
  if self._tbPartnerItemGo == nil then
    self._tbPartnerItemGo = {}
    return
  end
  for _, goItem in ipairs(self._tbPartnerItemGo) do
    destroy(goItem)
  end
  self._tbPartnerItemGo = {}
end

function SoldierTestEnterCtrl:OnPartnerItemClicked(trItem, partnerData)
  if partnerData == nil then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, trItem, partnerData.nType, partnerData.nActiveLevel, false)
end

function SoldierTestEnterCtrl:Awake()
  self._mapNode.goPartner.gameObject:SetActive(true)
  self._mapNode.goAttr.gameObject:SetActive(true)
  self._mapNode.tc_property.gameObject:SetActive(false)
  if self._mapNode.goPartnerItem ~= nil then
    self._mapNode.goPartnerItem:SetActive(false)
  end
  self._tbPartnerItemGo = {}
end

function SoldierTestEnterCtrl:OnEnable()
  PlayerData.SoldierData:SetCurSelectSeasonId(1)
  PlayerData.SoldierData:SendSoldierTechDetailReq()
  self._tbDeployedChess = {}
  self.tbPartner = {}
  self:InitChessDropdowns()
end

function SoldierTestEnterCtrl:OnDisable()
  self:_ClearPartnerItems()
end

function SoldierTestEnterCtrl:OnDestroy()
  self:_ClearPartnerItems()
end

function SoldierTestEnterCtrl:OnBtnClick_Confirm()
  if #self._tbDeployedChess > 0 then
    PlayerData.SoldierData:GMEnterSoldier(self._tbDeployedChess, 0, 1, 10101, 10101)
  end
end

function SoldierTestEnterCtrl:OnBtnClick_Tech()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierTechPanel)
end

function SoldierTestEnterCtrl:OnBtnClick_EnterSoldier()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierMainViewPanel)
end

function SoldierTestEnterCtrl:OnDropDownChanged_Chess(objComp, nIndex)
  if nIndex ~= nil and self._mapNode.chessId and self._mapNode.chessId[nIndex] == objComp then
    local nIdIndex = NovaAPI.GetDropDownValue(objComp)
    local nId = self.tbChessIdList[nIdIndex + 1] or 0
    if nId ~= 0 then
      for i = 1, 9 do
        if i ~= nIndex then
          local nOtherIdx = NovaAPI.GetDropDownValue(self._mapNode.chessId[i])
          local nOtherId = self.tbChessIdList[nOtherIdx + 1] or 0
          if nOtherId == nId then
            EventManager.Hit(EventId.OpenMessageBox, "不能选择重复棋子")
            NovaAPI.SetDDValueWithoutNotify(objComp, 0)
            break
          end
        end
      end
    end
  end
  if self:RefreshChess() then
    self:RefreshCharPartner()
    self:RefreshPartner()
  end
end

function SoldierTestEnterCtrl:OnBtnClick_Attr(btn, nIndex)
  if not self:RefreshChess() then
    return
  end
  local chessData = self._tbDeployedChess[nIndex]
  if chessData == nil or chessData.nId == 0 then
    EventManager.Hit(EventId.OpenMessageBox, "该格子未选择棋子")
    return
  end
  self:RefreshPartner()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, btn.gameObject, chessData, self._tbDeployedChess, self.tbPartner)
end

function SoldierTestEnterCtrl:ShowAttr(chessData, attrList)
  local mapCfg = ConfigTable.GetData("SoldierCharacter", chessData.nId)
  local sName = mapCfg ~= nil and mapCfg.Name or tostring(chessData.nId)
  local sTitle = string.format("<color=#43A9F1>%s</color> (%d★)", sName, chessData.nStar)
  NovaAPI.SetTMPText(self._mapNode.txtAttrTitle, sTitle)
  delChildren(self._mapNode.goAttrList)
  if attrList == nil then
    return
  end
  for _, v in ipairs(attrList) do
    local goItem = instantiate(self._mapNode.tc_property, self._mapNode.goAttrList.transform)
    goItem:SetActive(true)
    local ctrlItem = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplatePropertyCtrl")
    ctrlItem:SetSoldierAttr(v)
  end
end

return SoldierTestEnterCtrl
