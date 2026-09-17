local this = class("storyDialogManager", G_EventManagerBase)

function this:ctor()
  this.super.ctor(self)
  self._pageName = "dialogWindow_Common"
  self._dialogCommon = nil
  self._dialogData = nil
  self._queue = L_Struct.getQueue()
  self._event = require("core.event").new()
end

function this:closeDialog()
  if not self._dialogData then
    return
  end
  local onclosed = self._dialogData.onclosed
  
  local function closePageMask()
    self:_closePageMask()
    if onclosed ~= nil then
      onclosed()
    end
  end
  
  if self._dialogData.fadeOutTime ~= nil and self._dialogData.fadeOutTime > 0 then
    L_GameUtil.openMask({
      coverdTime = self._dialogData.fadeOutTime,
      fadeOut = true,
      isCompleteClose = false,
      callback = closePageMask
    })
  else
    closePageMask()
  end
  L_UI:close(self._pageName)
  self._dialogData = nil
  self._dialogCommon = nil
  self._queue:clear()
end

function this:showDialog(data)
  if not (data and data.showType) or not data.messages then
    return
  end
  if self._dialogData == nil then
    self._dialogData = data
    self:_showDialogWithData()
  else
    self._queue:enQueue(data)
  end
end

function this:_showDialogWithData()
  if not self._dialogData then
    return
  end
  if self._dialogData.fadeInTime ~= nil and self._dialogData.fadeInTime > 0 then
    L_GameUtil.openMask({
      coverdTime = self._dialogData.fadeInTime,
      fadeIn = true,
      isCompleteClose = false,
      callback = handler(self, self._loadDialogWindow)
    })
    local pageMask = L_UI:getPage("pageMask")
    if pageMask ~= nil and pageMask.cls and pageMask.cls.canvas then
      pageMask.cls.canvas.overrideSorting = true
    end
  else
    self:_loadDialogWindow()
  end
end

function this:_loadDialogWindow()
  if not self._dialogData then
    self:_closePageMask()
    return
  end
  if self._dialogCommon == nil then
    local page = L_UI:getPage(self._pageName)
    if not L_UI:checkPageShown(self._pageName, true) then
      local options = {}
      
      local function loadCallback()
        local _page = L_UI:getPage(self._pageName)
        self._dialogCommon = _page.cls
        self:_setDialogData()
        self:_closePageMask()
      end
      
      L_UI:open(self._pageName, options, loadCallback)
      return
    else
      self._dialogCommon = page.cls
    end
  end
  self:_setDialogData()
  self:_closePageMask()
end

function this:_setDialogData()
  if self._dialogData == nil then
    L_UI:close(self._pageName)
    return
  end
  self._dialogCommon:setTextData(self._dialogData, handler(self, self._onCurrentDialogEnd))
end

function this:_onCurrentDialogEnd()
  if self._queue:getLength() <= 0 or not self._dialogCommon then
    self:closeDialog()
  else
    self._dialogData = self._queue:deQueue()
    self:_showDialogWithData()
  end
end

function this:_closePageMask()
  if L_UI:checkPageShown("pageMask", true) then
    L_UI:close("pageMask")
  end
end

return this
