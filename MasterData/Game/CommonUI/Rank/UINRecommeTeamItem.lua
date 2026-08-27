local UINRecommeTeamItem = class("UINRecommeTeamItem", UIBaseNode)
local base = UIBaseNode
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")

local function RankHeroSortFunc(hero1, hero2)
  return hero1.formIdx < hero2.formIdx
end

function UINRecommeTeamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroHeadPool = UIItemPool.New(UINCommonRankItemHeroHead, self.ui.obj_HeroHead)
  self.ui.obj_HeroHead:SetActive(false)
end

function UINRecommeTeamItem:RefreshRecommeTeamItem(teamHero, index)
  self.ui.tex_TitleName:SetIndex(index - 1)
  self.heroHeadPool:HideAll()
  local onBattleHeros = {}
  if teamHero then
    local heroList = teamHero.heroes
    for key, rankHero in ipairs(heroList) do
      if not BattleUtil.PosOnBench(rankHero.position) then
        table.insert(onBattleHeros, rankHero)
      end
      if 5 <= #onBattleHeros then
        break
      end
    end
  end
  table.sort(onBattleHeros, RankHeroSortFunc)
  local heroNum = math.min(#onBattleHeros, 5)
  for i = 1, 5 do
    if i <= heroNum then
      local rankHero = onBattleHeros[i]
      local item = self.heroHeadPool:GetOne()
      if rankHero ~= nil then
        item:InitHead(rankHero.heroId, rankHero.level, rankHero.rank)
        item:SetVowFrame(rankHero.vowed)
      end
      item:SetHeroHeadItemAtive(rankHero ~= nil)
    else
      local emptyObj = self.ui.obj_EmptyHero:Instantiate(self.ui.obj_EmptyHero.transform.parent)
      emptyObj:SetActive(true)
    end
  end
end

function UINRecommeTeamItem:OnClickClose()
  self:Delete()
end

return UINRecommeTeamItem
