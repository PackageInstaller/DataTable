local TraceHuntHandBookCtrl = class("TraceHuntHandBookCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
TraceHuntHandBookCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  sv = {
    sComponentName = "LoopScrollView"
  }
}
TraceHuntHandBookCtrl._mapEventConfig = {}

function TraceHuntHandBookCtrl:RefreshContent()
  self:RefreshData()
  self:RefreshList()
end

function TraceHuntHandBookCtrl:RefreshData()
  local tbCollection, tbBossList = PlayerData.TraceHunt:GetBossCollection()
  self.nBossCount = #tbBossList
  if self.nBossCount == 0 then
    return
  end
  self.tbBoss = {}
  for i = 1, self.nBossCount do
    local nBossId = tbBossList[i]
    local mapBossData = tbCollection[nBossId]
    local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", nBossId)
    self.tbBoss[i] = {
      nId = tbBossList[i],
      bFind = false,
      bSp = false,
      nCompleteHuntCount = 0,
      nAssistHuntCount = 0
    }
    if mapBossData then
      self.tbBoss[i].bFind = true
      self.tbBoss[i].nCompleteHuntCount = mapBossData.nCompleteHuntCount
      self.tbBoss[i].nAssistHuntCount = mapBossData.nAssistHuntCount
    end
    if mapBossCfg then
      self.tbBoss[i].bSp = mapBossCfg.IsSpecial
    end
  end
end

function TraceHuntHandBookCtrl:RefreshList()
  self._mapNode.sv.gameObject:SetActive(self.nBossCount > 0)
  if self.nBossCount > 0 then
    self._mapNode.sv:SetAnim(0.04)
    self._mapNode.sv:Init(self.nBossCount, self, self.OnGridRefresh)
  end
end

function TraceHuntHandBookCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbBoss[nIndex]
  local txtName = goGrid.transform:Find("btnGrid/AnimRoot/txtName"):GetComponent("TMP_Text")
  local imgIcon = goGrid.transform:Find("btnGrid/AnimRoot/imgIcon"):GetComponent("Image")
  local imgIconGray = goGrid.transform:Find("btnGrid/AnimRoot/imgIconGray"):GetComponent("Image")
  local goActivity = goGrid.transform:Find("btnGrid/AnimRoot/goActivity").gameObject
  local txtActivity = goGrid.transform:Find("btnGrid/AnimRoot/goActivity/txtActivity"):GetComponent("TMP_Text")
  local goOn = goGrid.transform:Find("btnGrid/AnimRoot/goOn").gameObject
  local goOff = goGrid.transform:Find("btnGrid/AnimRoot/goOff").gameObject
  local txtCompleteTitle = goGrid.transform:Find("btnGrid/AnimRoot/goOn/txtCompleteTitle"):GetComponent("TMP_Text")
  local txtHelpTitle = goGrid.transform:Find("btnGrid/AnimRoot/goOn/txtHelpTitle"):GetComponent("TMP_Text")
  local txtCompleteCount = goGrid.transform:Find("btnGrid/AnimRoot/goOn/txtCompleteCount"):GetComponent("TMP_Text")
  local txtHelpCount = goGrid.transform:Find("btnGrid/AnimRoot/goOn/txtHelpCount"):GetComponent("TMP_Text")
  local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", mapData.nId)
  if mapData.bFind and mapBossCfg then
    local mData = ConfigTable.GetData("Monster", mapBossCfg.MonsterId)
    local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
    local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
    NovaAPI.SetTMPText(txtName, mManual.Name)
  else
    NovaAPI.SetTMPText(txtName, ConfigTable.GetUIText("TraceHunt_HandBook_DefaultName"))
  end
  if mapBossCfg then
    self:SetPngSprite(imgIcon, mapBossCfg.ProfileIcon)
    self:SetPngSprite(imgIconGray, mapBossCfg.ProfileIcon)
  end
  goActivity:SetActive(mapData.bSp)
  NovaAPI.SetTMPText(txtActivity, ConfigTable.GetUIText("TraceHunt_HandBook_Activity"))
  NovaAPI.SetTMPText(txtCompleteTitle, ConfigTable.GetUIText("TraceHunt_HandBook_CompleteTitle"))
  NovaAPI.SetTMPText(txtCompleteCount, mapData.nCompleteHuntCount)
  NovaAPI.SetTMPText(txtHelpTitle, ConfigTable.GetUIText("TraceHunt_HandBook_HelpTitle"))
  NovaAPI.SetTMPText(txtHelpCount, mapData.nAssistHuntCount)
  imgIcon.gameObject:SetActive(mapData.bFind)
  imgIconGray.gameObject:SetActive(not mapData.bFind)
  goOn:SetActive(mapData.bFind)
  goOff:SetActive(not mapData.bFind)
end

function TraceHuntHandBookCtrl:FadeIn()
end

function TraceHuntHandBookCtrl:Awake()
end

function TraceHuntHandBookCtrl:OnEnable()
  self:RefreshContent()
end

function TraceHuntHandBookCtrl:OnDisable()
end

function TraceHuntHandBookCtrl:OnDestroy()
end

function TraceHuntHandBookCtrl:OnEvent_Select()
end

return TraceHuntHandBookCtrl
