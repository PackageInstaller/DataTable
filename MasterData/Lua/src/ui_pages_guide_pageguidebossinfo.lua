local this = class("pageGuideBossInfo", G_UIPageBase)
local _guidePicTpl = L_GameTpl:getGuidePicTpl()

function this.bind()
  return {
    desPic = "",
    toggle_enableNextBtn = false,
    toggle_enablePreviousBtn = false,
    descText = "",
    titleText = "",
    active_closeTip = true,
    active_closeBtn = false,
    sortingOrder_page = 9450,
    txt_closeTip = "",
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
    }
  }
end

function this.methods()
  return {
    onChangePic = function(self, name)
      if name == "changePic" then
        self.currentNum = self.currentNum + 1
      elseif name == "changePicPrevious" then
        self.currentNum = self.currentNum - 1
      end
      if self.currentNum < 1 then
        self.currentNum = 1
      elseif self.maxPicNum and self.currentNum > self.maxPicNum then
        self.currentNum = self.maxPicNum
      end
      self:realShowPage(self.currentNum)
      self.onSwitchPic = false
    end,
    onClick_nextBtn = function(self)
      if self.onSwitchPic then
        return
      end
      if self.currentNum < self.maxPicNum then
        local nextPageNum = self.currentNum + 1
        if nextPageNum == self.maxPicNum and self.bind.active_closeBtn == false then
          self:tryShowPage(nextPageNum, function()
            self.onSwitchPic = true
          end)
        else
          self:tryShowPage(nextPageNum, function()
            self.onSwitchPic = true
          end)
        end
      end
      self.currentNum = self.currentNum + 1
      if self.currentNum < 1 then
        self.currentNum = 1
      elseif self.maxPicNum and self.currentNum > self.maxPicNum then
        self.currentNum = self.maxPicNum
      end
      self:realShowPage(self.currentNum)
      self.onSwitchPic = false
    end,
    onClick_previousBtn = function(self)
      if self.onSwitchPic then
        return
      end
      if self.currentNum > 1 then
        self:tryShowPage(self.currentNum - 1, function()
          self.onSwitchPic = true
        end)
      end
      self.currentNum = self.currentNum - 1
      if self.currentNum < 1 then
        self.currentNum = 1
      elseif self.maxPicNum and self.currentNum > self.maxPicNum then
        self.currentNum = self.maxPicNum
      end
      self:realShowPage(self.currentNum)
      self.onSwitchPic = false
    end,
    onClick_closeBtn = function(self)
      if self.finishCallback then
        self.finishCallback()
      end
      L_UI:close(self.pageName)
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
  self.isShowTurnBtn = self.maxPicNum > 1
  self.currentNum = 1
  self.totalNum = self.maxPicNum
  self.finishCallback = options.finishCallback
  self.bind.txt_closeTip = L_GameTpl:getWordsTpl():getValue("notice_guide_img_tip")
  self.bind.active_closeTip = true
  self.bind.active_closeBtn = false
  self.bind.active_closeShortCutKey = false
  self.isPicNumMax = false
  self.bind.sortingOrder_page = 9450
  self:tryShowPage(self.currentNum, function()
    self:realShowPage(self.currentNum)
  end)
  self.ability = C_TagStateManager.CreateState(C_TagStateDefine.GuideTip)
  self.ability:TryActive()
end

function this:show()
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ECloseGuideInfoWindow, function()
      if self.bind.active_closeBtn == false or self.onSwitchPic == true then
        return
      end
      if self.finishCallback then
        self.finishCallback()
      end
      L_UI:close(self.pageName)
    end)
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EShowPreviousGuideInfo, function()
      if self.onSwitchPic then
        return
      end
      self:tryShowPage(self.currentNum - 1, function()
        if self.currentNum > 1 then
          self.onSwitchPic = true
          self.currentNum = self.currentNum - 1
          if self.currentNum < 1 then
            self.currentNum = 1
          elseif self.maxPicNum and self.currentNum > self.maxPicNum then
            self.currentNum = self.maxPicNum
          end
          self:realShowPage(self.currentNum)
          self.onSwitchPic = false
        end
      end)
    end)
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EShowNextGuideInfo, function()
      if self.onSwitchPic then
        return
      end
      self:tryShowPage(self.currentNum + 1, function()
        if self.currentNum < self.maxPicNum then
          local nextPageNum = self.currentNum + 1
          if nextPageNum == self.maxPicNum and self.bind.active_closeBtn == false then
            self:tryShowPage(nextPageNum, function()
              self.onSwitchPic = true
              self.currentNum = self.currentNum + 1
              if self.currentNum < 1 then
                self.currentNum = 1
              elseif self.maxPicNum and self.currentNum > self.maxPicNum then
                self.currentNum = self.maxPicNum
              end
              self:realShowPage(self.currentNum)
              self.onSwitchPic = false
            end)
          else
            self:tryShowPage(nextPageNum, function()
              self.onSwitchPic = true
              self.currentNum = self.currentNum + 1
              if self.currentNum < 1 then
                self.currentNum = 1
              elseif self.maxPicNum and self.currentNum > self.maxPicNum then
                self.currentNum = self.maxPicNum
              end
              self:realShowPage(self.currentNum)
              self.onSwitchPic = false
            end)
          end
        end
      end)
    end)
    self:initShortCutKeyList(self.bind.closeShortCutKeyList, "PageGuideBossInfo/CloseGuideInfoWindow")
    self:initShortCutKeyList(self.bind.nextShortCutKeyList, "PageGuideBossInfo/ShowNextGuideInfo")
    self:initShortCutKeyList(self.bind.previousShortCutKeyList, "PageGuideBossInfo/ShowPreviousGuideInfo")
  end
end

function this:tryShowPage(index, callback)
  if index < 1 then
    return
  elseif index > self.maxPicNum then
    return
  end
  callback()
end

function this:realShowPage(index)
  self.currentNum = index
  if self.currentNum < 1 then
    self.currentNum = 1
  elseif self.currentNum > self.maxPicNum then
    self.currentNum = self.maxPicNum
  end
  self.bind.toggle_enableNextBtn = self.currentNum < self.maxPicNum and self.isShowTurnBtn
  self.bind.toggle_enablePreviousBtn = self.currentNum > 1 and self.isShowTurnBtn
  if not self.isPicNumMax and self.currentNum >= self.maxPicNum then
    self.bind.active_closeTip = false
    self.bind.active_closeBtn = true
    self.bind.active_closeShortCutKey = true
    self.isPicNumMax = true
  end
  local picId = self.pics[self.currentNum]
  local guidePicTpl = _guidePicTpl:getTplById(tonumber(picId))
  local icon = _guidePicTpl:getIcon(guidePicTpl)
  if icon and icon ~= "" then
    self.bind.desPic = icon
  end
  self.bind.titleText = _guidePicTpl:getTitle(guidePicTpl) or ""
  self.bind.descText = _guidePicTpl:getDesc(guidePicTpl) or ""
  self.bind.itemIndexList:clear()
  if 1 < self.maxPicNum then
    local listData = {}
    for i, _ in ipairs(self.pics) do
      table.insert(listData, {
        selected = i == self.currentNum
      })
    end
    self.bind.itemIndexList:insert_array(listData)
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

function this:escHandle()
end

function this:close()
  C_TagStateManager.ReleaseState(self.ability)
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:removeShortCut(self.pageName)
  end
end

return this
