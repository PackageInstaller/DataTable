_class("UIPetEquipUpLvInfoSkillItem", UICustomWidget)
UIPetEquipUpLvInfoSkillItem = UIPetEquipUpLvInfoSkillItem

function UIPetEquipUpLvInfoSkillItem:Constructor()
end

function UIPetEquipUpLvInfoSkillItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIPetEquipUpLvInfoSkillItem:OnHide()
  self._lv = nil
  self._desc = nil
  self._lvTex = nil
  self._descTex = nil
end

function UIPetEquipUpLvInfoSkillItem:SetData(data)
  self._lv, self._desc = data:GetData()
  self:_OnValue()
end

function UIPetEquipUpLvInfoSkillItem:_GetComponents()
  self._lvTex = self:GetUIComponent("UILocalizationText", "lv")
  self._descTex = self:GetUIComponent("UILocalizedTMP", "desc")
  
  function self._descTex.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
end

function UIPetEquipUpLvInfoSkillItem:_OnValue()
  self._lvTex:SetText("Lv." .. self._lv)
  self._descTex:SetText(self._desc)
end
