local UIAnni24Interactive = class("UIAnni24Interactive", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local UINInteractiveItem = require("Game.ActivityAnniversary24.UI.Interactive.UINAnni24InteractiveItem")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")

function UIAnni24Interactive:OnInit()
  self._resLoader = CS_ResLoader.Create()
end

function UIAnni24Interactive:InitAnni24Interactive(actData, entityDic)
  self._entityDic = entityDic
  self.actData = actData
  self._enttInfoDic = {}
  local prefabName = "Spring_Interactive"
  local prefabPath = PathConsts:GetActivityInteractUIPrefab(prefabName)
  self._resLoader:LoadABAssetAsync(prefabPath, BindCallback(self, self._OnLoadedEntityPrefab))
end

function UIAnni24Interactive:_OnLoadedEntityPrefab(prefabGo)
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

function UIAnni24Interactive:UpdateInteractive()
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
    local infoItem = self._enttInfoDic[entity]
    local intrctData = entity:GetLbIntrctEntData()
    local canInteract = not self.actData:GetHeroIsAlReadByObjId(intrctData:GetLbIntrctObjId())
    if not canInteract then
      if infoItem then
        self.interactiveItemPool:HideOne(infoItem)
        self._enttInfoDic[entity] = nil
      end
    else
      local targetTransform = entity:GetLbIntrctEntiUIPintTransform()
      local posX, posY, back = UIManager:World2UIPositionOut(targetTransform)
      posY = posY + actLbCtrl.actLbCamCtrl:GetAcbLbFollowUIPosOffset() * 0.5
      local xOutLeftScreen = posX + self._entityHalfSize.x * uiScaleMin < -halfScreenXLeft
      local xOutRightScreen = halfScreenX < posX - self._entityHalfSize.x * uiScaleMin
      local yOutDownScreen = posY + self._entityHalfSize.y * uiScaleMin < -halfScreenY or back
      local yOutUpScreen = halfScreenYTop < posY - self._entityHalfSize.y * uiScaleMin
      local outScreen = xOutLeftScreen or xOutRightScreen or yOutUpScreen or yOutDownScreen
      local closeAni = false
      if infoItem == nil then
        infoItem = self.interactiveItemPool:GetOne(true)
        self._enttInfoDic[entity] = infoItem
        infoItem:SetSpring24InteractiveItemEntt(entity)
        infoItem:RefreshSpring24InteractiveItem()
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
      if outScreen then
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
end

function UIAnni24Interactive:OnShow()
  base.OnShow(self)
  self:UpdateInteractive()
end

function UIAnni24Interactive:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UIAnni24Interactive
