_class("UIEliminateSkillItem", UICustomWidget)
UIEliminateSkillItem = UIEliminateSkillItem

function UIEliminateSkillItem:Constructor()
  self._isSelect = false
end

function UIEliminateSkillItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateSkillItem:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._intro = self:GetUIComponent("UILocalizationText", "Intro")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._selectMaskObj = self:GetGameObject("selectMask")
end

function UIEliminateSkillItem:SetData(id, index, clickCB, chooseCB)
  self._id = id
  self._index = index
  self._clickCB = clickCB
  self._chooseCB = chooseCB
  self:_InitComponents()
end

function UIEliminateSkillItem:_InitComponents()
  local itemCfg = Cfg.cfg_item[self._id]
  self._icon:LoadImage(itemCfg.Icon)
  self._name:SetText(StringTable.Get(itemCfg.Name))
  self._intro:SetText(StringTable.Get(itemCfg.Intro))
  self:StartTask(function(TT)
    YIELD(TT, 30 * (self._index - 1))
    self._anim:Play("uieff_UIEliminateChooseSkillItem_in")
  end)
end

function UIEliminateSkillItem:GetID()
  return self._id
end

function UIEliminateSkillItem:SetSelect(isSelect)
  self._isSelect = isSelect
  self._selectMaskObj:SetActive(isSelect)
end

function UIEliminateSkillItem:ChooseItem()
  if self._chooseCB then
    self._chooseCB(self)
  end
end

function UIEliminateSkillItem:PlayOutAnim()
  if self._isSelect then
    self._anim:Play("uieff_UIEliminateChooseSkillItem_out2")
  else
    self._anim:Play("uieff_UIEliminateChooseSkillItem_out1")
  end
end

function UIEliminateSkillItem:BtnOnClick()
  if self._isSelect then
    return
  end
  self:SetSelect(true)
  if self._clickCB then
    self._clickCB(self)
  end
end
