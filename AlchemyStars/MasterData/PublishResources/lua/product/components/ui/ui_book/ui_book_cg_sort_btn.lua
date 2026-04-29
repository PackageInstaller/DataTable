_class("UIBookCGSortBtn", UICustomWidget)
UIBookCGSortBtn = UIBookCGSortBtn

function UIBookCGSortBtn:Constructor()
  self.names = {
    [BookCGType.Main] = StringTable.Get("str_book_cg_main"),
    [BookCGType.Ext] = StringTable.Get("str_book_cg_ext"),
    [BookCGType.Season] = StringTable.Get("str_season_system_name"),
    [BookCGType.Pet] = StringTable.Get("str_book_cg_pet_skin")
  }
end

function UIBookCGSortBtn:OnShow(uiParams)
end

function UIBookCGSortBtn:GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._selectImgGo = self:GetGameObject("selectImg")
end

function UIBookCGSortBtn:SetData(cgType, curCgType, callback)
  self:GetComponents()
  self._cgType = cgType
  self._callback = callback
  self:OnValue(curCgType)
end

function UIBookCGSortBtn:OnValue(curCgType)
  self._name:SetText(self.names[self._cgType])
  self:Flush(curCgType)
end

function UIBookCGSortBtn:bgOnClick()
  if self._callback then
    self._callback(self._cgType)
  end
end

function UIBookCGSortBtn:Flush(cgType)
  if cgType == self._cgType then
    self._selectImgGo:SetActive(true)
    self._name.color = Color(0.9882352941176471, 0.9098039215686274, 0.00784313725490196, 1)
  else
    self._selectImgGo:SetActive(false)
    self._name.color = Color(1, 1, 1, 1)
  end
end
