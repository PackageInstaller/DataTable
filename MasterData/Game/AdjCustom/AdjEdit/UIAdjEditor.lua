local UIAdjEditor = class("UIAdjEditor", UIBaseWindow)
local base = UIBaseWindow
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local UINAdjEditorOperation = require("Game.AdjCustom.AdjEdit.UINAdjEditorOperation")
local UINAdjEditorSetBg = require("Game.AdjCustom.AdjEdit.UINAdjEditorSetBg")
local UINAdjEditorSetHero = require("Game.AdjCustom.AdjEdit.UINAdjEditorSetHero")
local UINAdjEditorSetSkin = require("Game.AdjCustom.AdjEdit.UINAdjEditorSetSkin")
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local SkinEnum = require("Game.Skin.SkinEnum")
local CS_ResLoader = CS.ResLoader
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_RenderManager = CS.RenderManager
xlua.private_accessible(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController)
local CS_MessageCommon = CS.MessageCommon

function UIAdjEditor:OnInit()
  UIUtil.SetTopStatus(self, self.CancleAdjEdit)
  UIUtil.AddClickHomeCheckFunc(BindCallback(self, self.__CheckClickTopHome))
  self._adjOperation = UINAdjEditorOperation.New()
  self._adjOperation:Init(self.ui.uINAdjSetEditor)
  self._adjOperation:InitUINAdjEditorOperation(self)
  self._adjOperation:Hide()
  self._adjSetBg = UINAdjEditorSetBg.New()
  self._adjSetBg:Init(self.ui.uINAdjSelectBg)
  self._adjSetBg:InitUINAdjEditorSetBg(self)
  self._adjSetBg:Hide()
  self._adjSetHero = UINAdjEditorSetHero.New()
  self._adjSetHero:Init(self.ui.uINAdjSetHero)
  self._adjSetHero:InitUINAdjEditorSetHero(self)
  self._adjSetHero:Hide()
  self._adjSetSkin = UINAdjEditorSetSkin.New()
  self._adjSetSkin:Init(self.ui.uINAdjSetSkin)
  self._adjSetSkin:InitUINAdjEditorSetSkin(self)
  self._adjSetSkin:Hide()
  self.subType = {
    Operation = 1,
    SetBg = 2,
    SetHero = 3,
    SetSkin = 4
  }
  self._UIStateUpdateFuncDic = {
    [self.subType.Operation] = {
      node = self._adjOperation,
      updateFunc = self._adjOperation.UpdateUINAdjEditorOperation
    },
    [self.subType.SetBg] = {
      node = self._adjSetBg,
      updateFunc = self._adjSetBg.UpdateUINAdjEditorSetBg
    },
    [self.subType.SetHero] = {
      node = self._adjSetHero,
      updateFunc = self._adjSetHero.UpdateUINAdjEditorSetHero
    },
    [self.subType.SetSkin] = {
      node = self._adjSetSkin,
      updateFunc = self._adjSetSkin.UpdateUINAdjEditorSetSkin
    }
  }
  self._adjIndexDic = nil
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    self.newlive2DNode, self.newlive2DUIGroup = homeUI:GetHomeMainL2dParent()
    self.newPicNode = homeUI:GetHomeMainPicParent()
    homeUI:OpenOtherWinWithMainCamera()
  end
  self.__OnHeroSkinUpgrade = BindCallback(self, self._OnHeroSkinUpgrade)
  MsgCenter:AddListener(eMsgEventId.AdjCustomModify, self.__OnHeroSkinUpgrade)
end

function UIAdjEditor:InitUIAdjEditor(adjTeamId, modifyIndex, closeFunc)
  self._adjTeamId = adjTeamId
  self._closeFunc = closeFunc
  self._modifyIndex = modifyIndex
  self._limitCount = ConfigData:GetAdjPresetHeroCount(adjTeamId)
  self._bgId = ConfigData.game_config.defaultBackgroundMain
  self._isL2dOpen = true
  self._teamName = nil
  self._resLoadDic = nil
  self._adjInfoDic = {}
  local adjData = PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(adjTeamId)
  self._adjIndexDic = {}
  local hideL2dDic = PlayerDataCenter.skinData:GetHideL2dDic()
  for skinId, value in pairs(hideL2dDic) do
    self:SetHideLive2dBg(skinId, value)
  end
  local l2dOpenSfxDic = PlayerDataCenter.skinData:GetL2dOpenSfxDic()
  for skinId, value in pairs(l2dOpenSfxDic) do
    self:SetOpenLive2dSfx(skinId, value)
  end
  if adjData == nil then
    PlayerClickCollectManager:BtnClickNumCollect(1012)
    self:__ApplyMainBg()
    self:AdjEditJumpSubNode(self.subType.SetHero)
    return
  end
  PlayerClickCollectManager:BtnClickNumCollect(1011)
  self._bgId = adjData:GetAdjPresetBgId()
  self._isL2dOpen = adjData:GetAdjPresetUseL2d()
  self._teamName = adjData:GetAdjPresetName()
  for index, heroId in ipairs(adjData:GetAdjPresetHeroList()) do
    self._adjIndexDic[index] = heroId
    local heroAdjInfo = adjData:GetAdjPresetElemData(heroId)
    self._adjInfoDic[heroId] = {
      dataId = heroId,
      skinId = heroAdjInfo.skinId,
      size = heroAdjInfo.size
    }
    if heroAdjInfo.pos ~= nil then
      self._adjInfoDic[heroId].pos = {
        heroAdjInfo.pos[1],
        heroAdjInfo.pos[2]
      }
    end
    self:__LoadResource(heroId)
  end
  self:__CheckL2dFirbid()
  if self._adjIndexDic[self._modifyIndex] ~= nil then
    self:AdjEditJumpSubNode(self.subType.Operation)
  else
    self:AdjEditJumpSubNode(self.subType.SetHero)
  end
  self:__ApplyMainBg()
end

function UIAdjEditor:SetAdjEditBg(bgId)
  if self._bgId == bgId then
    return
  end
  self._bgId = bgId
  if self._adjOperation.active then
    self._adjOperation:RefreshAdjOperaBgSelect()
  end
  self:__ApplyMainBg()
end

function UIAdjEditor:__ApplyMainBg()
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl == nil then
    return
  end
  if self._bgId == nil then
    homeCtrl:ResetHomeMainBg()
    return
  end
  local bgCfg = ConfigData.background[self._bgId]
  if bgCfg == nil then
    homeCtrl:ResetHomeMainBg()
    return
  end
  homeCtrl:SetHomeMainEditorBg(bgCfg)
end

function UIAdjEditor:SetAdjEditHero(heroId, isOn)
  if isOn and self._adjInfoDic[heroId] == nil then
    local oriHeroId = self._adjIndexDic[self._modifyIndex]
    if oriHeroId ~= nil then
      self:__UnloadResource(oriHeroId)
      self._adjInfoDic[oriHeroId] = nil
    end
    self._adjIndexDic[self._modifyIndex] = heroId
    local heroData = PlayerDataCenter.heroDic[heroId]
    local defaultSkinId = heroData ~= nil and heroData.skinId or 0
    self._adjInfoDic[heroId] = {dataId = heroId, skinId = defaultSkinId}
    if self:GetAdjMainHeroId() == heroId then
      self:__CheckL2dFirbid()
      if not self._forbidL2d then
        self._isL2dOpen = true
      end
    end
    self:__LoadResource(heroId)
  elseif not isOn and self._adjInfoDic[heroId] ~= nil then
    self._adjIndexDic[self._modifyIndex] = nil
    self._adjInfoDic[heroId] = nil
    self:__UnloadResource(heroId)
  end
end

function UIAdjEditor:SetAdjEditHeroPosition(heroId, vec)
  local data = self._adjInfoDic[heroId]
  if data == nil then
    return
  end
  if vec == nil then
    data.pos = nil
  elseif data.pos ~= nil then
    data.pos[1] = vec.x
    data.pos[2] = vec.y
  else
    data.pos = {
      vec.x,
      vec.y
    }
  end
  self:__AdjustResourceShow(heroId)
end

function UIAdjEditor:ResetAdjEditHeroPostion(heroId)
  local resInfo = self._resLoadDic[heroId]
  if resInfo == nil then
    return
  end
  local adjInfo = self._adjInfoDic[heroId]
  adjInfo.pos = nil
  adjInfo.size = nil
  self:__AdjustResourceShow(heroId)
end

function UIAdjEditor:SetAdjEditHeroScale(heroId, size)
  local data = self._adjInfoDic[heroId]
  if data == nil then
    return
  end
  data.size = size
  if data.size == 1 then
    data.size = nil
  end
  self:__AdjustResourceShow(heroId)
  local limitX, limitY = self:__GetLimitPos(heroId)
  if limitX == nil then
    return
  end
  local obj = self._resLoadDic[heroId].obj
  local pos = obj.transform.localPosition
  pos.x = math.clamp(pos.x, limitX[1], limitX[2])
  pos.y = math.clamp(pos.y, limitY[1], limitY[2])
  if pos ~= obj.transform.localPosition then
    obj.transform.localPosition = pos
    self:__RecordResourceShow(heroId)
  end
end

function UIAdjEditor:SetAdjEditHeroSkin(heroId, skinId)
  local data = self._adjInfoDic[heroId]
  if data == nil then
    return
  end
  if self:__GetHeroDefaultSkinId(heroId) == skinId then
    skinId = 0
  end
  if skinId == data.skinId then
    return
  end
  data.skinId = skinId
  if self:GetAdjMainHeroId() == heroId then
    self:__CheckL2dFirbid()
    if not self._forbidL2d then
      self._isL2dOpen = true
    end
  end
  data.pos = nil
  data.size = nil
  self:__LoadResource(heroId)
end

function UIAdjEditor:SetAdjEditL2dTog(flag)
  if self:IsAdjForbidL2d() then
    return
  end
  if self._isL2dOpen == flag then
    return
  end
  self._isL2dOpen = flag
  local heroId = self:GetAdjMainHeroId()
  if heroId ~= nil then
    if self.usingType == self.subType.Operation or self.usingType == self.subType.SetSkin then
      local data = self._adjInfoDic[heroId]
      data.pos = nil
      local resInfo = self._resLoadDic[heroId]
      if not IsNull(resInfo.obj) then
        data.screenPos = UIManager:GetMainCamera():WorldToScreenPoint(resInfo.obj.transform.position)
      end
    end
    self:__LoadResource(heroId)
  end
end

function UIAdjEditor:SetHideL2dBgTog(heroId, skinId, isHide)
  if self:IsAdjForbidL2d() then
    return
  end
  if self:IsHideLive2dBg(skinId) == isHide then
    return
  end
  self:SetHideLive2dBg(skinId, isHide)
  local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
  self:__RealActiveL2dBg(heroId, isHide, isHideHolight)
end

function UIAdjEditor:SetOpenL2dSfxTog(heroId, skinId, isOpen)
  if self:IsAdjForbidL2d() then
    return
  end
  if self:IsCloseLive2dSfx(skinId) == isOpen then
    return
  end
  self:SetOpenLive2dSfx(skinId, isOpen)
end

function UIAdjEditor:ChangeAdjMainHero()
  if self:GetAdjCurCount() < 2 then
    return
  end
  self._adjIndexDic[1], self._adjIndexDic[2] = self._adjIndexDic[2], self._adjIndexDic[1]
  self._modifyIndex = self._modifyIndex == 1 and 2 or 1
  if self._isL2dOpen then
    local heroId = self._adjIndexDic[2]
    local resInfo = self._resLoadDic[heroId]
    local adjInfo = self._adjInfoDic[heroId]
    adjInfo.pos = nil
    if not IsNull(resInfo.obj) then
      adjInfo.screenPos = UIManager:GetMainCamera():WorldToScreenPoint(resInfo.obj.transform.position)
    end
    self:__LoadResource(heroId)
  end
  self:__AdjustResourceSortOrder()
  self:__CheckL2dFirbid()
  if not self._forbidL2d then
    self._isL2dOpen = true
    local heroId = self._adjIndexDic[1]
    local resInfo = self._resLoadDic[heroId]
    local adjInfo = self._adjInfoDic[heroId]
    adjInfo.pos = nil
    if not IsNull(resInfo.obj) then
      adjInfo.screenPos = UIManager:GetMainCamera():WorldToScreenPoint(resInfo.obj.transform.position)
    end
    self:__LoadResource(heroId)
  end
  if self._adjOperation.active then
    self._adjOperation:RefreshAdjL2DTogGroup()
    self._adjOperation:RefreshAdjOperationHeroMain()
  end
end

function UIAdjEditor:ChangeAdjModifyIndex(index)
  if index ~= self._modifyIndex and 0 < index and index <= self._limitCount then
    self._modifyIndex = index
    if self._adjOperation ~= nil then
      self._adjOperation:RefreshAdjOperationHeroMain()
    end
  end
end

function UIAdjEditor:AdjEditJumpSubNode(subType)
  if self.usingType == self.subType.Operation then
    self:__RecordCache()
  end
  if self._adjOperation.active then
    self:__RegisterLeanTouch(false)
  end
  for uiType, data in pairs(self._UIStateUpdateFuncDic) do
    if uiType == subType then
      data.node:Show()
      data.updateFunc(data.node, self._modifyIndex)
    else
      data.node:Hide()
    end
  end
  if self._adjOperation.active then
    self:__RegisterLeanTouch(true)
  end
  if subType == self.subType.SetSkin then
    self.ui.tex_Title:SetIndex(1)
    self._adjSetSkin:SetUINAdjLastSubType(self.usingType)
  elseif subType == self.subType.SetBg then
    self.ui.tex_Title:SetIndex(2)
  else
    self.ui.tex_Title:SetIndex(0)
  end
  self.usingType = subType
  if self.usingType == self.subType.Operation then
    self:__ClearCache()
  end
end

function UIAdjEditor:__UnloadResource(heroId)
  if self._resLoadDic == nil or self._resLoadDic[heroId] == nil then
    return
  end
  local resInfo = self._resLoadDic[heroId]
  if not IsNull(resInfo.obj) then
    DestroyUnityObject(resInfo.obj)
  end
  resInfo.resloader:Put2Pool()
  self._resLoadDic[heroId] = nil
end

function UIAdjEditor:__LoadResource(heroId)
  self:__UnloadResource(heroId)
  if self._resLoadDic == nil then
    self._resLoadDic = {}
  end
  local resInfo = {
    dataId = heroId,
    resloader = CS_ResLoader.Create()
  }
  self._resLoadDic[heroId] = resInfo
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModel = skinCtr:GetResModel(heroId, self._adjInfoDic[heroId].skinId)
  local skinId = self._adjInfoDic[heroId].skinId
  
  local function Local_TrySetShowStateFunc(go)
    local resInfo = self._resLoadDic[heroId]
    resInfo.oriSize = go.transform.localScale.x
    resInfo.oriPosition = go.transform.localPosition
    self:__AdjustResourceShow(heroId)
    if self._adjOperation.active then
      self._adjOperation:RefreshAdjOperaHeroSize(heroId)
    end
    self:__AdjustResourceSortOrder()
    local adjInfo = self._adjInfoDic[heroId]
    if adjInfo ~= nil and adjInfo.screenPos ~= nil then
      local localPos = TransitionScreenPoint(UIManager:GetMainCamera(), go, adjInfo.screenPos)
      local limitX, limitY = self:__GetLimitPos(heroId)
      if limitX ~= nil then
        localPos.x = math.clamp(localPos.x, limitX[1], limitX[2])
        localPos.y = math.clamp(localPos.y, limitY[1], limitY[2])
      end
      go.transform.localPosition = localPos
      self:__RecordResourceShow(heroId)
      adjInfo.screenPos = nil
    end
  end
  
  PlayerDataCenter.skinData:IsShowSkinOutline(skinId, SkinEnum.fromWhere.adjutant, function(isShowSkinOutline)
    if self._isL2dOpen and heroId == self:GetAdjMainHeroId() and not isShowSkinOutline then
      local isHideBg = self:IsHideLive2dBg(self._adjInfoDic[heroId].skinId)
      local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
      self:__LoadLive2D(resModel, resInfo, Local_TrySetShowStateFunc, isHideBg, isHideHolight)
    else
      self:__LoadPic(resModel, resInfo, Local_TrySetShowStateFunc, skinId)
    end
  end)
end

function UIAdjEditor:__LoadLive2D(resModel, resInfo, callback, isHideBg, isHideHolight)
  local path = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, SkinEnum.fromWhere.adjutant)
  resInfo.resloader:LoadABAssetAsync(path, function(l2dModelAsset)
    if IsNull(self.transform) then
      return
    end
    resInfo.obj = l2dModelAsset:Instantiate(self.newlive2DNode.transform)
    resInfo.obj.transform:SetLayer(LayerMask.UI3D)
    local cs_mouth = resInfo.obj:GetComponent(typeof(CS.Live2D.Cubism.Framework.MouthMovement.CubismMouthController))
    if cs_mouth ~= nil then
      cs_mouth.enabled = false
    end
    resInfo.l2dBinding = {}
    UIUtil.LuaUIBindingTable(resInfo.obj, resInfo.l2dBinding)
    if self.newlive2DUIGroup ~= nil then
      resInfo.l2dBinding.renderController.uiCanvasGroup = self.newlive2DUIGroup
      resInfo.l2dBinding.renderController.SortingLayer = "UI3D"
      resInfo.l2dBinding.renderController.SortingOrder = -900
      resInfo.l2dBinding.renderController.InfluencedByUICanvas = true
      HeroL2dInterationController.ActiveLive2dBg(resInfo.l2dBinding.renderController, not isHideBg)
      HeroL2dInterationController.ActiveLive2dHolight(resInfo.l2dBinding.renderController, not isHideHolight)
    end
    resInfo.l2dBinding.commonPerpectiveHandle:SetRenderCamera(self.newlive2DNode)
    resInfo.l2dBinding.commonPerpectiveHandle:SetL2DPosType("Home", false)
    resInfo.cs_cubismCom = resInfo.obj:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if resInfo.cs_cubismCom ~= nil then
      resInfo.cs_cubismCom.enabled = true
    end
    callback(resInfo.obj)
  end)
end

function UIAdjEditor:__LoadPic(resModel, resInfo, callback, skinId)
  local path
  PlayerDataCenter.skinData:IsShowSkinOutline(skinId, SkinEnum.fromWhere.adjutant, function(isShowSkinOutline)
    if isShowSkinOutline then
      local replaceSkinRes = PlayerDataCenter.skinData:GetSkinOutlineRes(skinId, SkinEnum.getOutLineResType.skinId)
      path = PathConsts:GetCharacterBigImgPrefabPath(replaceSkinRes)
    else
      path = PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, SkinEnum.fromWhere.adjutant)
    end
    resInfo.resloader:LoadABAssetAsync(path, function(prefab)
      if IsNull(self.transform) then
        return
      end
      resInfo.obj = prefab:Instantiate(self.newPicNode.transform)
      resInfo.commonPicCom = resInfo.obj:FindComponent(eUnityComponentID.CommonPicController)
      resInfo.commonPicCom:SetPosType("Home")
      local rawImage = resInfo.obj:FindComponent(eUnityComponentID.RawImage)
      if rawImage ~= nil then
        if isShowSkinOutline then
          rawImage.color = PlayerDataCenter.skinData.outlineColor
        else
          rawImage.color = Color.white
        end
      end
      callback(resInfo.obj)
    end)
  end)
end

function UIAdjEditor:__AdjustResourceShow(heroId)
  if self._resLoadDic[heroId] == nil then
    return
  end
  local resInfo = self._resLoadDic[heroId]
  local obj = resInfo.obj
  if IsNull(obj) then
    return
  end
  local adjInfo = self._adjInfoDic[heroId]
  if adjInfo == nil then
    return
  end
  if adjInfo.pos ~= nil then
    obj.transform.localPosition = Vector3.New(adjInfo.pos[1], adjInfo.pos[2], obj.transform.localPosition.z)
  else
    obj.transform.localPosition = resInfo.oriPosition
  end
  if adjInfo.size ~= nil then
    local size = adjInfo.size * resInfo.oriSize
    obj.transform.localScale = Vector3.New(size, size, size)
  else
    obj.transform.localScale = Vector3.New(resInfo.oriSize, resInfo.oriSize, resInfo.oriSize)
  end
  if self._adjOperation.active then
    self._adjOperation:RefreshAdjOperaHeroSize(heroId)
  end
end

function UIAdjEditor:__RealActiveL2dBg(heroId, isHide, isHideHolight)
  local resInfo = self._resLoadDic[heroId]
  if resInfo == nil then
    return
  end
  if resInfo.l2dBinding == nil then
    return
  end
  local renderController = resInfo.l2dBinding.renderController
  if IsNull(renderController) then
    return
  end
  HeroL2dInterationController.ActiveLive2dBg(renderController, not isHide)
  HeroL2dInterationController.ActiveLive2dHolight(renderController, not isHideHolight)
end

function UIAdjEditor:__RecordResourceShow(heroId)
  local resInfo = self._resLoadDic[heroId]
  if resInfo == nil then
    return
  end
  local go = resInfo.obj
  if IsNull(go) then
    return
  end
  local adjInfo = self._adjInfoDic[heroId]
  if adjInfo == nil then
    return
  end
  local vec = go.transform.localPosition
  if adjInfo.pos == nil then
    adjInfo.pos = {
      vec.x,
      vec.y
    }
  else
    adjInfo.pos[1] = vec.x
    adjInfo.pos[2] = vec.y
  end
  if self._adjOperation.active then
    self._adjOperation:RefreshAdjOperaHeroSize(heroId)
  end
end

function UIAdjEditor:__AdjustResourceSortOrder()
  local heroId = self:GetAdjMainHeroId()
  local resInfo = self._resLoadDic[heroId]
  if resInfo ~= nil and resInfo.obj ~= nil then
    resInfo.obj.transform:SetAsLastSibling()
  end
end

function UIAdjEditor:__GetHeroDefaultSkinId(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg ~= nil then
    return heroCfg.default_skin
  end
end

function UIAdjEditor:__CheckL2dFirbid()
  local mainAdjId = self:GetAdjMainHeroId()
  if mainAdjId == nil then
    self._forbidL2d = true
    self._isL2dOpen = false
    self._l2dLevel = nil
    return
  end
  local heroModifyData = self._adjInfoDic[mainAdjId]
  if heroModifyData == nil or heroModifyData.skinId == nil then
    self._forbidL2d = true
    self._isL2dOpen = false
    self._l2dLevel = nil
    return
  end
  local skinId = heroModifyData.skinId
  if skinId == 0 then
    skinId = self:__GetHeroDefaultSkinId(mainAdjId)
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil or PlayerDataCenter.skinData:GetSkinLive2dLevel(skinId) == 0 then
    self._forbidL2d = true
    self._isL2dOpen = false
    self._l2dLevel = nil
  else
    self._forbidL2d = false
    self._l2dLevel = PlayerDataCenter.skinData:GetSkinLive2dLevel(skinId)
  end
end

function UIAdjEditor:__RegisterLeanTouch(flag)
  if flag then
    if self.__OnFingerDownCallback == nil then
      self.__OnFingerDownCallback = BindCallback(self, self.__OnFingerDown)
      self.__OnFingerUpCallback = BindCallback(self, self.__OnFingerUp)
      self.__OnGestureCallback = BindCallback(self, self.__OnGesture)
    end
    CS_LeanTouch.OnFingerDown("+", self.__OnFingerDownCallback)
    CS_LeanTouch.OnFingerUp("+", self.__OnFingerUpCallback)
    CS_LeanTouch.OnGesture("+", self.__OnGestureCallback)
  elseif self.__OnFingerDownCallback ~= nil then
    CS_LeanTouch.OnFingerDown("-", self.__OnFingerDownCallback)
    CS_LeanTouch.OnFingerUp("-", self.__OnFingerUpCallback)
    CS_LeanTouch.OnGesture("-", self.__OnGestureCallback)
  end
end

function UIAdjEditor:__OnFingerDown(finger)
  if finger.IsOverGui then
    local screenPos = finger.ScreenPosition
    local rayResList = CS_LeanTouch.RaycastGui(screenPos)
    for i = 0, rayResList.Count - 1 do
      if rayResList[i].gameObject.layer == self.gameObject.layer then
        return
      end
    end
  end
  self._touchSelect = nil
  local heroId = self._adjIndexDic[self._modifyIndex]
  if heroId == nil then
    return
  end
  self._dragLimitX, self._dragLimitY = self:__GetLimitPos(heroId)
  if self._dragLimitX == nil then
    return
  end
  self._touchIndex = finger.Index
  self._touchSelect = self._resLoadDic[heroId]
  self._lastTouchPoint = TransitionScreenPoint(UIManager:GetMainCamera(), self._touchSelect.obj, finger.ScreenPosition)
end

function UIAdjEditor:__OnFingerUp(finger)
  if self._touchIndex ~= finger.Index then
    return
  end
  self._touchIndex = nil
  self._touchSelect = nil
  self._lastTouchPoint = nil
  self._dragLimitX = nil
  self._dragLimitY = nil
end

function UIAdjEditor:__OnGesture(fingerList)
  local finger
  for i = 0, fingerList.Count - 1 do
    local item = fingerList[i]
    if item.Index == self._touchIndex then
      finger = item
      break
    end
  end
  if finger == nil or self._touchSelect == nil then
    return
  end
  local dragObj = self._touchSelect.obj
  local pos = TransitionScreenPoint(UIManager:GetMainCamera(), dragObj, finger.ScreenPosition)
  local diffPos = pos - self._lastTouchPoint
  diffPos.z = 0
  local finalPos = dragObj.transform.localPosition + diffPos
  finalPos.x = math.clamp(finalPos.x, self._dragLimitX[1], self._dragLimitX[2])
  finalPos.y = math.clamp(finalPos.y, self._dragLimitY[1], self._dragLimitY[2])
  dragObj.transform.localPosition = finalPos
  self:__RecordResourceShow(self._touchSelect.dataId)
  self._lastTouchPoint = pos
end

function UIAdjEditor:__GetLimitPos(heroId)
  local extra = self._adjInfoDic[heroId].size or 1
  extra = extra - 1
  if extra < 0 then
    extra = 0
  end
  local resInfo = self._resLoadDic[heroId]
  local obj = resInfo.obj
  if IsNull(obj) then
    return nil, nil
  end
  local backgroundStretchSize = Vector2.New(CS.UnityEngine.Screen.width, CS.UnityEngine.Screen.height)
  local minPoint = TransitionScreenPoint(UIManager:GetMainCamera(), obj, Vector2.New(0, 0))
  local maxPoint = TransitionScreenPoint(UIManager:GetMainCamera(), obj, backgroundStretchSize)
  local dragLimitX = {
    minPoint.x,
    maxPoint.x
  }
  table.sort(dragLimitX)
  local dragLimitY = {
    minPoint.y,
    maxPoint.y
  }
  table.sort(dragLimitY)
  local extraLimitY = (dragLimitY[2] - dragLimitY[1]) * extra / 2
  dragLimitY[2] = dragLimitY[2] + resInfo.oriPosition.y + extraLimitY
  dragLimitY[1] = dragLimitY[1] + resInfo.oriPosition.y - extraLimitY
  return dragLimitX, dragLimitY
end

function UIAdjEditor:__RecordCache()
  if self._cacheTable ~= nil then
    table.removeall(self._cacheTable)
  else
    self._cacheTable = {}
  end
  for index, heroId in ipairs(self._adjIndexDic) do
    local heroAdjInfo = self._adjInfoDic[heroId]
    table.insert(self._cacheTable, {
      dataId = heroId,
      skinId = heroAdjInfo.skinId,
      pos = heroAdjInfo.pos,
      size = heroAdjInfo.size,
      isL2d = index == 1 and self._isL2dOpen,
      isHideBg = self:IsHideLive2dBg(heroAdjInfo.skinId),
      isCloseL2dSfx = self:IsCloseLive2dSfx(heroAdjInfo.skinId)
    })
  end
end

function UIAdjEditor:ResetAdjCache()
  local cacheData = self._cacheTable ~= nil and self._cacheTable[self._modifyIndex] or nil
  local heroid = self._adjIndexDic[self._modifyIndex]
  local nowHeroData = heroid ~= nil and self._adjInfoDic[heroid] or nil
  if cacheData == nil then
    if nowHeroData ~= nil then
      self:SetAdjEditHero(nowHeroData.dataId, false)
    end
    return
  end
  if nowHeroData == nil then
    self:SetAdjEditHero(cacheData.dataId, true)
    self:SetAdjEditHeroSkin(cacheData.dataId, cacheData.skinId)
    if self._modifyIndex == 1 then
      self:SetAdjEditL2dTog(cacheData.isL2d)
      self:SetHideL2dBgTog(cacheData.dataId, cacheData.skinId, cacheData.isHideBg)
      self:SetOpenL2dSfxTog(cacheData.dataId, cacheData.skinId, cacheData.isCloseL2dSfx)
    end
    if cacheData.size ~= nil then
      self:SetAdjEditHeroScale(cacheData.size)
    end
    if cacheData.pos ~= nil then
      self:SetAdjEditHeroPosition(Vector2.New(cacheData.pos[1], cacheData.pos[2]))
    end
    return
  end
  if nowHeroData.dataId ~= cacheData.dataId then
    self:SetAdjEditHero(cacheData.dataId, true)
    self:SetAdjEditHeroSkin(cacheData.dataId, cacheData.skinId)
  elseif nowHeroData.skinId ~= cacheData.skinId then
    self:SetAdjEditHeroSkin(cacheData.dataId, cacheData.skinId)
  end
  if self._modifyIndex == 1 then
    self:SetAdjEditL2dTog(cacheData.isL2d)
    self:SetHideL2dBgTog(cacheData.dataId, cacheData.skinId, cacheData.isHideBg)
    self:SetOpenL2dSfxTog(cacheData.dataId, cacheData.skinId, cacheData.isCloseL2dSfx)
  end
  self:SetAdjEditHeroScale(cacheData.dataId, cacheData.size)
  if cacheData.pos ~= nil then
    self:SetAdjEditHeroPosition(cacheData.dataId, Vector2.New(cacheData.pos[1], cacheData.pos[2]))
  else
    self:SetAdjEditHeroPosition(cacheData.dataId, nil)
  end
end

function UIAdjEditor:__ClearCache()
  if self._cacheTable ~= nil then
    table.removeall(self._cacheTable)
  end
end

function UIAdjEditor:GetAdjEditBgId()
  return self._bgId
end

function UIAdjEditor:GetAdjEditAdjIndexDic()
  return self._adjIndexDic
end

function UIAdjEditor:GetAdjEditorAdjInfo(heroId)
  return self._adjInfoDic[heroId]
end

function UIAdjEditor:GetAdjMainHeroId()
  return self._adjIndexDic[1]
end

function UIAdjEditor:GetAdjMainSkinId()
  local heroId = self:GetAdjMainHeroId()
  return self._adjInfoDic[heroId].skinId
end

function UIAdjEditor:GetAdjCurCount()
  return table.count(self._adjInfoDic)
end

function UIAdjEditor:IsAdjForbidL2d()
  return self._forbidL2d
end

function UIAdjEditor:GetAdjL2DOpen()
  return self._isL2dOpen
end

function UIAdjEditor:IsHideLive2dBg(skinId)
  if self._hideLive2dBgTable == nil then
    return false
  end
  return self._hideLive2dBgTable[skinId]
end

function UIAdjEditor:SetHideLive2dBg(skinId, isHide)
  if self._hideLive2dBgTable == nil then
    self._hideLive2dBgTable = {}
  end
  self._hideLive2dBgTable[skinId] = isHide
end

function UIAdjEditor:IsCloseLive2dSfx(skinId)
  if self._isCloseL2dSfxTable == nil then
    return false
  end
  if self._isCloseL2dSfxTable[skinId] == nil then
    return false
  end
  return self._isCloseL2dSfxTable[skinId]
end

function UIAdjEditor:SetOpenLive2dSfx(skinId, isOpen)
  if self._isCloseL2dSfxTable == nil then
    self._isCloseL2dSfxTable = {}
  end
  self._isCloseL2dSfxTable[skinId] = isOpen
end

function UIAdjEditor:GetAdjL2dLevel()
  return self._l2dLevel
end

function UIAdjEditor:GetAdjModifyIndex()
  return self._modifyIndex
end

function UIAdjEditor:IsAdjHeroIdInPreset(heroId)
  return self._adjInfoDic[heroId], self._adjIndexDic[self._modifyIndex] == heroId
end

function UIAdjEditor:IsAdjCacheInModify()
  return self._cacheTable ~= nil and self._cacheTable[self._modifyIndex] ~= nil
end

function UIAdjEditor:SaveAdjEdit()
  if self._adjIndexDic[1] == nil then
    return
  end
  local data = {}
  data.id = self._adjTeamId
  data.name = self._teamName
  data.useL2D = self._isL2dOpen
  data.bgId = self._bgId
  for index = 1, self._limitCount do
    local heroId = self._adjIndexDic[index]
    if heroId ~= nil then
      local elem = {}
      local adjInfo = self._adjInfoDic[heroId]
      elem.heroId = heroId
      elem.skinId = adjInfo.skinId
      elem.posX = adjInfo.pos ~= nil and math.floor(adjInfo.pos[1] * 1000) or 0
      elem.posY = adjInfo.pos ~= nil and math.floor(adjInfo.pos[2] * 1000) or 0
      elem.heroSize = adjInfo.size ~= nil and math.floor(adjInfo.size * 1000) or 0
      local heroCfg = ConfigData.hero_data[heroId]
      if heroCfg ~= nil and elem.skinId == heroCfg.default_skin then
        elem.skinId = 0
      end
      if index == 1 then
        data.mainHero = elem
      else
        data.minorHero = elem
      end
    end
  end
  self:SaveLive2dHideBgValue()
  self:SaveLive2dOpenSfxValue()
  local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
  network:CS_MainInterface_PresetUpdate(data, function()
    UIUtil.PopFromBackStackByUiTab(self)
    self:__QuickUI()
  end)
end

function UIAdjEditor:SaveLive2dHideBgValue()
  if self._hideLive2dBgTable == nil then
    return
  end
  for skinId, isHide in pairs(self._hideLive2dBgTable) do
    if PlayerDataCenter.skinData:IsHideL2dBg(skinId) ~= isHide then
      local heroId = PlayerDataCenter.skinData:GetHeroIdBySkinId(skinId)
      PlayerDataCenter.skinData:UpdateHideL2dBg(heroId, skinId, isHide)
      local network = NetworkManager:GetNetwork(NetworkTypeID.Hero)
      network:CS_HERO_Skin_L2D_Hide(heroId, skinId, isHide, function()
      end)
    end
  end
end

function UIAdjEditor:SaveLive2dOpenSfxValue()
  if self._isCloseL2dSfxTable == nil then
    return
  end
  for skinId, isCloseL2dSfx in pairs(self._isCloseL2dSfxTable) do
    if PlayerDataCenter.skinData:IsCloseLive2dSfx(skinId) ~= isCloseL2dSfx then
      local heroId = PlayerDataCenter.skinData:GetHeroIdBySkinId(skinId)
      PlayerDataCenter.skinData:UpdateOpenLive2dSfx(skinId, isCloseL2dSfx)
      local network = NetworkManager:GetNetwork(NetworkTypeID.Hero)
      network:CS_HERO_Skin_L2D_Audio_Turn(heroId, skinId, isCloseL2dSfx, function()
      end)
    end
  end
end

function UIAdjEditor:_OnHeroSkinUpgrade(teamId)
  if self._adjTeamId ~= teamId then
    return
  end
  local adjData = PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(teamId)
  self:__CheckL2dFirbid()
  if adjData:GetAdjPresetUseL2d() and not self._isL2dOpen and not self._forbidL2d then
    self:SetAdjEditL2dTog(true)
    self._adjOperation:UpdateUINAdjEditorOperation()
  end
end

function UIAdjEditor:CancleAdjEdit(isToHome)
  if isToHome then
    self:__QuickUI()
    return
  end
  CS_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(406), function()
    self:__QuickUI()
  end, function()
    UIUtil.SetTopStatus(self, self.CancleAdjEdit)
    UIUtil.AddClickHomeCheckFunc(BindCallback(self, self.__CheckClickTopHome))
  end)
end

function UIAdjEditor:__CheckClickTopHome(returnCallback)
  CS_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(406), function()
    returnCallback()
  end, nil)
end

function UIAdjEditor:__QuickUI()
  self:Delete()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI:BackFromOtherWinWithMainCamera()
  end
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:ClearRecordMainBg()
  end
  if self._closeFunc ~= nil then
    self._closeFunc()
  end
end

function UIAdjEditor:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomModify, self.__OnHeroSkinUpgrade)
  if self._adjOperation.active then
    self:__RegisterLeanTouch(false)
  end
  base.OnDelete(self)
  for k, data in pairs(self._UIStateUpdateFuncDic) do
    data.node:Delete()
  end
  if self._resLoadDic ~= nil then
    for _, resInfo in pairs(self._resLoadDic) do
      if not IsNull(resInfo.obj) then
        DestroyUnityObject(resInfo.obj)
      end
      resInfo.resloader:Put2Pool()
      resInfo.l2dBinding = nil
      resInfo.cs_CubismInterationController = nil
      resInfo.commonPicCom = nil
    end
    self._resLoadDic = nil
  end
end

return UIAdjEditor
