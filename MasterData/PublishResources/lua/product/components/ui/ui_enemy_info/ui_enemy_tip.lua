_class("UIEnemyTip", UIController)
UIEnemyTip = UIEnemyTip

function UIEnemyTip:OnShow(uiParam)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._texRect = self:GetUIComponent("RectTransform", "txtName")
  self._contentSizeFilter = self:GetUIComponent("ContentSizeFitter", "txtName")
  self._nameRoot = self:GetUIComponent("RectTransform", "name")
  self._txtProperty = self:GetUIComponent("UILocalizationText", "txtProperty")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._imgCG = self:GetUIComponent("RawImageLoader", "cgoffset")
  self._tranCG = self:GetUIComponent("RectTransform", "cgoffset")
  self._powerTex = self:GetUIComponent("UILocalizationText", "power")
  self._isBoss = self:GetGameObject("txtBoss")
  self.txtElite = self:GetGameObject("txtElite")
  self.EliteGroup = self:GetGameObject("EliteGroup")
  self.txtEliteDesc = self:GetUIComponent("UILocalizationText", "txtEliteDesc")
  self._move = self:GetUIComponent("UILocalizationText", "move")
  self._body = self:GetUIComponent("UILocalizationText", "body")
  self._enemis = uiParam[1]
  self._currIdx = uiParam[2] or 1
  self:Init()
end

function UIEnemyTip:OnHide()
  if self._imgCG then
    self._imgCG:DestoryLastImage()
    self._imgCG = nil
  end
  self._backBtns = nil
end

function UIEnemyTip:Init()
  self._monsters = {}
  for i, v in ipairs(self._enemis) do
    local enemy = Enemy:New()
    enemy:Init(v)
    table.insert(self._monsters, enemy)
  end
  if self._monsters then
    local monsterCount = table.count(self._monsters)
    self._content:SpawnObjects("UIEnemyTipItem", monsterCount)
    self._enemyItems = self._content:GetAllSpawnList()
    for i = 1, #self._enemyItems do
      self._enemyItems[i]:Flush(i, self._monsters[i], function(idx)
        self:Flush(idx)
      end)
    end
    self:Flush(self._currIdx)
  end
end

function UIEnemyTip:Flush(idx)
  self._currIdx = idx
  local enemy = self._monsters[idx]
  self._txtName:SetText(enemy.name)
  self._txtProperty:SetText(enemy.prop.name)
  self._txtDesc:SetText(StringTable.Get("str_discovery_enemy_intr") .. enemy.desc)
  self._powerTex:SetText(StringTable.Get("str_discovery_enemy_power") .. enemy.power)
  local staticBody = enemy.staticBody
  local size = Cfg.cfg_global.ui_interface_common_monster_size.ArrayValue
  self._tranCG.sizeDelta = Vector2(size[1], size[2])
  UICG.SetTransform(self._tranCG, self:GetName(), staticBody)
  self._imgCG:LoadImage(staticBody)
  self._isBoss:SetActive(enemy.isBoss)
  self.txtElite:SetActive(enemy.isElite)
  self.EliteGroup:SetActive(enemy.isElite)
  if enemy.isElite then
    self.txtEliteDesc:SetText(enemy.eliteDesc)
  end
  local strArea = ""
  strArea = StringTable.Get("str_discovery_enemy_grid", enemy.area)
  local strStep = ""
  if enemy.canMove then
    strStep = StringTable.Get("str_discovery_enemy_grid", enemy.step)
  else
    strStep = StringTable.Get("str_discovery_enemy_cant_move")
  end
  self._body:SetText(strArea)
  self._move:SetText(strStep)
  for i = 1, #self._enemyItems do
    self._enemyItems[i]:Select(self._currIdx)
  end
  local texWidth
  if enemy.isBoss and enemy.isElite then
    texWidth = 477
  elseif enemy.isBoss or enemy.isElite then
    texWidth = 690
  else
    texWidth = 1024
  end
  self._texRect.sizeDelta = Vector2(texWidth, 100)
  if texWidth > self._txtName.preferredWidth then
    self._contentSizeFilter.enabled = true
  else
    self._contentSizeFilter.enabled = false
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._nameRoot)
end

function UIEnemyTip:bgOnClick()
  self:CloseDialog()
end
