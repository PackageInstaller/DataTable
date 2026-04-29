_class("UIChooseBgSecondTabItem", UICustomWidget)
UIChooseBgSecondTabItem = UIChooseBgSecondTabItem

function UIChooseBgSecondTabItem:OnShow()
  self:_GetComponents()
  self._type2tips = {
    [BookCGType.Main] = "str_book_main_cg_active",
    [BookCGType.Ext] = "str_book_ext_cg_active",
    [BookCGType.Season] = "str_book_season_cg_active",
    [BookCGType.Pet] = "str_book_pet_skin_cg_active"
  }
  self._names = {
    [BookCGType.Main] = "str_book_cg_main",
    [BookCGType.Ext] = "str_book_cg_ext",
    [BookCGType.Season] = "str_book_cg_season",
    [BookCGType.Pet] = "str_book_cg_pet_skin"
  }
end

function UIChooseBgSecondTabItem:_GetComponents()
  self._sceneSelectObj = self:GetGameObject("sceneSelect")
  self._title = self:GetUIComponent("UILocalizationText", "title")
end

function UIChooseBgSecondTabItem:SetData(type, data, callback)
  self._type = type
  self._data = data
  self._callback = callback
  self:InitComponent()
end

function UIChooseBgSecondTabItem:InitComponent()
  self._title:SetText(StringTable.Get(self._names[self._type]))
end

function UIChooseBgSecondTabItem:SetSelect(isSelect)
  self._isSelect = isSelect
  self._sceneSelectObj:SetActive(isSelect)
end

function UIChooseBgSecondTabItem:GetData()
  return self._data
end

function UIChooseBgSecondTabItem:BtnOnClick()
  if self._isSelect then
    return
  end
  if table.count(self._data) < 1 then
    local tipsStr = StringTable.Get(self._type2tips[self._type])
    ToastManager.ShowToast(tipsStr)
    return
  end
  self:SetSelect(true)
  if self._callback then
    self._callback(self)
  end
end
