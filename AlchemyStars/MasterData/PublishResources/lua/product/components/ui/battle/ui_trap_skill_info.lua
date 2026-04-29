_class("UITrapSkillInfo", UICustomWidget)
UITrapSkillInfo = UITrapSkillInfo

function UITrapSkillInfo:Constructor()
end

function UITrapSkillInfo:OnShow()
  self.enableFakeInput = true
  self._skillRoot = self:GetGameObject("skillRoot")
  self._skillRootPath = self:GetUIComponent("UISelectObjectPath", "skillRoot")
  self:AttachEvent(GameEventType.TrapPowerChange, self.OnTrapPowerChange)
  self:AttachEvent(GameEventType.TrapPowerVisible, self.OnTrapPowerVisible)
end

function UITrapSkillInfo:OnHide()
  self:DetachEvent(GameEventType.TrapPowerChange, self.OnTrapPowerChange)
  self:DetachEvent(GameEventType.TrapPowerVisible, self.OnTrapPowerVisible)
end

function UITrapSkillInfo:SetData(entityID)
  self._entityID = entityID
  local trapPowerMax = InnerGameHelperRender.GetTrapAttribute(self._entityID, "TrapPowerMax")
  self._skillRootPath:SpawnObjects("UITrapSkillEnergyItem", trapPowerMax)
  self._skillItemList = self._skillRootPath:GetAllSpawnList()
  local gridLayoutGroup = self:GetUIComponent("GridLayoutGroup", "skillRoot")
  local useCarSkin = InnerGameHelperRender.GetTrapIsCastSkillByRound(self._entityID)
  self.innerUIAtlas = self:GetAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  for i = 1, #self._skillItemList do
    local skillItem = self._skillItemList[i]
    local spriteImage, spriteImageBG
    local imageOffset = Vector3(0, 0, 0)
    if useCarSkin then
      spriteImage = self.innerUIAtlas:GetSprite("N15_WarChess_icon_carcharged")
      spriteImageBG = self.innerUIAtlas:GetSprite("N15_WarChess_icon_caruncharged")
    else
      spriteImage = self.innerUIAtlas:GetSprite("thread_junei_xuetiao15")
      spriteImageBG = self.innerUIAtlas:GetSprite("thread_junei_xuetiao14")
      imageOffset = Vector3(0, -2.1, 0)
    end
    skillItem:OnRefreshImage(spriteImage, spriteImageBG, imageOffset)
  end
  if useCarSkin then
    gridLayoutGroup.spacing = Vector2(0, 0)
  else
    gridLayoutGroup.spacing = Vector2(5, 0)
  end
  self:_OnUpdate()
end

function UITrapSkillInfo:OnTrapPowerVisible(visible)
  if not self._skillRoot then
    return
  end
  self._skillRoot.gameObject:SetActive(visible)
  if visible then
    self:_OnUpdate()
  end
end

function UITrapSkillInfo:OnTrapPowerChange()
  if not self._entityID then
    return
  end
  self:_OnUpdate()
end

function UITrapSkillInfo:_OnUpdate()
  local trapPower = InnerGameHelperRender.GetTrapAttribute(self._entityID, "TrapPower")
  for i = 1, #self._skillItemList do
    local skillItem = self._skillItemList[i]
    skillItem:OnVisible(i <= trapPower)
  end
end

function UITrapSkillInfo:buttonSkillOnClick()
end
