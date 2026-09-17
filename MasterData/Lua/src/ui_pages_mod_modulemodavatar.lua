local TypeList = L_GameTpl:getGameConstTpl():getData("AVATAR_TYPE", L_Const.GameTplType.list_int)
local AvatarModuleType = {
  GENERAL = 1,
  SKIN = 2,
  HEIGHT = 3
}
local PageStep = {
  SEX = 1,
  AVATAR = 2,
  NAME = 3
}
local _pullInCamAudio = "Play_SFX_System_UI_Dressing_Zoom_In"
local _pullAwayCamAudio = "Play_SFX_System_UI_Dressing_Zoom_Out"
local module = class("moduleModAvatar", G_UIModuleBase)

function module.bind()
  return {
    activeDragButton = false,
    activeRightArea = false,
    activeRandom = false,
    activeDefault = false,
    pos_nearCamera = C_Vector3.zero,
    wardrobeTypeList = {
      moduleName = "pages/mod/module/modTypeSelectItem"
    },
    tab_module = -1,
    module_avatarHeight = {
      moduleName = "pages/mod/module/moduleAvatarHeight"
    },
    module_avatarSkin = {
      moduleName = "pages/mod/module/moduleWardrobeSkin"
    },
    module_avatarGeneral = {
      moduleName = "pages/mod/module/moduleWardrobeSelect"
    },
    modPrefabName = "",
    modEuler = C_Vector3.zero,
    modScale = C_Vector3.one,
    txt_title = ""
  }
end

function module.methods()
  return {
    onEnterDrag = function(self)
      self._canScroll = true
    end,
    onExitDrag = function(self)
      self._canScroll = false
    end,
    dragBegin = function(self, pos)
      self.oldDragX = pos.x
    end,
    drag = function(self, pos)
      self.bind.modEuler = Unity.Vector3(0, self.bind.modEuler.y + self.oldDragX - pos.x, 0)
      self.oldDragX = pos.x
    end,
    randomButtonClick = function(self)
      L_ModStore:randomDataByWardrobeType(self._wardrobeType)
      self:playIdle()
    end,
    resetDefaultClick = function(self)
      if L_ModStore:isModDataChange() then
        L_GameUtil.showCommonTip({
          txtTitle = L_GameTpl:getWordsTpl():getTplById("notice_title_hint"),
          txtContent = L_GameTpl:getWordsTpl():getTplById("notice_avatar_initial"),
          confirmCallback = function()
            L_ModStore:resetDefaultData()
            local wardrobeType = self._wardrobeType
            self._wardrobeType = nil
            self:selectModule(wardrobeType)
            L_ModStore:setIsChanged(false)
            self.avatarAnimator:Play("Idle")
          end
        })
      else
        L_ModStore:resetDefaultData()
        local wardrobeType = self._wardrobeType
        self._wardrobeType = nil
        self:selectModule(wardrobeType)
        L_ModStore:setIsChanged(false)
        self.avatarAnimator:Play("Idle")
      end
    end,
    allRandomClick = function(self)
      if L_ModStore:isModDataChange() then
        L_GameUtil.showCommonTip({
          txtTitle = L_GameTpl:getWordsTpl():getTplById("notice_title_hint"),
          txtContent = L_GameTpl:getWordsTpl():getTplById("notice_avatar_random"),
          confirmCallback = function()
            L_ModStore:allRandomData(TypeList)
            L_ModStore:setIsChanged(false)
            self.avatarAnimator:Play("Idle")
          end
        })
      else
        L_ModStore:allRandomData(TypeList)
        L_ModStore:setIsChanged(false)
        self.avatarAnimator:Play("Idle")
      end
    end,
    wardrobeTypeList = {
      onClick_select = function(self, type)
        self:selectModule(type)
      end
    }
  }
end

function module:resetModOffset()
  self.bind.modEuler = C_Vector3.zero
end

function module:initAll()
  if self.inited then
    return
  end
  self.inited = true
  self:resetModOffset()
  self._currCamValue = 1
  self._targetCamValue = 1
  self._mixCam:SetWeight(self._camRemote, self._currCamValue)
  self._mixCam:SetWeight(self._camNear, 1 - self._currCamValue)
  self.parent.modules.module_sex:initAll()
  self:initTabList()
end

function module:showAvatarMod(isMale)
  local playPath = isMale and L_Const.playerPath.avatarPrefabMalePath or L_Const.playerPath.avatarPrefabFemalePath
  self.bind.modPrefabName = L_GameTpl:getGameConstTpl():getData(playPath, L_Const.GameTplType.string)
  self.modelCtrl = self.bindComponents.HeroMain.prefab:GetComponent(typeof(C_ModelControl))
  local biodata = self.modelCtrl.transform:GetChild(0):GetComponent(typeof(C_BiologyAvatar))
  biodata.isSync = true
  local avatarData = L_ModStore:getDefaultData(isMale and L_Const.sexType.male or L_Const.sexType.female)
  self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(self.modelCtrl, avatarData, C_AnimatorControllerType.UIPreview)
  self.avatarAnimator = biodata:GetComponent(typeof(C_PlayableAnimator))
  self.avatarAnimator:Play("Idle")
  self.avatarAnimator.updateMode = C_PlayableAnimator.UpdateMode.Normal
  L_ModStore:setTempAvatarCtrl(self.avatarCtrl)
end

function module:hideAvatarMod()
  self.bind.modPrefabName = ""
  if self.avatarCtrl then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
    self.avatarCtrl = nil
    L_ModStore:setTempAvatarCtrl(nil)
  end
end

function module:initTabList()
  local typeDatas = {}
  for i, v in pairs(L_GameTpl:getGameConstTpl():getData("AVATAR_TYPE", L_Const.GameTplType.list_int)) do
    table.insert(typeDatas, {wardrobeType = v})
  end
  table.insert(typeDatas, 1, {wardrobeType = 15})
  typeDatas[1].isSelect = true
  self.bind.wardrobeTypeList:clear()
  self.bind.wardrobeTypeList:insert_array(typeDatas)
  self:selectModule(typeDatas[1].wardrobeType)
  table.remove(typeDatas, 1)
  self.bind.wardrobeTypeList:clear()
  self.bind.wardrobeTypeList:insert_array(typeDatas)
  self:selectModule(typeDatas[1].wardrobeType)
end

local RemoteCameraTypes = {
  [L_ModStore.modType.height] = true,
  [L_ModStore.modType.skin] = true,
  [L_ModStore.modType.cloth] = true,
  [L_ModStore.modType.tryOn] = true,
  [L_ModStore.modType.sex] = true
}

function module:open()
  function self._mouseScrollWheelHandle(dv)
    if self.parent._step ~= PageStep.AVATAR or not self._canScroll then
      return
    end
    self._targetCamValue = self._targetCamValue + (0 < dv and -0.05 or dv < 0 and 0.05 or 0)
    self._targetCamValue = math.clamp(self._targetCamValue, 0, 1)
  end
  
  C_InputManager.AddSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  self._camRemote = self.bindComponents.camera_remote
  self._camNear = self.bindComponents.camera_near
  self._mixCam = self.bindComponents.CameraMix
  self._currCamValue = 1
  self._targetCamValue = 1
  self._mixCam:SetWeight(self._camRemote, self._currCamValue)
  self._mixCam:SetWeight(self._camNear, 1 - self._currCamValue)
  
  function self._onHeightChange()
    self:refreshHeight()
  end
  
  L_ModStore:listenCallFunc(L_ModStore.event.refreshHeight, self._onHeightChange)
end

function module:update()
  if self._currCamValue == self._targetCamValue then
    return
  end
  local dis = self._targetCamValue - self._currCamValue
  dis = math.clamp(dis, -0.05, 0.05)
  self._currCamValue = self._currCamValue + dis
  self._mixCam:SetWeight(self._camRemote, self._currCamValue)
  self._mixCam:SetWeight(self._camNear, 1 - self._currCamValue)
end

function module:close()
  C_InputManager.RemoveSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  L_ModStore:unListenCallFunc(L_ModStore.event.refreshHeight, self._onHeightChange)
end

function module:selectModule(wardrobeType)
  if self._wardrobeType == wardrobeType then
    return
  end
  if wardrobeType == L_ModStore.modType.sex and L_ModStore:isModDataChange() then
    L_GameUtil.showCommonTip({
      txtTitle = L_GameTpl:getWordsTpl():getTplById("notice_title_hint"),
      txtContent = L_GameTpl:getWordsTpl():getTplById("notice_avatar_choosegender"),
      confirmCallback = function()
        L_ModStore:setIsChanged(false)
        self:selectModule(L_ModStore.modType.sex)
      end
    })
    return
  end
  if self.avatarCtrl and wardrobeType ~= L_ModStore.modType.tryOn then
    self.avatarCtrl:RemoveTryOn()
  end
  self._targetCamValue = RemoteCameraTypes[wardrobeType] and 1 or 0
  self:doCameraMoveAudio(self._targetCamValue)
  for _, mod in ipairs(self.modules.wardrobeTypeList) do
    mod.bind.isSelect = wardrobeType == mod.bind.wardrobeType
  end
  self:leaveSexTab()
  self._wardrobeType = wardrobeType
  self.bind.txt_title = L_WordsTpl:getValue(L_ModStore.modTypeText[wardrobeType])
  if wardrobeType == L_ModStore.modType.height then
    self.bind.tab_module = AvatarModuleType.HEIGHT
    self.modules.module_avatarHeight:refreshUI()
  elseif wardrobeType == L_ModStore.modType.skin then
    self.bind.tab_module = AvatarModuleType.SKIN
    self.modules.module_avatarSkin:setModuleData(wardrobeType)
  elseif wardrobeType == L_ModStore.modType.sex then
    self:hideAvatarMod()
    self.bind.activeDragButton = false
    self.bind.activeRightArea = false
    self.bind.activeRandom = false
    self.bind.activeDefault = false
    self.parent.modules.module_sex:showAll()
    self.parent.bind.pos_sex_camera = C_Vector3(0, 0.8800049, -4.85)
  else
    self.bind.tab_module = AvatarModuleType.GENERAL
    self.modules.module_avatarGeneral:setModuleData(wardrobeType)
  end
end

function module:leaveSexTab()
  if self._wardrobeType == L_ModStore.modType.sex then
    self.parent.modules.module_sex:hideAll()
    local isMale = self.parent.initSex
    self:showAvatarMod(isMale)
    self.bind.activeRandom = true
    self.bind.activeDefault = true
    self.bind.activeDragButton = true
    self.bind.activeRightArea = true
    self.parent.bind.pos_sex_camera = C_Vector3(isMale and 0.4 or -0.4, 0.8800049, -4.85)
    self:refreshHeight()
    self:resetModOffset()
  end
end

function module:showAll()
  if self.inited then
    local type = self._wardrobeType
    self._wardrobeType = nil
    self:selectModule(type)
  else
    self:initAll()
  end
end

function module:hideAll()
  self:leaveSexTab()
end

function module:initReenter()
  self._currCamValue = 1
  self._targetCamValue = 1
  self._mixCam:SetWeight(self._camRemote, self._currCamValue)
  self._mixCam:SetWeight(self._camNear, 1 - self._currCamValue)
  self:initTabList()
  self:selectModule(self.modules.wardrobeTypeList[1].bind.wardrobeType)
  self:refreshHeight()
end

function module:refreshHeight()
  if not self.avatarCtrl then
    return
  end
  self.bind.pos_nearCamera = self.modelCtrl:GetTransByName("Head").position + C_Vector3(0.1, -0.02, -1.3)
end

function module:doCameraMoveAudio(targetCamValue)
  if self.oldTargetCamValue == targetCamValue then
    return
  end
  self.oldTargetCamValue = targetCamValue
  if targetCamValue == 1 then
    C_AudioManager.Play(_pullAwayCamAudio)
  else
    C_AudioManager.Play(_pullInCamAudio)
  end
end

function module:playIdle()
  if self.avatarCtrl:IsTryOn() then
    if self.avatarCtrl.sex == L_Const.sexType.male then
      self.avatarAnimator:Play("Suit_Idle")
    else
      self.avatarAnimator:Play("Maid_Idle")
    end
  else
    self.avatarAnimator:Play("Idle")
  end
end

function module:destroy()
  this.super.destroy(self)
  self:hideAvatarMod()
end

return module
