local this = class("moduleModName", G_UIModuleBase)
local randomNameTpl = L_GameTpl:getRandomNameTpl()
local firstNameList = randomNameTpl:getNameByType(1)
local lastNameList = randomNameTpl:getNameByType(2)
local _animAudio = "Play_SFX_System_UI_Dressing_Naming"

function this.bind()
  return {
    playerNameText = "",
    pos_camera = nil,
    rot_camera = nil,
    capturePrefabName = ""
  }
end

function this.methods()
  return {
    onPlayerNameEndEdit = function(self, val)
      self.bind.playerNameText = C_LuaUtility.StringSub(val, 0, 14)
      self.playerName = self.bind.playerNameText
    end,
    onClick_Random = function(self)
      self:randomPlayerName()
    end
  }
end

function this:toBind(uiBinding)
  this.super.toBind(self, uiBinding)
  self.isEditor = false
  self.photoInfos = self.bindComponents.assets:Get(0).Infos
end

function this:open()
  self.bindComponents.camera_capture.gameObject:SetActive(false)
end

function this:randomPlayerName()
  local randomFirstId = math.random(1, #firstNameList)
  local randomLastId = math.random(1, #lastNameList)
  while self._firstId == firstNameList[randomFirstId].id do
    randomFirstId = math.random(1, #firstNameList)
  end
  while self._lastId == lastNameList[randomLastId].id do
    randomLastId = math.random(1, #lastNameList)
  end
  self._firstId = firstNameList[randomFirstId].id
  self._lastId = lastNameList[randomLastId].id
  local firstName = randomNameTpl:getNameWords(randomNameTpl:getTplById(firstNameList[randomFirstId].id))
  local lastName = randomNameTpl:getNameWords(randomNameTpl:getTplById(lastNameList[randomLastId].id))
  local val = string.concat(firstName, lastName)
  self.playerName = val
  self.bind.playerNameText = val
end

function this:hide()
  if self._modData then
    self._modData:dispose()
    self._modData = nil
  end
  if self.timelineControl then
    self.timelineControl:dispose()
    self.timelineControl = nil
  end
end

function this:initAll()
  L_ModStore:getModData():RemoveTryOn()
  if self.avatarData then
    AzurWorld.avatarMgr:ReleaseAvatarData(self.avatarData)
    self.avatarData = nil
  end
  self.avatarData = L_ModStore:getModData().AvatarData:Clone()
  self.parent.bind.active_hideAll = false
  self.gameObject:SetActive(true)
  C_AudioManager.Play(_animAudio)
end

function this:showTimeline(callback)
  local heroId = L_GameUtil.getDefaultHeroId(L_ModStore:getModData().Sex)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(L_HeroStore:getDefaultHeroGuid(), heroId)
  local clothing = L_GameTpl:getHeroClothingTpl():getTplById(clothingId)
  local path = L_Config:getPathByHash(clothing.uiperform)
  if not self.timelineControl then
    self.timelineControl = require("ui.manager.hero.timeline.timelineControl").new()
  end
  local timelineAssetName = L_ModStore:getModData().Sex == L_Const.sexType.male and "UIEquip" or "UISkill"
  self.timelineControl:setCustomAvatarData(self.avatarData)
  self.timelineControl:asyncLoadTimelineAssets(path, timelineAssetName, nil, heroId, true, function()
  end, function()
    self.bind.bg = false
    local tlState = self.timelineControl._timelinePrefabHandle:getTimelineState(path)
    self.timelineControl:setAssetsActive(true)
    self.timelineControl:tryChangNextTimelineState(timelineAssetName)
    Timer.once(0, function()
      tlState.director:Pause()
      if callback then
        callback()
      end
    end)
  end, nil, clothingId)
end

function this:hideAll()
  if self.timelineControl then
    self.timelineControl:dispose()
    self.timelineControl = nil
  end
  if self.isEditor then
    self:leaveEditorMod()
  end
end

function this:finishMod()
  if string.isEmpty(self.playerName) then
    local wordsTpl = L_GameTpl:getWordsTpl()
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_noname"))
    return
  end
  self:startCapture()
end

function this:startCapture()
  self._capturing = true
  self:_capturePrepare(function()
    self:_doCapture()
  end)
  L_TimerManager:newOrResetTimer(self, "allTimeout", function()
    if self._capturing then
      self._capturing = false
      self:endCapture(false)
    end
  end, 20)
end

this.ShotList = {
  L_Const.screenShotType.battleHeadImg,
  L_Const.screenShotType.hearHeadImg,
  L_Const.screenShotType.halfBodyImg,
  L_Const.screenShotType.halfsHeadImg,
  L_Const.screenShotType.circleHeadImg,
  L_Const.screenShotType.paintImg
}

function this:_doCapture()
  self.urlData = {}
  Timer.once(0.3, self._oneCapture, self, self.gameObject)
end

function this:_capturePrepare(callback)
  self.parent.bind.active_hideAll = true
  self.gameObject:SetActive(false)
  local second = L_Const.oneDaySecond * 0.525
  C_GameTime.ActiveUITimeAgent()
  C_GameTime.SetVirTimeWithSecond(second)
  self.parent.bind.active_weather = false
  self.parent.bind.active_LightForUI = true
  self.parent.modules.module_avatar.bindComponents.HeroMain.gameObject:SetActive(false)
  Timer.once(0.1, function()
    self:showTimeline(function()
      callback()
    end)
  end)
end

function this:prepareOneShot(conf)
  local sex = L_ModStore:getModData().Sex
  if sex == 1 then
    self.bind.pos_camera = conf.CameraPosMale
    self.bind.rot_camera = conf.CameraRotMale
  else
    self.bind.pos_camera = conf.CameraPosFemale
    self.bind.rot_camera = conf.CameraRotFemale
  end
end

function this:_oneCapture(currIndex, isNext)
  if not self._capturing then
    return
  end
  currIndex = currIndex or 0
  if currIndex < self.photoInfos.Length then
    local conf = self.photoInfos[currIndex]
    self:prepareOneShot(conf)
    
    local function _capture()
      local camList = {
        self.bindComponents.camera_capture
      }
      
      local function call(flag, key)
        if flag then
          self.urlData[conf.ModDataKey] = key
          if isNext ~= false then
            self:_oneCapture(currIndex + 1, isNext)
          end
        else
          self._capturing = false
          self:endCapture(false)
        end
      end
      
      local rect = C_Rect(conf.RectPos.x, conf.RectPos.y, conf.RectSize.x, conf.RectSize.y)
      local t2d = L_PhotoManager:screenHeadShot(rect, camList, conf.Name, call)
    end
    
    L_TimerManager:newOrResetTimer(self, "capture", _capture, 0.05)
  else
    self._capturing = false
    self:endCapture(true)
  end
end

function this:revertCapture()
  if self.timelineControl then
    self.timelineControl:dispose()
    self.timelineControl = nil
  end
  self.parent.modules.module_avatar.bindComponents.HeroMain.gameObject:SetActive(true)
  self.parent.bind.active_weather = true
  self.parent.bind.active_LightForUI = false
  C_GameTime.InactiveUITimeAgent()
end

function this:endCapture(success)
  L_TimerManager:clearTimer(self)
  self:revertCapture()
  if success then
    if L_PlayerStore:getIsNewPlayer() then
      L_GameStore:req_playerCustomData({
        name = self.playerName,
        wardrobe_info = L_ModStore:transitionDataToServer(L_ModStore:getModData().AvatarData, self.urlData)
      }, function(rsp_data, errorCode)
        if errorCode == L_Const.errorCode.ErrCodeSucc then
          L_PhotoManager:checkHeadTex()
          L_UI:close("pageMOD2")
          C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
          if AzurWorldInstance.CurWorldId < 0 then
            AzurWorld.proxyCenter:RequestTransfer(AzurWorld.proxyCenter.defaultSceneId)
          end
        else
          self.parent.bind.active_hideAll = false
          self.gameObject:SetActive(true)
        end
      end)
    else
      L_PlayerStore:req_playerCustomDataUp(L_ModStore:transitionDataToServer(L_ModStore:getModData().AvatarData, self.urlData), function(rsp_data, errorCode)
        if errorCode == L_Const.errorCode.ErrCodeSucc then
          L_PhotoManager:checkHeadTex()
          self:refreshPlayer()
        else
          self.parent.bind.active_hideAll = false
          self.gameObject:SetActive(true)
          self.parent:onClickLast()
        end
      end)
    end
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageStandeePreview"))
    self.parent.bind.active_hideAll = false
    self.gameObject:SetActive(true)
    if not L_PlayerStore:getIsNewPlayer() then
      self.parent:onClickLast()
    end
  end
end

function this:refreshPlayer()
  AzurWorld.playerMgr.myPlayerUnitAdapter:RecreateFormationEntity(L_HeroStore:getDefaultHeroGuid(), 0, function()
    L_UI:close("pageMOD2")
    C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
    local options = {
      coverdTime = 0.2,
      fadeOut = true,
      isCompleteClose = true
    }
    L_UI:open("pageMask", options)
  end)
end

function this:enterEditorMod(conf)
  if not IS_EDITOR then
    return
  end
  self.parent:setStep(3)
  self.isEditor = true
  
  local function onPrepareFinish()
    self.bindComponents.camera_capture.gameObject:SetActive(true)
    self.bindComponents.editor_root.gameObject:SetActive(true)
    local rtTrans = self.bindComponents.editor_root:Find("rt_image")
    local rtImage = rtTrans:GetComponent(typeof(C_LRawImage))
    rtImage.texture = self.bindComponents.camera_capture.targetTexture
    self.parent.bind.active_hideAll = false
    self:editor_showShotState(conf)
  end
  
  self:_capturePrepare(onPrepareFinish)
end

function this:editor_showShotState(conf)
  if not IS_EDITOR then
    return
  end
  self:prepareOneShot(conf)
  local rectTrans = self.bindComponents.editor_root:Find("rect_res")
  rectTrans.anchoredPosition = conf.RectPos
  rectTrans.sizeDelta = conf.RectSize
end

function this:leaveEditorMod()
  if not IS_EDITOR then
    return
  end
  if not self.isEditor then
    return
  end
  self.isEditor = false
  self:revertCapture()
  self.parent.modules.module_avatar.bindComponents.HeroMain.gameObject:SetActive(true)
  self.bindComponents.camera_capture.gameObject:SetActive(false)
  self.bindComponents.editor_root.gameObject:SetActive(false)
end

function this:testPhoto()
  if not IS_EDITOR then
    return
  end
  local rectTrans = self.bindComponents.editor_root:Find("rect_res")
  local t2d = L_PhotoManager:shotByRectTrans(rectTrans, self.bindComponents.camera_capture)
  local image = self.bindComponents.editor_root:Find("testTexture"):GetComponent(typeof(C_LRawImage))
  image.gameObject:SetActive(true)
  image.texture = t2d
  image:SetNativeSize()
end

return this
