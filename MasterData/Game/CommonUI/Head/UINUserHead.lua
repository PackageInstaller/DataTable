local UINBaseHead = require("Game.CommonUI.Head.UINBaseHead")
local UINUserHead = class("UINUseHead", UINBaseHead)
local base = UINBaseHead

function UINUserHead:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_UserHead, self, self.OnUserHeadClicked)
end

function UINUserHead:InitUserHeadUI(headId, frameId, resloader)
  self.__resloader = resloader
  self:InitBaseHeadFull(headId, frameId, resloader)
end

function UINUserHead:RefreshUserHeadOnly(headId)
  self:__InitBaseHead(headId, self.__resloader)
end

function UINUserHead:RefreshUserHeadFrameOnly(frameId)
  self:__InitBaseHeadFrame(frameId, self.__resloader)
end

function UINUserHead:BindUserHeadEvent(clickEvent)
  self.__clickEvent = clickEvent
  self.ui.drawraycast.raycastTarget = true
end

function UINUserHead:OnUserHeadClicked()
  if self.__clickEvent ~= nil then
    self.__clickEvent()
  end
end

function UINUserHead:OnDelete()
  base.OnDelete(self)
end

return UINUserHead
