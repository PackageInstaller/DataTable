local UINEpSptRoomHeroDetail = class("UINEpSptRoomHeroDetail", UIBaseNode)
local base = UIBaseNode
local UINDungeonInfoHeroDetailAttr = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailAttr")
local UINDungeonInfoHeroDetailSkill = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailSkill")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UINEpSptRoomHeroDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.potentialImgWidth = self.ui.img_Breakthrough.sprite.textureRect.width
  self.ui.attriItem:SetActive(false)
  self.attrItemPool = UIItemPool.New(UINDungeonInfoHeroDetailAttr, self.ui.attriItem)
  self.ui.skillItem:SetActive(false)
  self.skillItemPool = UIItemPool.New(UINDungeonInfoHeroDetailSkill, self.ui.skillItem)
  self.__onShowSkillDetail = BindCallback(self, self.__ShowSkillDetail)
  self.__onHideRichInfoDetail = BindCallback(self, self.__HideRichInfoDetail)
end

function UINEpSptRoomHeroDetail:_InitBase(heroData)
  self:_RefreshPotential(heroData.potential)
  self:_RefreshLevel(heroData.level)
  self.ui.tex_HeroName.text = heroData:GetName()
end

function UINEpSptRoomHeroDetail:InitEpSptExRoomHeroDetail(heroData, resloader, fightPower)
  self:_InitBase(heroData)
  self.ui.tex_Power.text = tostring(fightPower)
  self.ui.img_HP.fillAmount = 1
  local maxHp = heroData:GetAttr(eHeroAttr.maxHp)
  self.ui.tex_HP:SetIndex(0, tostring(math.floor(maxHp)), tostring(maxHp))
  self.attrItemPool:HideAll()
  for _, attrId in ipairs(ConfigData.game_config.dungeonHeroMainAttrIds) do
    local attrVal = heroData:GetAttr(attrId)
    local attrItem = self.attrItemPool:GetOne()
    attrItem:InitAttr(attrId, attrVal, attrVal)
  end
  self.skillItemPool:HideAll()
  for k, skillData in ipairs(heroData.skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local skillItem = self.skillItemPool:GetOne()
      local battleSkill = DynBattleSkill.New(skillData.dataId, skillData.level, eBattleSkillLogicType.Original, skillData:IsSkillUnlockAdvance())
      battleSkill:SetIsFullLevel(skillData:IsFullLevel())
      skillItem:InitDungeonSkillItem(battleSkill, resloader, self.__onShowSkillDetail, self.__onHideRichInfoDetail)
    end
  end
end

function UINEpSptRoomHeroDetail:InitEpSptRoomHeroDetail(dynHeroData, resloader, fightPower)
  local heroData = dynHeroData.heroData
  self:_InitBase(heroData)
  local power = fightPower
  if power == nil then
    power = dynHeroData:GetFightingPower()
  end
  self.ui.tex_Power.text = tostring(power)
  local hpPer = dynHeroData.hpPer / 10000
  self.ui.img_HP.fillAmount = hpPer
  local maxHp = dynHeroData:GetRealAttr(eHeroAttr.maxHp)
  local realHp = maxHp * dynHeroData.hpPer / 10000
  if dynHeroData.hpPer / 10000 > 0 then
    realHp = math.max(1, realHp)
  end
  self.ui.tex_HP:SetIndex(0, tostring(math.floor(realHp)), tostring(maxHp))
  self.attrItemPool:HideAll()
  for _, attrId in ipairs(ConfigData.game_config.dungeonHeroMainAttrIds) do
    local attrVal = dynHeroData:GetRealAttr(attrId)
    local attrOriginVal = dynHeroData:GetOriginAttr(attrId)
    local attrItem = self.attrItemPool:GetOne()
    attrItem:InitAttr(attrId, attrVal, attrOriginVal)
  end
  self.skillItemPool:HideAll()
  for index, skillData in pairs(dynHeroData.showSkillDic) do
    if not skillData:IsCommonAttack() then
      local skillItem = self.skillItemPool:GetOne()
      skillItem:InitDungeonSkillItem(skillData, resloader, self.__onShowSkillDetail, self.__onHideRichInfoDetail)
    end
  end
  for _, skillitem in ipairs(self.skillItemPool.listItem) do
    if skillitem.skillData:IsPassiveSkill() then
      skillitem.transform:SetSiblingIndex(0)
    elseif skillitem.skillData:IsUniqueSkill() then
      skillitem.transform:SetSiblingIndex(#self.skillItemPool.listItem)
    end
  end
end

function UINEpSptRoomHeroDetail:_RefreshLevel(level)
  if 999 < level then
    warn("level Num is out off MaxSize 999")
  end
  local empty = ""
  if level <= 9 then
    empty = "00"
  elseif level <= 99 then
    empty = "0"
  end
  self.ui.tex_Level:SetIndex(0, empty, level)
end

function UINEpSptRoomHeroDetail:_RefreshPotential(potential)
  local vec = self.ui.img_Breakthrough.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * potential
  self.ui.img_Breakthrough.rectTransform.sizeDelta = vec
end

function UINEpSptRoomHeroDetail:__ShowSkillDetail(item, skillData)
  if skillData:GetIsUnlock() then
    UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
      if win ~= nil then
        self:__RichIntroOpen(skillData, win)
      end
    end)
  end
end

function UINEpSptRoomHeroDetail:__RichIntroOpen(skillData, win)
  local modifier
  local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if infowin ~= nil then
    modifier = infowin.ui.modifier
  end
  win:ShowIntroBySkillData(self.ui.introHolder, skillData, true, modifier, nil, nil, 1)
  win:SetIntroListPosition(cs_Edge.Left)
end

function UINEpSptRoomHeroDetail:__HideRichInfoDetail()
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

function UINEpSptRoomHeroDetail:OnDelete()
  self.attrItemPool:DeleteAll()
  self.skillItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINEpSptRoomHeroDetail
