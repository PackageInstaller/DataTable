local this = class("pageGuideSkip", G_UIPageBase)
local guideGroupTpl = L_GameTpl:getGuideGroupTpl()

function this.bind()
  return {
    tips = "",
    skipBtnActive = false,
    tipsActive = false,
    closeGuideActive = false,
    maskActive = false
  }
end

function this.methods()
  return {
    onClick_closeGuideBtn = function(self)
      self:onClick_closeGuideBtn()
    end,
    onClick_skipBtn = function(self)
      self:onSkipBtnClicked()
    end
  }
end

function this:preOpen()
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.ShowSkipGuide, self.onShowSkipGuide, self)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.GuideEnd, self.onGuideRefresh, self)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.GuideRefresh, self.onGuideRefresh, self)
end

function this:close()
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.ShowSkipGuide, self.onShowSkipGuide, self)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.GuideEnd, self.onGuideRefresh, self)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.GuideRefresh, self.onGuideRefresh, self)
end

function this:onShowSkipGuide(data)
  if data == nil or not data.isShow then
    self.bind.skipBtnActive = false
    self.bind.maskActive = false
    return
  end
  self.bind.skipBtnActive = true
  self.bind.maskActive = true
  self.guideId = data.guideId
  local tpl = guideGroupTpl:getTplById(self.guideId)
  self.skipNotSave = guideGroupTpl:getIsRepeat(tpl)
  local actions = {
    "UI/Click",
    "UI/Point",
    "UI/Submit"
  }
  C_InputManager.EnableHighLevelControl(actions, nil)
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = true})
end

function this:onSkipBtnClicked()
  local data_tip = {
    txtTitle = L_WordsTpl:getValue("notice_title_hint"),
    txtContent = L_WordsTpl:getValue("notice_guide_skip"),
    confirmCallback = function()
      local function respCb(isScccess)
        if not isScccess then
          return
        end
        L_GuideManager:clearAllControl()
        L_GuideManager:forceEndGuide(self.guideId)
        if self.bind then
          self.bind.maskActive = false
        end
        L_UI:close(self.pageName)
      end
      
      if not L_GuideManager:isOnDebugMode() and not self.skipNotSave then
        L_GuideStore:req_updateGuideData(self.guideId, 0, respCb)
      else
        respCb(true)
      end
    end,
    overrideSortingOrder = 9520
  }
  L_GameUtil.showCommonTip(data_tip)
end

function this:onClick_closeGuideBtn()
  local data_tip = {
    txtTitle = L_WordsTpl:getValue("ui_hintActivity_02"),
    txtContent = L_WordsTpl:getValue("ui_hintActivity_03"),
    confirmCallback = function()
      L_GuideManager:setGuideActive(false)
      L_GuideManager:stopAllGuide()
      if self.bind then
        self.bind.maskActive = false
      end
      L_UI:close(self.pageName)
    end,
    overrideSortingOrder = 9520
  }
  L_GameUtil.showCommonTip(data_tip)
end

function this:show()
  self.bind.skipBtnActive = false
  self.bind.maskActive = false
  local isShowSkip = L_GameTpl:getGameConstTpl():getData("GUIDE_UI_SKIP_BUTTON_DISPLAY", L_Const.GameTplType.bool) and Unity.Debug.isDebugBuild
  self.bind.closeGuideActive = isShowSkip
  local guideIds = L_GuideManager:getRunningGuideIds()
  self.bind.tipsActive = isShowSkip and 0 < #guideIds
  if not self.bind.tipsActive then
    return
  end
  local idStr = table.concat(guideIds, ", ")
  self.bind.tips = idStr .. L_WordsTpl:getValue("notice_guide")
end

function this:onGuideRefresh()
  if not self.bind.tipsActive then
    return
  end
  local guideIds = L_GuideManager:getRunningGuideIds()
  local idStr = table.concat(guideIds, ", ")
  self.bind.tips = idStr .. L_WordsTpl:getValue("notice_guide")
end

function this:escHandle()
end

return this
