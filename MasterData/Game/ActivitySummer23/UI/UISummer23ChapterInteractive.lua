local UISummer23ChapterInteractive = class("UISummer23ChapterInteractive", UIBaseWindow)
local base = UIBaseWindow
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local UINSummer23ChapterInteractItem = require("Game.ActivitySummer23.UI.UINSummer23ChapterInteractItem")

function UISummer23ChapterInteractive:OnInit()
  self.interItem = UINSummer23ChapterInteractItem.New()
  self.interItem:Init(self.ui.obj_interactiveIcon)
end

function UISummer23ChapterInteractive:InitSummer23Interactive(carnival23Data, entityDic, isActClose)
  self.carnival23Data = carnival23Data
  self._entityDic = entityDic
  self._entityHalfSize = self.interItem.transform.sizeDelta / 2
  if isActClose then
    self:SetActClose()
    return
  end
  self:InitInterItem()
  self:UpdateInteractive()
end

function UISummer23ChapterInteractive:InitInterItem()
  for i, entity in pairs(self._entityDic) do
    local actFrameId = self.carnival23Data:GetActFrameId()
    local cfgList = ConfigData.activity_chapter_interact[actFrameId]
    local isOpen = false
    local openCfg
    for i = #cfgList, 1, -1 do
      local cfg = cfgList[i]
      if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
        if cfg.obj_id == entity:GetLbInteractEntityId() then
          isOpen = true
          openCfg = cfg
          break
        end
        isOpen = false
        break
      end
    end
    if isOpen ~= false then
      self.openCfg = openCfg
      self.targetEntity = entity
      self.interItem:SetSummer23InteractiveItemEntt(entity)
      self.interItem:RefreshSummer23InteractiveItem(openCfg, self.carnival23Data)
      break
    end
  end
end

function UISummer23ChapterInteractive:UpdateInteractive()
  if self.isActClose then
    return
  end
  local halfScreenX = UIManager.BackgroundStretchSize.x / 2
  local halfScreenY = UIManager.BackgroundStretchSize.y / 2
  local halfScreenXLeft, halfScreenYTop = ActLbUtil.GetActLvFlowUIPosConstraint()
  local camPos = UIManager:GetMainCamera().transform.position
  local uiScaleMin, uiScaleMax, camDisMin, camDisMax = ActLbUtil.GetActLbFlowUIScaleParam()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local targetTransform = self.targetEntity:GetLbIntrctEntiUIPintTransform()
  local posX, posY, back = UIManager:World2UIPositionOut(targetTransform)
  posY = posY + actLbCtrl.actLbCamCtrl:GetAcbLbFollowUIPosOffset() * 0.5
  local xOutLeftScreen = posX + self._entityHalfSize.x * uiScaleMin < -halfScreenXLeft
  local xOutRightScreen = halfScreenX < posX - self._entityHalfSize.x * uiScaleMin
  local yOutDownScreen = posY + self._entityHalfSize.y * uiScaleMin < -halfScreenY or back
  local yOutUpScreen = halfScreenYTop < posY - self._entityHalfSize.y * uiScaleMin
  local outScreen = xOutLeftScreen or xOutRightScreen or yOutUpScreen or yOutDownScreen
  local closeAni = false
  if outScreen then
    closeAni = true
    self.interItem:CloseAllAni()
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
    self.interItem:SetArrowOpen(arrowDir)
  else
    self.interItem:SetArrowClose()
  end
  local itemWidth = self.interItem:GetInteractiveItemWidth()
  posX, posY = ActLbUtil.ConstrantActLvFlowUIPos(posX, posY, itemWidth)
  self.interItem.transform.anchoredPosition = Vector2.Temp(posX, posY)
  self.interItem.transform.localScale = Vector3.one * size
end

function UISummer23ChapterInteractive:SetActClose()
  self.isActClose = true
  self.interItem.transform.gameObject:SetActive(false)
end

function UISummer23ChapterInteractive:SetInfoBoardOpen(objId, bool)
  if self.interItem and self.openCfg and self.openCfg.obj_id == objId then
    self.interItem:SetInfoBoardOpen(bool)
  end
end

function UISummer23ChapterInteractive:OnDelete()
end

return UISummer23ChapterInteractive
