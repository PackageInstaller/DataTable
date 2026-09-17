local this = class("cellIconLibraryBook", G_UIModuleBase)

function this:open()
  self:refreshView()
end

function this.bind()
  return {
    tfmUnlock = true,
    tfmSelected = false,
    txtDesc = "",
    tfmReddowNew = false,
    txtCollect = "",
    txtUnCollect = "",
    active_c = false,
    active_unC = false,
    imgBook = nil,
    active_show = true,
    color_BgButton = C_Color(1, 1, 1, 1),
    color_imgBook = C_Color(1, 1, 1, 1),
    color_txtDesc = C_Color(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function this:refreshView()
  if self.bind.isEmpty == true then
    self.bind.active_show = false
    return
  end
  self.bind.active_show = true
  local librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
  local tempTpl = librarySeriesTpl:getTplById(self.bind.seriesId)
  if tempTpl == nil then
    return
  end
  self.bind.txtDesc = librarySeriesTpl:getName(tempTpl)
  self:refreshDataChange()
  if tempTpl.icon ~= nil then
    self.bind.imgBook = tempTpl.icon
  end
  local totalNum = tostring(#tempTpl.subId)
  local collectedNum = 0
  for k2, v2 in pairs(tempTpl.subId) do
    for k3, v3 in pairs(L_LibraryBookStore.data.itemDic) do
      if v2 == v3.itemId then
        collectedNum = collectedNum + 1
        break
      end
    end
  end
  local tx = tostring(collectedNum) .. "/" .. totalNum
  self.bind.txtCollect = tx
  self.bind.txtUnCollect = tx
  if 0 < collectedNum then
    self.bind.active_c = true
    self.bind.active_unC = false
  else
    self.bind.active_c = false
    self.bind.active_unC = true
  end
end

function this:setSelected(isSelected, playSelectedAnim)
  if self.isSelected == isSelected then
    return
  end
  self.isSelected = isSelected
  self.bind.tfmSelected = isSelected
  if playSelectedAnim and isSelected and self.bindComponents then
    self.bindComponents.anim_Select:Stop()
    self.bindComponents.anim_Select:Play()
  end
end

function this:refreshDataChange()
  local librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
  local tempTpl = librarySeriesTpl:getTplById(self.bind.seriesId)
  if tempTpl == nil then
    return
  end
  local isContainNew = false
  local isUnlock = false
  for k, v in pairs(tempTpl.subId) do
    for k2, v2 in pairs(L_LibraryBookStore.data.itemDic) do
      if v == v2.itemId then
        isUnlock = true
        if v2.isNew == nil or v2.isNew == 0 then
          isContainNew = true
        end
      end
    end
  end
  self.bind.tfmReddowNew = isContainNew
  self.bind.tfmUnlock = not isUnlock
  if isUnlock then
    local _, _color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    self.bind.color_BgButton = _color
    self.bind.color_imgBook = _color
    self.bind.color_txtDesc = _color
  else
    local _, _color = C_ColorUtility.TryParseHtmlString("#808080")
    self.bind.color_BgButton = _color
    self.bind.color_imgBook = _color
    self.bind.color_txtDesc = _color
  end
end

return this
