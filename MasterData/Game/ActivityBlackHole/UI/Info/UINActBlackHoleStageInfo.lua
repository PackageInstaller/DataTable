local UINActBlackHoleStageInfo = class("UINActBlackHoleStageInfo", UIBaseNode)
local base = UIBaseNode
local UINCommonRankItemHeroHeadNode = require("Game.ActivityBlackHole.UI.Item.UINActBlackHoleHeroItem")
local UINFairyHeadItem = require("Game.ActivityBlackHole.UI.Item.UINActBlackHoleFairyItem")
local UINNoHeroHeadItem = require("Game.ActivityBlackHole.UI.Item.UINActBlackHoleNoHeroItem")
local BattleUtil = require("Game.Battle.BattleUtil")

function UINActBlackHoleStageInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickBtnBattle)
  self.noHeroItemPool = UIItemPool.New(UINNoHeroHeadItem, self.ui.obj_NoHero, false)
  self.heroHeadItem = UIItemPool.New(UINCommonRankItemHeroHeadNode, self.ui.heroNode, false)
  self.fairyHeadItem = UINFairyHeadItem.New()
  self.fairyHeadItem:Init(self.ui.fairyNode)
  self.fairyHeadItem:Hide()
end

function UINActBlackHoleStageInfo:InitActBlackHoleStageInfo(dungeonData, battleFunc, index, resloader)
  self.dungeonData = dungeonData
  self.battleFunc = battleFunc
  self.index = index
  self.resloader = resloader
  self:RefreshBlackHoleStageInfo()
end

function UINActBlackHoleStageInfo:RefreshBlackHoleStageInfo()
  local nowNum = self.dungeonData:GetBlackHoleScoreNum()
  local state = 0 < nowNum and 0 or 1
  self.ui.img_Battle:SetIndex(state)
  self.ui.tex_Battle:SetIndex(state)
  self.ui.tex_Id:SetIndex(self.index - 1)
  self.ui.tex_Score.text = tostring(nowNum)
  self.ui.tex_Time.text = BattleUtil.FrameToTimeString(self.dungeonData:GetBlackHoleTimeNum(), true)
  self.noHeroItemPool:HideAll()
  self.heroHeadItem:HideAll()
  local heroIds, fairyData = self.dungeonData:GetBlackHolePassTeam()
  local totalNum = 0
  if heroIds then
    local onBattleHeros = {}
    if 8 < #heroIds then
      error("gen heroIds > 8")
    end
    for i, elem in pairs(heroIds) do
      table.insert(onBattleHeros, elem)
      if 8 <= #onBattleHeros then
        break
      end
    end
    table.sort(onBattleHeros, function(hero1, hero2)
      return hero1.formIdx < hero2.formIdx
    end)
    local heroNum = math.min(#heroIds, 8)
    for i = 1, heroNum do
      local elem = onBattleHeros[i]
      local item = self.heroHeadItem:GetOne()
      totalNum = totalNum + 1
      if elem ~= nil then
        item:InitActBlackHoleHeroItem(elem.heroId, elem.level, elem.rank)
      else
        item:InitActBlackHoleHeroItemEmpty()
      end
    end
  end
  if fairyData then
    self.fairyHeadItem:Show()
    self.fairyHeadItem:InitActBlackHoleFairyItem(fairyData, self.resloader)
    totalNum = totalNum + 1
  else
    self.fairyHeadItem:Hide()
  end
  self.fairyHeadItem.transform:SetAsLastSibling()
  for k = totalNum, 8 do
    self.noHeroItemPool:GetOne()
  end
end

function UINActBlackHoleStageInfo:OnClickBtnBattle()
  if self.battleFunc then
    self.battleFunc(self.dungeonData)
  end
end

function UINActBlackHoleStageInfo:PlayStageInfoSingleAni(delayTime)
  self:__StopTween()
  self.ui.aniNode.transform:DOLocalMoveY(-20, 0.3):From():SetDelay(delayTime):SetLink(self.ui.aniNode.gameObject)
  self.ui.canvasGroup:DOFade(0, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
end

function UINActBlackHoleStageInfo:__StopTween()
  self.ui.aniNode.transform:DOComplete()
  self.ui.canvasGroup:DOComplete()
end

function UINActBlackHoleStageInfo:OnDelete()
  self.noHeroItemPool:HideAll()
  self.heroHeadItem:HideAll()
  base.OnDelete(self)
end

return UINActBlackHoleStageInfo
