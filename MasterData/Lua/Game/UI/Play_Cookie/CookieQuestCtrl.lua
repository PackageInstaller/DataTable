local CookieQuestCtrl = class("CookieQuestCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
CookieQuestCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goBlur = {},
  tog = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnTog = {
    sNodeName = "tog",
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTab"
  },
  svQuest = {
    sComponentName = "LoopScrollView"
  },
  btnClaimAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClaimAll"
  },
  btnClaimAllGray = {},
  txtClaimAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  },
  txtClaimAllGary = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  }
}
CookieQuestCtrl._mapEventConfig = {
  CookieQuestUpdate = "OnEvent_CookieQuestUpdate",
  CookieLevelUpdate = "OnEvent_CookieLevelUpdate"
}
local tbModeTextKey = {
  "Cookie_Act_DailyMode",
  "Cookie_Act_NightmareMode"
}

function CookieQuestCtrl:Refresh()
  for i = 1, #self._mapNode.tog do
    self._mapNode.tog[i]:SetText(ConfigTable.GetUIText(tbModeTextKey[i]))
    self._mapNode.tog[i]:SetDefault(i == self.nCurSeletedTab)
  end
  if self.tbQuestGridCtrl ~= nil then
    for k, v in pairs(self.tbQuestGridCtrl) do
      if v ~= nil then
        self:UnbindCtrlByNode(v)
        self.tbQuestGridCtrl[k] = nil
      end
    end
  end
  self.tbDailyQuestData = {}
  self.tbNightmareQuestData = {}
  self.tbQuestStatus = PlayerData.Activity:GetActivityDataById(self.nActId):GetQuestData()
  
  local function fc(mapData)
    if mapData == nil then
      return
    end
    if mapData.CookieQuestLabel == 1 then
      table.insert(self.tbDailyQuestData, mapData)
    elseif mapData.CookieQuestLabel == 2 then
      table.insert(self.tbNightmareQuestData, mapData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CookieQuest"), fc)
  if self.nCurSeletedTab == 1 then
    self.tbQuestData = self.tbDailyQuestData
  elseif self.nCurSeletedTab == 2 then
    self.tbQuestData = self.tbNightmareQuestData
  end
  table.sort(self.tbQuestData, function(a, b)
    local statusA = 0
    local statusB = 0
    if self.tbQuestStatus ~= nil then
      for k, v in pairs(self.tbQuestStatus) do
        if v.nId == a.Id then
          statusA = v.nStatus or 0
        end
        if v.nId == b.Id then
          statusB = v.nStatus or 0
        end
        if statusA ~= nil and statusB ~= nil then
          break
        end
      end
    end
    if statusA ~= statusB then
      return statusA < statusB
    else
      return a.Id < b.Id
    end
  end)
  self._mapNode.svQuest:Init(#self.tbQuestData, self, self.OnGridRefresh)
  local bHasComplete = false
  if self.tbQuestStatus ~= nil then
    for k, v in pairs(self.tbQuestStatus) do
      if v ~= nil and v.nStatus == AllEnum.ActQuestStatus.Complete then
        bHasComplete = true
      end
    end
  end
  self._mapNode.btnClaimAll.gameObject:SetActive(bHasComplete)
  self._mapNode.btnClaimAllGray.gameObject:SetActive(not bHasComplete)
end

function CookieQuestCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local qeustData = self.tbQuestData[nDataIndex]
  if qeustData == nil then
    return
  end
  local gridCtrl = self:BindCtrlByNode(go, "Game.UI.Play_Cookie.CookieQuestCellCtrl")
  if gridCtrl ~= nil then
    gridCtrl:Init(qeustData, self.nActId)
    self.tbQuestGridCtrl[nDataIndex] = gridCtrl
  end
end

function CookieQuestCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if tbParam ~= nil then
    self.nActId = tbParam[1] or 0
  end
  self.tbQuestGridCtrl = {}
  self.nCurSeletedTab = 1
end

function CookieQuestCtrl:OnEnable()
  self:Refresh()
end

function CookieQuestCtrl:OnDisable()
  for k, v in pairs(self.tbQuestGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbQuestGridCtrl[k] = nil
  end
end

function CookieQuestCtrl:OnDestroy(...)
end

function CookieQuestCtrl:OnBtnClick_ChangeTab(btn, nIndex)
  if self.nCurSeletedTab == nIndex then
    return
  end
  self.nCurSeletedTab = nIndex
  self:Refresh()
end

function CookieQuestCtrl:OnBtnClick_ClaimAll()
  PlayerData.Activity:GetActivityDataById(self.nActId):SendQuestReceive(0)
end

function CookieQuestCtrl:OnEvent_CookieQuestUpdate()
  self:Refresh()
end

return CookieQuestCtrl
