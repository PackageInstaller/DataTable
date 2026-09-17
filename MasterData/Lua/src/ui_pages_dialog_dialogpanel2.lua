local page = class("dialogPanel2", G_UIPageBase)

function page.bind()
  return {
    detailText = "",
    nameText = "",
    selectButtonList = {
      moduleName = "pages/Dialog/dialogButtonItem2"
    },
    skipButtonActive = false,
    setMaxText = "",
    setActiveSelectButtonList = false,
    setDialogueUI = false
  }
end

page.dialogSelectIdDict = {}

function page.methods()
  return {
    skipOnClick = function(self)
      if self.skipTimestamp > self:getTimeStamp() then
        return
      end
      self.options.endCallback()
    end,
    selectButtonList = {
      onClick = function(self, branchNodeGuid)
        if self.skipTimestamp > self:getTimeStamp() then
          return
        end
        self.options.nextNodeCallback(branchNodeGuid)
      end
    },
    nextDialogueClick = function(self)
      if self.skipTimestamp > self:getTimeStamp() then
        return
      end
      if self.currentIndex < self:getUTFLen(self.contentText) then
        if not self.options.dialogueConfig.dialogueConst.allowStopWord then
          return
        end
        self.bind.setActiveSelectButtonList = true
        self.textAniPlay = false
        self.bind.detailText = self.contentText
        self.currentIndex = self:getUTFLen(self.contentText)
        return
      end
      if self.options.nextNodeType == L_DialogueManager.nextNodeType.Single and self.options.dialogueConfig.nodeConst.needClickNext and self.options.nextNodeCallback then
        self.options.nextNodeCallback(self.options.nextNodeGuid)
      end
    end
  }
end

function page:getTimeStamp()
  return (CS.System.DateTime.Now:ToUniversalTime().Ticks - 621355968000000000) / 10000
end

function page:initData(options)
  self.options = options
  if not options.dialogueActive then
    self.bind.nameText = ""
    self:setText("")
    self.bind.setActiveSelectButtonList = #self.options.branchSelects > 0
  else
    self.bind.nameText = string.gsub(self.options.speakerName, "nickname", L_PlayerStore:getPlayerName() or "")
    self:setText(self.options.content)
    self.bind.setActiveSelectButtonList = false
  end
  self.bind.setDialogueUI = options.dialogueActive
  self.skipTimestamp = self:getTimeStamp() + self.options.dialogueConfig.dialogueConst.allowSkipTime
  self.bind.selectButtonList:clear()
  self:updateSelectButtonList()
  self.bind.skipButtonActive = self.options.dialogueConfig.nodeConst.allowSkipDialogue
end

function page:updateSelectButtonList()
  for i = 1, #self.options.branchSelects do
    self.bind.selectButtonList:insert(i, {
      dialogButtonText = self:worldCountLimit(self.options.branchSelects[i].content, 16),
      branchNodeGuid = self.options.branchSelects[i].branchNodeGuid
    })
  end
end

function page:worldCountLimit(str, count)
  if count < self:getUTFLen(str) then
    return self:sub(str, count - 2) .. "..."
  end
  return str
end

function page:update()
  if self.textAniPlay then
    self.time = self.time + Unity.Time.deltaTime
    if self.time >= self.options.dialogueConfig.dialogueConst.wordInterval / 1000 then
      self.bind.detailText = self:getCurrentText()
      self.time = 0
    end
  end
end

function page:setText(text)
  self.time = 0
  self.textAniPlay = true
  self.currentIndex = 0
  self.bind.detailText = ""
  self.contentText = string.gsub(text, "nickname", L_PlayerStore:getPlayerName() or "")
  self.bind.setMaxText = self.contentText
end

function page:getCurrentText()
  self.currentIndex = self.currentIndex + 1
  if self.currentIndex >= self:getUTFLen(self.contentText) then
    self.textAniPlay = false
    self.bind.setActiveSelectButtonList = true
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

function page:getUTFLen(s)
  local sTable = self:StringToTable(s)
  return #sTable
end

function page:sub(s, length)
  local sTable = self:StringToTable(s)
  if table.isEmpty(sTable) then
    return ""
  end
  local len = 0
  for i = 1, length do
    local utfCharLen = string.len(sTable[i])
    len = len + utfCharLen
  end
  return string.sub(s, 1, len)
end

function page:open(options)
  self:initData(options)
end

return page
