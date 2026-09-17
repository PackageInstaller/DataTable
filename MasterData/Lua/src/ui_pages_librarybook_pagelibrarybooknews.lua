local this = class("pageLibraryBookNews", G_UIPageBase)
local _libraryReadingsTpl = L_GameTpl:getLibraryReadingsTpl()
local selectedBookBrowseId = 20015

function this.bind()
  return {txt_name = ""}
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:refresh()
end

function this.methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:refresh()
  FrameScheduler.add(function()
    local tempRoot = self.bindComponents.contentRoot.gameObject:GetComponent(typeof(C_RectTransform))
    local tempLeft = self.bindComponents.contentLeft.gameObject:GetComponent(typeof(C_RectTransform))
    local tempRight = self.bindComponents.contentRight.gameObject:GetComponent(typeof(C_RectTransform))
    local tempSizeDataLeft = tempLeft.sizeDelta
    local tempSizeDataRight = tempRight.sizeDelta
    local maxHeight = math.max(tempSizeDataLeft.y, tempSizeDataRight.y)
    tempRoot.sizeDelta = C_Vector2(tempRoot.sizeDelta.x, maxHeight)
    local bookReadingTpl = _libraryReadingsTpl:getTplById(selectedBookBrowseId)
    if bookReadingTpl == nil then
      return
    end
    self.bind.txt_name = _libraryReadingsTpl:getAuthor(bookReadingTpl)
  end)
end

return this
