_class("UIForgeSort", UICustomWidget)
UIForgeSort = UIForgeSort

function UIForgeSort:OnShow()
  self.txtSort = self:GetUIComponent("UILocalizationText", "txtSort")
  self.imgArrow = self:GetUIComponent("Transform", "imgArrow")
  self.arrow = self:GetUIComponent("Image", "imgArrow")
  self.data = self:GetModule(HomelandModule):GetForgeData()
  self.up = Vector3(0, 0, 180)
end

function UIForgeSort:OnHide()
end

function UIForgeSort:Init(forgeSortType)
  self.forgeSortType = forgeSortType
  self.txtSort:SetText(StringTable.Get("str_homeland_forge_sort_type_" .. forgeSortType))
end

function UIForgeSort:Flush()
  if self.data.tSort[1] == self.forgeSortType then
    if self.data.tSort[2] then
      self.imgArrow.localEulerAngles = self.up
    else
      self.imgArrow.localEulerAngles = Vector3.zero
    end
    self.arrow.color = Color(0.9725490196078431, 0.788235294117647, 0.48627450980392156)
  else
    self.arrow.color = Color(0.6, 0.6, 0.6)
  end
end

function UIForgeSort:bgOnClick(go)
  if self.data.tSort[1] == self.forgeSortType then
    self.data.tSort[2] = not self.data.tSort[2]
    self.data:SortList()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
  else
    self.data.tSort[1] = self.forgeSortType
    self.data:SortList()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
  end
end
