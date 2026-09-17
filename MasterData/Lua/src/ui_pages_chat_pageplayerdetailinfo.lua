local this = class("pagePlayerDetailInfo", G_UIPageBase)

function this.bind()
  return {
    module_playerDetailInfo = {
      moduleName = "pages/chat/modulePlayerDetailInfo"
    },
    playerDetailInfoPanel = nil,
    active_clickBgClose = false
  }
end

function this.methods()
  return {
    module_playerDetailInfo = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end
    },
    onClick_Bg_Close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.open(self, options)
  self.bUseUpdateCloseBack = options and options.clickCloseByUpdate
  self.bind.active_clickBgClose = options and options.clickBgClose and not options.clickCloseByUpdate
  self:refreshModule(options)
end

function this:refreshPageView(options)
  this.super.refreshPageView(self, options)
  self:refreshModule(options)
end

function this:refreshModule(options)
  local data = {
    uid = options.uid,
    isTeam = options.isTeam,
    visibleButtons = options.visibleButtons,
    inputTeamData = options.inputTeamData,
    isHideFriendBtn = options.isHideFriendBtn
  }
  self._teamType = options.isTeam
  self.modules.module_playerDetailInfo:initModule(data)
  if options.pos then
    local pos = options.pos
    if self._teamType == 4 then
      local node = self.modules.module_playerDetailInfo.gameObject.transform
      node = node:Find("AnimRoot/panel")
      local newPos = node.position
      newPos.x = pos.x
      newPos.y = pos.y
      node.position = newPos
      local localPos = node.localPosition
      localPos.x = localPos.x - node.sizeDelta.x * 0.5 * node.localScale.x
      node.localPosition = localPos
    else
      self.bind.playerDetailInfoPanel = pos
    end
  end
  self.onSelectCallBack = nil
  if options.onSelectCallBack then
    self.onSelectCallBack = options.onSelectCallBack
    self.onSelectCallBack(options.uid)
  end
  self.bInited = true
  self.delayHideSelfFrameNum = nil
end

function this:escHandle()
end

function this:close(options)
  self.bInited = false
  self.delayHideSelfFrameNum = nil
  if self.onSelectCallBack then
    self.onSelectCallBack(0)
  end
  self.onSelectCallBack = nil
  this.super.close(self, options)
end

function this:update()
  if not self.bUseUpdateCloseBack then
    return
  end
  if not self.bInited then
    return
  end
  if self.delayHideSelfFrameNum ~= nil and self.delayHideSelfFrameNum > 0 then
    self.delayHideSelfFrameNum = self.delayHideSelfFrameNum - 1
    if self.delayHideSelfFrameNum == 0 then
      self:HideSelf()
    end
  end
  if Unity.Input.GetAxis("Mouse ScrollWheel") ~= 0 then
    self:HideSelf()
    return
  end
  if Unity.Input.GetMouseButtonDown(0) then
    local rect = self.bindComponents.infoAreaRect
    local mousePositionV2 = C_Vector2(Unity.Input.mousePosition.x, Unity.Input.mousePosition.y)
    local isUI = Unity.RectTransformUtility.RectangleContainsScreenPoint(rect, mousePositionV2, Unity.GameObject.Find("[UI Camera]"):GetComponent("Camera"))
    if not isUI then
      local topPageName = L_UI:currentPage(L_UI.groupKeys.stack)
      if topPageName == "pageCommonTip" or topPageName == "pageCommonTextBox" or topPageName == "PageReportPlayerSingle" then
        return
      end
      self:HideSelfOnClick()
      return
    end
  end
end

function this:HideSelfOnClick()
  if self.delayHideSelfFrameNum ~= nil and self.delayHideSelfFrameNum > 0 then
    return
  end
  self.delayHideSelfFrameNum = L_UI.debugValue or 7
end

function this:HideSelf()
  L_UI:close(self.pageName)
end

return this
