_class("PrepareStageItem", UICustomWidget)
PrepareStageItem = PrepareStageItem

function PrepareStageItem:Constructor()
  self.prePareType = nil
  self.clickCallback = nil
end

function PrepareStageItem:GetPrepareType()
  return self.prePareType
end

function PrepareStageItem:OnShow(uiParams)
  self:InitWidget()
end

function PrepareStageItem:InitWidget()
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.unSelectName = self:GetUIComponent("UILocalizationText", "unSelectName")
  self.select = self:GetGameObject("select")
  self.unSelect = self:GetGameObject("unSelect")
end

function PrepareStageItem:SetData(name, prepareType, clickCallback)
  self.prePareType = prepareType
  self.clickCallback = clickCallback
  local txt = StringTable.Get(name)
  self.name:SetText(txt)
  self.unSelectName:SetText(txt)
end

function PrepareStageItem:SetSelect(bSelect)
  self.select:SetActive(bSelect)
  self.unSelect:SetActive(not bSelect)
end

function PrepareStageItem:ItemBtnOnClick(go)
  if self.clickCallback then
    self.clickCallback(self)
  end
end
