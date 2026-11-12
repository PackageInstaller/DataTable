local BdConvertContentCtrl = class("BdConvertContentCtrl", BaseCtrl)
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local barMinX = -378
local barMaxX = 0
BdConvertContentCtrl._mapNodeConfig = {
  txt_quest = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_QuestTitle"
  },
  redDotQuest = {},
  btn_quest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txt_mainProcess = {sComponentName = "TMP_Text"},
  imgMainBarFill = {
    sComponentName = "RectTransform"
  },
  btn_starTower = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoStarTower"
  },
  cell = {},
  ListContent = {
    sComponentName = "RectTransform"
  },
  ListCanvasGroup = {
    sNodeName = "ListContent",
    sComponentName = "CanvasGroup"
  },
  txt_starTower = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_GoToStarTower"
  }
}
BdConvertContentCtrl._mapEventConfig = {BdConvertQuestUpdate = "InitQuest"}
BdConvertContentCtrl._mapRedDotConfig = {
  [RedDotDefine.Activity_BdConvert_AllQuest] = {
    sNodeName = "redDotQuest"
  }
}

function BdConvertContentCtrl:SetData(nActId)
  self.nActId = nActId
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
end

function BdConvertContentCtrl:Refresh()
  local bResult = self.actData:CheckBuildsData()
  if bResult then
    self:UpdateOptionList()
  else
    EventManager.Hit(EventId.BlockInput, true)
    self.actData:RequestAllBuildData(function()
      if not self.bInAnim_In then
        EventManager.Hit(EventId.BlockInput, false)
      end
      self:UpdateOptionList()
    end)
  end
  self:InitQuest()
end

function BdConvertContentCtrl:OnDisable()
  if self.tbListCtrl ~= nil then
    for _, ctrl in pairs(self.tbListCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbListCtrl = {}
end

function BdConvertContentCtrl:UpdateOptionList()
  self.bdConfig = self.actData:GetBdConvertConfig()
  self.optionList = self.bdConfig.OptionList
  
  local function sort(a, b)
    local contentA_Data = self.actData:GetBdDataBy(a)
    local contentB_Data = self.actData:GetBdDataBy(b)
    local bFinish_A = contentA_Data.nCurSub == contentA_Data.nMaxSub
    local bFinish_B = contentB_Data.nCurSub == contentB_Data.nMaxSub
    if bFinish_A and not bFinish_B then
      return false
    elseif not bFinish_A and bFinish_B then
      return true
    end
    return a < b
  end
  
  table.sort(self.optionList, sort)
  self.tbGridSize = {}
  for _, optionId in ipairs(self.optionList) do
    local contentCfg = ConfigTable.GetData("BdConvertContent", optionId)
    if contentCfg ~= nil then
      local height = 0
      if #contentCfg.ConvertConditionList >= 3 then
        height = 360
      else
        height = 310
      end
      table.insert(self.tbGridSize, height)
    end
  end
  if self.tbListCtrl ~= nil then
    for _, ctrl in pairs(self.tbListCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbListCtrl = {}
  delChildren(self._mapNode.ListContent.gameObject)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.ListCanvasGroup, 0)
  for _, opId in ipairs(self.optionList) do
    local go = instantiate(self._mapNode.cell, self._mapNode.ListContent)
    local ctrl = self:BindCtrlByNode(go, "Game.UI.Activity.BdConvert._500001.BdConvertCellCtrl")
    ctrl:SetData(self.nActId, opId)
    table.insert(self.tbListCtrl, ctrl)
    go:SetActive(true)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.ListCanvasGroup, 1)
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.ListContent)
  end
  
  cs_coroutine.start(wait)
end

function BdConvertContentCtrl:InitQuest()
  local allCount = self.actData:GetAllQuestCount()
  local receivedCount = self.actData:GetAllReceivedCount()
  NovaAPI.SetTMPText(self._mapNode.txt_mainProcess, receivedCount .. "/" .. allCount)
  self._mapNode.imgMainBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (receivedCount / allCount), self._mapNode.imgMainBarFill.anchoredPosition.y)
end

function BdConvertContentCtrl:OnBtnClick_Quest()
  EventManager.Hit(EventId.OpenPanel, PanelId.BdConvertQuestPanel, self.nActId)
end

function BdConvertContentCtrl:OnBtnClick_GoStarTower()
  EventManager.Hit(EventId.OpenPanel, PanelId.LevelMenu, 2)
end

return BdConvertContentCtrl
