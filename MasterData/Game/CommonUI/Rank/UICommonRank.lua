local UICommonRank = class("UICommonRank", UIBaseWindow)
local base = UIBaseWindow
local UINCommonRankPanel = require("Game.CommonUI.Rank.UINCommonRankPanel")
local UINComRankPage = require("Game.CommonUI.Rank.Page.UINComRankPage")
local UINComRankReward = require("Game.CommonUI.Rank.Reward.UINComRankReward")
local eCommonRank = require("Game.CommonUI.Rank.eCommonRank")
local eComRankPage = eCommonRank.eComRankPage
local showRankPageFuncDic = {
  [eComRankPage.RankList] = function(self)
    if self._rewarkNode then
      self._rewarkNode:Hide()
    end
    self:ShowCommonRankPanel()
  end,
  [eComRankPage.Reward] = function(self)
    if self._rewarkNode == nil then
      local rankRewarkNode = UINComRankReward.New()
      rankRewarkNode:Init(self.ui.awardNode)
      self._rewarkNode = rankRewarkNode
    end
    self.__rankPanel:Hide()
    self._rewarkNode:Show()
    local rankRewardCfg = ConfigData.common_ranklist_percent_reward[self.__rankCfg.id]
    self._rewarkNode:InitComRankReward(rankRewardCfg, self._rankPercent)
  end
}

function UICommonRank:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickBack, nil, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
      if window == nil then
        return
      end
      window:InitCommonInfo(ConfigData:GetTipContent(8806), ConfigData:GetTipContent(8805), nil, true)
    end)
  end)
  self.__rankPanel = UINCommonRankPanel.New()
  self.__rankPanel:Init(self.ui.obj_rankNode)
  self.ui.pageList:SetActive(false)
  self.ui.awardNode:SetActive(false)
end

function UICommonRank:InitCommonRank(rankId, closefunc)
  self.closefunc = closefunc
  local rankCfg = ConfigData.common_ranklist[rankId]
  if rankCfg == nil then
    error("common rank cfg is null,id:" .. tostring(rankId))
  end
  self.__rankCfg = rankCfg
  self:InitCommonRankBaseInfo()
  self:ShowCommonRankPanel()
  self:_TryInitRewardNode()
  if self._pageNode then
    self._pageNode:ComRankPageSelectFirst()
  end
end

function UICommonRank:_TryInitRewardNode()
  if ConfigData.common_ranklist_percent_reward[self.__rankCfg.id] == nil then
    return
  end
  self:_InitPage()
  self._pageNode:AddComRankPage(eComRankPage.Reward)
end

function UICommonRank:_InitPage()
  if self._pageNode ~= nil then
    return
  end
  self._selectPageFunc = BindCallback(self, self._OnSelectPage)
  local pageNode = UINComRankPage.New()
  pageNode:Init(self.ui.pageList)
  pageNode:Show()
  pageNode:InitComRankPage(self.__rankCfg, self._selectPageFunc)
  self._pageNode = pageNode
end

function UICommonRank:InitCommonRankBaseInfo()
  self.ui.tex_CNTitle.text = LanguageUtil.GetLocaleText(self.__rankCfg.rank_title)
  self.ui.tex_ENTitle.text = LanguageUtil.GetLocaleText(self.__rankCfg.rank_title_en)
end

function UICommonRank:ShowCommonRankPanel()
  self.__rankPanel:Show()
  self.__rankPanel:InitCommonRankPanel(self.__rankCfg)
end

function UICommonRank:ReceiveRankFromServer(msg)
  if msg.rankId ~= self.__rankCfg.id then
    return
  end
  if self.__rankPanel == nil then
    return
  end
  self.__rankPanel:GetCommonRankPageMsg(msg, self.__rankCfg.time_switch, self.__rankCfg.hero_show_type == 1)
  self._rankPercent = nil
  if msg.myRank ~= nil then
    self._rankPercent = msg.myRank.rankPercent
  end
end

function UICommonRank:_OnSelectPage(comRankPageType)
  local showPageFunc = showRankPageFuncDic[comRankPageType]
  if showPageFunc == nil then
    error("Unsuppoted showRankPageFuncDic, comRankPageType:" .. tostring(comRankPageType))
    return
  end
  showPageFunc(self)
end

function UICommonRank:_OnClickBack(toHome)
  if self.closefunc ~= nil then
    self.closefunc()
  end
  self:Delete()
end

function UICommonRank:OnDelete()
  if self.__rankPanel ~= nil then
    self.__rankPanel:Delete()
    self.__rankPanel = nil
  end
  if self._pageNode ~= nil then
    self._pageNode:Delete()
    self._pageNode = nil
  end
  if self._rewarkNode ~= nil then
    self._rewarkNode:Delete()
    self._rewarkNode = nil
  end
  base.OnDelete(self)
end

return UICommonRank
