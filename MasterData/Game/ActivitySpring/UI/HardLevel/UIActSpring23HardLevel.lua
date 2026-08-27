local UIActSpring23HardLevel = class("UIActSpring23HardLevel", UIBaseWindow)
local base = UIBaseWindow
local UIActSpring23HardLevelItem = require("Game.ActivitySpring.UI.HardLevel.UINActSpring23HardLevelItem")
local SpringHardLevelData = require("Game.ActivitySpring.Dungeon.SpringDungeonLevelData")
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local eActInteract23Spring = require("Game.ActivityLobby.Activity.2023Spring.eActInteract")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_ResLoader = CS.ResLoader

function UIActSpring23HardLevel:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseChallenge)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  self._itemPool = UIItemPool.New(UIActSpring23HardLevelItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.__OnSelectChallengeCallback = BindCallback(self, self.__OnSelectChallenge)
  self.__BackFromeDetailCallback = BindCallback(self, self.__BackFromeDetail)
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.uI_CommonActivityBG)
  self._resloader = cs_ResLoader.Create()
end

function UIActSpring23HardLevel:InitSpring23HardLevel(spring23Data, callback, delayEnterCallback)
  self._spring23Data = spring23Data
  self._callback = callback
  self._actBgNode:InitActivityBG(spring23Data:GetActFrameId(), self._resloader)
  local levelTypeCfg = self._spring23Data:GetSpringHardLevelCfg()
  local dungeonIdList = levelTypeCfg.dungeon_levels
  self._itemPool:HideAll()
  if self._showSe ~= nil then
    self._showSe:Kill()
    self._showSe = nil
  end
  self._showSe = cs_DoTween.Sequence()
  for index, dungeonId in pairs(dungeonIdList) do
    self._showSe:AppendInterval(index ~= 1 and 0.1 or 0)
    self._showSe:AppendCallback(function()
      local item = self._itemPool:GetOne()
      item:InitSpring23ChallengeItem(self._spring23Data, dungeonId, index, self.__OnSelectChallengeCallback)
    end)
  end
  if delayEnterCallback ~= nil then
    local lengthTime = self.ui.ani_root.clip.length
    self._delayTimerId = TimerManager:StartTimer(lengthTime, delayEnterCallback, nil, true)
  end
end

function UIActSpring23HardLevel:__OnSelectChallenge(dungeonId)
  if self._selectDungeonId == dungeonId then
    return
  end
  self._selectDungeonId = dungeonId
  
  local function clickFunc()
    for i, item in ipairs(self._itemPool.listItem) do
      if self._selectDungeonId == item:GetSpringChallengeDungeonId() then
        self.ui.selected.gameObject:SetActive(true)
        self.ui.selected:SetParent(item.transform)
        self.ui.selected.anchoredPosition = Vector2.zero
        self.ui.selected:SetAsFirstSibling()
        local detailWin = UIManager:GetWindow(UIWindowTypeID.DungeonLevelDetail)
        local screenX = UIManager.BackgroundStretchSize.x
        local index = self._spring23Data:GetSpringChallengeDungeonIndex(self._selectDungeonId)
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
      local dungeonLevel = SpringHardLevelData.New(self._selectDungeonId)
      dungeonLevel:SetSpringLevelPic(self._spring23Data:GetSpringHardLevelCfg().pic_small)
      win:InitDungeonLevelDetail(dungeonLevel, false)
      win:SetDungeonLevelBgClose(true)
      win:SetDunLevelDetaiHideEndEvent(self.__BackFromeDetailCallback)
      clickFunc()
    end)
  else
    window:Show()
    local dungeonLevel = SpringHardLevelData.New(self._selectDungeonId)
    dungeonLevel:SetSpringLevelPic(self._spring23Data:GetSpringHardLevelCfg().pic_small)
    window:InitDungeonLevelDetail(dungeonLevel, false)
    clickFunc()
  end
end

function UIActSpring23HardLevel:OnClickRank()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(self._spring23Data:GetRankId())
  end)
end

function UIActSpring23HardLevel:SetRankTex(myRank)
  local inRank = myRank and myRank.inRank or false
  if inRank then
    self.ui.tex_Rank:SetIndex(0, tostring(myRank.rankParam))
  else
    self.ui.tex_Rank:SetIndex(1)
  end
end

function UIActSpring23HardLevel:__BackFromeDetail()
  if IsNull(self.transform) then
    return
  end
  self._selectDungeonId = nil
  self.ui.selected.gameObject:SetActive(false)
  self.ui.list:DOAnchorPos(Vector2.Temp(0, self.ui.list.anchoredPosition.y), 0.4):SetLink(self.ui.list.gameObject)
end

function UIActSpring23HardLevel:OnCloseChallenge()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIActSpring23HardLevel:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  if self._delayTimerId ~= nil then
    TimerManager:StopTimer(self._delayTimerId)
    self._delayTimerId = nil
  end
  if self._showSe ~= nil then
    self._showSe:Kill()
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.OnDelete(self)
end

return UIActSpring23HardLevel
