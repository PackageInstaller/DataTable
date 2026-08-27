local UINDungeonInfoHeroDetail = class("UINDungeonInfoHeroDetail", UIBaseNode)
local base = UIBaseNode
local UINDungeonInfoHeroDetailAttr = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailAttr")
local UINDungeonInfoHeroDetailSkill = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailSkill")
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINDungeonServerGridItem = require("Game.CommonUI.DungeonState.Info.UINDungeonServerGridItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local UINBattleBuffStatusItem = require("Game.Battle.UI.UINBattleBuffStatusItem")
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UINDungeonInfoHeroDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.cardItem = UINHeroCardItem.New()
  self.cardItem:Init(self.ui.obj_heroItem)
  self.attrPool = UIItemPool.New(UINDungeonInfoHeroDetailAttr, self.ui.obj_attriItem)
  self.ui.obj_attriItem:SetActive(false)
  self.skillPool = UIItemPool.New(UINDungeonInfoHeroDetailSkill, self.ui.obj_skillItem)
  self.ui.obj_skillItem:SetActive(false)
  self._buffStatusPool = UIItemPool.New(UINBattleBuffStatusItem, self.ui.introItem)
  self.ui.introItem:SetActive(false)
  self.serverGridPool = UIItemPool.New(UINDungeonServerGridItem, self.ui.gridBuffItem)
  self.ui.gridBuffItem:SetActive(false)
  self.__onShowSkillDetail = BindCallback(self, self.__ShowSkillDetail)
  self.__onHideRichInfoDetail = BindCallback(self, self.__HideRichInfoDetail)
  self.__onShowServerGridDetail = BindCallback(self, self.__ShowServerGridDetail)
  UIUtil.AddButtonListener(self.ui.attrTag, self, self.OnClickAttrDetail)
  UIUtil.AddButtonListener(self.ui.statusTag, self, self.OnClickStatusDetail)
end

function UINDungeonInfoHeroDetail:InitHeroInfo(dynHeroData, resloader)
  self.ui.tex_Power.text = tostring(dynHeroData:GetFightingPower())
  local hpPer = dynHeroData.hpPer / 10000
  self.ui.img_Hp.fillAmount = hpPer
  local maxHp = dynHeroData:GetRealAttr(eHeroAttr.maxHp)
  local realHp = maxHp * dynHeroData.hpPer / 10000
  if dynHeroData.hpPer / 10000 > 0 then
    realHp = math.max(1, realHp)
  end
  self.ui.tex_Hp:SetIndex(0, tostring(math.floor(realHp)), tostring(maxHp))
  self.attrPool:HideAll()
  for _, attrId in ipairs(ConfigData.game_config.dungeonHeroMainAttrIds) do
    local attrVal = dynHeroData:GetRealAttr(attrId)
    local attrOriginVal = dynHeroData:GetOriginAttr(attrId)
    local attrItem = self.attrPool:GetOne(true)
    attrItem:InitAttr(attrId, attrVal, attrOriginVal)
  end
  self:__InitCommon(dynHeroData, resloader)
  self.ui.attrTag.gameObject:SetActive(false)
  self.ui.statusTag.gameObject:SetActive(false)
  self:OnClickAttrDetail()
end

function UINDungeonInfoHeroDetail:InitHeroInfoInBattle(entity, resloader)
  local dynHeroData = entity.character
  local realAttrs = entity.realAttrList
  self.ui.tex_Power.text = tostring(dynHeroData:GetFightingPower())
  local maxHp = entity.maxHp
  local hpPer = entity.hp / maxHp
  self.ui.img_Hp.fillAmount = hpPer
  local realHp = maxHp * hpPer
  if 0 < hpPer then
    realHp = math.max(1, realHp)
  end
  self.ui.tex_Hp:SetIndex(0, tostring(math.floor(realHp)), tostring(maxHp))
  self.attrPool:HideAll()
  for _, attrId in ipairs(ConfigData.game_config.dungeonHeroMainAttrIds) do
    local attrVal = realAttrs[attrId] or 0
    local attrOriginVal = dynHeroData:GetOriginAttr(attrId)
    local attrItem = self.attrPool:GetOne(true)
    attrItem:InitAttr(attrId, attrVal, attrOriginVal)
  end
  self:__InitCommon(dynHeroData, resloader)
  self.ui.attrTag.gameObject:SetActive(false)
  self.ui.statusTag.gameObject:SetActive(false)
  self:OnClickAttrDetail()
end

function UINDungeonInfoHeroDetail:__InitCommon(dynHeroData, resloader)
  self.ui.img_Quality.color = HeroRareColor[dynHeroData.heroData.rare]
  local inTd = BattleUtil.IsInTDBattle()
  self.cardItem:InitHeroCardItem(dynHeroData.heroData, resloader, nil)
  self.cardItem:ShowTalentStage(dynHeroData:GetDynHeroTalentLevel())
  self.cardItem:RefreshSpecialFocus(dynHeroData:IsFriendSupport(), dynHeroData:IsSupport())
  local gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.None
  local isTdSpecHero = inTd and ConfigData.skill_adapter.td_adapter[dynHeroData.dataId] ~= nil
  if isTdSpecHero then
    gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.TD
  end
  self.cardItem:SetSpecialGameHeroActive(gameTypeAdapter)
  self.skillPool:HideAll()
  for _, skillData in pairs(dynHeroData.showSkillDic) do
    if not skillData:IsCommonAttack() then
      local skillItem = self.skillPool:GetOne(true)
      skillItem:InitDungeonSkillItem(skillData, resloader, self.__onShowSkillDetail, self.__onHideRichInfoDetail)
      if skillData:GetSkillAdapterType() > 0 and inTd then
        skillItem:ShowAsTdSkill()
      end
    end
  end
  for _, skillitem in ipairs(self.skillPool.listItem) do
    if skillitem.skillData:IsPassiveSkill() then
      skillitem.transform:SetSiblingIndex(0)
    elseif skillitem.skillData:IsUniqueSkill() then
      skillitem.transform:SetSiblingIndex(#self.skillPool.listItem)
    end
  end
  if ExplorationManager.epCtrl ~= nil then
    self.serverGridPool:HideAll()
    local dynPlayer = ExplorationManager.epCtrl.dynPlayer
    local gridlist = dynPlayer.allDynServerGrid:GetHeroServerGrid(dynHeroData.dataId)
    if gridlist ~= nil then
      for _, serverGrid in pairs(gridlist) do
        local gridItem = self.serverGridPool:GetOne()
        gridItem:InitServerGridItem(serverGrid, self.__onShowServerGridDetail, self.__onHideRichInfoDetail)
      end
    end
  end
end

function UINDungeonInfoHeroDetail:__ShowSkillDetail(item, skillData)
  if skillData:GetIsUnlock() then
    self.__onRichIntroOpen = BindCallback(self, self.__RichIntroOpen, skillData)
    UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
      if win ~= nil then
        self.__onRichIntroOpen(win)
      end
    end)
  end
end

function UINDungeonInfoHeroDetail:__RichIntroOpen(skillData, win)
  local modifier
  local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if infowin ~= nil then
    modifier = infowin.ui.modifier
  end
  win:ShowIntroBySkillData(self.ui.introHolder, skillData, true, modifier, nil, nil, nil, true)
  win:SetIntroListPosition(cs_Edge.Left)
end

function UINDungeonInfoHeroDetail:__HideRichInfoDetail()
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

function UINDungeonInfoHeroDetail:__ShowServerGridDetail(serverGrid)
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win == nil then
      return
    end
    local modifier
    local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
    if infowin ~= nil then
      modifier = infowin.ui.modifier
    end
    local name, desc = serverGrid:GetGridNameAndDesc()
    win:ShowIntroCustom(self.ui.gridIntroHolder, name, desc, true, modifier)
    win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
  end)
end

function UINDungeonInfoHeroDetail:OnClickAttrDetail()
  self.ui.heroNode:SetActive(true)
  self.ui.stateNode:SetActive(false)
  self.ui.img_attrTag.color = self.ui.selectColor
  self.ui.attrTagText.color = Color.white
  self.ui.img_statusTag.color = self.ui.normalColor
  self.ui.statusTagText.color = self.ui.normalTextColor
end

function UINDungeonInfoHeroDetail:OnClickStatusDetail()
  self.ui.heroNode:SetActive(false)
  self.ui.stateNode:SetActive(true)
  self.ui.img_statusTag.color = self.ui.selectColor
  self.ui.statusTagText.color = Color.white
  self.ui.img_attrTag.color = self.ui.normalColor
  self.ui.attrTagText.color = self.ui.normalTextColor
end

function UINDungeonInfoHeroDetail:OnDelete()
  base.OnDelete(self)
end

return UINDungeonInfoHeroDetail
