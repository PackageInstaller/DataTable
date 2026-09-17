local this = class("pageSituation", G_UIPageBase)
local _solutionTpl = L_GameTpl:getPhotoSpaceCaseTpl()
local _situationTabTpl = L_GameTpl:getSituationTabTpl()
local _situationPageMode = {main = 1, edit = 2}
local _SituationQuality = "SituationQuality"

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    commonTop = L_Const.ModuleInfo.CommonTop,
    solutionList = {
      moduleName = "pages/situation/cell/cellSituationItem"
    },
    activeMain = nil,
    txt_name = nil,
    txt_index = nil,
    activeEdit = nil,
    editTabId = nil,
    editTabList = {
      moduleName = "pages/photo/cell/cellPhotoMenu"
    },
    activeUndo = nil,
    activeRedo = nil,
    editModule = this.registEditModule(),
    groupName = "",
    activeLoading = nil,
    togQuality = nil,
    active_instruection = true,
    go_whiteCut = nil
  }
end

function this.methods()
  return {
    solutionList = {
      onClick = function(self, id)
        self:selectSolution(id)
      end
    },
    onClickEdit = function(self)
      self:enterEdit(self.curSelectId)
    end,
    onClickRename = function(self)
      self:onClickRename()
    end,
    onClickChangeCover = function(self)
      self:onClickChangeCover()
    end,
    onClickEditTab = function(self, id)
      self.bind.editTabId = id
      self:switchFuncPanel(id)
      self.modules.editModule[self.bind.groupName]:initModule()
    end,
    onClickUndo = function(self)
      self:onClickUndo()
    end,
    onClickRedo = function(self)
      self:onClickRedo()
    end,
    onClickSave = function(self)
      self:onClickSave()
    end,
    onClickCapture = function(self)
      self:capture()
    end,
    onClickTogQuality = function(self, isOn)
      self:switchQualityTog(isOn)
    end
  }
end

function this:preOpen(options)
  if L_DeviceTpl:getIsMobile() then
    C_UIMgr.CloseMidStackPages()
  end
  AzurWorld.AOI:Pause(true, Azur.EAOIPauseReason.UI_Photo)
  self.bind.activeLoading = false
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.checkUndoState, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.loadingCountChanged, self.onLoadingCountChanged, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.onClickStamp, self.onClickStamp, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.nameChanged, self.onNameChanged, self)
  self.pageState = _situationPageMode.main
  self:initCommonTopModule()
  self:initScene()
  self:initSolutionList()
  self.bind.activeMain = true
  self.bind.activeEdit = false
  local selectId = 1
  if options and options.selectId then
    selectId = options.selectId
  end
  if options and options.saveSituation then
    self.needSavePlayerCard = true
  end
  if options and options.openCallback then
    options.openCallback()
  end
  self:selectSolution(selectId)
  self:initEditTab()
  local useHighQuality = L_CommonUtil.getLocalBoolValue(_SituationQuality)
  self:switchQualityTog(useHighQuality)
  self.bind.togQuality = useHighQuality == true
  CS.UnityEngine.Rendering.Azur.UniversalRenderPipeline.SetShadowForceUpdate(true)
  if L_DeviceTpl:getIsPc() then
    self.bind.active_instruection = true
  else
    self.bind.active_instruection = false
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Camera_Open")
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.Situation)
end

function this:show()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.Situation)
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(handler(self, self.escHandle))
end

function this:initCommonTopModule()
  local data = {
    name = L_WordsTpl:getValue(L_WordsTpl:getValue("residual_code_pagesituation_01")),
    closeCurPage = function()
      self:escHandle()
    end
  }
  self.modules.commonTop:initModule(data)
end

function this:escHandle()
  if self.pageState == _situationPageMode.main then
    if self.needSavePlayerCard then
      self:saveToPlayerCard(function()
        if L_DeviceTpl:getIsMobile() or C_DeviceGradeHelper.IsLowMemoryDevice() then
          C_UIMgr.OpenCutin(1, function()
            L_UI:open("pagePlayerCard", {
              uid = L_PlayerStore:getPlayerId()
            })
            L_UI:close(self.pageName)
          end)
        else
          L_UI:close(self.pageName)
        end
      end)
    else
      L_UI:close(self.pageName)
    end
  elseif self.pageState == _situationPageMode.edit then
    if self.bind.activeLoading then
      return
    end
    self.pageState = _situationPageMode.main
    self:exitEdit()
  end
end

function this:refreshMaskableList()
  if self.isBind then
    local rectMask2D = self.bindComponents.rectMask2D
    local gameObject = self.bindComponents.goMask
    if not rectMask2D or not gameObject then
      return
    end
    local iClippableArray = gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.UI.IClippable), true)
    if iClippableArray.Length == 0 then
      return
    end
    for i = 0, iClippableArray.Length - 1 do
      rectMask2D:AddClippable(iClippableArray[i])
    end
  end
end

function this:initSolutionList()
  local list = {}
  for i, v in pairs(_solutionTpl.data) do
    local data = {}
    local id = v.id
    data.id = id
    local info = L_SituationStore:getSolutionInfo(id)
    if info then
      data.solutionData = info
    end
    table.insert(list, data)
  end
  table.sort(list, function(a, b)
    if a.solutionData ~= b.solutionData and (a.solutionData == nil or b.solutionData == nil) then
      return a.solutionData ~= nil
    end
    return a.id < b.id
  end)
  self.bind.solutionList:clear()
  self.bind.solutionList:insert_array(list)
end

function this:initScene()
  C_UISceneManager.SetSceneVisible()
  local sceneData, obj = L_SituationManager:loadScene(self.bindComponents.stampRoot)
  self.sceneData = sceneData
  self.sceneObj = obj
end

function this:onNameChanged(id)
  if id == self.curSelectId then
    local info = L_SituationStore:getSolutionInfo(id)
    if info then
      self.bind.txt_name = info.name
    end
  end
end

function this:selectSolution(id)
  if self.curSelectId == id then
    return
  end
  if not L_SituationStore:isUnlock(id) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagesituation_02"))
    return
  end
  if self.curSelectId then
    local solution = L_SituationStore:getSolutionInfo(self.curSelectId)
    solution:clear()
  end
  self.curSelectId = id
  for i, v in pairs(self.modules.solutionList) do
    v:refreshSelect(id)
  end
  local solution = L_SituationStore:getSolutionInfo(id)
  if solution then
    self.bind.txt_name = solution.name
    self.bind.txt_index = string.format("%02d", id)
  end
  self:loadSolution(id)
end

function this:enterEdit(solutionId)
  local solution = L_SituationStore:getSolutionInfo(solutionId)
  self.pageState = _situationPageMode.edit
  self.curEditSolution = solution
  self.bind.activeMain = false
  self.bind.activeEdit = true
  L_SituationManager:enterEdit(solution)
  self:checkUndoState()
  self.bind.editTabId = L_Const.situationGroup.hero
  for i, v in pairs(self.modules.editModule) do
    if i == "1" and v.isOpen and not v.isShow then
      v:toShow()
    end
  end
  self.cameraController = require("ui.pages.situation.module.situationCameraController").new()
  self.cameraController:init(self.sceneData.camera, self.sceneData.lookAtRoot)
  L_AudioUtil.playSound("Play_SFX_System_UI_Situation_Menu_Open")
end

function this:exitEdit()
  self.bind.activeLoading = false
  self.pageState = _situationPageMode.main
  self.curEditSolution = nil
  self.bind.activeMain = true
  self.bind.activeEdit = false
  L_SituationManager:exitEdit()
  for i, v in pairs(self.modules.editModule) do
    if v.isOpen and v.isShow then
      v:toHide()
    end
  end
  if self.cameraController then
    self.cameraController:release()
    self.cameraController = nil
  end
end

function this:loadSolution(id)
  local solution = L_SituationStore:getSolutionInfo(id)
  solution:loadSolution(self.sceneData)
end

function this:registEditModule()
  local tab = {
    type = "toggleModule"
  }
  for key, groupId in pairs(L_Const.situationGroup) do
    local cell = {
      assetName = "UI/Pages/Situation/Group/moduleSituationEdit_" .. key,
      moduleName = "pages/situation/group/moduleSituationEdit_" .. key
    }
    tab[tostring(groupId)] = cell
  end
  return tab
end

function this:initEditTab()
  self.bind.editTabList:clear()
  local list = {}
  for key, tpl in pairs(_situationTabTpl.data) do
    local item = {
      id = _situationTabTpl:getTabId(tpl),
      txt_NameOff = _situationTabTpl:getTabName(tpl),
      txt_NameOn = _situationTabTpl:getTabName(tpl),
      img_iconOn = _situationTabTpl:getTabIcon(tpl),
      img_iconOff = _situationTabTpl:getTabIcon(tpl),
      tabGroup = self.bindComponents.mainGroup
    }
    table.insert(list, item)
  end
  self.bind.editTabList:insert_array(list)
end

function this:switchFuncPanel(id)
  self.bind.groupName = tostring(id)
  for i, v in pairs(self.modules.editTabList) do
    v:refreshSelect()
  end
end

function this:getFuncPanel(id)
  local module = self.modules.editModule[tostring(id)]
  if module and module.isBind then
    return module
  end
  return nil
end

function this:onClickUndo()
  L_SituationManager:undo()
  self:checkUndoState()
end

function this:onClickRedo()
  L_SituationManager:redo()
  self:checkUndoState()
end

function this:onClickSave()
  if L_SituationManager:hasUndoCount() or self.curEditSolution:checkCameraChanged() then
    self.curEditSolution.isCaptured = false
  else
    return
  end
  L_SituationStore:req_editSituation(self.curSelectId, function()
    L_SituationStore:call(L_SituationStore.event.onSave)
    self.curEditSolution:apply()
    self.curEditSolution:record()
    L_SituationManager:clearUndoSystem()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_case_saved"))
  end)
end

function this:checkUndoState()
  self.bind.activeUndo = L_SituationManager:hasUndoCount()
  self.bind.activeRedo = L_SituationManager:hasRedoCount()
end

function this:onLoadingCountChanged(count)
  self.bind.activeLoading = 0 < count
end

function this:close(options)
  self:resetCaptureState()
  for i, v in pairs(L_SituationStore.solutionInfo) do
    v:clear()
  end
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.checkUndoState, self)
  L_SituationStore:unListenCallFunc(L_SituationStore.event.loadingCountChanged, self.onLoadingCountChanged, self)
  L_SituationStore:unListenCallFunc(L_SituationStore.event.onClickStamp, self.onClickStamp, self)
  L_SituationStore:unListenCallFunc(L_SituationStore.event.nameChanged, self.onNameChanged, self)
  L_SituationStore:unListenCallFunc(L_SituationStore.event.refreshPinchSpeed, self.refreshPinchSpeed, self)
  if L_CommonUtil.isValid(self.sceneObj) then
    C_GameObject.Destroy(self.sceneObj)
  end
  C_UISceneManager.SetSceneVisible()
  L_SituationManager:exitEdit()
  L_SituationManager:releaseAll()
  L_PhotoManager:releasePendingCaptureRTs()
  L_SettingStore:revertQuality()
  AzurWorld.AOI:Pause(false, Azur.EAOIPauseReason.UI_Photo)
  CS.UnityEngine.Rendering.Azur.UniversalRenderPipeline.SetShadowForceUpdate(false)
end

function this:update()
  if self.pageState == _situationPageMode.edit then
    self:objClickSelect()
    if self.cameraController then
      self.cameraController:update()
    end
  end
end

function this:objClickSelect()
  if not Unity.Input.GetMouseButtonDown(0) then
    return
  end
  if Unity.EventSystems.EventSystem.current:IsPointerOverGameObject() then
    return
  end
  local mousePosition = CS.UnityEngine.Input.mousePosition
  local hits = C_CameraManager.mainCamera:ScreenRaycastAllByLayer(C_Vector2(mousePosition.x, mousePosition.y), {"Character", "Default"})
  if hits then
    for i = 0, hits.Length - 1 do
      local hit = hits[i]
      local hitObj = hit.collider.gameObject
      for i, v in pairs(L_SituationManager.curSolution.heroContainers) do
        if v.hero.obj == hitObj then
          self.bind.editTabId = L_Const.situationGroup.hero
          local heroPanel = self:getFuncPanel(L_Const.situationGroup.hero)
          if heroPanel then
            heroPanel:selectHero(v)
          end
          return
        end
      end
      for i, v in pairs(L_SituationManager.curSolution.petContainers) do
        if v.pet.obj == hitObj then
          self.bind.editTabId = L_Const.situationGroup.pet
          local petPanel = self:getFuncPanel(L_Const.situationGroup.pet)
          if petPanel then
            petPanel:selectPet(v)
          end
          return
        end
      end
      for i, v in pairs(L_SituationManager.curSolution.objContainers) do
        if v.gameObject == hitObj then
          self.bind.editTabId = L_Const.situationGroup.obj
          local objPanel = self:getFuncPanel(L_Const.situationGroup.obj)
          if objPanel then
            objPanel:selectObj(v)
          end
          return
        end
      end
    end
  end
  if self.bind.editTabId == L_Const.situationGroup.hero then
  end
  if self.bind.editTabId == L_Const.situationGroup.stamp then
    local stampPanel = self:getFuncPanel(L_Const.situationGroup.stamp)
    if stampPanel then
      stampPanel:deselectStamp()
    end
  end
end

function this:onClickStamp(stampContainer)
  if self.pageState == _situationPageMode.edit then
    self.bind.editTabId = L_Const.situationGroup.stamp
    local stampPanel = self:getFuncPanel(L_Const.situationGroup.stamp)
    if stampPanel then
      stampPanel:selectStamp(stampContainer)
    end
  end
end

function this:capture()
  if self.isCapturing then
    return
  end
  local curWidth = C_Screen.width
  local curHeight = C_Screen.height
  local targetWidth = curWidth
  local targetHeight = curHeight
  if L_DeviceTpl:getIsPc() then
    if 2160 < curHeight then
      local ratio = curWidth / curHeight
      targetWidth = 2160 * ratio
      targetHeight = 2160
    end
  elseif 2560 < curWidth then
    local ratio = curHeight / curWidth
    targetHeight = 2560 * ratio
    targetWidth = 2560
  end
  self.preHighResolution = L_PhotoManager.useHighResolution
  L_PhotoManager.useHighResolution = true
  self.bind.go_whiteCut = true
  self.isCapturing = true
  
  local function onFail()
    self:resetCaptureState()
  end
  
  L_PhotoManager:capture(function(t2d)
    L_PhotoManager:captureUI(t2d, self:getCaptureUIRoot(), function(tex)
      self:resetCaptureState(true)
      L_UI:open("pagePhotoPreview", {rt = tex, isFullScreen = true}, function()
        if self.isBind then
          self.bind.go_whiteCut = false
        end
      end)
    end, onFail)
  end, targetWidth, targetHeight, false, onFail)
end

function this:getCaptureUIRoot()
  local stampRoot = self.bindComponents.stampRoot
  if not stampRoot or stampRoot.childCount <= 0 then
    return nil
  end
  return stampRoot
end

function this:resetCaptureState(keepWhiteCut)
  if self.preHighResolution ~= nil then
    L_PhotoManager.useHighResolution = self.preHighResolution
    self.preHighResolution = nil
  end
  self.isCapturing = false
  if not keepWhiteCut and self.isBind then
    self.bind.go_whiteCut = false
  end
end

function this:onClickRename()
  local cur = L_SituationStore:getSolutionInfo(self.curSelectId)
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_situation_changename"),
    placeHolder = L_WordsTpl:getValue("ui_situation_inputnewname"),
    txtContent = cur.name,
    limit = 7,
    keepPageOpen = true,
    textBoxType = L_Const.CommonTextBoxType.Rename,
    confirmCallback = function(txt)
      if txt == cur.name or txt == "" then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_situation_inputempty"))
        return
      end
      L_SituationStore:req_changeName(self.curSelectId, txt, function(code)
        L_UI:close("pageCommonTextBox")
      end)
    end
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:onClickChangeCover()
  if self.isCapturing then
    return
  end
  local situationId = self.curSelectId
  local solution = L_SituationStore:getSolutionInfo(situationId)
  if not solution or solution.isCaptured then
    return
  end
  local targetWidth = math.min(C_Screen.width, 640)
  local targetHeight = math.ceil(targetWidth * C_Screen.height / C_Screen.width)
  self.isCapturing = true
  
  local function onFail()
    self.isCapturing = false
  end
  
  local captureUIRoot = self:getCaptureUIRoot()
  
  local function releaseCaptureRT(rt)
    if rt then
      L_PhotoManager:releaseCaptureRT(rt)
    end
  end
  
  local function uploadCover(rt)
    if not L_CommonUtil.isValid(rt) then
      releaseCaptureRT(rt)
      onFail()
      return
    end
    local texture
    local tempTexture = rt:ToTexture2D()
    if not L_CommonUtil.isValid(tempTexture) then
      onFail()
      return
    end
    if tempTexture.width * 9 == tempTexture.height * 16 then
      texture = tempTexture
    else
      texture = C_CameraCaptureUtil.CropTextureToRatio(tempTexture, 16, 9)
      if L_CommonUtil.isValid(tempTexture) then
        tempTexture:ReleaseTexture()
      end
    end
    C_CameraCaptureUtil.SetAlphaOne(texture)
    releaseCaptureRT(rt)
    solution.isCaptured = true
    L_SituationManager:uploadCover(texture, situationId, function(success)
      self.isCapturing = false
      if not success then
        solution.isCaptured = false
      end
    end)
  end
  
  L_PhotoManager:capture(function(t2d)
    L_PhotoManager:captureUI(t2d, captureUIRoot, function(rt)
      if captureUIRoot == nil then
        FrameScheduler.add(function()
          if not self.isBind then
            releaseCaptureRT(rt)
            onFail()
            return
          end
          uploadCover(rt)
        end, 1)
      else
        uploadCover(rt)
      end
    end, onFail)
  end, targetWidth, targetHeight, false, onFail)
end

function this:switchQualityTog(v)
  if v then
    L_SettingStore:setHighestQuality()
    L_CommonUtil.setLocalBoolValue(_SituationQuality, true)
  else
    L_SettingStore:revertQuality()
    L_CommonUtil.setLocalBoolValue(_SituationQuality, false)
  end
end

function this:saveToPlayerCard(callback)
  L_PlayerDisplayStore:req_setPlayerCardSituationId(self.curSelectId, function()
    if callback then
      callback()
    end
  end)
end

function this:refreshPinchSpeed(speed)
  if self.cameraController then
    self.cameraController:set_PinchSpeed(speed)
  end
end

return this
