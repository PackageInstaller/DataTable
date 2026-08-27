local UISpring23Interactive = class("UISpring23Interactive", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local UINInteractiveItem = require("Game.ActivitySpring.UI.Interactive.UINSpring23InteractiveItem")
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")

function UISpring23Interactive:OnInit()
  self._resLoader = CS_ResLoader.Create()
end

function UISpring23Interactive:InitSpring23Interactive(springData, entityDic)
  self._springData = springData
  self._springStoryData = self._springData:GetSpringStoryData()
  self._entityDic = entityDic
  self._enttInfoDic = {}
  local prefabName = self._springStoryData:GetInteractUIPrefabName()
  local prefabPath = PathConsts:GetActivityInteractUIPrefab(prefabName)
  self._resLoader:LoadABAssetAsync(prefabPath, BindCallback(self, self._OnLoadedEntityPrefab))
end

function UISpring23Interactive:_OnLoadedEntityPrefab(prefabGo)
  if not self.active then
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

function UISpring23Interactive:UpdateInteractive()
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
    if self._springStoryData:GetIsCanInteractHero(heroId) then
      local targetTransform = entity:GetLbIntrctEntiUIPintTransform()
      local posX, posY, back = UIManager:World2UIPositionOut(targetTransform)
      posY = posY + actLbCtrl.actLbCamCtrl:GetAcbLbFollowUIPosOffset() * 0.5
      local infoItem = self._enttInfoDic[entity]
      local interactCfg, cantTalk = self._springStoryData:GetNowCfgByHeroId(heroId)
      local costNum = self._springStoryData:GetNowHaveExp(interactCfg.id)
      local xOutLeftScreen = posX + self._entityHalfSize.x * uiScaleMin < -halfScreenXLeft
      local xOutRightScreen = halfScreenX < posX - self._entityHalfSize.x * uiScaleMin
      local yOutDownScreen = posY + self._entityHalfSize.y * uiScaleMin < -halfScreenY or back
      local yOutUpScreen = halfScreenYTop < posY - self._entityHalfSize.y * uiScaleMin
      local outScreen = xOutLeftScreen or xOutRightScreen or yOutUpScreen or yOutDownScreen
      local closeAni = false
      if outScreen then
        if cantTalk or costNum < interactCfg.needNum or interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.ranReward then
          if infoItem then
            self.interactiveItemPool:HideOne(infoItem)
            self._enttInfoDic[entity] = nil
          end
          goto lbl_263
        elseif infoItem then
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
      if interactCfg == nil or interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.ranReward or cantTalk then
        infoItem.gameObject:SetActive(false)
      else
        if not cantTalk then
          infoItem.gameObject:SetActive(true)
          infoItem:SetSpring23InteractiveItemEntt(entity)
          infoItem:RefreshSpring23InteractiveItem(interactCfg, costNum, closeAni)
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
        if outScreen and not cantTalk and costNum >= interactCfg.needNum then
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
    ::lbl_263::
  end
end

function UISpring23Interactive:RefreshEntityState(entity)
  if not self.interactiveItemPool then
    return
  end
  local infoItem = self._enttInfoDic[entity]
  local intrctData = entity:GetLbIntrctEntData()
  local heroId = intrctData:GetLbIntrctObjHeroId()
  local interactCfg, cantTalk = self._springStoryData:GetNowCfgByHeroId(heroId)
  if interactCfg == nil then
    return
  end
  if infoItem == nil then
    infoItem = self.interactiveItemPool:GetOne(true)
    self._enttInfoDic[entity] = infoItem
  end
  if not cantTalk then
    infoItem.gameObject:SetActive(true)
    infoItem:RefreshSpring23InteractiveItem(interactCfg, self._springData:GetInteractCostNum())
  else
    infoItem.gameObject:SetActive(false)
  end
end

function UISpring23Interactive:OnCloseSpring23Interactive()
  self:Delete()
end

function UISpring23Interactive:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UISpring23Interactive
