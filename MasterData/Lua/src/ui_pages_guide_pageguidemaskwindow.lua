local cls = class("pageGuideMaskWindow", G_UIPageBase)
local tag = "pageGuideMaskWindow"

function cls.bind()
  return {totalMaskActive = true, guideMaskActive = false}
end

function cls:preOpen(options)
  self.bind.totalMaskActive = false
  self.bind.guideMaskActive = true
  self._guideMaskData = options
  self._initSuccess = false
  self:initMask()
end

function cls:onFinish()
  if self._guideMaskData.finishCallBack then
    self._guideMaskData.finishCallBack()
  end
  if L_CommonUtil.isValid(self.targetList) then
    self.targetList.disableScroll = false
  end
end

function cls:onExitBtnClick()
  if self._guideMaskData.finishCallBack then
    self._guideMaskData.finishCallBack()
  end
end

function cls:initMask()
  self._isShowMask = false
  self._guideMask = self.bindComponents.GuideMask
  self._onFinish = handler(self, self.onFinish)
  self._guideMask:RemoveClickCheckHandler(self._onFinish)
  self._guideMask:AddClickCheckHandler(self._onFinish)
  self._guideMask.scaleX = self._guideMaskData.scaleX
  self._guideMask.scaleY = self._guideMaskData.scaleY
  self._guideMask.scalingTime = self._guideMaskData.scalingTime
  self._guideMask.multipleX = self._guideMaskData.multipleX
  self._guideMask.multipleY = self._guideMaskData.multipleY
  self._page = L_UI:getPage(self._guideMaskData.guideWindowName)
  self._focusObj = self._page.gameObject.transform:Find(self._guideMaskData.focusObjData.focusObjPath)
  self._item = nil
end

function cls:findNode()
  if self._isShowMask == false then
    if L_CommonUtil.isValid(self._guideMaskData.targetItem) then
      self._initSuccess = true
    elseif self._guideMaskData.focusObjType == G_GuideManager.itemMode.list then
      if self._lScrollRect == nil and self._list == nil then
        self._lScrollRect = self._focusObj:GetComponent(typeof(C_LScrollRect))
        self._list = self._focusObj:GetComponent(typeof(C_LList))
      end
      if self._lScrollRect then
        local item = self._lScrollRect:GetItemById(self._guideMaskData.listItemId - 1)
        if item then
          self._item = item
          self._initSuccess = true
        end
      end
      if self._list then
        local item
        if self._list:CheckIsLuaTable() then
          item = self._list:GetItemById(self._guideMaskData.listItemId - 1)
        else
          item = self._list:GetCSharpItemById(self._guideMaskData.listItemId - 1)
        end
        if item then
          self._item = item
          self._initSuccess = true
        end
      end
    else
      self._initSuccess = true
    end
  end
end

function cls:showMask()
  self._isShowMask = true
  if L_CommonUtil.isValid(self._guideMaskData.targetItem) then
    local target = self._guideMaskData.targetItem:GetComponent(typeof(C_RectTransform))
    self.targetList = self._guideMaskData.targetItem:GetComponentInParent(typeof(C_LScrollRect))
    if self.targetList == nil then
      return
    end
    self:changeLongPressStatus(false)
    self:disableListScroll()
    self._guideMask:DelayedPlay(self._guideMaskData.guideMaskType, target, self._guideMaskData.isLoop == 1, self._guideMaskData.delayPlayTime)
    return
  end
  if L_CommonUtil.isValid(self._focusObj) then
    if self._guideMaskData.focusObjType == G_GuideManager.itemMode.list then
      if self._item then
        local targetRectTransform = self._item.uiBinding:GetComponent(typeof(C_RectTransform))
        self._guideMask:DelayedPlay(self._guideMaskData.guideMaskType, targetRectTransform, self._guideMaskData.isLoop == 1, self._guideMaskData.delayPlayTime)
      end
      self:changeLongPressStatus(false)
      self:disableListScroll()
    else
      local targetRectTransform = self._focusObj:GetComponent(typeof(C_RectTransform))
      if L_CommonUtil.isValid(targetRectTransform) then
        self:changeLongPressStatus(false)
        self._guideMask:DelayedPlay(self._guideMaskData.guideMaskType, targetRectTransform, self._guideMaskData.isLoop == 1, self._guideMaskData.delayPlayTime)
      end
    end
  end
end

function cls:changeLongPressStatus(status)
  C_LButton.GlobalLongInteractable = status
end

function cls:disableListScroll()
  if L_CommonUtil.isValid(self.targetList) then
    self.targetList.disableScroll = true
  end
end

function cls:update()
  if self._isShowMask == false and self._page.animating ~= true then
    if self._initSuccess == true then
      self:showMask()
    else
      self:findNode()
    end
  end
end

function cls:close()
  if L_CommonUtil.isValid(self.gameObject) then
    local tipsPanel = L_CommonUtil.findTranByName("guideComponentTips", self.gameObject.transform)
    if L_CommonUtil.isValid(tipsPanel) then
      C_BoundGameObject.DestroyImmediate(tipsPanel.gameObject)
    end
  end
  self:changeLongPressStatus(true)
  self._lScrollRect = nil
  self._list = nil
  self._item = nil
end

function cls:escHandle()
end

return cls
