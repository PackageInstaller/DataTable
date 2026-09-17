local this = class("cellLibraryBrowseTabItem", G_UIModuleBase)
local _libraryReadingsTpl = L_GameTpl:getLibraryReadingsTpl()
local COLORS = {
  black = CS.UnityEngine.Color(0, 0, 0),
  white = C_LuaUtility.ParseHtmlStringColor("#FDFDFD")
}

function this.bind()
  return {
    tfmLeftImg = false,
    tfmImg = false,
    tfmLine = false,
    tfmLock = false,
    tfmClickBtn = false,
    tfmbg = false,
    imgTxt = "",
    scaleNum = C_Vector3(0, 0, 0)
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      local isBookNameType = self.bind.index % 2 ~= 0
      if not isBookNameType then
        return
      end
      if self.bind.callback ~= nil then
        self.bind:callback(self)
      end
    end
  }
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  local isBookNameType = self.bind.index % 2 ~= 0
  self.bind.tfmLeftImg = isBookNameType
  self.bind.tfmLine = not isBookNameType
  self.bind.tfmClickBtn = true
  if not isBookNameType then
    self.bind.tfmbg = false
    self.bind.tfmClickBtn = false
  end
  local isBookCollected = L_LibraryBookStore:isLibraryBookCollect(self.bind.id)
  local bookReadingTpl = _libraryReadingsTpl:getTplById(self.bind.id)
  self.bind.tfmLock = not isBookCollected and isBookNameType
  self.bind.tfmImg = isBookNameType and isBookCollected
  if bookReadingTpl ~= nil then
    self.bind.imgTxt = bookReadingTpl.chapterIcon
  end
end

function this:setSelected(isSelected)
  local imgColor = COLORS.white
  local localScale = C_Vector3(0.7, 0.7, 0.7)
  if isSelected then
    imgColor = COLORS.white
    localScale = C_Vector3(1, 1, 1)
  else
    imgColor = COLORS.black
    localScale = C_Vector3(0.7, 0.7, 0.7)
  end
  self.bindComponents.imgNum.color = imgColor
  self.bindComponents.imgLock.color = imgColor
  self.bind.scaleNum = localScale
  self.bind.tfmbg = isSelected
end

return this
