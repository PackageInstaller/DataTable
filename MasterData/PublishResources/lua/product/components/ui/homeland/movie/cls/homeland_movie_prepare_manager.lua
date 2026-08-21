_class("HomelandMoviePrepareManager", Singleton)
HomelandMoviePrepareManager = HomelandMoviePrepareManager
_class("HomelandMovieItemData", Object)
HomelandMovieItemData = HomelandMovieItemData

function HomelandMovieItemData:Constructor(phase, titleId, itemId, req, Object)
  self._phase = phase
  self._titleId = titleId
  self._itemId = itemId
  self._itemReq = req
  self._itemObject = Object
  self._animReq = nil
  self:Init()
  self._effectPlayed = false
end

function HomelandMovieItemData:StartTimerFun()
  if not self._anim then
    return
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  self._timeInter = 100
  self._loopTime = 0
  self._timer = GameGlobal.Timer():AddEventTimes(self._timeInter, TimerTriggerCount.Infinite, self.CheckAnimation, self)
  self:PlayAnim(AirPetAnimName.Click)
  self:ShowEffect()
end

function HomelandMovieItemData:CheckAnimation()
  if not self._anim then
    return
  end
  self._loopTime = self._loopTime + self._timeInter
  if self._loopTime > 10000 then
    self:PlayAnim(AirPetAnimName.Click)
    self:ShowEffect()
  end
  local stateInfo = self._anim:get_Item(AirPetAnimName.Click)
  if stateInfo.normalizedTime >= 0.92 then
    self:PlayAnim(AirPetAnimName.Stand)
    if self.clickEff then
      self.clickEff:SetActive(false)
      self._effectPlayed = false
    end
    self._loopTime = 0
  end
end

function HomelandMovieItemData:PlayAnim(name)
  self._anim:CrossFade(name, 0.2)
end

function HomelandMovieItemData:Init()
  self._rootPoint = "Root"
  if self._phase == MoviePrepareType.PT_Actor then
    self._rootPoint = "Root"
  else
    self._rootPoint = "meshroot"
  end
  local cfgAll = Cfg.cfg_homeland_movice_item({})
  local itemCfg = cfgAll[self._titleId]
  if itemCfg then
    self._itemType = itemCfg.Type
    for i = 1, #itemCfg.SelectList do
      if self._itemId == itemCfg.SelectList[i][1] then
        self._itemMatchRate = itemCfg.SelectList[i][2]
        if itemCfg.Offset and self._itemObject then
          self._rotationAngles = itemCfg.Offset[i] or 0
        end
        break
      end
    end
  end
  self:AddBoxCollider()
  self._skinID = self._itemId
  self.clickEffCfg = Cfg.cfg_aircraft_click_eff[self._skinID]
  if self.clickEffCfg and self.clickEffCfg.EffName then
    self.clickEffReq = ResourceManager:GetInstance():SyncLoadAsset(self.clickEffCfg.EffName .. ".prefab", LoadType.GameObject)
    self.clickEff = self.clickEffReq.Obj
    self.clickEff.transform.localScale = Vector3.one
    local cfgPos = self.clickEffCfg.PosOffset
    self.clickEffOffset = Vector3(cfgPos[1], cfgPos[2], cfgPos[3])
  end
end

function HomelandMovieItemData:AddBoxCollider()
  if not self._itemObject then
    return
  end
  if self._phase == MoviePrepareType.PT_Actor then
    local root = GameObjectHelper.FindChild(self._itemObject.transform, "Bip001")
    if root == nil then
      return
    end
    local collider = root.transform.gameObject:AddComponent(typeof(UnityEngine.BoxCollider))
    local cfg = Cfg.cfg_homeland_pet[self._itemId]
    if not cfg then
      Log.error("cfg_homeland_pet Not Exist:", self._itemId)
    end
    local size = Vector3(cfg.BoxSize[1], cfg.BoxSize[3], cfg.BoxSize[2])
    collider.size = size
    collider.center = Vector3(0, 0, 0)
    self._collider = collider
  else
    self._collider = self._itemObject:GetComponent(typeof(UnityEngine.BoxCollider))
    if not self._collider then
      self._collider = self._itemObject:AddComponent(typeof(UnityEngine.BoxCollider))
    end
  end
end

function HomelandMovieItemData:GetCollider()
  return self._collider
end

function HomelandMovieItemData:EnableCollider(enable)
  if self._collider then
    self._collider.enabled = enable
  end
end

function HomelandMovieItemData:OnClick()
  if HomelandMoviePrepareManager:GetInstance():GetPhaseType() == self._phase then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMoviePrepareItemsSelected, self._phase, self._titleId, self._itemId)
    HomelandMoviePrepareManager:GetInstance():HideAllOutline(self._phase)
    self:ShowOutline(true)
    self:StartTimerFun()
  end
end

function HomelandMovieItemData:GetTitleId()
  return self._titleId
end

function HomelandMovieItemData:GetItemId()
  return self._itemId
end

function HomelandMovieItemData:GetPhase()
  return self._phase
end

function HomelandMovieItemData:GetItemObject()
  return self._itemObject
end

function HomelandMovieItemData:GetItemType()
  return self._itemType
end

function HomelandMovieItemData:GetItemMatchRate()
  return self._itemMatchRate
end

function HomelandMovieItemData:ShowOutline(show)
  if not self._itemObject then
    return
  end
  local root = GameObjectHelper.FindChild(self._itemObject.transform, self._rootPoint)
  if root then
    local outline = root.gameObject:GetComponent(typeof(OutlineComponent))
    if outline then
      outline.enabled = show
    end
  end
end

function HomelandMovieItemData:ShowObject(show)
  if show then
    if not self._timer then
      self._timer = GameGlobal.Timer():AddEventTimes(self._timeInter, TimerTriggerCount.Infinite, self.CheckAnimation, self)
    end
  elseif self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  if self.clickEff then
    self.clickEff:SetActive(show)
  end
  if not self._itemObject then
    return
  end
  self._itemObject:SetActive(show)
end

function HomelandMovieItemData:SetOutlineColor(color)
  if not self._itemObject then
    return
  end
  local root = GameObjectHelper.FindChild(self._itemObject.transform, self._rootPoint)
  if root then
    local outline = root.gameObject:GetComponent(typeof(OutlineComponent))
    if outline then
      outline.outlinColor = color
    end
  end
end

function HomelandMovieItemData:SetAnimation(anim)
  self._anim = anim
end

function HomelandMovieItemData:SetAnimRes(animReq)
  self._animReq = animReq
end

function HomelandMovieItemData:SetEulerAngles()
  if self._rotationAngles and self._itemObject then
    self._itemObject.transform.localEulerAngles = Vector3(0, self._rotationAngles, 0)
  end
end

function HomelandMovieItemData:ShowEffect()
  if self.clickEff and not self._effectPlayed then
    self.clickEff.transform.rotation = self._itemObject.transform.rotation
    self.clickEff.transform.position = self._itemObject.transform.position + self.clickEffOffset
    self.clickEff:SetActive(false)
    self.clickEff:SetActive(true)
    self._effectPlayed = true
  end
end

function HomelandMovieItemData:Dispose()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  if self._itemObject then
    self._itemObject:Destroy()
    self._itemObject = nil
  end
  if self._itemReq then
    self._itemReq:Dispose()
    self._itemReq = nil
  end
  if self._animReq then
    self._animReq:Dispose()
    self._animReq = nil
  end
  if self.clickEffReq then
    self.clickEffReq:Dispose()
    self.clickEffReq = nil
  end
end

function HomelandMoviePrepareManager:Constructor()
end

function HomelandMoviePrepareManager:Init(oprateBuilding, movieCfgData)
  self._oprateBuilding = oprateBuilding
  self._movieCfgData = movieCfgData
  self._movieFatherSon = MovieFatherSon:New()
  self._shadowItemName = "5232003.prefab"
  self._selectDataList = {}
  self._shadowDataList = {}
  self._selectedIds = {}
  self._selectSceneBuildings = {}
  self._homelandMoviePrepareItemBtnClick = GameHelper:GetInstance():CreateCallback(self._MoviePrepareItemBtnClick, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIHomelandMoviePrepareItemBtnClick, self._homelandMoviePrepareItemBtnClick)
  self._homelandMoviePrepareTitleBtnClick = GameHelper:GetInstance():CreateCallback(self._MoviePrepareTitleBtnClick, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self._homelandMoviePrepareTitleBtnClick)
  self._homelandMoviePrepareSelectBtnClick = GameHelper:GetInstance():CreateCallback(self._MoviePrepareSelectBtnClick, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIHomelandMovieSelectBtnClick, self._homelandMoviePrepareSelectBtnClick)
end

function HomelandMoviePrepareManager:Dispose()
  if self._oprateBuilding then
    local co = self._oprateBuilding._go:GetComponent(typeof(UnityEngine.BoxCollider))
    co.enabled = true
  end
  if self._homelandMoviePrepareItemBtnClick then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIHomelandMoviePrepareItemBtnClick, self._homelandMoviePrepareItemBtnClick)
    self._homelandMoviePrepareItemBtnClick = nil
  end
  if self._homelandMoviePrepareTitleBtnClick then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self._homelandMoviePrepareTitleBtnClick)
    self._homelandMoviePrepareTitleBtnClick = nil
  end
  if self._homelandMoviePrepareSelectBtnClick then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIHomelandMovieSelectBtnClick, self._homelandMoviePrepareSelectBtnClick)
    self._homelandMoviePrepareSelectBtnClick = nil
  end
  self:ClearAll()
  self._selectDataList = {}
end

function HomelandMoviePrepareManager:SetPhaseType(phase)
  self._phaseType = phase
  self:EnableCollider(phase)
end

function HomelandMoviePrepareManager:GetPhaseType()
  return self._phaseType
end

function HomelandMoviePrepareManager:EnableCollider(phase)
  if self._oprateBuilding then
    local co = self._oprateBuilding._go:GetComponent(typeof(UnityEngine.BoxCollider))
    co.enabled = false
  end
  for index, value in pairs(self._selectSceneBuildings) do
    local co = value._go:GetComponent(typeof(UnityEngine.BoxCollider))
    co.enabled = phase == MoviePrepareType.PT_Scene
  end
  local data = self:GetSelectedData(MoviePrepareType.PT_Actor)
  for k, v in ipairs(data) do
    v:EnableCollider(phase == MoviePrepareType.PT_Actor)
  end
  data = self:GetSelectedData(MoviePrepareType.PT_Prop)
  for k, v in ipairs(data) do
    v:EnableCollider(phase == MoviePrepareType.PT_Prop)
  end
end

function HomelandMoviePrepareManager:WorldToScreenPoint(camera, pos)
  if camera ~= nil and pos ~= nil then
    return camera:WorldToScreenPoint(pos)
  end
  return Vector2.zero
end

function HomelandMoviePrepareManager:ScreenPointToLocalPointInRectangle(rect, camera, pos)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, pos, camera, nil)
  return res, pos
end

function HomelandMoviePrepareManager:CheckItemUsing(phase, itemId)
  if not self._selectDataList[phase] then
    return false
  end
  for key, value in pairs(self._selectDataList[phase]) do
    if value[1] and value[1]:GetItemId() == itemId then
      return true
    end
  end
  return false
end

function HomelandMoviePrepareManager:GetFirstTitleAndItem(phase)
  if not self._selectDataList[phase] then
    return nil, nil
  end
  local titles = self._movieCfgData:GetMovieItemTitleById(MoviePrepareData:GetInstance():GetMovieId(), phase)
  if #titles == 0 then
    return nil, nil
  end
  for key, value in pairs(self._selectDataList[phase]) do
    for k, v in pairs(value) do
      if v:GetPhase() == MoviePrepareType.PT_Scene and v:GetTitleId() == titles[1] then
        self._selectSceneBuildings[v:GetItemId()]:ShowOutline()
        return v:GetTitleId(), v:GetItemId()
      elseif v:GetTitleId() == titles[1] then
        v:OnClick()
        return v:GetTitleId(), v:GetItemId()
      end
    end
  end
  return nil, nil
end

function HomelandMoviePrepareManager:ClearShadowObject()
  for key, value in pairs(self._shadowDataList) do
    for k, v in pairs(value) do
      v:Dispose()
    end
  end
  self._shadowDataList = {}
end

function HomelandMoviePrepareManager:CreateShadowObject(movieId, phase, title)
  self:ClearShadowObject()
  local titles = self._movieCfgData:GetMovieItemTitleById(movieId, phase)
  if not self._shadowDataList[phase] then
    self._shadowDataList[phase] = {}
  end
  if phase == MoviePrepareType.PT_Scene then
  else
    for i = 1, #titles do
      local effectReq = ResourceManager:GetInstance():SyncLoadAsset(self._shadowItemName, LoadType.GameObject)
      local effectObj = effectReq.Obj
      self:SetPosition(titles[i], effectObj)
      local itemdata = HomelandMovieItemData:New(phase, titles[i], self._shadowItemName, effectReq, effectObj)
      self._shadowDataList[phase][titles[i]] = itemdata
      if self._selectDataList[phase] and self._selectDataList[phase][titles[i]] then
        local haveItem = #self._selectDataList[phase][titles[i]] > 0
        itemdata:ShowObject(not haveItem)
      end
    end
  end
end

function HomelandMoviePrepareManager:CheckHadSelect(phase, titleId)
  if self._selectDataList[phase] and self._selectDataList[phase][titleId] then
    local haveItem = #self._selectDataList[phase][titleId] > 0
    return haveItem
  end
  return false
end

function HomelandMoviePrepareManager:ShowShadowObject(phase, titleId, bShow)
  if not self._shadowDataList[phase] then
    return
  end
  if phase == MoviePrepareType.PT_Scene then
  else
    if not titleId then
      for index, value in pairs(self._shadowDataList[phase]) do
        value:ShowObject(bShow)
      end
      return
    end
    for index, value in pairs(self._shadowDataList[phase]) do
      if value:GetTitleId() == titleId then
        value:ShowObject(bShow)
      end
    end
  end
end

function HomelandMoviePrepareManager:_CreateActorObject(phase, titleId, selectData)
  local obj, dataItem = self:InsertItemObject(phase, titleId, selectData[1])
  self:SetPosition(titleId, obj)
  local rootTrans = obj.transform:Find("Root")
  local root = rootTrans.gameObject
  for i = 0, rootTrans.childCount - 1 do
    local child = rootTrans:GetChild(i)
    if string.find(child.name, "weapon") then
      child.gameObject:SetActive(false)
    end
  end
  local petHomePrefab = HelperProxy:GetInstance():GetPetAnimatorControllerName(selectData[1] .. ".prefab", PetAnimatorControllerType.Aircraft)
  if petHomePrefab then
    local petHomelandAnimReq = ResourceManager:GetInstance():SyncLoadAsset(petHomePrefab, LoadType.GameObject)
    dataItem:SetAnimRes(petHomelandAnimReq)
    local animator = root:GetComponent(typeof(UnityEngine.Animator))
    if animator then
      UnityEngine.Object.Destroy(animator)
    end
    local petAnim = root:AddComponent(typeof(UnityEngine.Animation))
    dataItem:SetAnimation(petAnim)
    local homelandAnimation = petHomelandAnimReq.Obj:GetComponent("Animation")
    local clips = HelperProxy:GetInstance():GetAllAnimationClip(homelandAnimation)
    for i = 0, clips.Length - 1 do
      if clips[i] == nil then
        Log.error("Pet animation is null:", self._petID, ", index:", i)
      else
        petAnim:AddClip(clips[i], clips[i].name)
      end
    end
    dataItem:StartTimerFun()
  end
  local outLine = root.gameObject:GetComponent(typeof(OutlineComponent))
  if not outLine then
    outLine = root.gameObject:AddComponent(typeof(OutlineComponent))
    outLine.downSample = 1
    outLine.blurNum = 3
    outLine.outlinColor = Color(0.23921568627450981, 0.5882352941176471, 1.0, 1)
    outLine.intensity = 3.5
    outLine.outlineSize = 1.93
    outLine.blendType = OutlineComponent.BlendType.Blend
    outLine.enabled = true
  end
  return obj
end

function HomelandMoviePrepareManager:_CreateItemObject(phase, titleId, selectData)
  local cfg = self._movieCfgData:GetArchitectureItemCfg(selectData[1])
  local obj, itemdata = self:InsertItemObject(phase, titleId, cfg.ID)
  if not obj then
    return
  end
  self:SetPosition(titleId, obj)
  itemdata:SetEulerAngles()
  local rootPath = "meshroot"
  local rootTrans = GameObjectHelper.FindChild(obj.transform, rootPath)
  local root = rootTrans.gameObject
  local outLine = root.gameObject:GetComponent(typeof(OutlineComponent))
  if not outLine then
    outLine = root.gameObject:AddComponent(typeof(OutlineComponent))
    outLine.downSample = 1
    outLine.blurNum = 3
    outLine.outlinColor = Color(0.23921568627450981, 0.5882352941176471, 1.0, 1)
    outLine.intensity = 3.5
    outLine.outlineSize = 1.93
    outLine.blendType = OutlineComponent.BlendType.Blend
    outLine.enabled = true
  end
  return obj
end

function HomelandMoviePrepareManager:SetPosition(titleId, obj)
  local hangPointCfg = self._movieCfgData:GetMovieItemByItemId(titleId)
  local posinfo = hangPointCfg.HangPoint
  local pathRoot = self._oprateBuilding:Transform():Find("MoviePath")
  local parent = pathRoot:Find(posinfo)
  obj.transform:SetParent(parent)
  obj.transform.localPosition = Vector3(0, 0, 0)
  obj.transform.localRotation = Quaternion.identity
  obj.transform.localScale = Vector3(1, 1, 1)
  obj.gameObject:SetActive(true)
end

function HomelandMoviePrepareManager:ClearAll(phase)
  if not phase then
    self:ClearObjectsByPhase(MoviePrepareType.PT_Prop)
    self:ClearObjectsByPhase(MoviePrepareType.PT_Actor)
    return
  end
  self:ClearObjectsByPhase(phase)
  self:ShowShadowObject(phase, nil, true)
end

function HomelandMoviePrepareManager:ShowAll(show)
  local hideTag = {
    MoviePrepareType.PT_Actor,
    MoviePrepareType.PT_Prop
  }
  for i = 1, #hideTag do
    if self._selectDataList[hideTag[i]] then
      for key, value in pairs(self._selectDataList[hideTag[i]]) do
        for k, v in pairs(value) do
          v:ShowObject(show)
        end
      end
    end
  end
end

function HomelandMoviePrepareManager:ClearObjectsByPhase(phase)
  if not self._selectDataList then
    return
  end
  if not self._selectDataList[phase] then
    return
  end
  if phase == MoviePrepareType.PT_Scene then
    for key, value in pairs(self._selectSceneBuildings) do
      self._movieFatherSon:RemoveBuilding(self._oprateBuilding, value)
    end
    self._selectSceneBuildings = {}
  end
  if self._selectDataList[phase] then
    for key, value in pairs(self._selectDataList[phase]) do
      for k, v in pairs(value) do
        v:Dispose()
      end
    end
  end
  self._selectDataList[phase] = {}
end

function HomelandMoviePrepareManager:_MoviePrepareItemBtnClick(isAdd, phase, titleId, selectData)
  if isAdd then
    if phase == MoviePrepareType.PT_Scene then
      self:_CreateItemObject(phase, titleId, selectData)
    elseif phase == MoviePrepareType.PT_Prop then
      self:_CreateItemObject(phase, titleId, selectData)
    elseif phase == MoviePrepareType.PT_Actor then
      self:_CreateActorObject(phase, titleId, selectData)
    end
  else
    if not self._selectDataList[phase] then
      return
    end
    if phase == MoviePrepareType.PT_Scene then
      local building = self._selectSceneBuildings[selectData[1]]
      self._movieFatherSon:RemoveBuilding(self._oprateBuilding, building)
      self._selectSceneBuildings[selectData[1]] = nil
      self._selectDataList[phase][titleId] = {}
    elseif self._selectDataList[phase][titleId] then
      for i = 1, #self._selectDataList[phase][titleId] do
        self._selectDataList[phase][titleId][i]:Dispose()
      end
      self._selectDataList[phase][titleId] = {}
      self:ShowShadowObject(phase, titleId, #self._selectDataList[phase][titleId] == 0)
    end
  end
  local data = self:GetSelectedData(MoviePrepareType.PT_Actor)
  local cfgData = self._movieCfgData:GetMovieItemTitleById(MoviePrepareData:GetInstance():GetMovieId(), MoviePrepareType.PT_Actor)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMoviePrepareActorSelected, #data > #cfgData)
end

function HomelandMoviePrepareManager:_MoviePrepareTitleBtnClick(titleId, phase)
  self:HideAllOutline(phase)
  if not self._selectDataList[phase] then
    return
  end
  if not self._selectDataList[phase][titleId] then
    return
  end
  for key, value in pairs(self._selectDataList[phase]) do
    for k, v in pairs(value) do
      if v:GetPhase() == MoviePrepareType.PT_Scene and v:GetTitleId() == titleId then
        self._selectSceneBuildings[v:GetItemId()]:ShowOutline()
      elseif v:GetTitleId() == titleId then
        v:OnClick()
      end
    end
  end
end

function HomelandMoviePrepareManager:_MoviePrepareSelectBtnClick(titleId, phase)
  self:HideAllOutline(phase)
end

function HomelandMoviePrepareManager:HomelandMoviePrepareItemSelect(ray)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, 1000)
  local indexTb = {
    MoviePrepareType.PT_Scene,
    MoviePrepareType.PT_Prop,
    MoviePrepareType.PT_Actor
  }
  if castRes then
    local data = self:GetSelectedData(self:GetPhaseType())
    if self:GetPhaseType() == MoviePrepareType.PT_Scene then
      for k, v in ipairs(data) do
        local building = self._selectSceneBuildings[v:GetItemId()]
        if building and hitInfo.collider == building:GetColliders()[1] then
          Log.fatal("点击到：" .. hitInfo.transform.gameObject.name)
          v:OnClick()
          self._selectSceneBuildings[v:GetItemId()]:ShowOutline()
        end
      end
    else
      for k, v in ipairs(data) do
        if hitInfo.collider == v:GetCollider() then
          Log.fatal("点击到：" .. hitInfo.transform.gameObject.name)
          v:OnClick()
        end
      end
    end
  end
end

function HomelandMoviePrepareManager:SetSelectIdByType(phase, titleId, itemId)
  if not self._selectedIds[phase] then
    self._selectedIds[phase] = {}
  end
  self._selectedIds[phase][titleId] = itemId
end

function HomelandMoviePrepareManager:HideAllOutline(phase)
  if not self._selectDataList[phase] then
    return
  end
  for key, value in pairs(self._selectSceneBuildings) do
    value:HideOutline()
  end
  for key, value in pairs(self._selectDataList[phase]) do
    for i = 1, #value do
      value[i]:ShowOutline(false)
    end
  end
end

function HomelandMoviePrepareManager:InsertItemObject(phase, titleId, itemId)
  if not self._selectDataList[phase] then
    self._selectDataList[phase] = {}
  end
  if not self._selectDataList[phase][titleId] then
    self._selectDataList[phase][titleId] = {}
  end
  self:HideAllOutline(phase)
  if #self._selectDataList[phase][titleId] > 0 then
    for i = 1, #self._selectDataList[phase][titleId] do
      self._selectDataList[phase][titleId][i]:Dispose()
    end
    self._selectDataList[phase][titleId] = {}
  end
  local goReq, goObj
  if phase == MoviePrepareType.PT_Scene then
    local building = self._movieFatherSon:AddFixedBuilding(self._oprateBuilding, itemId)
    self._selectSceneBuildings[itemId] = building
    building:ShowOutline()
  else
    goReq = ResourceManager:GetInstance():SyncLoadAsset(itemId .. ".prefab", LoadType.GameObject)
    if not goReq then
      Log.exception("未加载到模型资源  prefabId:" .. itemId)
      return
    end
    goObj = goReq.Obj
  end
  local itemdata = HomelandMovieItemData:New(phase, titleId, itemId, goReq, goObj)
  table.insert(self._selectDataList[phase][titleId], itemdata)
  self:ShowShadowObject(phase, titleId, #self._selectDataList[phase][titleId] == 0)
  return goObj, itemdata
end

function HomelandMoviePrepareManager:InsertShadowObject(phase, titleId, itemId)
  if not self._selectDataList[phase] then
    self._selectDataList[phase] = {}
  end
  if not self._selectDataList[phase][titleId] then
    self._selectDataList[phase][titleId] = {}
  end
  local effectReq, effectObj
  if phase == MoviePrepareType.PT_Scene then
  else
    effectReq = ResourceManager:GetInstance():SyncLoadAsset(itemId .. ".prefab", LoadType.GameObject)
    effectObj = effectReq.Obj
  end
  local itemdata = HomelandMovieItemData:New(phase, titleId, itemId, effectReq, effectObj)
  table.insert(self._selectDataList[phase][titleId], itemdata)
  return effectObj
end

function HomelandMoviePrepareManager:GetOperateBuilding()
  return MoviePrepareData:GetInstance():GetFatherBuild()
end

function HomelandMoviePrepareManager:GetSelectedData(PrepareType)
  local endList = {}
  if not self._selectDataList[PrepareType] then
    return endList
  end
  for key, value in pairs(self._selectDataList[PrepareType]) do
    if value[1] then
      table.insert(endList, value[1])
    end
  end
  return endList
end

function HomelandMoviePrepareManager:GetRequestServerData()
  local selectedItmes, selectedActors = {}, {}
  local data = self:GetSelectedData(MoviePrepareType.PT_Scene)
  for itemId, value in ipairs(data) do
    selectedItmes[value:GetTitleId()] = value:GetItemId()
  end
  data = self:GetSelectedData(MoviePrepareType.PT_Prop)
  for index, value in ipairs(data) do
    selectedItmes[value:GetTitleId()] = value:GetItemId()
  end
  data = self:GetSelectedData(MoviePrepareType.PT_Actor)
  for index, value in ipairs(data) do
    selectedActors[value:GetTitleId()] = value:GetItemId()
  end
  return selectedItmes, selectedActors
end
