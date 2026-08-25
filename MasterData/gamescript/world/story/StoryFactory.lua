local StoryFactory = System.NewClass("StoryFactory")

function StoryFactory.Create(nodeName, storyId, nodeId, callback)
  local nodeCalss
  if nodeName then
  else
  end
  if nodeCalss then
    do return nodeCalss, storyId, nodeId end
    return nodeCalss, storyId, nodeId, callback
  end
end

function StoryFactory.GetDialogTime(dialogConfig)
  local function calTime(deltaTime, content, minTime)
    local wordCount = UIUtils.SubStringGetTotalIndex(content)
    
    local time = wordCount * deltaTime
    if minTime > time then
      time = minTime
    end
    return time
  end
  
  local switch = {
    [CommonDefine.StoryDialogType.UIDialog] = function()
      local deltaTime = tonumber(DT.GetConstant("UIDialog_Speed"))
      local minTime = tonumber(DT.GetConstant("UIDialog_MiniTime"))
      do return calTime, deltaTime, dialogConfig.NodeAttr.Content end
      return calTime, deltaTime, dialogConfig.NodeAttr.Content, minTime
    end,
    [CommonDefine.StoryDialogType.NPCDialog] = function()
      local deltaTime = tonumber(DT.GetConstant("NPCDialog_Speed"))
      local minTime = tonumber(DT.GetConstant("NPCDialog_MiniTime"))
      do return calTime, deltaTime, dialogConfig.NodeAttr.Content end
      return calTime, deltaTime, dialogConfig.NodeAttr.Content, minTime
    end,
    [CommonDefine.StoryDialogType.SideDialog] = function()
      local deltaTime = tonumber(DT.GetConstant("SideDialog_Speed"))
      local minTime = tonumber(DT.GetConstant("SideDialog_MiniTime"))
      do return calTime, deltaTime, dialogConfig.NodeAttr.Content end
      return calTime, deltaTime, dialogConfig.NodeAttr.Content, minTime
    end,
    [CommonDefine.StoryDialogType.MaskDialog] = function()
      local deltaTime = tonumber(DT.GetConstant("MaskDialog_Speed"))
      local minTime = tonumber(DT.GetConstant("MaskDialog_MiniTime"))
      do return calTime, deltaTime, dialogConfig.NodeAttr.Content end
      return calTime, deltaTime, dialogConfig.NodeAttr.Content, minTime
    end,
    [CommonDefine.StoryDialogType.HalfMaskDialog] = function()
      local deltaTime = tonumber(DT.GetConstant("HalfMaskDialog_Speed"))
      local minTime = tonumber(DT.GetConstant("HalfMaskDialog_MiniTime"))
      do return calTime, deltaTime, dialogConfig.NodeAttr.Content end
      return calTime, deltaTime, dialogConfig.NodeAttr.Content, minTime
    end,
    [CommonDefine.StoryDialogType.CGDialog] = function()
      return 1
    end,
    [CommonDefine.StoryDialogType.SceneDialog] = function()
      return -1
    end
  }
  local autoTimeFunc = switch[dialogConfig.NodeAttr.DialogType]
  if autoTimeFunc then
    local time = autoTimeFunc()
    Logger.Info("Dialog Time == %s", time)
    return time
  else
    return -1
  end
end

return StoryFactory
