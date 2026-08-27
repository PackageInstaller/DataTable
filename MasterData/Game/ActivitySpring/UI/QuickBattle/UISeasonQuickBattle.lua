local base = require("Game.Exploration.UI.EpRewardBag.UIEpRewardBag")
local UISeasonQuickBattle = class("UISeasonQuickBattle", base)
local cs_MovieManager = CS.MovieManager.Instance
local UINEpRewardBagItem = require("Game.Exploration.UI.EpRewardBag.UINEpRewardBagItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")

function UISeasonQuickBattle:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self._OnClickGetReward)
  UIUtil.AddButtonListener(self.ui.btn_SelectAll, self, self._OnClickSelectAll)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancelSelect)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickGiveup)
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.gameResourceGroup)
  self.ui.rewardBagItem:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINEpRewardBagItem, self.ui.rewardBagItem)
  self._selectRewardFunc = BindCallback(self, self._OnSelectReward)
end

function UISeasonQuickBattle:RefreshSeasonQuickBattle(rewardList, stageCfg, selectOverCallback)
  local stageId = stageCfg.id
  self:SetEpRewardBagCloseFunc(selectOverCallback)
  self:InitEpRewardBag(rewardList, stageCfg, false, nil, true, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, stageId)
  self:__PlayQuickBattleVideo()
end

function UISeasonQuickBattle:__PlayQuickBattleVideo()
  local pos = self.ui.trans_videoHodlerBg.position
  self.ui.trans_videoHodlerBg.localPosition = Vector2.zero
  self.ui.trans_videoHodlerBg:DOMove(pos, 0.5):SetDelay(1.8):SetLink(self.transform.gameObject)
  self.ui.cg_otherParent.alpha = 0
  self.ui.cg_otherParent:DOFade(1, 0.5):SetDelay(1.9):SetLink(self.transform.gameObject)
  self.ui.obj_Finish:SetActive(false)
  if self._moviePlayer == nil then
    self._moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  self:__PreparePlayEveryItemTween()
  local avgPath = PathConsts:GetAvgVideoPath("activityDungeonQuickBattle_01")
  self._moviePlayer:SetVideoRender(self.ui.img_videoHodler)
  self._moviePlayer:PlayVideo(avgPath)
  self._moviePlayer:PresetsPauseVideoFrameNo(59)
  self._moviePlayer:SetPauseVideoCallback(function()
    self.ui.obj_Finish:SetActive(true)
    self:__PlayEveryItemTween()
  end)
end

function UISeasonQuickBattle:__PreparePlayEveryItemTween()
  for index, item in ipairs(self.rewardItemPool.listItem) do
    item.ui.cg.alpha = 0
  end
end

function UISeasonQuickBattle:__PlayEveryItemTween()
  local lineNum = (#self.rewardItemPool.listItem - 1) // 5 + 1
  local lastLine = 1
  for index, item in ipairs(self.rewardItemPool.listItem) do
    local delay = (index - 1) * 0.2
    item.ui.cg:DOFade(1, 0.5):SetDelay(delay):SetLink(item.transform.gameObject)
    item.ui.realItem:DOScale(0, 0.3):From(true):SetDelay(delay):SetLink(item.transform.gameObject)
    item.ui.realItem:DOLocalMoveX(-50, 0.2):From(true):SetRelative(true):SetDelay(delay):SetLink(item.transform.gameObject):OnComplete(function()
      local curLine = (index - 1) // 5 + 1
      if curLine > lastLine then
        print(curLine / lineNum)
        self.ui.scroll:DOVerticalNormalizedPos(1 - curLine / lineNum, 0.2):SetLink(self.transform.gameObject)
        lastLine = curLine
      end
    end)
  end
end

function UISeasonQuickBattle:OnDelete()
  if self._moviePlayer ~= nil then
    self._moviePlayer:ReSet()
    cs_MovieManager:ReturnMoviePlayer(self._moviePlayer)
    self._moviePlayer = nil
  end
  base.OnDelete(self)
end

return UISeasonQuickBattle
