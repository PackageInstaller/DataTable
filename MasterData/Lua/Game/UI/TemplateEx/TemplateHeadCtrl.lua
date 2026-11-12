local TemplateHeadCtrl = class("TemplateHeadCtrl", BaseCtrl)
local HeadType = {Monster = 1, Char = 2}
TemplateHeadCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgSelect = {},
  Monster = {
    sNodeName = "--Monster--"
  },
  goBoss = {},
  goElite = {}
}
TemplateHeadCtrl._mapEventConfig = {}

function TemplateHeadCtrl:SetMonsterHead(nMonsterId)
  self:_SwitchType(HeadType.Monster)
  local mapMonster = ConfigTable.GetData("Monster", nMonsterId)
  if mapMonster == nil then
    self.gameObject:SetActive(false)
    return
  end
  local mapSkin = ConfigTable.GetData("MonsterSkin", mapMonster.FAId)
  if mapSkin == nil then
    return
  end
  local mapMonsterManual = ConfigTable.GetData("MonsterManual", mapSkin.MonsterManual)
  if mapMonsterManual == nil then
    return
  end
  self.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgIcon, mapMonsterManual.Icon)
  if mapMonster.EpicLv == GameEnum.monsterEpicType.LORD then
    self._mapNode.goBoss:SetActive(true)
    self._mapNode.goElite:SetActive(false)
  elseif mapMonster.EpicLv == GameEnum.monsterEpicType.LEADER or mapMonster.EpicLv == GameEnum.monsterEpicType.ELITE then
    self._mapNode.goBoss:SetActive(false)
    self._mapNode.goElite:SetActive(true)
  else
    self._mapNode.goBoss:SetActive(false)
    self._mapNode.goElite:SetActive(false)
  end
end

function TemplateHeadCtrl:_SwitchType(enumType)
  self._mapNode.Monster:SetActive(enumType == HeadType.Monster)
end

function TemplateHeadCtrl:SetCharHead(nSkinId)
  local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nSkinId)
  if mapSkinCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgIcon, mapSkinCfg.Icon .. AllEnum.CharHeadIconSurfix.XXL)
  end
end

return TemplateHeadCtrl
