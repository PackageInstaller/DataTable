_class("UIHelpPetSortBtn", UICustomWidget)
UIHelpPetSortBtn = UIHelpPetSortBtn

function UIHelpPetSortBtn:Constructor()
  self.names = {
    [ElementType.ElementType_Blue] = StringTable.Get("str_help_pet_shui"),
    [ElementType.ElementType_Red] = StringTable.Get("str_help_pet_huo"),
    [ElementType.ElementType_Green] = StringTable.Get("str_help_pet_sen"),
    [ElementType.ElementType_Yellow] = StringTable.Get("str_help_pet_lei")
  }
end

function UIHelpPetSortBtn:OnShow(uiParams)
end

function UIHelpPetSortBtn:GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._selectImgGo = self:GetGameObject("selectImg")
end

function UIHelpPetSortBtn:SetData(cgType, curCgType, callback)
  self:GetComponents()
  self._cgType = cgType
  self._callback = callback
  self:OnValue(curCgType)
end

function UIHelpPetSortBtn:OnValue(curCgType)
  self._name:SetText(self.names[self._cgType])
  self:Flush(curCgType)
end

function UIHelpPetSortBtn:bgOnClick()
  if self._callback then
    self._callback(self._cgType)
  end
end

function UIHelpPetSortBtn:Flush(cgType)
  if cgType == self._cgType then
    self._selectImgGo:SetActive(true)
    self._name.color = Color(0.9882352941176471, 0.9098039215686274, 0.00784313725490196, 1)
  else
    self._selectImgGo:SetActive(false)
    self._name.color = Color(1, 1, 1, 1)
  end
end
