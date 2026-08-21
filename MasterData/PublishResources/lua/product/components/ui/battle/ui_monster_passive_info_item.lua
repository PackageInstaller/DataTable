_class("UIMonsterPassiveInfoItem", UICustomWidget)
UIMonsterPassiveInfoItem = UIMonsterPassiveInfoItem

function UIMonsterPassiveInfoItem:OnShow()
  self._descName = self:GetUIComponent("RollingText", "descName")
  self._typeName = self:GetUIComponent("RollingText", "typeName")
  self._typeNameBG = self:GetUIComponent("Image", "bg")
  self._line = self:GetGameObject("line")
  self._describeText = self:GetUIComponent("UILocalizationText", "describeText")
  self._textRect = self:GetUIComponent("RectTransform", "describeText")
  self._go = self:GetGameObject()
  self._uiBattleAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
end

function UIMonsterPassiveInfoItem:OnHide()
end

function UIMonsterPassiveInfoItem:Init(type, name, desc)
  local iconName, typeName
  if type == MonsterPassiveInfoType.Base then
    iconName = "thread_junei_tipsborad04"
    typeName = "str_battle_monster_base_passive"
  elseif type == MonsterPassiveInfoType.AntiSkill then
    iconName = "thread_junei_tipsborad05"
    typeName = "str_battle_monster_passive_skill"
  end
  self._typeNameBG.sprite = self._uiBattleAtlas:GetSprite(iconName)
  local temp = StringTable.Get(typeName)
  self._typeName:RefreshText(StringTable.Get(typeName))
  temp = StringTable.Get(name)
  self._descName:RefreshText(StringTable.Get(name))
  temp = StringTable.Get(desc)
  self._describeText:SetText(StringTable.Get(desc))
end

function UIMonsterPassiveInfoItem:InitElite(index, eliteID)
  local cfgElite = Cfg.cfg_monster_elite[eliteID]
  if not cfgElite then
    return
  end
  self._buffIcon.gameObject:SetActive(false)
  self._describeText.text = StringTable.Get(cfgElite.Name) .. " : " .. StringTable.Get(cfgElite.Desc)
  self._textRect.sizeDelta = Vector2(580, self._textRect.sizeDelta.y)
  self._layout.padding.left = -25
end
