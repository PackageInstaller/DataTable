local page = class("dialogPanel", G_UIPageBase)

function page.bind()
  return {
    detailText = "",
    nameText = "",
    selectButtonList = {
      moduleName = "pages/Dialog/dialogButtonItem"
    },
    skipButtonActive = false,
    setMaxText = ""
  }
end

page.dialogSelectIdDict = {}

function page.methods()
  return {
    skipOnClick = function(self)
      if self.skipTimestamp > self:getTimeStamp() then
        return
      end
      AzurWorld.StoryMgr:Stop()
    end,
    selectButtonList = {
      onClick = function(self, selectDialogueId)
        if self.skipTimestamp > self:getTimeStamp() then
          return
        end
        self:initData(selectDialogueId)
      end,
      onPointerEnter = function(self)
      end
    },
    nextDialogueClick = function(self)
      if self.skipTimestamp > self:getTimeStamp() then
        return
      end
      if self.currentIndex < self:GetUTFLen(self.contentText) then
        self:updateSelectButtonList()
        self.textAniPlay = false
        self.bind.detailText = self.contentText
        self.currentIndex = self:GetUTFLen(self.contentText)
        return
      end
      local dialogInfo = L_Config:getConfigDirectly("dialogue", self.dialogId, nil)
      if #dialogInfo.select > 0 then
        return
      end
      if dialogInfo.nextId == -1 then
        AzurWorld.StoryMgr:Stop()
        return
      end
      if 0 < dialogInfo.nextId then
        self:initData(dialogInfo.nextId)
        return
      end
      self:initData(self.dialogId + 1)
    end
  }
end

function page:getTimeStamp()
  return (CS.System.DateTime.Now:ToUniversalTime().Ticks - 621355968000000000) / 10000
end

function page:initData(dialogId)
  self.dialogId = dialogId
  local dialogInfo = L_Config:getConfigDirectly("dialogue", dialogId)
  self.bind.nameText = string.gsub(dialogInfo.speakerName, "{nickname}", L_PlayerStore:getPlayerName()) .. dialogInfo.speakerTitle
  self:setText(dialogInfo.content)
  self.skipTimestamp = self:getTimeStamp() + dialogInfo.skipDelay
  self.bind.selectButtonList:clear()
end

function page:updateSelectButtonList()
  local dialogInfo = L_Config:getConfigDirectly("dialogue", self.dialogId)
  for i = 1, #dialogInfo.select do
    local dialogSelectInfo = L_Config:getConfigDirectly("dialogue", dialogInfo.select[i])
    self.bind.selectButtonList:insert(i, {
      dialogButtonText = self:worldCountLimit(dialogSelectInfo.content, 16),
      selectDialogue = dialogInfo.selectDialogue[i]
    })
  end
end

function page:worldCountLimit(str, count)
  if count < self:GetUTFLen(str) then
    return self:sub(str, count - 2) .. "..."
  end
  return str
end

function page:update()
  if self.textAniPlay then
    self.time = self.time + Unity.Time.deltaTime
    if self.time >= 0.1 then
      self.bind.detailText = self:getCurrentText()
      self.time = 0
    end
  end
end

function page:setText(text)
  self.time = 0
  self.textAniPlay = true
  self.currentIndex = 0
  self.contentText = string.gsub(text, "{nickname}", L_PlayerStore:getPlayerName())
  self.bind.setMaxText = self.contentText
end

function page:getCurrentText()
  self.currentIndex = self.currentIndex + 1
  if self.currentIndex >= self:GetUTFLen(self.contentText) then
    self.textAniPlay = false
    self:updateSelectButtonList()
  end
  return self:sub(self.contentText, self.currentIndex)
end

function page:StringToTable(s)
  local tb = {}
  for utfChar in string.gmatch(s, "[%z\001-\127Â-ô][€-¿]*") do
    table.insert(tb, utfChar)
  end
  return tb
end

function page:GetUTFLen(s)
  local sTable = self:StringToTable(s)
  return #sTable
end

function page:sub(s, length)
  local sTable = self:StringToTable(s)
  local len = 0
  for i = 1, length do
    local utfCharLen = string.len(sTable[i])
    len = len + utfCharLen
  end
  return string.sub(s, 1, len)
end

function page:open(options)
  self.storyId = options.storyId
  local dialogId = options.dialogId
  self.bind.skipButtonActive = options.isAllowSkip == 1
  self:initData(dialogId)
end

return page
