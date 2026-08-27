local base = UIBaseWindow
local UIActCommonHardLevel = class("UIActCommonHardLevel", base)
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local UINActCommonHardLevelItem = require("Game.ActivityFrame.ActCommonHardLevel.UI.UINActCommonHardLevelItem")

function UIActCommonHardLevel:OnInit()
  UIUtil.SetTopStatus(self, self._Close)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.__OnClickRank)
  self._conditionListener = ConditionListener.New()
  self._resloader = cs_ResLoader.Create()
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.uI_CommonActivityBG)
  self._itemPool = UIItemPool.New(UINActCommonHardLevelItem, self.ui.item, false)
  self._onSelectChallenge = BindCallback(self, self._OnSelectChallenge)
  self.__BackFromeDetailCallback = BindCallback(self, self.__BackFromeDetail)
  self.__refreshAllLevel = BindCallback(self, self.__RefreshAllLevel)
end

function UIActCommonHardLevel:InitActCommonHardLevel(hardLevelPlayData, selfRankData, closeCallback, delayEnterCallback)
  self._hardLevelPlayData = hardLevelPlayData
  self._selfRankData = selfRankData
  self._closeCallback = closeCallback
  local actFrameId = self._hardLevelPlayData:AHLPD_GetActFreameId()
  self._actBgNode:InitActivityBG(actFrameId, self._resloader)
  local actHardLevelDataList = self._hardLevelPlayData:AHLPD_GetDunDataList()
  self._itemPool:HideAll()
  if self._showSequence ~= nil then
    self._showSequence:Kill()
  end
  self._showSequence = cs_DoTween.Sequence()
  for index, actHardLevelData in pairs(actHardLevelDataList) do
    self._showSequence:AppendInterval(index ~= 1 and 0.1 or 0)
    self._showSequence:AppendCallback(function()
      local item = self._itemPool:GetOne()
      item:InitCommonChallengeItem(self._hardLevelPlayData, actHardLevelData, index, self._onSelectChallenge)
    end)
    local isUnlock = actHardLevelData:GetIsLevelUnlock()
    if not isUnlock then
      local pre_condition, pre_para1, pre_para2 = actHardLevelData:GetLevelUnlockConditionCfg()
      self._conditionListener:AddConditionChangeListener(index, self.__refreshAllLevel, pre_condition, pre_para1, pre_para2)
    end
  end
  self:__RefreshRankInfo()
  self._showSequence:AppendCallback(function()
    self._hardLevelPlayData:AHLPD_SetAllSeen()
    if delayEnterCallback ~= nil then
      delayEnterCallback()
    end
  end)
end

function UIActCommonHardLevel:__RefreshAllLevel(index)
  self._conditionListener:RemoveConditionChangeListener(index)
  for _, item in pairs(self._itemPool.listItem) do
    item:__Refresh()
  end
end

function UIActCommonHardLevel:_OnSelectChallenge(actHardLevelData, index)
  local dungeonId = actHardLevelData:GetDungeonLevelStageId()
  if self._selectDungeonId == dungeonId then
    return
  end
  self._selectDungeonId = dungeonId
  
  local function clickFunc()
    for i, item in ipairs(self._itemPool.listItem) do
      if self._selectDungeonId == item.actHardLevelData:GetDungeonLevelStageId() then
        self.ui.scroll_list.enabled = false
        self.ui.selected.gameObject:SetActive(true)
        self.ui.selected:SetParent(item.transform)
        self.ui.selected.anchoredPosition = Vector2.zero
        self.ui.selected:SetAsFirstSibling()
        local detailWin = UIManager:GetWindow(UIWindowTypeID.DungeonLevelDetail)
        local screenX = UIManager.BackgroundStretchSize.x
        local spacing = self.ui.horizontalLayout.spacing
        local itemOffset = (index - 1) * (item.transform.sizeDelta.x + spacing)
        if itemOffset > spacing + item.transform.sizeDelta.x / 2 then
          itemOffset = itemOffset - spacing - item.transform.sizeDelta.x / 2
        end
        itemOffset = index - 1 > 0 and itemOffset - (screenX / 2 - detailWin:GetDLevelDetailWidthAndDuration()) / 2 or itemOffset
        self.ui.list:DOAnchorPos(Vector2.Temp(-itemOffset, self.ui.list.anchoredPosition.y), 0.4):SetLink(self.ui.list.gameObject)
        break
      end
    end
  end
  
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonLevelDetail)
  if window == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(win)
      if win == nil then
        return
      end
      win:InitDungeonLevelDetail(actHardLevelData, false)
      win:SetDungeonLevelBgClose(true)
      win:SetDunLevelDetaiHideEndEvent(self.__BackFromeDetailCallback)
      clickFunc()
    end)
  else
    window:Show()
    window:InitDungeonLevelDetail(actHardLevelData, false)
    clickFunc()
  end
end

function UIActCommonHardLevel:__RefreshRankInfo()
  local inRank = self._selfRankData and self._selfRankData.inRank or false
  if inRank then
    self.ui.tex_Rank:SetIndex(0, tostring(self._selfRankData.rankParam))
  else
    self.ui.tex_Rank:SetIndex(1)
  end
end

function UIActCommonHardLevel:__OnClickRank()
  local rankId = self._hardLevelPlayData:AHLPD_GetRankId()
  UIManager:HideWindow(UIWindowTypeID.CommonHardLevel)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CommonHardLevel)
    end)
  end)
end

function UIActCommonHardLevel:__BackFromeDetail()
  if IsNull(self.transform) then
    return
  end
  self._selectDungeonId = nil
  self.ui.selected.gameObject:SetActive(false)
  self.ui.scroll_list.enabled = true
end

function UIActCommonHardLevel:_Close()
  self:Delete()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UIActCommonHardLevel:OnDelete()
  self._conditionListener:Delete()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  if self._showSequence ~= nil then
    self._showSequence:Kill()
    self._showSequence = nil
  end
  base.OnDelete(self)
end

return UIActCommonHardLevel
