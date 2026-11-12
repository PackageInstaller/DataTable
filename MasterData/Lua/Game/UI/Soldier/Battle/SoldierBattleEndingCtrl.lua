local SoldierBattleEndingCtrl = class("SoldierBattleEndingCtrl", BaseCtrl)
SoldierBattleEndingCtrl._mapNodeConfig = {
  ImagePicture = {sComponentName = "Image"},
  TextTitle = {sComponentName = "TMP_Text"},
  TextContent = {sComponentName = "TMP_Text"},
  btnClick = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Click"
  },
  TMP_Click = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BattleEnding_Continue"
  }
}
SoldierBattleEndingCtrl._mapEventConfig = {}
SoldierBattleEndingCtrl._mapRedDotConfig = {}

function SoldierBattleEndingCtrl:Awake()
end

function SoldierBattleEndingCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) ~= "table" then
    return
  end
  self.nEndingId = tbParam[1]
  self.callback = tbParam[2]
  self:Refresh()
end

function SoldierBattleEndingCtrl:Refresh()
  local mapCfg = ConfigTable.GetData("SoldierEndingPlan", self.nEndingId)
  if mapCfg == nil then
    return
  end
  self.mapCfg = mapCfg
  local sIcon
  if mapCfg.IsBossCG then
    local sGenderSurfix = PlayerData.Base:GetPlayerSex() and "_MP" or "_FP"
    sIcon = mapCfg.BossCG .. sGenderSurfix
  else
    sIcon = mapCfg.CG
  end
  self:SetPngSprite(self._mapNode.ImagePicture, sIcon)
  self._mapNode.TextTitle.text = mapCfg.EndingTitle
  self._mapNode.TextContent.text = mapCfg.Desc
end

function SoldierBattleEndingCtrl:ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBattleEnding)
end

function SoldierBattleEndingCtrl:OnBtnClick_Click()
  local sAvgId = self.mapCfg and self.mapCfg.AVGId
  if sAvgId == nil or sAvgId == "" or sAvgId == "0" then
    self:ClosePanel()
    return
  end
  
  local function avgEndCallback()
    EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
    self:ClosePanel()
  end
  
  local mapData = {
    nType = AllEnum.StoryAvgType.Plot,
    sAvgId = sAvgId,
    nNodeId = nil,
    callback = avgEndCallback
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.PureAvgStory, mapData)
end

function SoldierBattleEndingCtrl:OnDisable()
  if self.callback ~= nil then
    self.callback()
    self.callback = nil
  end
end

function SoldierBattleEndingCtrl:OnDestroy()
end

return SoldierBattleEndingCtrl
