local page = class("dialogLogWindow", G_UIPageBase)

function page.bind()
  return {
    mainTable = {},
    focusItemIndex = 1,
    titleText = ""
  }
end

function page.methods()
  return {
    onBtnSkip = function(self)
      L_UI:close("DialogPhoneWindow")
    end,
    onBtnMain = function(self)
      self:checkNext(true)
    end,
    onMainClick = function(self)
      self:checkNext(true)
    end
  }
end

function page:check(options, callback)
  local id = options.phoneId
  if not L_Config:getConfigDirectly("dialogue_phone")[id] then
    errorf("没有这个配置id " .. id)
    if options.callback then
      options.callback()
    end
    callback(false)
  end
  callback(true)
end

function page:preOpen(options)
  self._phoneID = options.phoneId
  local config = L_Config:getConfigDirectly("dialogue_phone")[self._phoneID]
  self.bind.titleText = L_Lang:get(config.chatName)
  self._chatConfig = config._children
  self._callback = options.callback
  self._currIndex = 1
  printf("剧情手机Id", options.phoneId, config)
  self.bind.mainTable:clear()
  self:refreshShow()
  self:checkNext()
end

local ContinueType = {CLICK = 0, AUTO = 1}

function page:checkNext(fromClick)
  local nextConf = self._chatConfig[self._currIndex + 1]
  if not nextConf then
    if fromClick then
      L_UI:close("DialogPhoneWindow")
    end
    return
  end
  local continue = nextConf.continue
  if continue == ContinueType.CLICK then
    if fromClick then
      self:doNext()
    end
  elseif continue == ContinueType.AUTO then
    if self._waiting then
      L_TimerManager:stopTimer(self, "auto")
      self:doNext()
      return
    end
    self._waiting = true
    L_TimerManager:newOrResetTimer(self, "auto", handler(self, self.doNext), 1, 1)
  end
end

function page:doNext()
  self._waiting = false
  self._currIndex = self._currIndex + 1
  self:refreshShow()
  self:checkNext()
end

function page:refreshShow()
  local tableDatas = {}
  for i = 1, self._currIndex do
    local conf = self._chatConfig[i]
    local itemData = {}
    itemData.speaker = L_Lang:get(conf.name, {
      playerName = L_PlayerStore:getPlayerName()
    })
    itemData.content = L_Lang:get(conf.dialogue)
    itemData.headIcon = L_Config:getPathByHash(conf.icon)
    itemData.identify = conf.isSelf and "dialogPhoneSelfItem" or "dialogPhoneSpeakItem"
    itemData.moduleName = "pages/dialogue/dialogPhoneSpeakItem"
    table.insert(tableDatas, itemData)
  end
  self.bind.mainTable:clear()
  self.bind.mainTable:insert_array(tableDatas)
  self.bind.focusItemIndex = L_TableUtil.count(tableDatas)
end

function page:close(options)
  L_TimerManager:clearTimer(self)
  if self._callback then
    self._callback()
  end
end

return page
