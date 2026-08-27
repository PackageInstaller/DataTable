local UIRecommeFormationWindow = class("UIRecommeFormationWindow", UIBaseWindow)
local base = UIBaseWindow
local UINWCSRecommeFormationItem = require("Game.Formation.UI.FmtRecommend.UINRecommeFormationItem")
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINCommanderSkill = require("Game.Formation.UI.2DFormation.UINCommanderSkill")
local HeroData = require("Game.PlayerData.Hero.HeroData")

function UIRecommeFormationWindow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.resloader = CS.ResLoader.Create()
  self.__GetHeroHeadCallback = BindCallback(self, self.GetHeroHead)
  self.__GetCommanderSkillCallback = BindCallback(self, self.GetCommanderSkill)
  self.formationItemPool = UIItemPool.New(UINWCSRecommeFormationItem, self.ui.recommeTeamItem)
  self.ui.recommeTeamItem.gameObject:SetActive(false)
  self.heroHeadItemPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.obj_HeroHead)
  self.ui.obj_HeroHead.gameObject:SetActive(false)
  self.skillItemPool = UIItemPool.New(UINCommanderSkill, self.ui.obj_SkillItem)
  self.ui.obj_SkillItem.gameObject:SetActive(false)
  self.ui.obj_EmptyHero:SetActive(false)
  self.emptyHeroHeadItemList = {}
  self.emptyHeroHeadItemListIndex = 1
end

function UIRecommeFormationWindow:InitFmtRecommendTeamAndSkill(recommendTeamList, recommendSkillDataList)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  self._recommendTeamList = recommendTeamList
  self._recommendSkillDataList = recommendSkillDataList
  self.formationItemPool:HideAll()
  self.heroHeadItemPool:HideAll()
  self.skillItemPool:HideAll()
  for i = 1, #self.emptyHeroHeadItemList do
    self.emptyHeroHeadItemList[i]:SetActive(false)
  end
  self.emptyHeroHeadItemListIndex = 1
  self:InitRecommendTeamShow()
end

function UIRecommeFormationWindow:GetHeroHead(heroId, parentTr)
  if heroId ~= nil then
    self:_GetOneHeroHead(heroId, parentTr)
  else
    self:_GetOneEmptyHeroHead(parentTr)
  end
end

function UIRecommeFormationWindow:_GetOneHeroHead(heroId, parentTr)
  local headItem = self.heroHeadItemPool:GetOne()
  local heroInfo = PlayerDataCenter.heroDic[heroId]
  local isHas = heroInfo ~= nil
  if not isHas then
    local heroCfg = ConfigData.hero_data[heroId]
    heroInfo = HeroData.New({
      basic = {
        id = heroCfg.id,
        level = 1,
        exp = 0,
        star = heroCfg.rank,
        potentialLvl = 0,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
      }
    })
    heroInfo.heroCfg = heroCfg
  end
  headItem:InitHead(heroInfo, isHas)
  headItem.gameObject.transform:SetParent(parentTr)
  headItem.gameObject.transform:SetAsLastSibling()
  return headItem
end

function UIRecommeFormationWindow:_GetOneEmptyHeroHead(parentTr)
  local emptyIndex = self.emptyHeroHeadItemListIndex
  local emptyIcon
  if emptyIndex <= #self.emptyHeroHeadItemList then
    emptyIcon = self.emptyHeroHeadItemList[emptyIndex]
  else
    emptyIcon = self.ui.obj_EmptyHero:Instantiate()
    table.insert(self.emptyHeroHeadItemList, emptyIcon)
  end
  emptyIndex = emptyIndex + 1
  emptyIcon:SetActive(true)
  emptyIcon.transform:SetParent(parentTr)
  emptyIcon.transform:SetAsLastSibling()
  self.emptyHeroHeadItemListIndex = emptyIndex
  return emptyIcon
end

function UIRecommeFormationWindow:GetCommanderSkill(skillId, parentTr)
  local skillItem = self.skillItemPool:GetOne()
  if skillId == nil then
    error("nil commander id！")
    return
  end
  skillItem:InitCommanderSkill(skillId, self.resloader)
  skillItem.transform:SetParent(parentTr)
  skillItem.transform:SetAsLastSibling()
end

function UIRecommeFormationWindow:InitRecommendTeamShow()
  for recommendId, recommendTeam in pairs(self._recommendTeamList) do
    local recommendSkillData = self._recommendSkillDataList[recommendId]
    local formationItem = self.formationItemPool:GetOne()
    formationItem:InitRecommeFormationItem(recommendTeam, recommendSkillData, self.__GetHeroHeadCallback, self.__GetCommanderSkillCallback, self.resloader)
  end
end

function UIRecommeFormationWindow:BackAction()
  self:Hide()
end

function UIRecommeFormationWindow:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIRecommeFormationWindow:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIRecommeFormationWindow
