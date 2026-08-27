local UISteinsGate23Interactive = class("UISteinsGate23Interactive", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local UINInteractiveItem = require("Game.Activity23SteinsGate.UI.Interactive.UINSG23InteractiveItem")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")

function UISteinsGate23Interactive:OnInit()
  self._resLoader = CS_ResLoader.Create()
end

function UISteinsGate23Interactive:InitSG23Interactive(sgData, entityDic)
  self._sgData = sgData
  self._sgInteractData = self._sgData:GetSteinsGateInteractData()
  self._entityDic = entityDic
  self._enttInfoDic = {}
  local prefabName = self._sgInteractData:GetInteractUIPrefabName()
  local prefabPath = PathConsts:GetActivityInteractUIPrefab(prefabName)
  self._resLoader:LoadABAssetAsync(prefabPath, BindCallback(self, self._OnLoadedEntityPrefab))
end

function UISteinsGate23Interactive:_OnLoadedEntityPrefab(prefabGo)
  if IsNull(self.transform) then
    return
  end
  if self.interactiveItemPool then
    self.interactiveItemPool:HideAll()
  else
    local go = prefabGo:Instantiate(self.ui.root.transform)
    go.transform.anchoredPosition = Vector2.zero
    self._entityHalfSize = go.transform.sizeDelta / 2
    self.interactiveItemPool = UIItemPool.New(UINInteractiveItem, go, false)
  end
  self:UpdateInteractive()
end

function UISteinsGate23Interactive:UpdateInteractive()
  if not self.interactiveItemPool then
    return
  end
  local halfScreenX = UIManager.BackgroundStretchSize.x / 2
  local halfScreenY = UIManager.BackgroundStretchSize.y / 2
  local halfScreenXLeft, halfScreenYTop = ActLbUtil.GetActLvFlowUIPosConstraint()
  local camPos = UIManager:GetMainCamera().transform.position
  local uiScaleMin, uiScaleMax, camDisMin, camDisMax = ActLbUtil.GetActLbFlowUIScaleParam()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  for i, entity in pairs(self._entityDic) do
    local intrctData = entity:GetLbIntrctEntData()
    local heroId = intrctData:GetLbIntrctObjHeroId()
    local objId = intrctData:GetLbIntrctObjId()
    if self._sgInteractData:GetIsCanInteractHero(heroId) or self._sgInteractData:GetIsCanInteractObj(objId) then
      local targetTransform = entity:GetLbIntrctEntiUIPintTransform()
      local posX, posY, back = UIManager:World2UIPositionOut(targetTransform)
      posY = posY + actLbCtrl.actLbCamCtrl:GetAcbLbFollowUIPosOffset() * 0.5
      local infoItem = self._enttInfoDic[entity]
      local interactCfg, cantTalk = self._sgInteractData:GetNowCfgByHeroIdOrObjId(heroId, objId)
      local xOutLeftScreen = posX + self._entityHalfSize.x * uiScaleMin < -halfScreenXLeft
      local xOutRightScreen = halfScreenX < posX - self._entityHalfSize.x * uiScaleMin
      local yOutDownScreen = posY + self._entityHalfSize.y * uiScaleMin < -halfScreenY or back
      local yOutUpScreen = halfScreenYTop < posY - self._entityHalfSize.y * uiScaleMin
      local outScreen = xOutLeftScreen or xOutRightScreen or yOutUpScreen or yOutDownScreen
      local closeAni = false
      if outScreen and cantTalk then
        if infoItem then
          self.interactiveItemPool:HideOne(infoItem)
          self._enttInfoDic[entity] = nil
        end
        goto lbl_269
      elseif outScreen then
        if infoItem then
          infoItem:CloseAllAni()
          closeAni = true
        else
          closeAni = true
        end
      end
      if infoItem == nil then
        infoItem = self.interactiveItemPool:GetOne(true)
        self._enttInfoDic[entity] = infoItem
      end
      if interactCfg == nil or cantTalk then
        infoItem.gameObject:SetActive(false)
      else
        if not cantTalk then
          infoItem.gameObject:SetActive(true)
          infoItem:SetIsHeroInteractItem(ConfigData.activity_23steinsgate_interact_icon[interactCfg.id] and ConfigData.activity_23steinsgate_interact_icon[interactCfg.id].is_talk or false)
          infoItem:SetSG23InteractiveItemEntt(entity)
          infoItem:RefreshSG23InteractiveItem(interactCfg, closeAni)
        end
        local distance = Vector3.Distance(camPos, targetTransform.position)
        local size = outScreen and 1 or Mathf.Lerp(uiScaleMax, uiScaleMin, (distance - camDisMin) / (camDisMax - camDisMin))
        local arrowScale = 1.5
        if xOutLeftScreen then
          posX = -halfScreenXLeft + self._entityHalfSize.x * size * arrowScale
        elseif xOutRightScreen then
          posX = halfScreenX - self._entityHalfSize.x * size * arrowScale
        end
        if yOutDownScreen then
          posY = -halfScreenY + self._entityHalfSize.y * size * arrowScale
        elseif yOutUpScreen then
          posY = halfScreenYTop - self._entityHalfSize.y * size * arrowScale
        end
        local arrowDir = Vector3.Temp(posX, posY, 0)
        if outScreen and not cantTalk then
          infoItem:SetArrowOpen(arrowDir)
        else
          infoItem:SetArrowClose()
        end
        local itemWidth = infoItem:GetInteractiveItemWidth()
        posX, posY = ActLbUtil.ConstrantActLvFlowUIPos(posX, posY, itemWidth)
        infoItem.transform.anchoredPosition = Vector2.Temp(posX, posY)
        infoItem.transform.localScale = Vector3.one * size
      end
    end
    ::lbl_269::
  end
end

function UISteinsGate23Interactive:RefreshEntityState(entity)
  if not self.interactiveItemPool then
    return
  end
  local infoItem = self._enttInfoDic[entity]
  local intrctData = entity:GetLbIntrctEntData()
  local heroId = intrctData:GetLbIntrctObjHeroId()
  local objId = intrctData:GetLbIntrctObjId()
  local interactCfg, cantTalk = self._sgInteractData:GetNowCfgByHeroIdOrObjId(heroId, objId)
  if interactCfg == nil then
    return
  end
  if infoItem == nil then
    infoItem = self.interactiveItemPool:GetOne(true)
    self._enttInfoDic[entity] = infoItem
  end
  if not cantTalk then
    infoItem.gameObject:SetActive(true)
    infoItem:RefreshSG23InteractiveItem(interactCfg)
  else
    infoItem.gameObject:SetActive(false)
  end
end

function UISteinsGate23Interactive:OnCloseSpring23Interactive()
  self:Delete()
end

function UISteinsGate23Interactive:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UISteinsGate23Interactive
