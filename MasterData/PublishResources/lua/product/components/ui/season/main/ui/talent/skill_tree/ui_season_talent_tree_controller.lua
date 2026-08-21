_class("UISeasonTalentTreeController", UIController)
UISeasonTalentTreeController = UISeasonTalentTreeController

function UISeasonTalentTreeController:LoadDataOnEnter(TT, res)
  self._componentId_Talent_Tree = ECCampaignSeasonComponentID.TALENT_TREE
  self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  self._talent_tree_component = self._seasonObj:GetComponent(self._componentId_Talent_Tree)
  if self._talent_tree_component:ComponentIsOpen() then
    res:SetSucc(true)
    self._comCfgID = self._talent_tree_component:GetComponentCfgId()
    self._talent_tree_component_info = self._talent_tree_component:GetComponentInfo()
  else
    res:SetSucc(false)
    Log.error("###[UISeasonTalentTreeController] tree com is close !")
  end
  self._currentSelectSkill = nil
  self._currentSelectSlotID = nil
  self._isDragTreeSkill = nil
  self._isDragSlotSkill = nil
  self._isDragSlotID = nil
end

function UISeasonTalentTreeController:GetComponents()
  local backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = backBtn:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end, function()
    UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.TalentTree)
  end, function()
    GameGlobal.GetUIModule(SeasonModule):ExitSeasonTo(UIStateType.UIMain)
  end)
  local costItemPool = self:GetUIComponent("UISelectObjectPath", "costItem")
  self._costItem = costItemPool:SpawnObject("UISeasonTalentCostItemBase")
  local itemTips = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._itemTips = itemTips:SpawnObject("UISelectInfo")
  local treePool = self:GetUIComponent("UISelectObjectPath", "treePool")
  local infoPool = self:GetUIComponent("UISelectObjectPath", "infoPool")
  local slotPool = self:GetUIComponent("UISelectObjectPath", "slotPool")
  self._slotItem = slotPool:SpawnObject("UISeasonTalentTreeSlotItem")
  self._treeItem = treePool:SpawnObject("UISeasonTalentTreeTreeItem")
  self._infoItem = infoPool:SpawnObject("UISeasonTalentTreeInfoItem")
  self._dragSkill = self:GetGameObject("DragSkill")
  self._dragSkillRect = self:GetUIComponent("RectTransform", "DragSkill")
  self._dragSkillIcon = self:GetUIComponent("RawImageLoader", "DragSkillIcon")
  self._dragSkill:SetActive(false)
  self._guideObj = self:GetGameObject("guideObj")
end

function UISeasonTalentTreeController:OnShow(uiParams)
  self:AttachEvents()
  self:GetComponents()
  self:CreateStateMachine()
  self:CreateData()
  self:OnValue()
  self:ClearRed()
  self:Lock("UISeasonTalentTreeController:OnShow")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(500, function()
    self:UnLock("UISeasonTalentTreeController:OnShow")
  end)
  self:CheckGuide()
end

function UISeasonTalentTreeController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonTalentTreeController)
end

function UISeasonTalentTreeController:Get_1P_2N_Icon()
  if self._treeItem then
    return self._treeItem:Get_1P_2N_Icon()
  end
end

function UISeasonTalentTreeController:ClearRed()
  local sample = GameGlobal.GetModule(SeasonModule):GetCurSeasonSample()
  if sample then
    local skillRed = UISeasonHelper.TalentTreeSkillRed(sample)
    if skillRed then
      GameGlobal.GetUIModule(SeasonModule):SetTalentTreeSkillClientTag(true)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentTreeRedChange)
    end
  end
end

function UISeasonTalentTreeController:AttachEvents()
  self:AttachEvent(GameEventType.OnTalentDragEvent, self.DragEvent)
end

function UISeasonTalentTreeController:DragEvent(type, param)
  if type == TalentTree_FSM_Event_Type.Drag_In_Begin then
    self._machine:ChangeState(TalentTree_FSM_State_Type.Drag_In_Begin, param)
  elseif type == TalentTree_FSM_Event_Type.Drag_In_Drag then
    self._machine:Update(param)
  elseif type == TalentTree_FSM_Event_Type.Drag_In_End then
    self._machine:ChangeState(TalentTree_FSM_State_Type.Drag_In_End, param)
  elseif type == TalentTree_FSM_Event_Type.Drag_Out_Begin then
    self._machine:ChangeState(TalentTree_FSM_State_Type.Drag_Out_Begin, param)
  elseif type == TalentTree_FSM_Event_Type.Drag_Out_Drag then
    self._machine:Update(param)
  elseif type == TalentTree_FSM_Event_Type.Drag_Out_End then
    self._machine:ChangeState(TalentTree_FSM_State_Type.Drag_Out_End, param)
  else
    Log.error("###[UISeasonTalentTreeController] DragEvent type error !")
  end
end

function UISeasonTalentTreeController:OnValue()
  self:SlotList()
  self:ShowSkillTree()
  self:ShowSkillInfo()
  self:SetCostItem()
end

function UISeasonTalentTreeController:CreateData()
  self._skillData = SeasonTalentTree_SkillCfg:New(self._talent_tree_component)
end

function UISeasonTalentTreeController:RefreshSelectSkillCls()
  if self._currentSelectSkill then
    local rootid = self._currentSelectSkill.rootid
    local map = self._skillData:RootIDMap()
    self._currentSelectSkill = map[rootid]
  end
end

function UISeasonTalentTreeController:SlotList()
  self._slotPoolRect, self._slotRectList, self._slotCfgList = self._slotItem:SetData(self._talent_tree_component, self._skillData, function(slotid)
    self:ClickSlot(slotid)
  end, function(slotid)
    self:UnLoadSkill(slotid)
  end, function()
    self:UnLoadAllSkill()
  end)
end

function UISeasonTalentTreeController:ShowSkillTree()
  self._treeItem:SetData(self._talent_tree_component, self._skillData, function(cls)
    self:ClickSkill(cls)
  end)
end

function UISeasonTalentTreeController:ShowSkillInfo()
  self._infoItem:SetData(self._talent_tree_component, self._skillData, self._currentSelectSkill, function()
    self:UpLvSkill()
  end, function()
    self:BuySkill()
  end)
end

function UISeasonTalentTreeController:UpLvSkill()
  local rootid = self._currentSelectSkill.rootid
  GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_Upgrade, rootid, 0)
end

function UISeasonTalentTreeController:BuySkill()
  local rootid = self._currentSelectSkill.rootid
  GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_Buy, rootid, 0)
end

function UISeasonTalentTreeController:ClickSlot(slotid)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  local currentState = self._machine:CurrentState()
  if currentState == TalentTree_FSM_State_Type.Select_Skill then
    local rootid = self._currentSelectSkill.rootid
    local cfg_slot = Cfg.cfg_component_talent_tree_slot({
      ComponentID = self._comCfgID,
      SlotID = slotid
    })[1]
    if cfg_slot.TypeLimit == self._currentSelectSkill.type then
      Log.error("###[UISeasonTalentTreeController] start load a skill,ClickSlot slotid:", slotid, "|rootid:", rootid)
      GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_Install, rootid, slotid)
    else
      self._machine:ChangeState(TalentTree_FSM_State_Type.Select_Slot, slotid)
    end
  else
    self._machine:ChangeState(TalentTree_FSM_State_Type.Select_Slot, slotid)
  end
end

function UISeasonTalentTreeController:ClickSkill(cls)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  local currentState = self._machine:CurrentState()
  if currentState == TalentTree_FSM_State_Type.Select_Slot then
    local rootid = cls.rootid
    local cfg_slot = Cfg.cfg_component_talent_tree_slot({
      ComponentID = self._comCfgID,
      SlotID = self._currentSelectSlotID
    })[1]
    if cfg_slot.TypeLimit == cls.type then
      Log.error("###[UISeasonTalentTreeController] start load a skill,ClickSkill slotid:", self._currentSelectSlotID, "|rootid:", rootid)
      GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_Install, rootid, self._currentSelectSlotID)
    else
      self._machine:ChangeState(TalentTree_FSM_State_Type.Select_Skill, cls)
    end
  else
    self._machine:ChangeState(TalentTree_FSM_State_Type.Select_Skill, cls)
  end
end

function UISeasonTalentTreeController:OperateTalentTreeSkillReq(TT, type, rootid, slotid, callback)
  self:Lock("UISeasonTalentTreeController:OperateTalentTreeSkillReq")
  local res = AsyncRequestRes:New()
  self._talent_tree_component:HandleOperateTalentTreeSkill(TT, res, type, rootid, slotid)
  self:UnLock("UISeasonTalentTreeController:OperateTalentTreeSkillReq")
  if res:GetSucc() then
    self:ReloadData()
    self:CreateData()
    self:RefreshSelectSkillCls()
    self:RefreshUI()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentTreeChange)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentTreeRedChange)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSkill, self._currentSelectSkill)
    if type == OperateTalentTree.OTT_Talent_Buy or type == OperateTalentTree.OTT_Talent_Upgrade then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentTreeSkillUp, rootid)
    end
    if callback then
      callback()
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonTalentTreeController] HandleOperateTalentTreeSkill fail ! result:", result)
  end
end

function UISeasonTalentTreeController:UnLoadSkill(slotid)
  Log.error("###[UISeasonTalentTreeController] start unload one skill,slotid:", slotid)
  GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_Install, 0, slotid, function()
    self._machine:ChangeState(TalentTree_FSM_State_Type.Empty)
  end)
end

function UISeasonTalentTreeController:UnLoadAllSkill()
  Log.error("###[UISeasonTalentTreeController] start unload all skill")
  GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_UnInstall_all, 0, 0, function()
    self._machine:ChangeState(TalentTree_FSM_State_Type.Empty)
  end)
end

function UISeasonTalentTreeController:ReloadData()
  self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  self._talent_tree_component = self._seasonObj:GetComponent(self._componentId_Talent_Tree)
  if self._talent_tree_component:ComponentIsOpen() then
    self._comCfgID = self._talent_tree_component:GetComponentCfgId()
    self._talent_tree_component_info = self._talent_tree_component:GetComponentInfo()
  else
    Log.error("###[UISeasonTalentTreeController] tree com is close 2!")
    local res = AsyncRequestRes:New()
    res:SetSucc(false)
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE)
    GameGlobal.GetModule(SeasonModule):CheckSeasonClose(res)
  end
end

function UISeasonTalentTreeController:RefreshUI()
  self._slotItem:RefreshData(self._talent_tree_component, self._skillData)
  self._treeItem:RefreshCls(self._talent_tree_component, self._skillData)
  self._infoItem:RefreshData(self._talent_tree_component, self._skillData, self._currentSelectSkill)
end

function UISeasonTalentTreeController:CreateStateMachine()
  self._machine = TalentTree_FSM_Machine:New()
  self:Select_Skill_State()
  self:Empty_State()
  self:Select_Slot_State()
  self:Drag_In_Begin_State()
  self:Drag_In_End_State()
  self:Drag_Out_Begin_State()
  self:Drag_Out_End_State()
end

function UISeasonTalentTreeController:Select_Skill_State()
  local state_select_skill = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Select_Skill, function(params)
    self._currentSelectSkill = params
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSkill, self._currentSelectSkill)
    self._infoItem:RefreshData(self._talent_tree_component, self._skillData, self._currentSelectSkill, true)
  end, function(context)
    self._currentSelectSkill = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSkill, self._currentSelectSkill)
  end, function()
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Select_Skill, state_select_skill)
end

function UISeasonTalentTreeController:Empty_State()
  local state_Empty = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Empty, function()
    self._currentSelectSkill = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSkill, self._currentSelectSkill)
    self._infoItem:RefreshData(self._talent_tree_component, self._skillData, self._currentSelectSkill)
  end, function()
  end, function()
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Empty, state_Empty)
end

function UISeasonTalentTreeController:Select_Slot_State()
  local state_Select_Slot = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Select_Slot, function(slotid)
    self._currentSelectSlotID = slotid
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSlot, self._currentSelectSlotID)
    self._currentSelectSkill = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSkill, self._currentSelectSkill)
    self._infoItem:RefreshData(self._talent_tree_component, self._skillData, self._currentSelectSkill)
  end, function()
    self._currentSelectSlotID = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSlot, self._currentSelectSlotID)
  end, function()
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Select_Slot, state_Select_Slot)
end

function UISeasonTalentTreeController:Drag_In_Begin_State()
  local state_Drag_In_Begin = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Drag_In_Begin, function(cls)
    local rootid = cls.rootid
    self._isDragTreeSkill = rootid
    self:ShowDragSkill(rootid)
    self._currentSelectSkill = cls
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSelectSkill, self._currentSelectSkill)
    self._infoItem:RefreshData(self._talent_tree_component, self._skillData, self._currentSelectSkill)
    if GuideHelper.IsUIGuideShow() then
      self._guideObj:SetActive(true)
      if GameGlobal.GuideMessageBoxMng()._uiMsgBox then
        GameGlobal.GuideMessageBoxMng()._uiMsgBox:SetShow(false)
      end
    end
  end, function(pos)
  end, function(pos)
    if self._isDragTreeSkill then
      self:UpdateDragSkillPos(pos)
    end
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Drag_In_Begin, state_Drag_In_Begin)
end

function UISeasonTalentTreeController:UpdateDragSkillPos(pos)
  local uipos = self:Screen2Rect(pos, self._dragSkillRect.parent)
  self._dragSkillRect.anchoredPosition = uipos
end

function UISeasonTalentTreeController:Drag_In_End_State()
  local state_Drag_In_End_State = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Drag_In_End, function(pos)
    if pos then
      local idx = self:IsDragInSlot(pos)
      if GuideHelper.IsUIGuideShow() then
        self._guideObj:SetActive(false)
        if GameGlobal.GuideMessageBoxMng()._uiMsgBox then
          GameGlobal.GuideMessageBoxMng()._uiMsgBox:SetShow(true)
        end
      end
      if idx and self:LoadSkillOnSlot(idx) and GuideHelper.IsUIGuideShow() then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
      end
      self._isDragTreeSkill = nil
      self:ShowDragSkill(nil)
    else
      Log.debug("###[UISeasonTalentTreeController] in error end !")
    end
  end, function()
  end, function()
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Drag_In_End, state_Drag_In_End_State)
end

function UISeasonTalentTreeController:LoadSkillOnSlot(idx)
  local slotCfg = self._slotCfgList[idx]
  local slotInfo = self._talent_tree_component_info.m_talent_info.m_skill_solt
  if slotInfo[slotCfg.SlotID] then
    local skillCfg = Cfg.cfg_component_talent_tree_skill({
      ComponentID = self._comCfgID,
      SkillTypeID = self._isDragTreeSkill
    })[1]
    if skillCfg.Type == slotCfg.TypeLimit then
      Log.error("###[UISeasonTalentTreeController] drag skill inner , type is limit ! succ , slot idx:", idx)
      GameGlobal.TaskManager():StartTask(self.OperateTalentTreeSkillReq, self, OperateTalentTree.OTT_Talent_Install, self._isDragTreeSkill, slotCfg.SlotID)
      return true
    else
      Log.error("###[UISeasonTalentTreeController] drag skill inner , type is not limit ! fail , slot idx:", idx)
    end
  else
    Log.error("###[UISeasonTalentTreeController] drag skill inner lock slot ! fail , slot idx:", idx)
  end
  return false
end

function UISeasonTalentTreeController:IsDragInSlot(screenPos)
  local uipos = self:Screen2Rect(screenPos, self._slotPoolRect.parent)
  for index, value in ipairs(self._slotRectList) do
    local inner = self:CheckRectInner(uipos, value)
    if inner then
      return index
    end
  end
  return false
end

function UISeasonTalentTreeController:Drag_Out_Begin_State()
  local state_Drag_Out_Begin = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Drag_Out_Begin, function(params)
    self._isDragSlotSkill = params.rootid
    self._isDragSlotID = params.slotid
    self:ShowDragSkill(params.rootid)
  end, function(pos)
  end, function(pos)
    if self._isDragSlotSkill then
      self:UpdateDragSkillPos(pos)
    end
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Drag_Out_Begin, state_Drag_Out_Begin)
end

function UISeasonTalentTreeController:ShowDragSkill(rootid)
  if rootid then
    self._dragSkill:SetActive(true)
    local skillMap = self._skillData:RootIDMap()
    local cls = skillMap[rootid]
    local cfg = cls:GetCfg()
    local icon = cfg.Icon
    if icon then
      self._dragSkillIcon:LoadImage(icon)
    end
  else
    self._dragSkill:SetActive(false)
  end
end

function UISeasonTalentTreeController:Drag_Out_End_State()
  local state_Drag_Out_End = TalentTree_FSM_State:New(TalentTree_FSM_State_Type.Drag_Out_End, function(pos)
    if pos then
      if self:IsOutSlotPool(pos) then
        self:UnLoadSkill(self._isDragSlotID)
      end
      self._isDragSlotSkill = nil
      self._isDragSlotID = nil
      self:ShowDragSkill(nil)
    else
      Log.debug("###[UISeasonTalentTreeController] error end !")
    end
  end, function()
  end, function()
  end)
  self._machine:AddState(TalentTree_FSM_State_Type.Drag_Out_End, state_Drag_Out_End)
end

function UISeasonTalentTreeController:IsOutSlotPool(screenPos)
  local uipos = self:Screen2Rect(screenPos, self._slotPoolRect.parent)
  local inner = self:CheckRectInner(uipos, self._slotPoolRect)
  if inner then
    Log.error("###[UISeasonTalentTreeController] drag skill out slot ! fail , slot id:", self._isDragSlotID)
  else
    Log.error("###[UISeasonTalentTreeController] drag skill out slot ! succ , slot id:", self._isDragSlotID)
  end
  return not inner
end

function UISeasonTalentTreeController:CheckRectInner(uipos, rectTransform)
  local xIn = false
  if uipos.x > rectTransform.anchoredPosition.x - rectTransform.sizeDelta.x * 0.5 and uipos.x < rectTransform.anchoredPosition.x + rectTransform.sizeDelta.x * 0.5 then
    xIn = true
  end
  local yIn = false
  if xIn and uipos.y > rectTransform.anchoredPosition.y - rectTransform.sizeDelta.y * 0.5 and uipos.y < rectTransform.anchoredPosition.y + rectTransform.sizeDelta.y * 0.5 then
    yIn = true
  end
  return xIn and yIn
end

function UISeasonTalentTreeController:Screen2Rect(screenPos, tr)
  if tr then
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(tr, screenPos, camera, nil)
    return pos
  end
end

function UISeasonTalentTreeController:OnHide()
  self:UnLock("UISeasonTalentTreeController:OnShow")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonTalentTreeController:SetCostItem()
  local costid = Cfg.cfg_global.TalentTreeItemId.IntValue
  self._costItem:SetData(costid, function(id, go)
    if self._itemTips then
      self._itemTips:SetData(costid, go.transform.position)
    end
  end)
end

function UISeasonTalentTreeController:EmptyOnClick(go)
  self._machine:ChangeState(TalentTree_FSM_State_Type.Empty)
end
