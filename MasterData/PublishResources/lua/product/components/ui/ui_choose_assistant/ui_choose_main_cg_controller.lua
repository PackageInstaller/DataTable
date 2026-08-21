_class("UIChooseMainCgController", UIController)
UIChooseMainCgController = UIChooseMainCgController

function UIChooseMainCgController:Constructor()
  self._changePosValue = 0
  self._changePosValue2 = 0
  self._speed = 50
  self._up_offset = -1
  self._down_offset = 5
  self._right_offset = -20
  self._scaleK = 0.2
  self._touchScaleK = 0.001
  self._scaleMax = 2
  self._scaleMin = 0.5
  self._moveK = 1
  self._moveMaxX = 1000
  self._moveMinX = -1000
  self._moveMaxY = 500
  self._moveMinY = -500
  self._mousePos2 = 0
  self._mousePos = 0
  self._scaling = false
  self._draging = false
  self._touch0Pos = 0
  self._touch0Pos2 = 0
  self._touchDis = 0
  self._touchDis2 = 0
  local pixels = Cfg.cfg_aircraft_camera.clickAndDragPixelLength.Value
  self._startMove = pixels * pixels
  self._roleModule = self:GetModule(RoleModule)
  self._signInModule = self:GetModule(SignInModule)
  self.rangSelectList = {}
end

function UIChooseMainCgController:OnShow(params)
  self:GetComponents()
  self:SetCgShowInfo(params)
  self:_OnInit()
  local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  if flagValue then
    self._cgState = DynamicAndStaticState.Static
  else
    self._cgState = DynamicAndStaticState.Dynamic
  end
  self.isSetCgControllerShowOrHide = true
  self:AttachEvent(GameEventType.ChangeMainBg, self.SetMainBg)
end

function UIChooseMainCgController:SetCgShowInfo(params)
  local type = params[1]
  if type then
    if type == UIChooseAssistantType.Change2Cg then
      self._cgID = params[2]
      self._grade = params[3]
      self._skinID = params[4]
      self._asID = params[5]
    elseif type == UIChooseAssistantType.Change2Bg then
      self._bgId = params[2]
      self._bgType = params[3]
    end
  else
    self._bgId = self._roleModule:UI_GetMainBgID()
    self._bgType = self._roleModule.m_choose_painting.background_type
    self._bgId = self._bgId == 0 and 2 or self._bgId
    self._bgType = self._bgType == 0 and 1 or self._bgType
  end
  self:SetShowAssistant()
  self:OnValue()
  self:_GetPosAndScale()
  self._changeItemWidget:RefreshInfo()
end

function UIChooseMainCgController:SetShowAssistant()
  local cgId = self._roleModule:GetResId()
  if cgId and cgId ~= -1 and self._type and self._type == UIChooseAssistantType.Change2Cg then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyHideAssistant, false)
  end
end

function UIChooseMainCgController:GetComponents()
  self._minValueTex = self:GetUIComponent("UILocalizationText", "minValue")
  self._maxValueTex = self:GetUIComponent("UILocalizationText", "maxValue")
  self._currentValueTex = self:GetUIComponent("UILocalizationText", "currentValue")
  self._sliderView = self:GetUIComponent("Slider", "sliderView")
  self._line_down = self:GetUIComponent("RectTransform", "line_down")
  self._line_up = self:GetUIComponent("RectTransform", "line_up")
  self._line_left = self:GetUIComponent("RectTransform", "line_left")
  self._line_right = self:GetUIComponent("RectTransform", "line_right")
  self._selectPetObj = self:GetGameObject("select_pet")
  self._selectBgObj = self:GetGameObject("select_bg")
  self._petBtnObj = self:GetGameObject("petBtn")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._staticDynamicBtns = self:GetUIComponent("UISelectObjectPath", "node_staticDynamicBtns")
  if self._staticDynamicBtns then
    self._staticDynamicBtnsWidget = self._staticDynamicBtns:SpawnObject("UIChooseStaticDynamicBtns")
  end
  self._changeItem = self:GetUIComponent("UISelectObjectPath", "node_change")
  if self._changeItem then
    self._changeItemWidget = self._changeItem:SpawnObject("UIChooseMainCgChangeItem")
  end
  self._isSliderPointerDown = false
  GameGlobal.TaskManager():StartTask(self.Task_InitMulitDress, self)
end

function UIChooseMainCgController:SetMainBg(type, id, anim, isSaveBtn, save, changeAsHide, spineIndex)
  self.curSpineIndex = spineIndex
end

function UIChooseMainCgController:Task_SaveDressGroup(TT)
  self:Lock("UIChooseMainCgController_Task_SaveDressGroup")
  self:SavePerDress(self.curDressIndex)
  local firstDress
  local firstIndex = -1
  for i = 1, #self.curInfos do
    local info = self.curInfos[i]
    if info.range_select == 1 and firstDress == nil then
      firstDress = info
      firstIndex = i
    end
  end
  if firstDress ~= nil then
    self.curDressIndex = firstIndex
    self:SetIndexDress(self.curDressIndex, false)
  end
  YIELD(TT)
  local res, replay = self._signInModule:HandleCurMainDressUpReq(TT, self.curDressIndex)
  if res:GetSucc() then
  end
  local res2, replay2 = self._signInModule:HandleSetMainDressUpReq(TT, self.curInfos)
  if res2:GetSucc() then
    YIELD(TT)
    self.isSetCgControllerShowOrHide = false
    self._mousePresent = nil
    UnityEngine.Input.multiTouchEnabled = false
    ChooseAssistantHelper:ClearTmpChoosePaintingData()
    self:_OnMainCgChangeSave(UIChooseAssistantType.Change2Cg, UIChooseAssistantState.Save)
    self:_OnMainCgChangeSave(UIChooseAssistantType.Change2Bg, UIChooseAssistantState.Save)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.None)
    self:StartTask(self.ChangeRequest, self)
  else
    Log.fatal("Task_SaveDressGroup is error")
  end
  self:UnLock("UIChooseMainCgController_Task_SaveDressGroup")
end

function UIChooseMainCgController:Task_InitMulitDress(TT)
  self:Lock("UIChooseMainCgController_Task_InitMulitDress")
  local res, replay = self._signInModule:HandleGetMainDressUpReq(TT)
  if res:GetSucc() then
    if #replay.info < 5 then
      for i = #replay.info + 1, 5 do
        if i == 1 then
          local firstinfo = self:_CreateFirstDress()
          replay.info[i] = firstinfo
        else
          local defaultinfo = self:_CreateDefDress()
          replay.info[i] = defaultinfo
        end
      end
      replay.cur_index = 1
    end
    if replay.cur_index == 0 or replay.cur_index == -1 then
      self.curDressIndex = 1
      replay.info[-1] = nil
    else
      local curSetIndex = replay.cur_index
      self.curDressIndex = curSetIndex
    end
    self.curInfos = replay.info
    for i = 1, #self.curInfos do
      self.rangSelectList[i] = self.curInfos[i].range_select
    end
    
    function self.setIndexDressCb(index)
      self:SetIndexDress(index, true)
    end
    
    function self.setToggleOpenCb(index, isopen)
      self:SetToggleOpen(index, isopen)
    end
    
    self.muiltDressPool = self:GetUIComponent("UISelectObjectPath", "MuiltDress")
    if self.muiltDressPool ~= nil then
      self.mulitDressGroup = self.muiltDressPool:SpawnObject("UIMainCgDressUpGroupItem")
      self.mulitDressGroup:SetData(self.curDressIndex, self.curInfos, self.setIndexDressCb, self.setToggleOpenCb)
    end
    self:SetIndexDress(self.curDressIndex)
  else
    Log.fatal("HandleGetMainDressUpReq is error")
  end
  self:UnLock("UIChooseMainCgController_Task_InitMulitDress")
end

function UIChooseMainCgController:SetIndexDress(index, savePer)
  if savePer then
    self:SavePerDress(index)
  end
  self.curDressIndex = index
  local targetInfo
  if self.curInfos[index] == nil then
    local info = self:_CreateDefDress()
    self.curInfos[index] = info
    targetInfo = info
  else
    targetInfo = self.curInfos[index]
  end
  if targetInfo.bg_id == 0 then
    targetInfo.bg_id = 2
    targetInfo.bg_type = 1
  end
  self._cgID = targetInfo.pet_cfg_id
  self._grade = targetInfo.pet_grade
  self._skinID = targetInfo.pet_skin_id
  self._asID = targetInfo.board_pet
  self._bgId = targetInfo.bg_id
  self._bgType = targetInfo.bg_type
  ChooseAssistantHelper:SaveTmpChooseCgPaintingData(true, self._cgID, self._grade, self._skinID, self._asID)
  ChooseAssistantHelper:SaveTmpChooseBgPaintingData(true, self._bgId, self._bgType)
  local petPos = Vector2(targetInfo.pet_x, targetInfo.pet_y)
  local petScale = targetInfo.pet_scale
  if petScale == 0 then
    petScale = 1
  end
  ChooseAssistantHelper.SaveAssistantPetSetting(petPos, petScale)
  local bgPos = Vector2(targetInfo.bg_x, targetInfo.bg_y)
  local bgScale = targetInfo.bg_scale
  if bgScale == nil or bgScale == 0 or bgScale <= 0.1 then
    bgScale = 1
    targetInfo.bg_scale = 1
  end
  ChooseAssistantHelper.SaveAssistantBgSetting(bgPos, bgScale, self._bgType, self._bgId, false, 1)
  GameGlobal.TaskManager():StartTask(self.Task_RefreshAssistant, self, targetInfo)
end

function UIChooseMainCgController:Task_RefreshAssistant(TT, targetInfo)
  self:Lock("UIChooseMainCgController_Task_RefreshAssistant")
  YIELD(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAssistantChanged, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeMainBg, self._bgType, self._bgId, true, false, false, true, targetInfo.spine_id)
  self:SetShowAssistant()
  self:OnValue()
  self:_GetPosAndScale()
  if targetInfo.is_static == nil then
    targetInfo.is_static = false
  end
  GameGlobal.TaskManager():StartTask(self.Task_SetExtFlag, self, targetInfo.is_static)
  local staticValue = DynamicAndStaticState.Dynamic
  if targetInfo.is_static then
    staticValue = DynamicAndStaticState.Static
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchSkinStaticOrDynamic, staticValue)
  self._staticDynamicBtnsWidget:ChangeDynamicAndStatic(staticValue)
  YIELD(TT)
  self._changeItemWidget:RefreshInfo()
  self:UnLock("UIChooseMainCgController_Task_RefreshAssistant")
end

function UIChooseMainCgController:Task_SetExtFlag(TT, isStatic)
  self:Lock("UIChooseMainCgController_Task_SetExtFlag")
  local roleModule = GameGlobal.GetModule(RoleModule)
  roleModule:SetExtFlag(TT, CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE, isStatic)
  self:UnLock("UIChooseMainCgController_Task_SetExtFlag")
end

function UIChooseMainCgController:SavePerDress(index)
  if self._cgID == nil then
    return
  end
  self:_OnMainCgChangeSave(UIChooseAssistantType.Change2Cg, UIChooseAssistantState.Save)
  self:_OnMainCgChangeSave(UIChooseAssistantType.Change2Bg, UIChooseAssistantState.Save)
  if self.curInfos[self.curDressIndex] ~= nil then
    local targetInfo = self.curInfos[self.curDressIndex]
    targetInfo.pet_cfg_id = self._cgID
    targetInfo.pet_grade = self._grade
    targetInfo.pet_skin_id = self._skinID
    targetInfo.board_pet = self._asID
    targetInfo.bg_id = self._bgId
    targetInfo.bg_type = self._bgType
    local petPos, petScale = ChooseAssistantHelper.GetAssistantPetSetting()
    targetInfo.pet_x = petPos.x
    targetInfo.pet_y = petPos.y
    targetInfo.pet_scale = petScale
    local bgPos, bgScale = ChooseAssistantHelper.GetAssistantBgSetting(self._bgType, self._bgId)
    targetInfo.bg_x = bgPos.x
    targetInfo.bg_y = bgPos.y
    targetInfo.bg_scale = bgScale
    targetInfo.spine_id = self.curSpineIndex
    Log.debug("[FX] SAVE SPINE ID ", targetInfo.spine_id)
    local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
    targetInfo.is_static = flagValue
    self.curInfos[self.curDressIndex] = targetInfo
  else
  end
end

function UIChooseMainCgController:Task_ToggleNullOpen(TT, index)
  self:Lock("UIChooseMainCgController_SetToggleOpen")
  ToastManager.ShowToast(StringTable.Get("str_assistant_main_cg_dressup_warning_un_open"))
  self.mulitDressGroup:SetToggleOpen(index, true)
  YIELD(TT)
  self:UnLock("UIChooseMainCgController_SetToggleOpen")
end

function UIChooseMainCgController:SetToggleOpen(index, isopen)
  if not isopen then
    local open = 0
    for i = 1, #self.curInfos do
      local info = self.curInfos[i]
      if info.range_select == 1 then
        open = open + 1
      end
    end
    if open == 1 or open == 0 then
    end
  end
  if self.curInfos[index] == nil then
    local info = self:_CreateDefDress()
    local open = 1
    if not isopen then
      open = 0
    end
    info.range_select = open
    self.curInfos[index] = info
  else
    local info = self.curInfos[index]
    local open = 1
    if not isopen then
      open = 0
    end
    info.range_select = open
    self.curInfos[index] = info
  end
end

function UIChooseMainCgController:_CreateFirstDress()
  local petPos, petScale = ChooseAssistantHelper.GetAssistantPetSetting()
  local bgType = self._roleModule.m_choose_painting.background_type
  local bgId = self._roleModule:UI_GetMainBgID()
  local bgPos, bgScale = ChooseAssistantHelper.GetAssistantBgSetting(bgType, bgId)
  local dressInfo = MainDressUpInfo:New()
  dressInfo.bg_id = self._roleModule:UI_GetMainBgID()
  dressInfo.bg_scale = bgScale
  dressInfo.bg_type = self._roleModule.m_choose_painting.background_type
  dressInfo.bg_x = bgPos.x
  dressInfo.bg_y = bgPos.y
  dressInfo.board_pet = self._roleModule.m_choose_painting.board_pet
  dressInfo.is_hand_operate = false
  dressInfo.pet_cfg_id = self._roleModule:GetResId()
  dressInfo.pet_grade = self._roleModule.m_choose_painting.pet_grade
  dressInfo.pet_scale = petScale
  dressInfo.pet_skin_id = self._roleModule.m_choose_painting.skin_id
  dressInfo.pet_x = petPos.x
  dressInfo.pet_y = petPos.y
  dressInfo.range_select = 1
  dressInfo.spine_id = self._roleModule.m_choose_painting.spine_id
  local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  dressInfo.is_static = flagValue
  return dressInfo
end

function UIChooseMainCgController:_CreateDefDress()
  local dressInfo = MainDressUpInfo:New()
  dressInfo.bg_id = 2
  dressInfo.bg_scale = 1.0
  dressInfo.bg_type = 1
  dressInfo.bg_x = 0.0
  dressInfo.bg_y = 0.0
  dressInfo.board_pet = 0
  dressInfo.is_hand_operate = false
  dressInfo.pet_cfg_id = 0
  dressInfo.pet_grade = 0
  dressInfo.pet_scale = 1.0
  dressInfo.pet_skin_id = 0
  dressInfo.pet_x = 0.0
  dressInfo.pet_y = 0.0
  dressInfo.range_select = 0
  dressInfo.spine_id = 1
  dressInfo.is_static = false
  return dressInfo
end

function UIChooseMainCgController:OnValue()
  self._pivot = Vector2(0.5, 0.5)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  self._safeArea = Vector2(realWidth, realHeight)
end

function UIChooseMainCgController:_GetPosAndScale()
  self._defaultPos, self._defaultScale = ChooseAssistantHelper.GetAssistantPetSetting()
  self._petSize = ChooseAssistantHelper.GetAssistantPetSize()
  local mainController = GameGlobal.UIStateManager():GetController("UIMainLobbyController")
  local bgStartPos, bgStartScale = Vector2(0, 0), 1
  self._bgSize = ChooseAssistantHelper.GetAssistantBgSize(self._bgType, self._bgId)
  if mainController then
    bgStartPos, bgStartScale = mainController:GetBgSetting()
    bgStartPos = bgStartPos or Vector2(0, 0)
    bgStartScale = bgStartScale or 1
  end
  local rate_x = 1
  local rate_y = 1
  if self._bgSize.x * bgStartScale < self._safeArea.x then
    rate_x = self._bgSize.x * bgStartScale / self._safeArea.x
  end
  if self._bgSize.y * bgStartScale < self._safeArea.y then
    rate_y = self._bgSize.y * bgStartScale / self._safeArea.y
  end
  if rate_x < 1 or rate_y < 1 then
    local changex = true
    if rate_x < rate_y then
      changex = true
    else
      changex = false
    end
    if changex then
      bgStartScale = bgStartScale / rate_x
    else
      bgStartScale = bgStartScale / rate_y
    end
  end
  self._bgDefaultPos = bgStartPos
  self._bgDefaultScale = bgStartScale
  self._changeItemWidget:SetScale(UIChooseAssistantType.Change2Cg, self._defaultScale)
  self._changeItemWidget:SetScale(UIChooseAssistantType.Change2Bg, self._bgDefaultScale)
end

function UIChooseMainCgController:_OnInit()
  self._mousePresent = GameGlobal.EngineInput().mousePresent
  UnityEngine.Input.multiTouchEnabled = true
end

function UIChooseMainCgController:OnHide()
  self._mousePresent = nil
  UnityEngine.Input.multiTouchEnabled = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.None)
  local cgId = self._roleModule:GetResId()
  if cgId and cgId ~= -1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyHideAssistant, false)
  end
end

function UIChooseMainCgController:saveBtnOnClick(go)
  if self._draging or self._scaling then
    return
  end
  self:StartTask(self.Task_SaveDressGroup, self)
end

function UIChooseMainCgController:cancelBtnOnClick(go)
  if self._draging or self._scaling then
    return
  end
  self.isSetCgControllerShowOrHide = false
  self._mousePresent = nil
  UnityEngine.Input.multiTouchEnabled = false
  if self.rangSelectList ~= nil and #self.rangSelectList > 0 then
    for i = 1, #self.rangSelectList do
      local oldSelect = self.rangSelectList[i]
      self.curInfos[i].range_select = oldSelect
    end
  end
  ChooseAssistantHelper:SaveTmpChooseCgPaintingData(false)
  ChooseAssistantHelper:SaveTmpChooseBgPaintingData(false)
  if self._cgID then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAssistantChanged, true)
  end
  self:_OnMainCgChangeSave(self._type, UIChooseAssistantState.Cancel)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.None)
  local firstDress
  local firstIndex = -1
  for i = 1, #self.curInfos do
    local info = self.curInfos[i]
    if info.range_select == 1 and firstDress == nil then
      firstDress = info
      firstIndex = i
    end
  end
  self:StartTask(self.Task_CancleSaveDefault, self, firstIndex)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeSave, UIChooseAssistantType.Bg2MainLobby, UIChooseAssistantState.Cancel, -1, -1, firstIndex)
  self:StartTask(self.ChangeCgState, self)
end

function UIChooseMainCgController:Task_CancleSaveDefault(TT, firstIndex)
  local res, replay = self._signInModule:HandleCurMainDressUpReq(TT, firstIndex)
  if res:GetSucc() then
  end
end

function UIChooseMainCgController:defaultBtnOnClick(go)
  if self._draging or self._scaling then
    return
  end
  self:_OnMainCgChangeSave(self._type, UIChooseAssistantState.Default)
end

function UIChooseMainCgController:ChangeScale(scale_off)
  self:_OnMainCgChangeScale(self._type, scale_off)
end

function UIChooseMainCgController:ChangePos(pos_off)
  local pos2v2 = Vector2(pos_off.x, pos_off.y)
  self:_OnMainCgChangePos(self._type, pos2v2)
end

function UIChooseMainCgController:SetIsSliderPointerDown(boo)
  self._isSliderPointerDown = boo
end

function UIChooseMainCgController:Update(deltaTimeMS)
  if not self.isSetCgControllerShowOrHide then
    return
  end
  if self._mousePresent then
    self:EditorInput(deltaTimeMS * 0.001)
  else
    self:TouchInput(deltaTimeMS * 0.001)
  end
  self:Animation(deltaTimeMS)
end

function UIChooseMainCgController:Animation(deltaTimeMS)
  self._changePosValue = self._changePosValue + deltaTimeMS * 0.001 * self._speed
  self._changePosValue2 = self._changePosValue2 - deltaTimeMS * 0.001 * self._speed
  if self._changePosValue >= 54 then
    self._changePosValue = -54
  end
  if self._changePosValue2 <= -54 then
    self._changePosValue2 = 54
  end
  self._line_down.anchoredPosition = Vector2(self._changePosValue2 - 54 + self._down_offset, 0)
  self._line_up.anchoredPosition = Vector2(self._changePosValue - 54 + self._up_offset, 0)
  self._line_left.anchoredPosition = Vector2(0, self._changePosValue - 54)
  self._line_right.anchoredPosition = Vector2(0, self._changePosValue2 - 54 + self._right_offset)
end

function UIChooseMainCgController:TouchInput()
  local touchCount = GameGlobal.EngineInput().touchCount
  local touch0
  if 0 < touchCount then
    touch0 = GameGlobal.EngineInput().GetTouch(0)
  end
  local touch1
  if 1 < touchCount then
    touch1 = GameGlobal.EngineInput().GetTouch(1)
  end
  if touch0 and touch0.phase == TouchPhase.Began then
    self._touch0DownPos = touch0.position
  end
  if not touch1 and not self._isSliderPointerDown and touch0 and touch0.phase == TouchPhase.Moved then
    self._touch0Pos = touch0.position
    if self._touch0Pos2 and self._touch0Pos2 ~= 0 and self._touch0Pos2 ~= self._touch0Pos then
      if self._draging == false and (self._touch0Pos - self._touch0DownPos).sqrMagnitude > self._startMove then
        self._draging = true
      end
      local offset = self._touch0Pos - self._touch0Pos2
      local _moveGap = offset * self._moveK
      self:ChangePos(_moveGap)
    end
    self._touch0Pos2 = self._touch0Pos
  end
  if touchCount == 0 then
    self._draging = false
    self._scaling = false
    self._touch0Pos = 0
    self._touch0Pos2 = 0
  end
  if touch1 then
    self._scaling = true
    local lastLength = Vector2.Distance(touch0.position - touch0.deltaPosition, touch1.position - touch1.deltaPosition)
    local length = Vector2.Distance(touch0.position, touch1.position)
    local offset = length - lastLength
    local gap = offset * self._touchScaleK
    self:ChangeScale(gap)
  end
end

function UIChooseMainCgController:EditorInput()
  if GameGlobal.EngineInput().GetMouseButtonDown(0) then
    self._mousePos2 = 0
    self._mousePos = 0
    self._mouseDpwnPos = GameGlobal.EngineInput().mousePosition
  end
  if GameGlobal.EngineInput().GetMouseButton(0) and not self._isSliderPointerDown then
    self._mousePos = GameGlobal.EngineInput().mousePosition
    if self._mousePos2 and self._mousePos2 ~= 0 and self._mousePos2 ~= self._mousePos then
      if self._draging == false and (self._mousePos - self._mouseDpwnPos).sqrMagnitude > self._startMove then
        self._draging = true
      end
      local offset = self._mousePos - self._mousePos2
      local _moveGap = offset * self._moveK
      self:ChangePos(_moveGap)
    end
    self._mousePos2 = self._mousePos
  end
  self._scaleLength = GameGlobal.EngineInput().GetAxis("Mouse ScrollWheel")
  if 0 < self._scaleLength or 0 > self._scaleLength then
    local gap = self._scaleLength * self._scaleK
    self:ChangeScale(gap)
  end
  if GameGlobal.EngineInput().GetMouseButtonUp(0) then
    self._mousePos2 = 0
    self._mousePos = 0
    if self._draging then
      self._draging = false
    end
  end
end

function UIChooseMainCgController:PetBtnOnClick()
  if self._type == UIChooseAssistantType.Change2Cg then
    return
  end
  local cgId = self._roleModule:GetResId()
  if cgId and cgId ~= -1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainLobbyHideAssistant, false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.Pet)
  self._type = UIChooseAssistantType.Change2Cg
  self._selectPetObj:SetActive(true)
  self._selectBgObj:SetActive(false)
  if self._staticDynamicBtnsWidget then
    self._staticDynamicBtnsWidget:GetGameObject():SetActive(true)
  end
end

function UIChooseMainCgController:BgBtnOnClick()
  if self._type == UIChooseAssistantType.Change2Bg then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.Bg)
  self._type = UIChooseAssistantType.Change2Bg
  self._selectPetObj:SetActive(false)
  self._selectBgObj:SetActive(true)
  if self._staticDynamicBtnsWidget then
    self._staticDynamicBtnsWidget:GetGameObject():SetActive(false)
  end
end

function UIChooseMainCgController:_OnMainCgChangeSave(type, state)
  if type == UIChooseAssistantType.Change2Cg then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeSave, UIChooseAssistantType.Cg2MainLobby, state)
  elseif type == UIChooseAssistantType.Change2Bg then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeSave, UIChooseAssistantType.Bg2MainLobby, state, self._bgId, self._bgType)
  end
end

function UIChooseMainCgController:_MainCgChangeSave(state)
  if state == UIChooseAssistantState.Save or state == UIChooseAssistantState.Cancel then
    self:StartTask(self._CloseAnim, self)
  elseif state == UIChooseAssistantState.Default then
  end
end

function UIChooseMainCgController:GetMinAndMaxScale(type)
  if type == UIChooseAssistantType.Change2Cg then
    if self._petSize then
      local up, left, right, down, minScale = self:_CalcImgInnerSafeArea(self._scaleMin, self._defaultPos, true, type)
      local up1, left1, right1, down1, maxScale = self:_CalcImgInnerSafeArea(self._scaleMax, self._defaultPos, true, type)
      minScale = minScale == nil and self._scaleMin or minScale
      maxScale = maxScale == nil and self._scaleMax or maxScale
      return minScale, maxScale
    else
      return self._scaleMin, self._scaleMax
    end
  elseif type == UIChooseAssistantType.Change2Bg then
    local up, left, right, down, minScale = self:_CalcImgInnerSafeArea(self._scaleMin, self._bgDefaultPos, true, type)
    local up, left, right, down, maxScale = self:_CalcImgInnerSafeArea(self._scaleMax, self._bgDefaultPos, true, type)
    minScale = minScale == nil and self._scaleMin or minScale
    maxScale = maxScale == nil and self._scaleMax or maxScale
    return minScale, maxScale
  end
end

function UIChooseMainCgController:_OnMainCgChangeScale(type, scale_off)
  if type == UIChooseAssistantType.Change2Cg then
    if self._petSize then
      local targetScale = self._defaultScale + scale_off
      if 2 < targetScale then
        targetScale = 2
      end
      local cantScale = false
      local needChangePos = 0
      local up, left, right, down, newScale = self:_CalcImgInnerSafeArea(targetScale, self._defaultPos, true, type)
      if up and not left and not right and not down then
        needChangePos = 2
      elseif up and left and not right and not down then
        needChangePos = 1
      elseif up and not left and right and not down then
        needChangePos = 3
      elseif not up and left and not right and not down then
        needChangePos = 4
      elseif not up and left and not right and down then
        needChangePos = 7
      elseif not up and not left and right and not down then
        needChangePos = 6
      elseif not up and not left and right and down then
        needChangePos = 9
      elseif not up and not left and not right and down then
        needChangePos = 8
      elseif not up and not left and not right and not down then
        needChangePos = 5
      else
        cantScale = true
      end
      if not cantScale then
        if newScale then
          targetScale = newScale
        end
        self._defaultScale = targetScale
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeScale, UIChooseAssistantType.Cg2MainLobby, self._defaultScale)
        self._changeItemWidget:SetScale(UIChooseAssistantType.Change2Cg, self._defaultScale)
        if needChangePos ~= 0 or needChangePos ~= 5 then
          local newSize = Vector2(math.floor(self._petSize.x * self._defaultScale), math.floor(self._petSize.y * self._defaultScale))
          local gap = Vector2(0, 0)
          if needChangePos == 1 then
            local x = self._safeArea.x * -0.5 - math.floor(self._defaultPos.x - newSize.x * self._pivot.x)
            local y = self._safeArea.y * 0.5 - math.floor(self._defaultPos.y + newSize.y * (1 - self._pivot.y))
            gap = Vector2(x, y)
          elseif needChangePos == 2 then
            local x = 0
            local y = self._safeArea.y * 0.5 - math.floor(self._defaultPos.y + newSize.y * (1 - self._pivot.y))
            gap = Vector2(x, y)
          elseif needChangePos == 3 then
            local x = self._safeArea.x * 0.5 - math.floor(self._defaultPos.x + newSize.x * (1 - self._pivot.x))
            local y = self._safeArea.y * 0.5 - math.floor(self._defaultPos.y + newSize.y * (1 - self._pivot.y))
            gap = Vector2(x, y)
          elseif needChangePos == 4 then
            local x = self._safeArea.x * -0.5 - math.floor(self._defaultPos.x - newSize.x * self._pivot.x)
            local y = 0
            gap = Vector2(x, y)
          elseif needChangePos == 5 then
          elseif needChangePos == 6 then
            local x = self._safeArea.x * 0.5 - math.floor(self._defaultPos.x + newSize.x * (1 - self._pivot.x))
            local y = 0
            gap = Vector2(x, y)
          elseif needChangePos == 7 then
            local x = self._safeArea.x * -0.5 - math.floor(self._defaultPos.x - newSize.x * self._pivot.x)
            local y = self._safeArea.y * -0.5 - math.floor(self._defaultPos.y - newSize.y * self._pivot.y)
            gap = Vector2(x, y)
          elseif needChangePos == 8 then
            local x = 0
            local y = self._safeArea.y * -0.5 - math.floor(self._defaultPos.y - newSize.y * self._pivot.y)
            gap = Vector2(x, y)
          elseif needChangePos == 9 then
            local x = self._safeArea.x * 0.5 - math.floor(self._defaultPos.x + newSize.x * (1 - self._pivot.x))
            local y = self._safeArea.y * -0.5 - math.floor(self._defaultPos.y - newSize.y * self._pivot.y)
            gap = Vector2(x, y)
          end
          self._defaultPos = self._defaultPos + gap
          GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Cg2MainLobby, self._defaultPos)
        end
      end
    else
      local targetScale = self._defaultScale + scale_off
      if targetScale > self._scaleMax then
        targetScale = self._scaleMax
      end
      if targetScale < self._scaleMin then
        targetScale = self._scaleMin
      end
      self._defaultScale = targetScale
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeScale, UIChooseAssistantType.Cg2MainLobby, self._defaultScale)
      self._changeItemWidget:SetScale(UIChooseAssistantType.Change2Cg, self._defaultScale)
    end
  elseif type == UIChooseAssistantType.Change2Bg then
    local targetScale = self._bgDefaultScale + scale_off
    if 2 < targetScale then
      targetScale = 2
    end
    local cantScale = false
    local needChangePos = 0
    local up, left, right, down, newScale = self:_CalcImgInnerSafeArea(targetScale, self._bgDefaultPos, true, type)
    if up and not left and not right and not down then
      needChangePos = 2
    elseif up and left and not right and not down then
      needChangePos = 1
    elseif up and not left and right and not down then
      needChangePos = 3
    elseif not up and left and not right and not down then
      needChangePos = 4
    elseif not up and left and not right and down then
      needChangePos = 7
    elseif not up and not left and right and not down then
      needChangePos = 6
    elseif not up and not left and right and down then
      needChangePos = 9
    elseif not up and not left and not right and down then
      needChangePos = 8
    elseif not up and not left and not right and not down then
      needChangePos = 5
    else
      cantScale = true
    end
    if not cantScale then
      if newScale then
        targetScale = newScale
      end
      self._bgDefaultScale = targetScale
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangeScale, UIChooseAssistantType.Bg2MainLobby, self._bgDefaultScale)
      self._changeItemWidget:SetScale(UIChooseAssistantType.Change2Bg, self._bgDefaultScale)
      if needChangePos ~= 0 or needChangePos ~= 5 then
        local newSize = Vector2(math.floor(self._bgSize.x * self._bgDefaultScale), math.floor(self._bgSize.y * self._bgDefaultScale))
        local gap = Vector2(0, 0)
        if needChangePos == 1 then
          local x = self._safeArea.x * -0.5 - math.floor(self._bgDefaultPos.x - newSize.x * self._pivot.x)
          local y = self._safeArea.y * 0.5 - math.floor(self._bgDefaultPos.y + newSize.y * (1 - self._pivot.y))
          gap = Vector2(x, y)
        elseif needChangePos == 2 then
          local x = 0
          local y = self._safeArea.y * 0.5 - math.floor(self._bgDefaultPos.y + newSize.y * (1 - self._pivot.y))
          gap = Vector2(x, y)
        elseif needChangePos == 3 then
          local x = self._safeArea.x * 0.5 - math.floor(self._bgDefaultPos.x + newSize.x * (1 - self._pivot.x))
          local y = self._safeArea.y * 0.5 - math.floor(self._bgDefaultPos.y + newSize.y * (1 - self._pivot.y))
          gap = Vector2(x, y)
        elseif needChangePos == 4 then
          local x = self._safeArea.x * -0.5 - math.floor(self._bgDefaultPos.x - newSize.x * self._pivot.x)
          local y = 0
          gap = Vector2(x, y)
        elseif needChangePos == 5 then
        elseif needChangePos == 6 then
          local x = self._safeArea.x * 0.5 - math.floor(self._bgDefaultPos.x + newSize.x * (1 - self._pivot.x))
          local y = 0
          gap = Vector2(x, y)
        elseif needChangePos == 7 then
          local x = self._safeArea.x * -0.5 - math.floor(self._bgDefaultPos.x - newSize.x * self._pivot.x)
          local y = self._safeArea.y * -0.5 - math.floor(self._bgDefaultPos.y - newSize.y * self._pivot.y)
          gap = Vector2(x, y)
        elseif needChangePos == 8 then
          local x = 0
          local y = self._safeArea.y * -0.5 - math.floor(self._bgDefaultPos.y - newSize.y * self._pivot.y)
          gap = Vector2(x, y)
        elseif needChangePos == 9 then
          local x = self._safeArea.x * 0.5 - math.floor(self._bgDefaultPos.x + newSize.x * (1 - self._pivot.x))
          local y = self._safeArea.y * -0.5 - math.floor(self._bgDefaultPos.y - newSize.y * self._pivot.y)
          gap = Vector2(x, y)
        end
        self._bgDefaultPos = self._bgDefaultPos + gap
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Bg2MainLobby, self._bgDefaultPos)
      end
    end
  end
end

function UIChooseMainCgController:_OnMainCgChangePos(type, pos_off)
  if type == UIChooseAssistantType.Change2Cg then
    if self._petSize then
      local targetPos = self._defaultPos + pos_off
      local targetPos_x = self._defaultPos + Vector2(pos_off.x, 0)
      local targetPos_y = self._defaultPos + Vector2(0, pos_off.y)
      if self:_CalcImgInnerSafeArea(self._defaultScale, targetPos, false, type) then
        self._defaultPos = self._defaultPos + pos_off
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Cg2MainLobby, self._defaultPos)
      elseif self:_CalcImgInnerSafeArea(self._defaultScale, targetPos_x, false, type) then
        self._defaultPos = targetPos_x
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Cg2MainLobby, self._defaultPos)
      elseif self:_CalcImgInnerSafeArea(self._defaultScale, targetPos_y, false, type) then
        self._defaultPos = targetPos_y
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Cg2MainLobby, self._defaultPos)
      end
    else
      local targetPos = self._defaultPos + pos_off
      if targetPos.x > self._moveMaxX then
        targetPos = Vector2(self._moveMaxX, targetPos.y)
      end
      if targetPos.x < self._moveMinX then
        targetPos = Vector2(self._moveMinX, targetPos.y)
      end
      if targetPos.y > self._moveMaxY then
        targetPos = Vector2(targetPos.x, self._moveMaxY)
      end
      if targetPos.y < self._moveMinY then
        targetPos = Vector2(targetPos.x, self._moveMinY)
      end
      self._defaultPos = targetPos
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Cg2MainLobby, self._defaultPos)
    end
  elseif type == UIChooseAssistantType.Change2Bg then
    local targetPos = self._bgDefaultPos + pos_off
    local targetPos_x = self._bgDefaultPos + Vector2(pos_off.x, 0)
    local targetPos_y = self._bgDefaultPos + Vector2(0, pos_off.y)
    if self:_CalcImgInnerSafeArea(self._bgDefaultScale, targetPos, false, type) then
      self._bgDefaultPos = self._bgDefaultPos + pos_off
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Bg2MainLobby, self._bgDefaultPos)
    elseif self:_CalcImgInnerSafeArea(self._bgDefaultScale, targetPos_x, false, type) then
      self._bgDefaultPos = targetPos_x
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Bg2MainLobby, self._bgDefaultPos)
    elseif self:_CalcImgInnerSafeArea(self._bgDefaultScale, targetPos_y, false, type) then
      self._bgDefaultPos = targetPos_y
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCgChangePos, UIChooseAssistantType.Bg2MainLobby, self._bgDefaultPos)
    end
  end
end

function UIChooseMainCgController:SetCgControllerShowOrHide(isShow)
  local obj = self:GetGameObject()
  if not obj then
    return
  end
  if isShow then
    obj.transform.localScale = Vector3(1, 1, 1)
    if self._type then
      if self._type == UIChooseAssistantType.Change2Cg then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.Pet)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.Bg)
      end
    end
    self:_OnInit()
  else
    obj.transform.localScale = Vector3(0, 0, 0)
    self:OnHide()
  end
  self.isSetCgControllerShowOrHide = isShow
end

function UIChooseMainCgController:_CalcImgInnerSafeArea(scale, pos, changeScale, type)
  local newScale, size
  if type == UIChooseAssistantType.Change2Cg then
    size = self._petSize
  elseif type == UIChooseAssistantType.Change2Bg then
    size = self._bgSize
  end
  local newSize = Vector2(math.floor(size.x * scale), math.floor(size.y * scale))
  if newSize.x < self._safeArea.x or newSize.y < self._safeArea.y then
    local rate_x = self._safeArea.x / newSize.x
    local rate_y = self._safeArea.y / newSize.y
    if rate_x > rate_y then
      newScale = self._safeArea.x / size.x
    else
      newScale = self._safeArea.y / size.y
    end
    newSize = Vector2(size.x * newScale, size.y * newScale)
  end
  local up = changeScale and self._safeArea.y * 0.5 or self._safeArea.y * 0.5 - 1
  local left = changeScale and self._safeArea.x * -0.5 or self._safeArea.x * -0.5 + 1
  local right = changeScale and self._safeArea.x * 0.5 or self._safeArea.x * 0.5 - 1
  local down = changeScale and self._safeArea.y * -0.5 or self._safeArea.y * -0.5 + 1
  local m_up = up > math.floor(pos.y + newSize.y * (1 - self._pivot.y))
  local m_left = left < math.floor(pos.x - newSize.x * self._pivot.x)
  local m_right = right > math.floor(pos.x + newSize.x * (1 - self._pivot.x))
  local m_down = down < math.floor(pos.y - newSize.y * self._pivot.y)
  if changeScale then
    return m_up, m_left, m_right, m_down, newScale
  elseif not m_up and not m_left and not m_right and not m_down then
    return true
  end
  return false
end

function UIChooseMainCgController:_CloseAnim(TT)
  self:Lock("UIChooseMainCgController_CloseAnim")
  self._anim:Play("uieff_Assistant_MainCG_Out")
  YIELD(TT, 433)
  self:UnLock("UIChooseMainCgController_CloseAnim")
  self:CloseDialog()
end

function UIChooseMainCgController:ChangeCgState(TT)
  local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  local cgState = DynamicAndStaticState.Dynamic
  if flagValue then
    cgState = DynamicAndStaticState.Static
  end
  if self._cgState ~= cgState then
    self._staticDynamicBtnsWidget:_OnGetExtData(TT, self._cgState)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchSkinStaticOrDynamic, self._cgState)
  end
  self:_CloseAnim(TT)
end

function UIChooseMainCgController:ChangeRequest(TT)
  if not self._cgID then
    self:_CloseAnim(TT)
    return
  end
  local id = self._cgID
  local grade = self._grade
  local skinID = self._skinID
  local asID = self._asID
  if id == -1 then
    grade = -1
    skinID = -1
    asID = -1
  else
    local open_id = GameGlobal.GameLogic():GetOpenId()
    local key = "MAIN_BG_AS_ACTIVE" .. open_id
    LocalDB.SetInt(key, 0)
  end
  local res = self._roleModule:RequestChoosePainting(TT, id, grade, skinID, asID)
  self:UnLock("UIChooseMainCgController:changeBtnOnClick")
  if res:GetSucc() then
  else
    Log.debug("###UIChooseMainCgController id-->", id, "|grade-->", grade, "|skin-->", skinID, "|as-->", asID)
    Log.fatal("###UIChooseMainCgController -- change assistent res error ! result --> ", res:GetResult())
  end
  self:_CloseAnim(TT)
end
