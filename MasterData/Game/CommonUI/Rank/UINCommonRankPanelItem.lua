local UINCommonRankPanelItem = class("UINCommonRankPanelItem", UIBaseNode)
local base = UIBaseNode
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local UINRankFairyHeadItem = require("Game.CommonUI.Rank.UINRankFairyHeadItem")

local function RankHeroSortFunc(hero1, hero2)
  return hero1.formIdx < hero2.formIdx
end

function UINCommonRankPanelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_openUserInfo, self, self.OnClickOpenUserInfoBtn)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickMultiTeamCheck)
  self.heroHeadPool = UIItemPool.New(UINCommonRankItemHeroHead, self.ui.obj_HeroHead)
  self.ui.obj_HeroHead:SetActive(false)
  self.userHead = UINUserHead.New()
  self.userHead:Init(self.ui.uINBaseHead)
  self.userTitle = UINUserTitle.New()
  self.userTitle:Init(self.ui.obj_title)
  self._fairyItem = UINRankFairyHeadItem.New()
  self._fairyItem:Init(self.ui.obj_FairyHead)
end

function UINCommonRankPanelItem:RefeshCommonRankItem(rankCfg, rankElemData, resloader, hasTime, showHeroNum)
  self.__rankElemData = rankElemData
  local rankAvatar = rankElemData.entry.avatar
  self.ui.tex_RankNumber.text = tostring(rankElemData.rankIdx)
  self.ui.tex_PlayerName.text = tostring(rankAvatar.name)
  local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
  self._titleBgAtlas = resloader:LoadABAsset(atlasPath)
  if rankAvatar.title and rankAvatar.title.titlePrefix ~= 0 then
    self.ui.obj_title:SetActive(true)
    self.userTitle:InitNormalTitleItem(rankAvatar.title.titlePrefix, rankAvatar.title.titlePostfix, rankAvatar.title.titleBackGround, resloader, self._titleBgAtlas)
  else
    self.ui.obj_title:SetActive(false)
  end
  local valueText
  if rankCfg.option_show_type == 1 then
    valueText = BattleUtil.FrameToTimeString(rankElemData.entry.score1, true)
  else
    valueText = tostring(rankElemData.entry.score1)
  end
  self.ui.tex_Score.text = valueText
  self.ui.tex_Time.gameObject:SetActive(hasTime)
  if hasTime then
    self.ui.tex_Time.text = BattleUtil.FrameToTimeString(rankElemData.entry.frame, true)
  end
  self.userHead:InitUserHeadUI(rankAvatar.avatarId, rankAvatar.avatarFrame, resloader)
  local rankForm = rankElemData.entry.form
  self.rankMultiForm = rankElemData.entry.multiForm
  if not rankForm or #rankForm.heroes == 0 and self.rankMultiForm[1] ~= nil then
    rankForm = self.rankMultiForm[1]
    self.ui.btn_Check.gameObject:SetActive(true)
  else
    self.ui.btn_Check.gameObject:SetActive(false)
  end
  local count = 0
  self.heroHeadPool:HideAll()
  self.ui.tex_heroCount.gameObject:SetActive(showHeroNum)
  self.ui.obj_heroList:SetActive(not showHeroNum)
  if showHeroNum then
    if rankElemData.entry.params ~= nil then
      local heroCount = rankElemData.entry.params[1]
      self.ui.tex_heroCount.text = tostring(heroCount)
    end
  else
    local onBattleHeros = {}
    for key, rankHero in ipairs(rankForm.heroes) do
      if not BattleUtil.PosOnBench(rankHero.position) then
        table.insert(onBattleHeros, rankHero)
      end
      if #onBattleHeros >= rankCfg.hero_num then
        break
      end
    end
    table.sort(onBattleHeros, RankHeroSortFunc)
    for i = 1, rankCfg.hero_num do
      local rankHero = onBattleHeros[i]
      local item = self.heroHeadPool:GetOne()
      if rankHero ~= nil then
        item:InitHead(rankHero.heroId, rankHero.level, rankHero.rank)
        item:SetVowFrame(rankHero.vowed)
      end
      item:SetHeroHeadItemAtive(rankHero ~= nil)
    end
    if rankCfg.hero_num > 5 then
      UIUtil.ScrollRectLocation(self.ui.Obj_herolist, self.heroHeadPool.listItem[1], true)
      self.ui.Obj_herolist.transform.sizeDelta = Vector2.Temp(110 * rankCfg.hero_num - 70, 100)
    elseif rankCfg.hero_num < 5 then
      self.ui.Obj_herolist.transform.sizeDelta = Vector2.Temp(110 * rankCfg.hero_num, 100)
    end
    if rankCfg.fairy_hide then
      self._fairyItem:Hide()
    else
      self._fairyItem:Show()
      self._fairyItem:InitRankFairyHeadItem(rankForm and rankForm.fairy, true, resloader)
    end
  end
end

function UINCommonRankPanelItem:OnClickOpenUserInfoBtn()
  PlayerDataCenter:GetUserInfoByUID(self.__rankElemData.entry.uid, function(userInfoData)
    if userInfoData == nil then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
      if win == nil then
        return
      end
      win:InitUserInfoView(userInfoData)
    end)
  end)
end

function UINCommonRankPanelItem:SetDownTransform(transform)
  self.downTransform = transform
end

function UINCommonRankPanelItem:OnClickMultiTeamCheck()
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormationSeason, function(win)
    if win == nil then
      return
    end
    win:RefreshTeamItem(self.rankMultiForm)
    win:SetShowPosition(self.ui.btn_Check.transform, self.downTransform)
  end)
end

return UINCommonRankPanelItem
