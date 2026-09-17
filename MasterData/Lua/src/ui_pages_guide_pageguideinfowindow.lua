local this = class("pageGuideInfoWindow", G_UIPageBase)
local CriWareStatus = CS.CriWare.CriMana.Player.Status
local _guidePicTpl = L_GameTpl:getGuidePicTpl()
local csUIStatus = CS.Azur.Gameplay.UI.EUIStatus

function this.bind()
  return {
    desPic = "",
    toggle_enableNextBtn = false,
    toggle_enablePreviousBtn = false,
    currentNum = 1,
    totalNum = 9,
    descText = "",
    titleText = "",
    active_closeBtn = false,
    sortingOrder_page = 9450,
    txt_closeTip = "",
    active_showTurnBtn = true,
    active_videoBlackMask = false,
    active_tutorialVideo = false,
    active_replayVideo = false,
    enable_tutorialImage = false,
    closeShortCutKeyList = {
      moduleName = "pages/Guide/cellKeyIcon"
    },
    nextShortCutKeyList = {
      moduleName = "pages/Guide/cellKeyIcon"
    },
    previousShortCutKeyList = {
      moduleName = "pages/Guide/cellKeyIcon"
    },
    active_closeShortCutKey = false,
    itemIndexList = {
      moduleName = "pages/guide/cellItemIndex"
    },
    color_video1 = C_Color(1, 1, 1, 0),
    color_video2 = C_Color(1, 1, 1, 0)
  }
end

function this.methods()
  return {
    onChangePic = function(self, name)
      if name == "changePic" then
        self.bind.currentNum = self.bind.currentNum + 1
      elseif name == "changePicPrevious" then
        self.bind.currentNum = self.bind.currentNum - 1
      end
      if self.bind.currentNum < 1 then
        self.bind.currentNum = 1
      elseif self.maxPicNum and self.bind.currentNum > self.maxPicNum then
        self.bind.currentNum = self.maxPicNum
      end
      self:realShowPage(self.bind.currentNum)
      self.onSwitchPic = false
    end,
    onClick_nextBtn = function(self)
      if self.onSwitchPic or self._inPreheatVideo then
        return
      end
      if self.bind.currentNum < self.maxPicNum then
        local nextPageNum = self.bind.currentNum + 1
        if nextPageNum == self.maxPicNum and self.bind.active_closeBtn == false then
          self:tryShowPage(nextPageNum, function()
            self.bindComponents.guideInfoAnimation:Stop()
            self.onSwitchPic = true
            self.bindComponents.guideInfoAnimation:Play("anim_guide_guidepage_switch_btn_in")
          end)
        else
          self:tryShowPage(nextPageNum, function()
            self.bindComponents.guideInfoAnimation:Stop()
            self.onSwitchPic = true
            self.bindComponents.guideInfoAnimation:Play("anim_guide_guidepage_switch")
          end)
        end
      end
    end,
    onClick_previousBtn = function(self)
      if self.onSwitchPic or self._inPreheatVideo then
        return
      end
      if self.bind.currentNum > 1 then
        self:tryShowPage(self.bind.currentNum - 1, function()
          self.bindComponents.guideInfoAnimation:Stop()
          self.onSwitchPic = true
          self.bindComponents.guideInfoAnimation:Play("anim_guide_guidepage_switch_toPrevious")
        end)
      end
    end,
    onClick_closeBtn = function(self)
      if self.finishCallback then
        self.finishCallback()
      end
      L_UI:close(self.pageName)
    end,
    onClick_closeBtn2 = function(self)
      if self.finishCallback then
        self.finishCallback()
      end
      L_UI:close(self.pageName)
    end,
    onClick_replayVideo = function(self)
      self:tryShowPage(self.bind.currentNum, function()
        self:realShowPage(self.bind.currentNum)
      end)
    end
  }
end

function this:open()
  self.super.open(self)
  C_InputManager.SetCameraFollowMouse(false)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.pics = options.pics
  self.maxPicNum = self.pics and #self.pics or 0
  self.bind.active_showTurnBtn = self.maxPicNum > 1
  self.bind.currentNum = 1
  self.bind.totalNum = self.maxPicNum
  self.finishCallback = options.finishCallback
  self.bind.txt_closeTip = L_GameTpl:getWordsTpl():getValue("notice_guide_img_tip")
  L_ShortCutManager:addShortKeyFlag(self, L_Const.gamepadSpecialButtonName.D_PadAndLeftRight, L_Const.AnchorType.Middle, self.bindComponents.rectGamepadCutClosetp)
  L_ShortCutManager:addShortKeyFlag(self, "PageGuideInfoWindow/ShowPreviousGuideInfo", L_Const.AnchorType.Middle, self.bindComponents.rectPreviousGamepadShortCutKey)
  L_ShortCutManager:addShortKeyFlag(self, "PageGuideInfoWindow/ShowNextGuideInfo", L_Const.AnchorType.Middle, self.bindComponents.rectNextGamepadShortCutKey)
  self.onEvent_controlSchemeChangeHandle = self.onEvent_controlSchemeChangeHandle or handler(self, self.onEvent_controlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
  self:onEvent_controlSchemeChange()
  self.bind.active_closeBtn = false
  self.bind.active_closeShortCutKey = false
  self.isPicNumMax = false
  self.bind.sortingOrder_page = 9450
  self:initVideo()
  self:tryShowPage(self.bind.currentNum, function()
    self:realShowPage(self.bind.currentNum)
  end)
  self.ability = C_TagStateManager.CreateState(C_TagStateDefine.GuideTip)
  self.ability:TryActive()
end

function this:show()
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ECloseGuideInfoWindow, function()
      if self.bind.active_closeBtn == false or self.onSwitchPic == true or self._inPreheatVideo then
        return
      end
      if self.finishCallback then
        self.finishCallback()
      end
      L_UI:close(self.pageName)
    end)
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EShowPreviousGuideInfo, function()
      if self.onSwitchPic or self._inPreheatVideo then
        return
      end
      self:tryShowPage(self.bind.currentNum - 1, function()
        self.bindComponents.guideInfoAnimation:Stop()
        if self.bind.currentNum > 1 then
          self.onSwitchPic = true
          self.bindComponents.guideInfoAnimation:Play("anim_guide_guidepage_switch_toPrevious")
        end
      end)
    end)
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EShowNextGuideInfo, function()
      if self.onSwitchPic or self._inPreheatVideo then
        return
      end
      self:tryShowPage(self.bind.currentNum + 1, function()
        if self.bind.currentNum < self.maxPicNum then
          local nextPageNum = self.bind.currentNum + 1
          if nextPageNum == self.maxPicNum and self.bind.active_closeBtn == false then
            self:tryShowPage(nextPageNum, function()
              self.bindComponents.guideInfoAnimation:Stop()
              self.onSwitchPic = true
              self.bindComponents.guideInfoAnimation:Play("anim_guide_guidepage_switch_btn_in")
            end)
          else
            self:tryShowPage(nextPageNum, function()
              self.bindComponents.guideInfoAnimation:Stop()
              self.onSwitchPic = true
              self.bindComponents.guideInfoAnimation:Play("anim_guide_guidepage_switch")
            end)
          end
        end
      end)
    end)
    if C_InputManager.IsEnableGamePad then
      return
    end
    self:initShortCutKeyList(self.bind.closeShortCutKeyList, "PageGuideInfoWindow/CloseGuideInfoWindow")
    self:initShortCutKeyList(self.bind.nextShortCutKeyList, "PageGuideInfoWindow/ShowNextGuideInfo")
    self:initShortCutKeyList(self.bind.previousShortCutKeyList, "PageGuideInfoWindow/ShowPreviousGuideInfo")
    self.isInitKeyboard = true
  end
end

function this:initVideo()
  self.curVideoState = CriWareStatus.Stop
  self.waitPlayVideoPath = ""
  self.videoComponent = self.bindComponents.movieController
  self.videoComponent.player.statusChangeCallback = handler(self, self.statusChangeCallback)
  self.curShowVideoIndex = 1
  self.curVideoStateArray = {}
  table.insert(self.curVideoStateArray, CriWareStatus.Stop)
  table.insert(self.curVideoStateArray, CriWareStatus.Stop)
  self.videoComponentArray = {}
  table.insert(self.videoComponentArray, self.bindComponents.movieController1)
  table.insert(self.videoComponentArray, self.bindComponents.movieController2)
  self.videoComponentArray[1].player.statusChangeCallback = handler(self, self.statusChangeCallback1)
  self.videoComponentArray[2].player.statusChangeCallback = handler(self, self.statusChangeCallback2)
  self.waitPlayVideoPathArray = {"", ""}
end

function this:getNextShowVideoIndex()
  local index = self.curShowVideoIndex + 1
  if 2 < index then
    index = index - 2
  end
  return index
end

function this:tryShowPage(index, callback)
  if index < 1 then
    return
  elseif index > self.maxPicNum then
    return
  end
  local picId = self.pics[index]
  local guidePicTpl = _guidePicTpl:getTplById(tonumber(picId))
  local displayType = _guidePicTpl:GetDisplayType(guidePicTpl)
  if displayType == 2 then
    local nextShowVideIndex = self:getNextShowVideoIndex()
    local videoPath = _guidePicTpl:GetVideoPath(guidePicTpl)
    self:preheatVideo(nextShowVideIndex, videoPath, callback)
  else
    callback()
  end
end

function this:realShowPage(index)
  self._inPreheatVideo = false
  self.bind.currentNum = index
  if self.bind.currentNum < 1 then
    self.bind.currentNum = 1
  elseif self.bind.currentNum > self.maxPicNum then
    self.bind.currentNum = self.maxPicNum
  end
  self.bind.toggle_enableNextBtn = self.bind.currentNum < self.maxPicNum
  self.bind.toggle_enablePreviousBtn = self.bind.currentNum > 1
  if not self.isPicNumMax and self.bind.currentNum >= self.maxPicNum then
    self.bind.active_closeBtn = true
    self.bind.active_closeShortCutKey = true
    self.isPicNumMax = true
  end
  local picId = self.pics[self.bind.currentNum]
  local guidePicTpl = _guidePicTpl:getTplById(tonumber(picId))
  local displayType = _guidePicTpl:GetDisplayType(guidePicTpl)
  if displayType == 1 then
    local icon = _guidePicTpl:getIcon(guidePicTpl)
    if icon and icon ~= "" then
      self.bind.desPic = icon
    end
    self.videoComponentArray[1]:Stop()
    self.videoComponentArray[2]:Stop()
    self.bind.active_videoBlackMask = false
    self.bind.active_replayVideo = false
    self.bind.enable_tutorialImage = true
    self.bind.active_tutorialVideo = false
  elseif displayType == 2 then
    self.videoComponentArray[self.curShowVideoIndex]:Stop()
    local nextShowVideoIndex = self:getNextShowVideoIndex()
    self.bind.active_videoBlackMask = false
    self.bind.active_replayVideo = false
    self.bind.enable_tutorialImage = false
    self.bind.active_tutorialVideo = true
    self.curShowVideoIndex = nextShowVideoIndex
    if self.curShowVideoIndex == 1 then
      self.bind.color_video1 = C_Color(1, 1, 1, 1)
    else
      self.bind.color_video2 = C_Color(1, 1, 1, 1)
    end
  end
  self.bind.titleText = _guidePicTpl:getTitle(guidePicTpl) or ""
  self.bind.descText = _guidePicTpl:getDesc(guidePicTpl) or ""
  self.bind.itemIndexList:clear()
  if 1 < self.maxPicNum then
    local listData = {}
    for i, _ in ipairs(self.pics) do
      table.insert(listData, {
        selected = i == self.bind.currentNum
      })
    end
    self.bind.itemIndexList:insert_array(listData)
  end
  self:onEvent_controlSchemeChange()
end

function this:preheatVideo(index, videoPath, callback)
  self._inPreheatVideo = true
  self._nextShowIndex = index
  self._preheatVideoCallback = callback
  if self.curVideoStateArray[index] == CriWareStatus.PlayEnd then
    self.videoComponentArray[index].player:SetFile(nil, videoPath)
    self.videoComponentArray[index]:Play()
  elseif self.curVideoStateArray[index] == CriWareStatus.StopProcessing then
    self.waitPlayVideoPathArray[index] = videoPath
  elseif self.curVideoStateArray[index] ~= CriWareStatus.Stop then
    self.videoComponentArray[index]:Stop()
    self.waitPlayVideoPathArray[index] = videoPath
  else
    self.videoComponentArray[index].player:SetFile(nil, videoPath)
    self.videoComponentArray[index]:Play()
  end
end

function this:initShortCutKeyList(shortCutKeyList, inputActionPath)
  shortCutKeyList:clear()
  local action = C_InputManager.GetAction(inputActionPath)
  local str = ""
  if action ~= nil then
    str = C_InputManager.GetActionName(action)
    if str ~= "" then
      local keyData = {}
      table.insert(keyData, {keyText = str})
      shortCutKeyList:insert_array(keyData)
    end
  end
end

function this:statusChangeCallback(status)
  C_MJLog.LogInfo("监听 Video 播放状态变化 -> " .. tostring(status) .. "当前帧数：" .. C_Time.frameCount, C_ELogModule.Guide)
  if status == CriWareStatus.Error then
    C_SoulEssenceMovieHelper.StopSoulEssenceMovie()
    self.curVideoState = CriWareStatus.Stop
  elseif status == CriWareStatus.PlayEnd then
    self.curVideoState = CriWareStatus.PlayEnd
    self.bind.active_videoBlackMask = true
    self.bind.active_replayVideo = true
    self:refreshBottomGamepadCut()
  elseif status == CriWareStatus.Playing then
    self.curVideoState = CriWareStatus.Playing
  elseif status == CriWareStatus.Stop then
    self.curVideoState = CriWareStatus.Stop
    if not string.isEmpty(self.waitPlayVideoPath) then
      self.videoComponent.player:SetFile(nil, self.waitPlayVideoPath)
      self.videoComponent:Play()
      self.waitPlayVideoPath = ""
    end
  end
end

function this:statusChangeCallback1(status)
  if status == CriWareStatus.Error then
    self.curVideoStateArray[1] = CriWareStatus.Stop
  elseif status == CriWareStatus.PlayEnd then
    self.curVideoStateArray[1] = CriWareStatus.PlayEnd
    self.bind.active_videoBlackMask = true
    self.bind.active_replayVideo = true
    self:refreshBottomGamepadCut()
  elseif status == CriWareStatus.Playing then
    self.curVideoStateArray[1] = CriWareStatus.Playing
    if self._inPreheatVideo then
      self.bind.color_video1 = C_Color(1, 1, 1, 0)
      self._inPreheatVideo = false
      self._preheatVideoCallback()
    end
  elseif status == CriWareStatus.StopProcessing then
    self.curVideoStateArray[1] = CriWareStatus.StopProcessing
  elseif status == CriWareStatus.Stop then
    self.curVideoStateArray[1] = CriWareStatus.Stop
    if not string.isEmpty(self.waitPlayVideoPathArray[1]) then
      self.videoComponentArray[1].player:SetFile(nil, self.waitPlayVideoPathArray[1])
      self.videoComponentArray[1]:Play()
      self.waitPlayVideoPathArray[1] = ""
    end
  end
end

function this:statusChangeCallback2(status)
  if status == CriWareStatus.Error then
    self.curVideoStateArray[2] = CriWareStatus.Stop
  elseif status == CriWareStatus.PlayEnd then
    self.curVideoStateArray[2] = CriWareStatus.PlayEnd
    self.bind.active_videoBlackMask = true
    self.bind.active_replayVideo = true
    self:refreshBottomGamepadCut()
  elseif status == CriWareStatus.Playing then
    self.curVideoStateArray[2] = CriWareStatus.Playing
    if self._inPreheatVideo then
      self.bind.color_video2 = C_Color(1, 1, 1, 0)
      self._inPreheatVideo = false
      self._preheatVideoCallback()
    end
  elseif status == CriWareStatus.StopProcessing then
    self.curVideoStateArray[2] = CriWareStatus.StopProcessing
  elseif status == CriWareStatus.Stop then
    self.curVideoStateArray[2] = CriWareStatus.Stop
    if not string.isEmpty(self.waitPlayVideoPathArray[2]) then
      self.videoComponentArray[2].player:SetFile(nil, self.waitPlayVideoPathArray[2])
      self.videoComponentArray[2]:Play()
      self.waitPlayVideoPathArray[2] = ""
    end
  end
end

function this:replayVideo()
  self.bind.active_videoBlackMask = false
  self.bind.active_replayVideo = false
  self:refreshBottomGamepadCut()
  self.videoComponent:Play()
end

function this:escHandle()
end

function this:onEvent_controlSchemeChange()
  self.bindComponents.rectPreviousGamepadShortCutKey.gameObject:SetActive(C_InputManager.IsEnableGamePad and self.bind.currentNum > 1)
  self.bindComponents.rectNextGamepadShortCutKey.gameObject:SetActive(C_InputManager.IsEnableGamePad and self.bind.currentNum < self.maxPicNum)
  self.bind.active_closeShortCutKey = not C_InputManager.IsEnableGamePad and not self.isPicNumMax and self.bind.currentNum >= self.maxPicNum
  self:refreshBottomGamepadCut()
  local picId = self.pics[self.bind.currentNum]
  local guidePicTpl = _guidePicTpl:getTplById(tonumber(picId))
  self.bind.descText = _guidePicTpl:getDesc(guidePicTpl) or ""
  if not C_InputManager.IsEnableGamePad and not self.isInitKeyboard then
    self:initShortCutKeyList(self.bind.closeShortCutKeyList, "PageGuideInfoWindow/CloseGuideInfoWindow")
    self:initShortCutKeyList(self.bind.nextShortCutKeyList, "PageGuideInfoWindow/ShowNextGuideInfo")
    self:initShortCutKeyList(self.bind.previousShortCutKeyList, "PageGuideInfoWindow/ShowPreviousGuideInfo")
  end
end

function this:refreshBottomGamepadCut()
  local args
  if self.bind.active_replayVideo then
    args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = self.pageName
    }
  end
  C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
end

function this:close()
  C_TagStateManager.ReleaseState(self.ability)
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:removeShortCut(self.pageName)
  end
  self.waitPlayVideoPath = ""
  self.videoComponent.player.statusChangeCallback = nil
  self.videoComponent:Stop()
  self.videoComponent = nil
  self.videoComponentArray[1].player.statusChangeCallback = nil
  self.videoComponentArray[1]:Stop()
  self.videoComponentArray[2].player.statusChangeCallback = nil
  self.videoComponentArray[2]:Stop()
  self.videoComponentArray = nil
  self.waitPlayVideoPathArray = nil
  if self.onEvent_controlSchemeChangeHandle then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
    self.onEvent_controlSchemeChangeHandle = nil
  end
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
