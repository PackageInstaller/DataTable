local JointDrillBuildListCtrl = class("JointDrillBuildListCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillBuildListCtrl._mapNodeConfig = {
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  txtBuildList = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Selected_Build"
  },
  buildList = {},
  buildLSV = {
    sComponentName = "LoopScrollView"
  },
  goSelectBuildItem = {
    sComponentName = "RectTransform"
  },
  txtBuildTitle = {sComponentName = "TMP_Text"},
  goBuild = {},
  btnSelectBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectBuild"
  },
  btnDelBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DelBuild"
  },
  txtScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Score_Text"
  },
  imgBuildScore = {sComponentName = "Image"},
  charItem = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  btnStart = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtBtnStart = {sComponentName = "TMP_Text"},
  txtChallengeCount = {sComponentName = "TMP_Text"},
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Select_Tip"
  },
  goChallengeTime = {},
  txtChallengeTime = {sComponentName = "TMP_Text"}
}
JointDrillBuildListCtrl._mapEventConfig = {
  RefreshChallengeTime = "OnEvent_RefreshChallengeTime",
  RefreshJointDrillActTime = "OnEvent_RefreshJointDrillActTime"
}
JointDrillBuildListCtrl._mapRedDotConfig = {}

function JointDrillBuildListCtrl:GetJointDrillPlayerData()
  return PlayerData.JointDrill_1
end

function JointDrillBuildListCtrl:GetJointDrillBuildListPanelId()
  return JointDrillContext.GetPanelId(self:GetJointDrillPlayerData().nActId, "BuildList")
end

function JointDrillBuildListCtrl:GetJointDrillLevelSelectPanelId()
  return JointDrillContext.GetPanelId(self:GetJointDrillPlayerData().nActId, "LevelSelect")
end

function JointDrillBuildListCtrl:GetRegionBossFormationType()
  return AllEnum.RegionBossFormationType.JointDrill
end

function JointDrillBuildListCtrl:GetBuildItemCtrlPath()
  return "Game.UI.JointDrill.JointDrill_1.JointDrillBuildItemCtrl"
end

function JointDrillBuildListCtrl:GetJointDrillBuildListRaw()
  return self:GetJointDrillPlayerData():GetJointDrillBuildList()
end

function JointDrillBuildListCtrl:GetJointDrillBuildList()
  return self:GetJointDrillBuildListRaw()
end

function JointDrillBuildListCtrl:RefreshBuildList()
  self.tbBuildItemCtrl = {}
  local nAllChallengeCount = self:GetJointDrillPlayerData():GetMaxChallengeCount(self.nLevelId)
  nAllChallengeCount = math.max(4, nAllChallengeCount)
  self._mapNode.buildLSV:Init(nAllChallengeCount, self, self.OnGridRefresh)
end

function JointDrillBuildListCtrl:SetSelectBuildItem()
  local nCurSelectBuildId = self:GetJointDrillPlayerData():GetCachedBuild()
  if nCurSelectBuildId == 0 then
    self._mapNode.btnSelectBuild.gameObject:SetActive(true)
    self._mapNode.goBuild.gameObject:SetActive(false)
  else
    local function callback(mapBuildData)
      self._mapNode.btnSelectBuild.gameObject:SetActive(mapBuildData == nil)
      
      self._mapNode.goBuild.gameObject:SetActive(mapBuildData ~= nil)
      if mapBuildData ~= nil then
        for k, mapChar in ipairs(mapBuildData.tbChar) do
          self._mapNode.charItem[k]:SetChar(mapChar.nTid)
        end
        local sScore = "Icon/BuildRank/BuildRank_" .. mapBuildData.mapRank.Id
        self:SetPngSprite(self._mapNode.imgBuildScore, sScore)
      end
    end
    
    PlayerData.Build:GetBuildDetailData(callback, nCurSelectBuildId)
  end
  local nIndex = #self.tbBuildList + 1
  NovaAPI.SetTMPText(self._mapNode.txtBuildTitle, orderedFormat(ConfigTable.GetUIText("JointDrill_Build_Index"), nIndex))
end

function JointDrillBuildListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapBuild = self.tbBuildList[nIndex]
  if self.tbBuildItemCtrl[goGrid] == nil then
    local itemCtrl = self:BindCtrlByNode(goGrid, self:GetBuildItemCtrlPath())
    self.tbBuildItemCtrl[goGrid] = itemCtrl
  end
  self.tbBuildItemCtrl[goGrid]:SetItem(nIndex, mapBuild, self.nLevelId)
end

function JointDrillBuildListCtrl:SetChallengeTime(nRemainTime)
  local tbTime = timeFormat_Table(nRemainTime)
  local sTime = ""
  if tbTime.min > 0 then
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_3"), tbTime.min, tbTime.sec)
  else
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_4"), tbTime.sec)
  end
  NovaAPI.SetTMPText(self._mapNode.txtChallengeTime, orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_Left"), sTime))
end

function JointDrillBuildListCtrl:RefreshChallengeTime()
  local nStartTime = self:GetJointDrillPlayerData():GetJointDrillStartTime()
  local nCloseTime = math.floor(nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max"))
  local nCurTime = ClientManager.serverTimeStamp
  local nRemainTime = nCloseTime - nCurTime
  self:SetChallengeTime(nRemainTime)
end

function JointDrillBuildListCtrl:Awake()
end

function JointDrillBuildListCtrl:OnEnable()
  self.tbBuildItemCtrl = {}
  local tbParam = self:GetPanelParam()
  if nil ~= tbParam and nil ~= tbParam[1] then
    self.nLevelId = tbParam[1]
    self.bSimulation = tbParam[2]
  end
  self.bInBattle = self:GetJointDrillPlayerData():CheckJointDrillInBattle()
  self.tbBuildList = self:GetJointDrillBuildList()
  if not self.bInBattle then
    NovaAPI.SetTMPText(self._mapNode.txtBtnStart, ConfigTable.GetUIText("JointDrill_Btn_Start_Challenge"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnStart, ConfigTable.GetUIText("JointDrill_Btn_Continue_Challenge"))
    self:RefreshChallengeTime()
  end
  if not self.bInBattle then
    self._mapNode.animRoot:Play("JointDrillBuildList_Single_in", 0, 0)
    self._mapNode.buildList.gameObject:SetActive(false)
    self._mapNode.goSelectBuildItem.anchoredPosition = Vector2(0, 0)
  else
    self._mapNode.animRoot:Play("JointDrillBuildList_List_in", 0, 0)
    self._mapNode.buildList.gameObject:SetActive(true)
    self._mapNode.goSelectBuildItem.anchoredPosition = Vector2(310, 0)
    self:RefreshBuildList()
  end
  self:SetSelectBuildItem()
  local nChallengeCount = #self.tbBuildList
  self.nAllChallengeCount = self:GetJointDrillPlayerData():GetMaxChallengeCount(self.nLevelId)
  NovaAPI.SetTMPText(self._mapNode.txtChallengeCount, orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Count"), self.nAllChallengeCount - nChallengeCount))
  self._mapNode.goChallengeTime.gameObject:SetActive(self.bInBattle)
end

function JointDrillBuildListCtrl:OnDisable()
  for _, v in pairs(self.tbBuildItemCtrl) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbBuildItemCtrl = {}
end

function JointDrillBuildListCtrl:OnDestroy()
end

function JointDrillBuildListCtrl:OnBtnClick_SelectBuild()
  if not self:GetJointDrillPlayerData():CheckChallengeCount() then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossBuildBrief, self:GetRegionBossFormationType())
end

function JointDrillBuildListCtrl:OnBtnClick_DelBuild()
  self:GetJointDrillPlayerData():SetSelBuildId(0)
  self:SetSelectBuildItem()
end

function JointDrillBuildListCtrl:OnBtnClick_Start()
  local bInChallengeTime = self:GetJointDrillPlayerData():CheckActChallengeTime()
  if not bInChallengeTime then
    local function gameOverCallback()
      EventManager.Hit(EventId.ClosePanel, self:GetJointDrillBuildListPanelId())
    end
    
    if self.bInBattle then
      self:GetJointDrillPlayerData():JointDrillGameOver(gameOverCallback, true)
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Challenge_End_Tip"))
      gameOverCallback()
    end
    return
  end
  if not self:GetJointDrillPlayerData():CheckChallengeCount() then
    return
  end
  local nBuildId = self:GetJointDrillPlayerData():GetCachedBuild()
  if nBuildId == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_SelectBuild_Tip"))
    return
  end
  if self.bInBattle then
    local nStartTime = self:GetJointDrillPlayerData():GetJointDrillStartTime()
    local nCloseTime = math.floor(nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max"))
    if nCloseTime <= ClientManager.serverTimeStamp then
      self:GetJointDrillPlayerData():JointDrillGameOver(nil, true)
      return
    end
  end
  local nType = AllEnum.JointDrillLevelStartType.Start
  if self.bInBattle then
    nType = AllEnum.JointDrillLevelStartType.Continue
  end
  self:GetJointDrillPlayerData():EnterJointDrill(self.nLevelId, nBuildId, self.bSimulation, nType)
end

function JointDrillBuildListCtrl:OnEvent_RefreshChallengeTime(nRemainTime)
  self:SetChallengeTime(nRemainTime)
end

function JointDrillBuildListCtrl:OnEvent_RefreshJointDrillActTime(nStatus, nRemainTime)
  if nStatus == AllEnum.JointDrillActStatus.Closed then
    local function confirmCallback()
      EventManager.Hit(EventId.ClosePanel, self:GetJointDrillBuildListPanelId())
      
      EventManager.Hit(EventId.ClosePanel, self:GetJointDrillLevelSelectPanelId())
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("JointDrill_Act_End_Tip"),
      callbackConfirm = confirmCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

return JointDrillBuildListCtrl
