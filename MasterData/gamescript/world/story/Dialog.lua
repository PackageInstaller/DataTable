local GameObject = CS.UnityEngine.GameObject
local Dialog, Super = System.NewClass("Dialog", Entity)

function Dialog:ctor(storyId, nodeId, interUid)
  Super.ctor(self)
  self.nodeId = nodeId
  self.storyId = storyId
  self.interUid = interUid
  self.dialogConfig = StoryDataUtils.GetNodeData(storyId, nodeId)
  self.childNode = {}
  self.dialogId = self.dialogConfig.NodeAttr.DialogId
  self.state = CommonDefine.RunningStateType.Awake
  self.isCloseUIOnDestroy = true
end

function Dialog:Awake()
  local nodeAttr = self.dialogConfig and self.dialogConfig.NodeAttr
  local childsTable = nodeAttr and nodeAttr.childsTable
  if not childsTable then
    return
  end
  for _, value in pairs(childsTable) do
    local childNodeConfig = StoryDataUtils.GetNodeData(self.storyId, value)
    local node = StoryFactory.Create(childNodeConfig.NodeName, self.storyId, value, nil)
    self.childNode[value] = node
  end
  self.state = CommonDefine.RunningStateType.Awake
end

function Dialog:SetKeepDialogUIOnDestroy()
  self.isCloseUIOnDestroy = false
end

function Dialog:EnterDialog()
  if self.state == CommonDefine.RunningStateType.Awake then
    if self.dialogConfig.NodeAttr.DialogType == CommonDefine.StoryDialogType.None then
      EventMgr.Instance.StoryNext:Dispatch(self.storyId, self.nodeId)
      return
    end
    self:ShowDialogUI()
    for _, value in pairs(self.childNode) do
      value:Enter()
    end
    self:ShowPhoto()
    self.state = CommonDefine.RunningStateType.Running
    if self:IsNeedAutoStory() then
      self:AutoStory()
    end
  end
end

function Dialog:Update()
  Super.Update(self)
end

function Dialog:ShowDialogUI()
  if not self.binder then
    self.binder = Vue.newBinder(self)
    self.binder:BindEvent(EventMgr.Instance.StroyCardTip, System.fn(self, self.ShowStoryCardTip))
  end
  local switch = {
    [CommonDefine.StoryDialogType.NPCDialog] = function()
      self.uiPath = Urls.StoryBubbleDialog
    end,
    [CommonDefine.StoryDialogType.MaskDialog] = function()
      self.uiPath = Urls.StoryFullDialogPanel
    end
  }
  local recyleDialogType = {
    [CommonDefine.StoryDialogType.DynamicComic] = true
  }
  local dialogType = self.dialogConfig.NodeAttr.DialogType
  local fun = switch[dialogType]
  if fun then
    if self.dialogConfig.NodeAttr.ScreenCtl > 0 then
      EventMgr.Instance.MoveBanned:Dispatch("ScreenCtl", true)
    end
    fun()
    if self.uiPath then
      if dialogType == CommonDefine.StoryDialogType.NPCDialog then
        self.bubbleUI = self.binder:BindNewComponent(MapManager.Instance:GetStoryLayer(), require(self.uiPath), Function_BubbleDialogResource, self.storyId, self.nodeId, nil)
      elseif dialogType == CommonDefine.StoryDialogType.SideDialog then
        if UIManager.Instance:GetWindow(self.uiPath) then
          EventMgr.Instance.StorySideDialog:Dispatch(self.storyId, self.nodeId)
        else
          UIManager.Instance:Reopen(self.uiPath, self.storyId, self.nodeId, nil)
        end
      elseif recyleDialogType[dialogType] then
        if UIManager.Instance:GetWindow(self.uiPath) then
          EventMgr.Instance.StoryNextInfo:Dispatch(self.storyId, self.nodeId)
        else
          UIManager.Instance:Reopen(self.uiPath, self.storyId, self.nodeId, nil)
        end
      else
        UIManager.Instance:Reopen(self.uiPath, self.storyId, self.nodeId, nil)
      end
    end
  end
end

function Dialog:IsInView(worldPos)
  local camTransform = UIRootMgr.GetMainCamera().transform
  local viewPos = UIRootMgr.GetMainCamera():WorldToViewportPoint(worldPos)
  local dir = (worldPos - camTransform.position).normalized
  local dot = CS.UnityEngine.Vector3.Dot(camTransform.forward, dir)
  if dot > 0 then
    return true
  else
    return false
  end
end

function Dialog:SetBubbleUIPos()
  local interUid = self.interUid
  
  local function GetActor(tid)
    if -1 == tid then
      do return RoleManager.Instance.GetRole, RoleManager.Instance end
      return RoleManager.Instance.GetRole, RoleManager.Instance, DataCenter.playerData.DRole.uid
    end
    return nil
  end
  
  local actor = GetActor(self.dialogConfig.NodeAttr.NpcId)
  if nil == actor then
    Logger.Info("没有找到Npc  NpcID == %s", self.dialogConfig.NodeAttr.NpcId)
    self.bubbleUI.binder:teardown()
    self.bubbleUI = nil
    return
  end
  local worldPos = actor:GetHead().transform.position
  if not self:IsInView(worldPos) then
    self.bubbleUI.ui.uiNode:SetActive(false)
    return
  end
  self.bubbleUI.ui.uiNode:SetActive(true)
  local targetParentRectTransform = self.bubbleUI.ui.uiNode.transform.parent:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local convertFunc = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos
  local uiLocalPos = convertFunc(worldPos, targetParentRectTransform, UIRootMgr.GetMainCamera(), UIRootMgr.GetUICamera())
  self.bubbleUI.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = uiLocalPos
end

function Dialog:CloseDialogUI()
  if self.binder then
    self.binder:Unbind()
    self.binder = nil
  end
  self.sceneDialogUI = nil
  if self.uiPath ~= Urls.StoryBubbleDialog then
    UIManager.Instance:CloseByUrl(self.uiPath)
    self.uiPath = nil
  end
  local isBubbleDialog = false
  if self.uiPath == Urls.StoryBubbleDialog then
    isBubbleDialog = true
    self.uiPath = nil
    self.bubbleUI = nil
  end
  if not isBubbleDialog then
    EventMgr.Instance.StoryShowBgPanel:Dispatch()
    EventMgr.Instance.StoryShowComponent:Dispatch()
  end
end

function Dialog:ShowStoryCardTip(params)
end

function Dialog:IsNeedAutoStory()
  if self.dialogConfig.NodeAttr.DialogType == CommonDefine.StoryDialogType.NPCDialog or self.dialogConfig.NodeAttr.DialogType == CommonDefine.StoryDialogType.SideDialog then
    return true
  end
  if self.dialogConfig.NodeAttr.ShowComicAuto == CommonDefine.ComicAuto.Forever then
    return true
  end
  return false
end

function Dialog:AutoStory()
  if self.autoTimer and self.autoTimer > 0 then
    return
  end
  if self.dialogConfig.NodeAttr.ShowComicAuto == CommonDefine.ComicAuto.Never then
    return
  end
  if 0 == DataCenter.copiesData.CopiesId and self:GetType() == CommonDefine.StoryDialogType.UIDialog then
    return
  end
  local autoTime = StoryFactory.GetDialogTime(self.dialogConfig)
  if autoTime and autoTime > 0 then
    self.autoTimer = TimerManager.Instance:CreateTimer(autoTime, 1, nil, function()
      EventMgr.Instance.StoryNext:Dispatch(self.storyId, self.nodeId)
    end)
  end
end

function Dialog:StopAutoStory()
  Logger.Debug("StopAutoStory  dialogNodeId == %s", self.nodeId)
  if self.autoTimer and self.autoTimer > 0 then
    TimerManager.Instance:StopTimer(self.autoTimer)
    self.autoTimer = nil
  end
end

function Dialog:Step(callback)
  self:StopAutoStory()
  for _, value in pairs(self.childNode) do
    value:Step()
  end
  if callback then
    callback()
  end
end

function Dialog:NextStep()
  if self.autoTimer and self.autoTimer > 0 then
    TimerManager.Instance:StopTimer(self.autoTimer)
    self.autoTimer = nil
  end
  for _, value in pairs(self.childNode) do
    value:NextStep()
  end
end

function Dialog:Destroy()
  Super.Destroy(self)
  if self.dialogConfig.NodeAttr.ScreenCtl > 0 then
    EventMgr.Instance.MoveBanned:Dispatch("ScreenCtl", false)
  end
  if self.isCloseUIOnDestroy then
    self:CloseDialogUI()
  end
  for _, value in pairs(self.childNode) do
    value:Exit()
  end
  self.childNode = {}
  if self.autoTimer and self.autoTimer > 0 then
    TimerManager.Instance:StopTimer(self.autoTimer)
    self.autoTimer = nil
  end
  self.state = CommonDefine.RunningStateType.End
  EventMgr.Instance.StroyCardTip:RemoveEvent(System.fn(self, self.ShowStoryCardTip))
end

function Dialog:GetType()
  return self.dialogConfig.NodeAttr.DialogType
end

function Dialog:IsHasOptionNode()
  local ret = false
  for _, value in pairs(self.childNode) do
    if value:IsOptionNode() then
      ret = true
    end
  end
  return ret
end

function Dialog:ShowPhoto()
  if self.dialogConfig.NodeAttr.DialogType == "UIDialog" and self.dialogConfig.NodeAttr.ShowPhotoPath ~= "" then
    EventMgr.Instance.StoryShowPhoto:Dispatch(self.dialogConfig.NodeAttr.ShowPhotoPath)
  end
end

return Dialog
