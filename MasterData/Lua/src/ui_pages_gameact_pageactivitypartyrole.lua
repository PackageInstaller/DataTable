local this = class("pageActivityPartyRole", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local _formationTpl = L_GameTpl:getFormationTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()

local function isMainHeroConfigId(heroConfigId)
  return heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female)
end

local function buildDisplayHeroData(heroInfo)
  if not heroInfo then
    return nil
  end
  local heroConfigId = L_HeroStore:getHeroConfigId(heroInfo)
  if not isMainHeroConfigId(heroConfigId) then
    return heroInfo
  end
  return {
    guid = L_HeroStore:getHeroGuid(heroInfo),
    configId = heroConfigId,
    lv = L_HeroStore:getHeroLevel(heroInfo),
    heroGrade = L_HeroStore:getHeroStar(heroInfo),
    heroRank = L_HeroStore:getHeroRank(heroInfo),
    petId = heroInfo.petId or 0,
    trailPetId = heroInfo.trailPetId or 0,
    type = L_Const.HeroType.HT_MAIN
  }
end

local function forceShowModelRenderers(heroObj)
  if not L_CommonUtil.isValid(heroObj) then
    return
  end
  heroObj:SetActive(true)
  local skinned = heroObj:GetComponentsInChildren(typeof(CS.UnityEngine.SkinnedMeshRenderer), true)
  if skinned then
    for i = 0, skinned.Length - 1 do
      local s = skinned[i]
      if s then
        s.updateWhenOffscreen = true
      end
    end
  end
end

local SCENE_CONFIG = {
  displayScenePath = function()
    return "Program/UIScene/PetDuel/pre_petDuelScene_ui_01.prefab"
  end
}
local PREVIEW_MODEL_Y_OFFSET = 0.12
this.selectHeroGuid = -1
this.heroUidList = {}
this.actId = 0
this.sceneObj = nil
this.previewHeroModelObj = nil
this.previewHeroEntity = nil
this.modelRootTrans = nil
this.heroParentTrans = nil
this.previewIdleTimer = nil
this.sceneLoadTimer = nil
this.aniCallbackTimer = nil
this.sceneLoadHandle = nil
this.previewHeroModelHandle = nil
this.displayHeroGuid = -1
this.previewContainerGo = nil
this.previewBindGo = nil
this._previewInitializing = false
this.previewCameraTrans = nil
this.previewPlayableAnimator = nil
this._previewHeroModelOwnedByEntity = false
this._previewLoadToken = 0
this._isClosing = false
this.characterAnchorFit = nil

function this.bind()
  return {
    leftHeroGrid = {
      moduleName = "modulePages/cellIconUnit"
    },
    active_heroModel = true,
    active_btnChangeHero = true,
    go_previewContainer = nil,
    active_savePetEdit = true,
    active_savePetEditGrey = false,
    active_save_btn = true,
    active_save_btn_grey = false
  }
end

function this.methods()
  return {
    onClick_saveHeroEdit = function(self)
      self:onClickConfirmSelectHero()
    end,
    save_btn = function(self)
      self:onClickConfirmSelectHero()
    end,
    onClick_cancel = function(self)
      self:onClickCancel()
    end,
    OnClick_Model = function(self)
      self:playPreviewRandomIdle()
    end,
    onClick_model = function(self)
      self:playPreviewRandomIdle()
    end
  }
end

function this:onClickConfirmSelectHero()
  if not self:canConfirmSelectHero() then
    return
  end
  self:reqChangeHero(self.selectHeroGuid, function(success)
    if not success then
      return
    end
    self.displayHeroGuid = self.selectHeroGuid
    if self.onConfirm then
      self.onConfirm(self.selectHeroGuid)
    end
    L_UI:close(self.pageName)
  end)
end

function this:onClickCancel()
  if self.onCancel then
    self.onCancel(self.displayHeroGuid or self.selectHeroGuid)
  end
  L_UI:close(self.pageName)
end

function this:canConfirmSelectHero()
  return self.selectHeroGuid > 0
end

function this:refreshConfirmBtnState()
  local canConfirm = self:canConfirmSelectHero()
  self.bind.active_savePetEdit = canConfirm
  self.bind.active_savePetEditGrey = not canConfirm
  self.bind.active_save_btn = canConfirm
  self.bind.active_save_btn_grey = not canConfirm
end

function this:reqChangeHero(heroGuid, callback)
  if not heroGuid or heroGuid <= 0 then
    if callback then
      callback(false)
    end
    return
  end
  local msgId = MsgGenCode and MsgGenCode.CSProtoPopperPartyChangeHero or 11532
  if not L_Net or not L_Net.sendMessage then
    if callback then
      callback(false)
    end
    return
  end
  local heroIdNum = tonumber(heroGuid)
  if not heroIdNum or heroIdNum <= 0 then
    if callback then
      callback(false)
    end
    return
  end
  local payload = {hero_id = heroIdNum}
  local ok, err = pcall(function()
    L_Net:sendMessage(msgId, payload, function(_, errorCode)
      local success = not errorCode or errorCode == L_Const.errorCode.ErrCodeSucc
      if not success then
        L_FlyMsgManager:showNormalMsg("角色切换失败，请重试")
      end
      if callback then
        callback(success)
      end
    end)
  end)
  if not ok and callback then
    callback(false)
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:ensureRuntimeVisibleRoots()
  self._isClosing = false
  self.selectHeroGuid = -1
  self.heroUidList = {}
  self.actId = options.actId or 0
  local currentHeroGuid = options.currentHeroGuid or -1
  self.onConfirm = options.onConfirm
  self.onCancel = options.onCancel
  self.previewContainerGo = nil
  self.previewBindGo = nil
  self._previewInitializing = false
  self.previewPlayableAnimator = nil
  self._previewHeroModelOwnedByEntity = false
  self._previewLoadToken = 0
  self:initDefaultHero(currentHeroGuid)
  if 0 < currentHeroGuid and L_HeroStore:getHero(currentHeroGuid) then
    self.displayHeroGuid = currentHeroGuid
  else
    self.displayHeroGuid = self.selectHeroGuid
  end
  self._needRefreshHeroList = true
  self:refreshConfirmBtnState()
end

function this:initCommonTopModule()
  if not C_IntegrateMgr or not C_IntegrateMgr.TopBarModule then
    return
  end
  local topBar = C_IntegrateMgr.TopBarModule
  if topBar.SetTopBarCloseFunc then
    topBar:SetTopBarCloseFunc(handler(self, self.escHandle))
  end
  if topBar.SetTopBarMainBtnFunc then
    topBar:SetTopBarMainBtnFunc(handler(self, self.escHandle))
  end
end

function this:open()
  this.super.open(self)
  self:initCommonTopModule()
  self:ensureRuntimeVisibleRoots()
  self:setPreviewSceneActive(true)
  if self._needRefreshHeroList then
    self._needRefreshHeroList = nil
    self:refreshHeroListDeferred()
  end
  self:ensurePreviewContainer()
  if (not self.sceneObj or not self.previewHeroModelObj) and not self._previewInitializing then
    self:initPreviewDisplay()
  end
  Timer.once(0.2, function()
    if L_CommonUtil.isValid(self.gameObject) then
      self:ensureRuntimeVisibleRoots()
    end
  end, self, self.gameObject)
end

function this:onShow()
  this.super.onShow(self)
  self:initCommonTopModule()
end

function this:show()
  self:setPreviewSceneActive(true)
end

function this:hide()
  self:setPreviewSceneActive(false)
end

function this:escHandle()
  if self._isClosing then
    return
  end
  self:onClickCancel()
end

function this:ensureRuntimeVisibleRoots()
  if not self.gameObject or not self.gameObject.transform then
    return
  end
  
  local function ensureCanvasGroup(go)
    if not go then
      return
    end
    local cg = go:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    cg = cg or go:AddComponent(typeof(CS.UnityEngine.CanvasGroup))
    if cg then
      cg.alpha = 1
      cg.interactable = true
      cg.blocksRaycasts = true
    end
  end
  
  local function forceVisibleByName(nodeName)
    local trans = self:findChildByNameDeep(self.gameObject.transform, nodeName)
    if not trans then
      return
    end
    local go = trans.gameObject
    if go and go.SetActive then
      go:SetActive(true)
    end
    ensureCanvasGroup(go)
  end
  
  forceVisibleByName("root_heroEdit")
  forceVisibleByName("root_heroModel")
  forceVisibleByName("leftHeroContent")
  forceVisibleByName("root_heroIconGrid")
  forceVisibleByName("grid_hero")
end

function this:refreshHeroListDeferred(retryCount)
  retryCount = retryCount or 0
  local heroListBind = self.bind.leftHeroGrid
  local heroListModules = self.modules.leftHeroGrid
  local canUseList = heroListBind and heroListBind.clear and heroListBind.insert_array and heroListModules
  if canUseList then
    self:refreshHeroList()
    return
  end
  if 8 <= retryCount then
    self:refreshHeroList()
    return
  end
  Timer.once(0.1, function()
    if L_CommonUtil.isValid(self.gameObject) then
      self:refreshHeroListDeferred(retryCount + 1)
    end
  end, self, self.gameObject)
end

function this:initDefaultHero(defaultGuid)
  if 0 < defaultGuid and L_HeroStore:getHero(defaultGuid) then
    self.selectHeroGuid = defaultGuid
    return
  end
  self.selectHeroGuid = L_HeroStore:getDefaultHeroGuid()
  if 0 >= self.selectHeroGuid then
    local allHeroes = L_HeroStore:getAllHero()
    for _, heroData in pairs(allHeroes) do
      local heroGuid = L_HeroStore:getHeroGuid(heroData)
      if heroGuid and 0 < heroGuid then
        self.selectHeroGuid = heroGuid
        break
      end
    end
  end
end

function this:initPreviewDisplay()
  if self._previewInitializing then
    return
  end
  self._previewInitializing = true
  self:ensurePreviewContainer()
  self:loadPreviewScene(function(isSuccess)
    self._previewInitializing = false
    if isSuccess then
      self:selectHero(self.selectHeroGuid)
      self:ensurePreviewVisibleState()
    end
  end)
end

function this:setPreviewSceneActive(active)
  if not L_CommonUtil.isValid(self.sceneObj) then
    return
  end
  if active then
    C_UISceneManager.SetSceneVisible()
  end
  self.sceneObj:SetActive(active)
  if self.previewCameraTrans and self.previewCameraTrans.gameObject then
    self.previewCameraTrans.gameObject:SetActive(active)
  end
  if active and L_CommonUtil.isValid(self.previewHeroModelObj) then
    forceShowModelRenderers(self.previewHeroModelObj)
  end
end

function this:ensurePreviewContainer()
  if self.previewContainerGo and L_CommonUtil.isValid(self.previewContainerGo) then
    return
  end
  local bindGo, sceneGo
  if self.bindComponents then
    local sceneRoot = self.bindComponents.SceneRoot
    if sceneRoot then
      sceneGo = sceneRoot.gameObject or sceneRoot
    end
    local headRoot = self.bindComponents.modelHeadRoot_preview or self.bindComponents.modelHeadRoot_edit or self.bindComponents.modelHeadRoot_formation or self.bindComponents.modelHeadRoot_formationEdit
    if headRoot then
      bindGo = headRoot.gameObject or headRoot
    end
    local comp = self.bindComponents.go_previewContainer or self.bindComponents.previewContainer
    if not sceneGo and comp then
      sceneGo = comp.gameObject or comp
    end
  end
  if self.gameObject and self.gameObject.transform then
    if not sceneGo then
      local sceneRoot = self:findChildByNameDeep(self.gameObject.transform, "SceneRoot")
      if sceneRoot then
        sceneGo = sceneRoot.gameObject
      end
    end
    if not sceneGo then
      local deep = self:findChildByNameDeep(self.gameObject.transform, "go_previewContainer") or self:findChildByNameDeep(self.gameObject.transform, "previewContainer")
      if deep then
        sceneGo = deep.gameObject
      end
    end
    if not bindGo then
      local bindRoot = self:findChildByNameDeep(self.gameObject.transform, "modelHeadRoot_preview") or self:findChildByNameDeep(self.gameObject.transform, "modelHeadRoot_edit")
      if bindRoot then
        bindGo = bindRoot.gameObject
      end
    end
  end
  self.previewContainerGo = sceneGo
  self.previewBindGo = bindGo or sceneGo
  if self.previewContainerGo and self.previewContainerGo.SetActive then
    self.previewContainerGo:SetActive(true)
  end
  if self.previewBindGo and self.previewBindGo.SetActive then
    self.previewBindGo:SetActive(true)
  end
end

function this:loadPreviewScene(callback)
  if not L_CommonUtil.isValid(self.gameObject) then
    callback(false)
    return
  end
  local containerGo = self.previewContainerGo
  if not containerGo and self.gameObject then
    local trans = self.gameObject.transform:Find("go_previewContainer") or self.gameObject.transform:Find("previewContainer") or self:findChildByNameDeep(self.gameObject.transform, "go_previewContainer") or self:findChildByNameDeep(self.gameObject.transform, "previewContainer")
    if trans then
      containerGo = trans.gameObject
      self.previewContainerGo = containerGo
    end
  end
  if not containerGo or not L_CommonUtil.isValid(containerGo) then
    containerGo = nil
  end
  local scenePath = SCENE_CONFIG.displayScenePath()
  if type(scenePath) ~= "string" or scenePath == "" then
    callback(false)
    return
  end
  if self.sceneLoadHandle then
    pcall(function()
      C_PrefabManager:RecycleByLoader(self.sceneLoadHandle)
    end)
    self.sceneLoadHandle = nil
  end
  self.sceneLoadHandle = C_UIMgr.uiLoader:SpawnAsync(scenePath, function(instanceId, go)
    if self._isClosing or not L_CommonUtil.isValid(self.gameObject) then
      if instanceId then
        pcall(function()
          C_PrefabManager:RecycleByLoader(instanceId)
        end)
      end
      callback(false)
      return
    end
    if not L_CommonUtil.isValid(go) then
      callback(false)
      return
    end
    self.sceneObj = go
    local sceneTrans = self.sceneObj.transform
    sceneTrans:SetParent(C_LuaUtility.GetRootNode())
    L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
    L_Vector3.setRot(sceneTrans, L_Vector3.zero)
    self.sceneObj:SetActive(true)
    C_UISceneManager.SetSceneVisible()
    self:disableAllColliders(self.sceneObj)
    local sceneRoot = self:findChildByNameDeep(go.transform, "pre_petDuelScene_ui_01") or self:findChildByNameDeep(go.transform, "pre_formation_ui_default")
    local searchRoot = sceneRoot or go.transform
    local heroParent = self:findChildByNameDeep(searchRoot, "PlayerModelRoot") or self:findChildByNameDeep(searchRoot, "ModelRoot") or self:findChildByNameDeep(searchRoot, "Model") or searchRoot
    self.heroParentTrans = heroParent
    self.modelRootTrans = heroParent
    local cameraCandidates = {
      self:findChildByNameDeep(searchRoot, "petCameraHeroChange"),
      self:findChildByNameDeep(searchRoot, "petCameraPrepare"),
      self:findChildByNameDeep(searchRoot, "Camera_formation"),
      self:findChildByNameDeep(searchRoot, "Camera")
    }
    local previewCamera
    for _, camTrans in ipairs(cameraCandidates) do
      if camTrans and camTrans.gameObject then
        camTrans.gameObject:SetActive(false)
        previewCamera = previewCamera or camTrans
      end
    end
    if previewCamera and previewCamera.gameObject then
      previewCamera.gameObject:SetActive(true)
      self.previewCameraTrans = previewCamera
      local camComp
      pcall(function()
        camComp = previewCamera:GetComponent(typeof(CS.UnityEngine.Camera))
      end)
      if not camComp then
        pcall(function()
          camComp = previewCamera:GetComponentInChildren(typeof(CS.UnityEngine.Camera), true)
        end)
      end
      if camComp then
        pcall(function()
          camComp.enabled = true
          camComp.cullingMask = -1
          camComp.nearClipPlane = 0.01
          camComp.farClipPlane = 2000
        end)
      end
    end
    local formationUI = self:findChildByNameDeep(searchRoot, "UI_Formation")
    if formationUI then
      formationUI.gameObject:SetActive(false)
    end
    local bgRoot = self:findChildByNameDeep(searchRoot, "BgRoot")
    if bgRoot and bgRoot.gameObject then
      bgRoot.gameObject:SetActive(false)
    end
    local bgFullScreen = self:findChildByNameDeep(searchRoot, "BgFullScreen_bg")
    if bgFullScreen and bgFullScreen.gameObject then
      bgFullScreen.gameObject:SetActive(false)
    end
    local bgPrepareFront = self:findChildByNameDeep(searchRoot, "BgFullScreen_bg_prepare_front")
    if bgPrepareFront and bgPrepareFront.gameObject then
      bgPrepareFront.gameObject:SetActive(false)
    end
    local bgPrepareBack = self:findChildByNameDeep(searchRoot, "BgFullScreen_bg_prepare_back")
    if bgPrepareBack and bgPrepareBack.gameObject then
      bgPrepareBack.gameObject:SetActive(false)
    end
    local bgStateFront = self:findChildByNameDeep(searchRoot, "BgFullScreen_bg_state_front")
    if bgStateFront and bgStateFront.gameObject then
      bgStateFront.gameObject:SetActive(false)
    end
    local bgStateBack = self:findChildByNameDeep(searchRoot, "BgFullScreen_bg_state_back")
    if bgStateBack and bgStateBack.gameObject then
      bgStateBack.gameObject:SetActive(false)
    end
    local anchorFit = self.heroParentTrans and self.heroParentTrans:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
    if L_CommonUtil.isValid(anchorFit) then
      local followTrans = self:resolvePreviewFollowTrans()
      if not followTrans and containerGo and containerGo.transform then
        followTrans = containerGo.transform
      end
      if followTrans then
        anchorFit.followTrans = followTrans
      end
    end
    callback(true)
    self:ensurePreviewVisibleState()
  end, C_LuaUtility.GetRootNode(), true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function this:selectHero(heroGuid)
  if not heroGuid or heroGuid <= 0 then
    return
  end
  if not L_CommonUtil.isValid(self.gameObject) then
    return
  end
  if not (self.sceneObj and self.modelRootTrans) or not L_CommonUtil.isValid(self.modelRootTrans.gameObject) then
    self:initPreviewDisplay()
    return
  end
  local heroData = L_HeroStore:getHero(heroGuid)
  if not heroData then
    return
  end
  local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
  self._previewLoadToken = (tonumber(self._previewLoadToken) or 0) + 1
  local loadToken = self._previewLoadToken
  self:stopPreviewIdleTimer()
  if self.aniCallbackTimer then
    Timer.remove(self.aniCallbackTimer)
    self.aniCallbackTimer = nil
  end
  self:cleanupHeroModel()
  self:_fetchHeroModelAsync(heroConfigId, function(entity, heroObj)
    if loadToken ~= self._previewLoadToken then
      if entity and entity ~= self.previewHeroEntity then
        self:destroyHeroEntity(entity)
      elseif heroObj and heroObj ~= self.previewHeroModelObj then
        self:recycleLoaderObject(heroObj)
      end
      return
    end
    if not (L_CommonUtil.isValid(self.gameObject) and L_CommonUtil.isValid(heroObj) and self.modelRootTrans) or not L_CommonUtil.isValid(self.modelRootTrans.gameObject) then
      return
    end
    local heroTrans = heroObj.transform
    local parentTrans = self.heroParentTrans or self.modelRootTrans
    if heroTrans.parent ~= parentTrans then
      local ok = pcall(function()
        heroTrans:SetParent(parentTrans, false)
      end)
      if not ok then
        heroTrans:SetParent(parentTrans)
      end
    end
    self:applyPreviewAnchorFit(heroObj, entity)
    if entity then
      self:playPreviewDefaultAnim(entity)
      self:_fetchEffectModel(heroConfigId, entity:getGameObject())
      forceShowModelRenderers(heroObj)
      self:startPreviewIdleTimer()
    else
      forceShowModelRenderers(heroObj)
      self:startPreviewIdleTimer()
    end
  end)
end

function this:adjustPreviewCameraToHero(heroTrans)
  if not heroTrans or not self.previewCameraTrans then
    return
  end
  local camTrans = self.previewCameraTrans
  local heroPos = heroTrans.position
  local camPos = CS.UnityEngine.Vector3(heroPos.x, heroPos.y + 1.35, heroPos.z - 2.4)
  L_Vector3.setPos(camTrans, camPos)
  local lookTarget = CS.UnityEngine.Vector3(heroPos.x, heroPos.y + 1.05, heroPos.z)
  pcall(function()
    camTrans:LookAt(lookTarget)
  end)
end

function this:_fetchHeroModelAsync(heroConfigId, callback)
  if not heroConfigId or heroConfigId <= 0 then
    callback(nil, nil)
    return
  end
  if not L_CommonUtil.isValid(self.gameObject) then
    callback(nil, nil)
    return
  end
  local isPlayerHero = isMainHeroConfigId(heroConfigId)
  local unitId = L_GameUtil.getUnitIdByRole(heroConfigId, L_Const.roleType.hero)
  if not unitId then
    callback(nil, nil)
    return
  end
  local heroTplData = _heroTpl:getTplById(heroConfigId)
  local unit = _unitTpl:getTplById(unitId)
  local heroModelPath = unit and _unitTpl:getModel(unit, 1) or nil
  if type(heroModelPath) ~= "string" or heroModelPath == "" then
    heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
  end
  if type(heroModelPath) ~= "string" or heroModelPath == "" then
    callback(nil, nil)
    return
  end
  local parentTrans = self.heroParentTrans or self.modelRootTrans
  local initPos = heroTplData and _heroTpl:getKiBoDuelFormationHeroTransOffset(heroTplData) or L_Vector3.zero
  local initRot = heroTplData and _heroTpl:getKiBoDuelFormationHeroTransEuler(heroTplData) or L_Vector3.zero
  local initScale = heroTplData and _heroTpl:getKiBoDuelHeroPrepareTransScale(heroTplData) or L_Vector3.one
  initPos = L_Vector3.new(initPos.x, initPos.y + PREVIEW_MODEL_Y_OFFSET, initPos.z)
  local needAnimaList = {"KiboDuelUi", "Idle"}
  if L_UIModelMgr and L_UIModelMgr.RecycleHeroModel then
    L_UIModelMgr:RecycleHeroModel()
  end
  L_UIModelMgr:LoadHeroModelAsync(heroModelPath, initPos, initRot, initScale, function(obj)
    if not (not self._isClosing and L_CommonUtil.isValid(self.gameObject)) or not L_CommonUtil.isValid(obj) then
      callback(nil, nil)
      return
    end
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), obj)
    if biologyData then
      biologyData.isSync = true
    end
    if self.previewHeroEntity then
      self.previewHeroEntity:onDestroy()
    end
    local entity = L_EntityManager:generateSimpleHero(heroConfigId, obj, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.ActivityPartyRole)
    if entity and entity.playableAnimator then
      entity.playableAnimator:Play("KiboDuelUi")
    end
    self.previewHeroEntity = entity
    self.previewHeroModelObj = obj
    self.previewPlayableAnimator = entity and entity.playableAnimator or L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
    self._previewHeroModelOwnedByEntity = false
    self:updatePreviewHeroName(heroConfigId)
    self:disableAllColliders(obj)
    callback(entity, entity and entity.gameObject or obj)
  end, parentTrans)
end

function this:ensurePreviewVisibleState()
  Timer.once(0.05, function()
    if not L_CommonUtil.isValid(self.gameObject) then
      return
    end
    if L_CommonUtil.isValid(self.sceneObj) then
      self.sceneObj:SetActive(true)
    end
    if L_CommonUtil.isValid(self.previewHeroModelObj) then
      self.previewHeroModelObj:SetActive(true)
    end
  end, self, self.gameObject)
end

function this:resolvePreviewFollowTrans()
  local followTrans
  if self.bindComponents then
    followTrans = self.bindComponents.modelHeadRoot_edit or self.bindComponents.modelHeadRoot_preview or self.bindComponents.modelHeadRoot_formationEdit or self.bindComponents.modelHeadRoot_formation or self.bindComponents.playerModelHeadRoot
  end
  if not followTrans and self.previewBindGo and self.previewBindGo.transform then
    followTrans = self.previewBindGo.transform
  end
  if not followTrans and self.previewContainerGo and self.previewContainerGo.transform then
    followTrans = self.previewContainerGo.transform
  end
  return followTrans
end

function this:findPreviewModelRoot(targetGo)
  if not L_CommonUtil.isValid(targetGo) then
    return nil
  end
  local modelControl = targetGo:GetComponent(typeof(C_ModelControl))
  if modelControl then
    return targetGo
  end
  local trans = targetGo.transform
  if not trans then
    return targetGo
  end
  for i = 0, trans.childCount - 1 do
    local child = trans:GetChild(i)
    if child and child.gameObject then
      local childGo = child.gameObject
      local childModelControl = childGo:GetComponent(typeof(C_ModelControl))
      if childModelControl or L_CommonUtil.compareLayer(childGo, L_Const.layer.character) then
        return childGo
      end
    end
  end
  return targetGo
end

function this:applyPreviewAnchorFit(heroObj, entity)
  local anchorFit = self.heroParentTrans and self.heroParentTrans:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
  if not L_CommonUtil.isValid(anchorFit) then
    return
  end
  self.characterAnchorFit = anchorFit
  local followTrans = self:resolvePreviewFollowTrans()
  if followTrans then
    anchorFit.followTrans = followTrans
  end
  local modelHeight
  local biologyData = entity and entity.biologyData or L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), heroObj)
  if biologyData and biologyData.halfHeight then
    modelHeight = biologyData.halfHeight * 2
  end
  if not modelHeight or modelHeight <= 0 then
    local modelObj = self:findPreviewModelRoot(heroObj) or heroObj
    local modelControl = modelObj and modelObj:GetComponent(typeof(C_ModelControl)) or nil
    local headTrans = modelControl and modelControl:GetTransByName("Head") or nil
    if headTrans and self.heroParentTrans then
      modelHeight = headTrans.position.y - self.heroParentTrans.position.y + 0.2
    end
  end
  if modelHeight and 0 < modelHeight then
    pcall(function()
      anchorFit:SetModelHeight(modelHeight)
    end)
  end
end

function this:playPreviewDefaultAnim(entity)
  local animator = not self.previewPlayableAnimator and (not entity or not entity.playableAnimator) and L_CommonUtil.isValid(self.previewHeroModelObj) and L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.previewHeroModelObj)
  if not animator then
    return
  end
  local ok = pcall(function()
    animator:Play("KiboDuelUi")
  end)
  if not ok then
    pcall(function()
      animator:Play("FormationIdle")
    end)
  end
end

function this:setHeroAdmission(heroEntity, heroConfigId, callback)
  if not heroEntity or not L_CommonUtil.isValid(heroEntity.gameObject) then
    if callback then
      callback()
    end
    return
  end
  local entity = heroEntity
  local heroGameObject = entity:getGameObject()
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), heroGameObject)
  if not animator then
    if callback then
      callback()
    end
    return
  end
  animator:CrossFade("FormationAdmission", 0, -1, 0, 0)
  if callback then
    local aniState = animator:GetState("FormationAdmission")
    if aniState then
      self.aniCallbackTimer = Timer.once(aniState.length, callback, self, self.gameObject)
    else
      callback()
    end
  end
  self:_fetchEffectModel(heroConfigId, heroGameObject)
end

function this:_fetchEffectModel(heroConfigId, heroGameObject)
  if not heroConfigId or not L_CommonUtil.isValid(heroGameObject) then
    return
  end
  local tpl = _heroTpl:getTplById(heroConfigId)
  if not tpl then
    return
  end
  local elementId = _heroTpl:getElement(tpl)
  local tpl_ele = _elementTpl:getTplById(elementId)
  if not tpl_ele then
    return
  end
  local path = _elementTpl:getAdmissioneffects(tpl_ele)
  if type(path) ~= "string" or path == "" then
    return
  end
  local effectObj = L_ResPool:syncGameObject(path)
  if not L_CommonUtil.isValid(effectObj) then
    return
  end
  local targetTrans = heroGameObject.transform.childCount > 0 and heroGameObject.transform:GetChild(0) or heroGameObject.transform
  effectObj.transform:SetParent(targetTrans)
  L_Vector3.setLocalPos(effectObj.transform, L_Vector3.zero)
  effectObj:ActiveTrans(true)
end

function this:updatePreviewHeroName(heroConfigId)
  local tplData = _heroTpl:getTplById(heroConfigId)
end

function this:findChildByNameDeep(root, targetName)
  if not root or string.isEmpty(targetName) then
    return nil
  end
  local direct = root:Find(targetName)
  if direct then
    return direct
  end
  local queue = {root}
  local idx = 1
  while idx <= #queue do
    local node = queue[idx]
    idx = idx + 1
    for i = 0, node.childCount - 1 do
      local child = node:GetChild(i)
      if child.name == targetName then
        return child
      end
      table.insert(queue, child)
    end
  end
  return nil
end

function this:disableAllColliders(targetGo)
  if not L_CommonUtil.isValid(targetGo) then
    return
  end
  local colliders = targetGo:GetComponentsInChildren(typeof(CS.UnityEngine.Collider), true)
  if colliders then
    for i = 0, colliders.Length - 1 do
      local c = colliders[i]
      if c then
        c.enabled = false
      end
    end
  end
  local colliders2D = targetGo:GetComponentsInChildren(typeof(CS.UnityEngine.Collider2D), true)
  if colliders2D then
    for i = 0, colliders2D.Length - 1 do
      local c2 = colliders2D[i]
      if c2 then
        c2.enabled = false
      end
    end
  end
end

function this:recycleLoaderObject(obj)
  if not L_CommonUtil.isValid(obj) then
    return
  end
  local recycled = false
  if C_PrefabManager and C_PrefabManager.RecycleByLoader then
    recycled = pcall(function()
      C_PrefabManager:RecycleByLoader(obj)
    end)
  end
  if not recycled and L_CommonUtil.isValid(obj) then
    CS.UnityEngine.GameObject.Destroy(obj)
  end
end

function this:destroyHeroEntity(entity)
  if entity then
    entity:onDestroy()
  end
end

function this:cleanupHeroModel()
  self._previewLoadToken = tonumber(self._previewLoadToken) or 0
  if self.previewIdleTimer then
    Timer.remove(self.previewIdleTimer)
    self.previewIdleTimer = nil
  end
  if self.aniCallbackTimer then
    Timer.remove(self.aniCallbackTimer)
    self.aniCallbackTimer = nil
  end
  if self.sceneLoadTimer then
    Timer.remove(self.sceneLoadTimer)
    self.sceneLoadTimer = nil
  end
  if L_UIModelMgr and L_UIModelMgr.RecycleHeroModel then
    L_UIModelMgr:RecycleHeroModel()
  end
  self:destroyHeroEntity(self.previewHeroEntity)
  self.previewHeroEntity = nil
  self.previewPlayableAnimator = nil
  self.characterAnchorFit = nil
  if self.previewHeroModelHandle then
    pcall(function()
      C_PrefabManager:RecycleByLoader(self.previewHeroModelHandle)
    end)
    self.previewHeroModelHandle = nil
  elseif self._previewHeroModelOwnedByEntity ~= true then
    self:recycleLoaderObject(self.previewHeroModelObj)
  end
  self.previewHeroModelObj = nil
  self._previewHeroModelOwnedByEntity = false
end

function this:startPreviewIdleTimer()
  self:stopPreviewIdleTimer()
  self.previewIdleTimer = Timer.repeated(3, function()
    self:playPreviewRandomIdle()
  end, self, self.gameObject)
end

function this:stopPreviewIdleTimer()
  if self.previewIdleTimer then
    Timer.remove(self.previewIdleTimer)
    self.previewIdleTimer = nil
  end
end

function this:playPreviewRandomIdle()
  local animator = not self.previewPlayableAnimator and (not self.previewHeroEntity or not self.previewHeroEntity.playableAnimator) and L_CommonUtil.isValid(self.previewHeroModelObj) and L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.previewHeroModelObj)
  if not animator then
    return
  end
  local idleAnims = {
    "idle_casual",
    "idle_01",
    "idle_02",
    "idle_special"
  }
  local randomAnim = idleAnims[math.random(1, #idleAnims)]
  animator:Play(randomAnim)
end

function this:refreshHeroList()
  self.heroUidList = self:getAllHeroList()
  local heroListBind = self.bind.leftHeroGrid
  if #self.heroUidList <= 0 then
    if heroListBind then
      heroListBind:clear()
    end
    self:refreshConfirmBtnState()
    return
  end
  self:sortHeroUidList()
  local dataArray = {}
  
  local function onClickHeroCell(cell)
    if self.selectHeroGuid ~= cell.bind.guid then
      self.selectHeroGuid = cell.bind.guid
      self:setHeroListActive()
      self:selectHero(self.selectHeroGuid)
      self:refreshConfirmBtnState()
    end
  end
  
  for _, uid in ipairs(self.heroUidList) do
    local heroInfo = L_HeroStore:getHero(uid)
    if heroInfo then
      local heroConfigId = L_HeroStore:getHeroConfigId(heroInfo)
      local heroItem = L_ItemTplManager:getHeroItem(heroConfigId)
      table.insert(dataArray, {
        itemType = L_Const.resType.hero,
        guid = uid,
        dataSrc = buildDisplayHeroData(heroInfo),
        star = L_HeroStore:getHeroStar(heroInfo),
        lv = L_HeroStore:getHeroLevel(heroInfo),
        ignorePet = true,
        quality = heroItem.quality or 0,
        callback = onClickHeroCell,
        isSelect = uid == self.selectHeroGuid
      })
    end
  end
  if heroListBind then
    pcall(function()
      heroListBind:clear()
    end)
    pcall(function()
      heroListBind:insert_array(dataArray)
    end)
  end
  self:setHeroListActive()
  self:refreshConfirmBtnState()
end

function this:getAllHeroList()
  local list = {}
  for _, heroData in pairs(L_HeroStore:getAllHero()) do
    local heroGuid = L_HeroStore:getHeroGuid(heroData)
    if heroGuid and 0 < heroGuid then
      table.insert(list, heroGuid)
    end
  end
  return list
end

function this:sortHeroUidList()
  table.sort(self.heroUidList, function(a, b)
    if a == self.displayHeroGuid and b ~= self.displayHeroGuid then
      return true
    end
    if b == self.displayHeroGuid and a ~= self.displayHeroGuid then
      return false
    end
    local heroA = L_HeroStore:getHero(a)
    local heroB = L_HeroStore:getHero(b)
    if not heroA or not heroB then
      return b < a
    end
    local cfgIdA = L_HeroStore:getHeroConfigId(heroA)
    local cfgIdB = L_HeroStore:getHeroConfigId(heroB)
    return cfgIdA > cfgIdB
  end)
end

function this:setHeroListActive()
  local heroListModules = self.modules.leftHeroGrid
  for idx, cellModule in pairs(heroListModules or {}) do
    if cellModule and cellModule.setSelectState then
      cellModule:setSelectState(cellModule.bind.guid == self.selectHeroGuid)
    end
  end
end

function this:close(options)
  self._isClosing = true
  if L_CommonUtil.isValid(self.previewHeroModelObj) then
    self.previewHeroModelObj:SetActive(false)
  end
  if L_CommonUtil.isValid(self.sceneObj) then
    self.sceneObj:SetActive(false)
  end
  self:cleanupHeroModel()
  if self.sceneLoadHandle then
    pcall(function()
      C_PrefabManager:RecycleByLoader(self.sceneLoadHandle)
    end)
    self.sceneLoadHandle = nil
  end
  self.sceneObj = nil
  local heroListBind = self.bind.leftHeroGrid
  if heroListBind then
    heroListBind:clear()
  end
  self.selectHeroGuid = -1
  self.heroUidList = {}
  self.modelRootTrans = nil
  self.heroParentTrans = nil
  self.previewCameraTrans = nil
  self._previewInitializing = false
  this.super.close(self, options)
end

return this
