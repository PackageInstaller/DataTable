local Story, Super = System.NewClass("Story", Entity)

function Story:ctor(storyId, endCallback, interUid, isLocal)
  Super.ctor(self)
  self.storyId = storyId
  self.storyConfig = StoryDataUtils.GetStoryData(self.storyId)
  self.interUid = interUid
  self.isLocal = isLocal
  self.dialogs = {}
  self.cameraNodes = {}
  self.curDialogNodeId = 0
  self.isAuto = DataCenter.storyData.AutoPlay
  self.endCallback = endCallback
end

function Story:Awake()
  Logger.Debug("Story Awake id == %s", self.storyId)
  self:InitAllDialog()
end

function Story:InitAllDialog()
  for key, value in pairs(self.storyConfig.NodeList) do
    if value.NodeName == CommonDefine.StoryNodeName.Dialog then
      local dialog = Dialog(self.storyId, key, self.interUid)
      dialog:Awake()
      self.dialogs[key] = dialog
    end
    if value.NodeName == CommonDefine.StoryNodeName.CameraGroup then
      self.cameraNodes[key] = value
    end
  end
end

function Story:StartFirstDialog()
  self.curDialogNodeId = self.storyConfig.FirstNode
  self:EnterCurDialog()
end

function Story:GetDialog(nodeTid)
  return self.dialogs[nodeTid]
end

function Story:IsAppendStoryPanelText(curDialog, NextNodeId)
  local appendUiTypeList = {
    [CommonDefine.StoryDialogType.MaskDialog] = 1,
    [CommonDefine.StoryDialogType.HalfMaskDialog] = 1
  }
  local nextDialog = self:GetDialog(NextNodeId)
  local dgType = curDialog:GetType()
  if nextDialog and dgType == nextDialog:GetType() and appendUiTypeList[dgType] then
    return true
  end
end

function Story:EnterNextDialog()
  local curDialog = self:GetDialog(self.curDialogNodeId)
  local dialogConfig = StoryDataUtils.GetNodeData(self.storyId, self.curDialogNodeId)
  local nextNodeId = dialogConfig.NextNodeId or 0
  local nextDialog = self:GetDialog(nextNodeId)
  if nextDialog then
    if self:IsAppendStoryPanelText(curDialog, dialogConfig.NextNodeId) then
      EventMgr.Instance.StorySetShowText:Dispatch(self.storyId, dialogConfig.NextNodeId)
      self.curDialogNodeId = dialogConfig.NextNodeId
      return
    end
    local nextDialogConfig = StoryDataUtils.GetNodeData(self.storyId, dialogConfig.NextNodeId)
    local keepUIMap = {
      [CommonDefine.StoryDialogType.DynamicComic] = true
    }
    local curDialogType = dialogConfig.NodeAttr.DialogType
    if curDialogType == nextDialogConfig.NodeAttr.DialogType and keepUIMap[curDialogType] then
      self:KeepCurDialogUI()
    end
    self:ExitCurDialog()
    self.curDialogNodeId = dialogConfig.NextNodeId
    self:EnterCurDialog()
  else
    local function handle(data, code)
      Logger.Debug("Story End", self.curDialogNodeId)
      
      local options = data and data.options
      if not curDialog:IsHasOptionNode() or not options then
        if code.code == ErrorMsg.SUCCESS then
          self.endCallback(self.storyId)
        end
        if data then
          EventMgr.Instance.GearCloseNodeHandleUIEvent:Dispatch(true, data)
        end
        return
      end
      if code.code == ErrorMsg.SUCCESS and options then
        EventMgr.Instance.StoryShowOptions:Dispatch(data)
      end
    end
    
    if self.isLocal then
      self.endCallback(self.storyId)
    else
      if CacheUtils.IsCached("StoryEnd", self.curDialogNodeId) then
        return
      end
      CacheUtils.CacheData("StoryEnd", self.curDialogNodeId, 3)
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("WorldRequest", "OnPlotSayEnd", function(data, code)
        CacheUtils.ClearCacheData("StoryEnd", self.curDialogNodeId)
        handle(data, code)
      end, function(data, code)
        CacheUtils.ClearCacheData("StoryEnd", self.curDialogNodeId)
        handle(data, code)
      end, self.curDialogNodeId)
    end
  end
end

function Story:EnterCurDialog()
  if self.dialogs[self.curDialogNodeId] then
    self.dialogs[self.curDialogNodeId]:EnterDialog()
    if self.isAuto then
      self.dialogs[self.curDialogNodeId]:AutoStory()
    end
  end
  if self.cameraNodes[self.curDialogNodeId] then
    local nodeData = self.cameraNodes[self.curDialogNodeId]
    local attr = nodeData.NodeAttr
    EventMgr.Instance.SceneCamera:Dispatch(attr.CameraGroupName, attr.dura, function()
      self:ExitCurDialog()
      self.curDialogNodeId = nodeData.NextNodeId
      self:EnterCurDialog()
    end)
  end
end

function Story:KeepCurDialogUI()
  if self.dialogs[self.curDialogNodeId] then
    self.dialogs[self.curDialogNodeId]:SetKeepDialogUIOnDestroy()
  end
end

function Story:ExitCurDialog()
  if self.dialogs[self.curDialogNodeId] then
    self.dialogs[self.curDialogNodeId]:Destroy()
    self.dialogs[self.curDialogNodeId] = nil
  end
end

function Story:AutoStory()
  self.isAuto = DataCenter.storyData.AutoPlay
  if self.isAuto then
    if self.dialogs[self.curDialogNodeId] then
      self.dialogs[self.curDialogNodeId]:AutoStory()
    end
  elseif self.dialogs[self.curDialogNodeId] then
    self.dialogs[self.curDialogNodeId]:StopAutoStory()
  end
end

function Story:StepStory()
  local dialog = self.dialogs[self.curDialogNodeId]
  if not dialog then
    return
  end
  local dialogConfig = dialog.dialogConfig
  if dialogConfig.NextNodeId and 0 == dialogConfig.NextNodeId then
    dialog:EnterDialog()
    dialog:Step(nil)
    self:EnterNextDialog()
    return
  end
  dialog:Step(function()
    dialog:Destroy()
    self.dialogs[self.curDialogNodeId] = nil
    local dialogConfig = StoryDataUtils.GetNodeData(self.storyId, self.curDialogNodeId)
    if dialogConfig.NextNodeId and dialogConfig.NextNodeId > 0 then
      self.curDialogNodeId = dialogConfig.NextNodeId
    end
    self:StepStory()
  end)
end

function Story:StepCurDialog()
  if self.dialogs[self.curDialogNodeId] then
    self.dialogs[self.curDialogNodeId]:NextStep()
  end
end

function Story:Update()
  Super.Update(self)
  for _, value in pairs(self.dialogs) do
    value:Update()
  end
end

function Story:Destroy()
  Super.Destroy(self)
  for _, value in pairs(self.dialogs) do
    value:Destroy()
  end
  self.dialogs = {}
  self.curDialogNodeId = 0
end

return Story
