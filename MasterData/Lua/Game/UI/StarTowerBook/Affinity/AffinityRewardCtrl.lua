local BaseCtrl = require("GameCore.UI.BaseCtrl")
local AffinityRewardCtrl = class("AffinityRewardCtrl", BaseCtrl)
AffinityRewardCtrl._mapNodeConfig = {
  anit_window_01 = {sNodeName = "t_window", sComponentName = "Animator"},
  got_fullscreen_blur_black = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  svList = {
    sComponentName = "LoopScrollView"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Favour_Reward"
  }
}
AffinityRewardCtrl._mapEventConfig = {}

function AffinityRewardCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.curNpcId = tbParam[1]
  self.curNpcAffinityGroup = 0
  self.tbAffinityCfgData = {}
  self.mapGridCtrl = {}
  self.mapNPCAffinityData = PlayerData.StarTower:GetNpcAffinityData(self.curNpcId)
  local mapNpcCfgData = ConfigTable.GetData("StarTowerNPC", self.curNpcId)
  if mapNpcCfgData ~= nil then
    self.curNpcAffinityGroup = mapNpcCfgData.AffinityGroupId
  end
end

function AffinityRewardCtrl:OnEnable()
  self._mapNode.anit_window_01:Play("t_window_04_t_in")
  self._mapNode.got_fullscreen_blur_black:SetActive(true)
  
  local function forEachNpcAffinity(mapData)
    if mapData.AffinityGroupId == self.curNpcAffinityGroup and mapData.Level > 0 then
      table.insert(self.tbAffinityCfgData, mapData)
    end
  end
  
  ForEachTableLine(DataTable.NPCAffinityGroup, forEachNpcAffinity)
  
  local function sort(a, b)
    return a.Level < b.Level
  end
  
  table.sort(self.tbAffinityCfgData, sort)
  local nIdx = 1
  for i, mapData in ipairs(self.tbAffinityCfgData) do
    if self.mapNPCAffinityData.Level < mapData.Level then
      nIdx = i
      break
    end
  end
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self._mapNode.svList:Init(#self.tbAffinityCfgData, self, self.OnRefreshGrid, nil)
  if 2 <= nIdx then
    nIdx = nIdx - 2
  else
    nIdx = 0
  end
  self._mapNode.svList:SetScrollGridPos(nIdx)
end

function AffinityRewardCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self.mapGridCtrl = {}
end

function AffinityRewardCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapGridCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerBook.Affinity.AffinityRewardGridCtrl")
    self.mapGridCtrl[nInstanceId] = objCtrl
  end
  local mapCfgData = self.tbAffinityCfgData[gridIndex + 1]
  objCtrl:Refresh(mapCfgData, self.mapNPCAffinityData)
end

function AffinityRewardCtrl:OnBtn_ClickClose()
  self._mapNode.anit_window_01:Play("t_window_04_t_out")
  self._mapNode.got_fullscreen_blur_black:SetActive(false)
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
end

function AffinityRewardCtrl:OnCloseAnimFinish()
  EventManager.Hit(EventId.ClosePanel, PanelId.NpcAffinityRewardPanel)
end

return AffinityRewardCtrl
