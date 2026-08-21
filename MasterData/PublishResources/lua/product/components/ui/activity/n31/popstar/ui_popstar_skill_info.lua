_class("UIPopStarSkillInfo", UICustomWidget)
UIPopStarSkillInfo = UIPopStarSkillInfo

function UIPopStarSkillInfo:OnShow()
  self._go = self:GetGameObject("go")
  local bg = self:GetGameObject("bg")
  local passEvent = bg:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:Close()
  end)
  self._root = self:GetUIComponent("RectTransform", "root")
  self._root.anchoredPosition = Vector2(10000, 0)
  self._go:SetActive(false)
  self._btnUse = self:GetGameObject("BtnUse")
  self._btnDown = self:GetGameObject("BtnDown")
  self._btns = self:GetGameObject("Btns")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._tips1Label = self:GetUIComponent("UILocalizationText", "Tips1")
  self._tips1 = self:GetGameObject("Tips1Panel")
  self._tips2Label = self:GetUIComponent("UILocalizationText", "Tips2")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIPopStarSkillInfo:RefreshOffset(btnType)
  local offsetX = 0
  local offsetY = 111
  if btnType == 0 then
    offsetX = 341
  else
    offsetX = 436.94
  end
  self._showAnchorPositions = {}
  self._showAnchorPositions[1] = Vector2(-50 - offsetX, -50 - offsetY)
  self._showAnchorPositions[2] = Vector2(50 + offsetX, -50 - offsetY)
  self._showAnchorPositions[3] = Vector2(50 + offsetX, 50 + offsetY)
  self._showAnchorPositions[4] = Vector2(-50 - offsetX, 50 + offsetY)
end

function UIPopStarSkillInfo:SetData(pos, btnType, petId, callback)
  self._petId = petId
  self._callback = callback
  self:RefreshOffset(btnType)
  self:RefreshUI()
  self._btnUse:SetActive(false)
  self._btnDown:SetActive(false)
  self._btns:SetActive(false)
  if btnType == 1 then
    self._btnDown:SetActive(true)
    self._btns:SetActive(true)
  elseif btnType == 2 then
    self._btnUse:SetActive(true)
    self._btns:SetActive(true)
  end
  self._go:SetActive(true)
  self._anim:Play("uieff_UIPopStarSkillInfo_in")
  self._root.position = pos
  local index = 0
  if 0 < self._root.anchoredPosition.x then
    if 0 < self._root.anchoredPosition.y then
      index = 1
    else
      index = 4
    end
  elseif 0 < self._root.anchoredPosition.y then
    index = 2
  else
    index = 3
  end
  local x = self._root.anchoredPosition.x + self._showAnchorPositions[index].x
  local y = self._root.anchoredPosition.y + self._showAnchorPositions[index].y
  self._root.anchoredPosition = Vector2(x, y)
end

function UIPopStarSkillInfo:RefreshUI()
  local petCfg = Cfg.cfg_popstar_pet_list[self._petId]
  local skillId = petCfg.SkillId
  local cfg = Cfg.cfg_pet_battle_skill[skillId]
  self._nameLabel:SetText(StringTable.Get(cfg.Name))
  self._desLabel:SetText(StringTable.Get(cfg.Desc))
  self._iconLoader:LoadImage(cfg.Icon)
  self._tips2Label:SetText(string.format(StringTable.Get("str_common_cooldown_round"), cfg.TriggerParam))
  if petCfg.PreAttack == nil or petCfg.PreAttack == "" then
    self._tips1:SetActive(false)
  else
    self._tips1:SetActive(true)
    self._tips1Label:SetText(StringTable.Get(petCfg.PreAttack))
  end
end

function UIPopStarSkillInfo:BtnUseOnClick()
  if self._callback then
    self._callback(self._petId)
    self:Close()
  end
end

function UIPopStarSkillInfo:BGOnClick()
end

function UIPopStarSkillInfo:BtnDownOnClick()
  if self._callback then
    self._callback(self._petId)
    self:Close()
  end
end

function UIPopStarSkillInfo:Close()
  self:StartTask(function(TT)
    self:Lock("UIPopStarSkillInfo_Close")
    self._anim:Play("uieff_UIPopStarSkillInfo_out")
    YIELD(TT, 170)
    self:UnLock("UIPopStarSkillInfo_Close")
  end, self)
end
