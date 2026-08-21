_class("UIEnemyBookTip", UIController)
UIEnemyBookTip = UIEnemyBookTip

function UIEnemyBookTip:OnShow(uiParam)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._imgCG = self:GetUIComponent("RawImageLoader", "cgoffset")
  self._tranCG = self:GetUIComponent("RectTransform", "cgoffset")
  self._powerTex = self:GetUIComponent("UILocalizationText", "power")
  self._isBoss = self:GetGameObject("bossTag")
  self._move = self:GetUIComponent("UILocalizationText", "move")
  self._body = self:GetUIComponent("UILocalizationText", "body")
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end)
  self._enemis = uiParam[1]
  self:Init()
end

function UIEnemyBookTip:OnHide()
  if self._imgCG then
    self._imgCG:DestoryLastImage()
    self._imgCG = nil
  end
  self._backBtns = nil
end

function UIEnemyBookTip:Init()
  self._monsters = {}
  for i, v in ipairs(self._enemis) do
    local enemy = Enemy:New()
    enemy:Init(v)
    table.insert(self._monsters, enemy)
  end
  self:Flush(self._currIdx)
end

function UIEnemyBookTip:Flush()
  local enemy = self._monsters[1]
  self._txtName:SetText(enemy.name)
  self._txtDesc:SetText(StringTable.Get("str_discovery_enemy_intr") .. enemy.desc)
  if enemy.power then
    self._powerTex:SetText(StringTable.Get("str_discovery_enemy_power") .. enemy.power)
  else
    self._powerTex:SetText("")
  end
  local staticBody = enemy.staticBody
  local size = Cfg.cfg_global.ui_interface_common_monster_size.ArrayValue
  self._tranCG.sizeDelta = Vector2(size[1], size[2])
  UICG.SetTransform(self._tranCG, "UIEnemyTip", staticBody)
  self._imgCG:LoadImage(staticBody)
  self._isBoss:SetActive(enemy.isBoss)
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
end

function UIEnemyBookTip:bgOnClick()
  self:CloseDialog()
end
