local base = UIBaseWindow
local UIActLbFollowInfo = class("UIActLbFollowInfo", base)
local UINActLbEntiInfoItem = require("Game.ActivityLobby.UI.FollowInfo.UINActLbEntiInfoItem")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")

function UIActLbFollowInfo:OnInit()
  self._resLoader = CS.ResLoader.Create()
end

function UIActLbFollowInfo:InitActLbFollowInfo(prefabName, entityDic)
  self._entityDic = entityDic
  self._enttInfoDic = {}
  local prefabPath = PathConsts:GetActivityLobbyUIPrefab(prefabName)
  self._resLoader:LoadABAssetAsync(prefabPath, BindCallback(self, self._OnLoadedEntityPrefab))
end

function UIActLbFollowInfo:_OnLoadedEntityPrefab(prefabGo)
  if IsNull(prefabGo) then
    return
  end
  local go = prefabGo:Instantiate(self.ui.interactEntityInfo)
  self._entityHalfSize = go.transform.sizeDelta / 2
  self._enttInfoItemPool = UIItemPool.New(UINActLbEntiInfoItem, go, false)
  self:UpdActLbFollowInfo()
end

function UIActLbFollowInfo:UpdActLbFollowInfo()
  if self._enttInfoItemPool == nil then
    return
  end
  local UICamera = UIManager:GetMainCamera()
  if UICamera == nil then
    return
  end
  local halfScreenX = UIManager.BackgroundStretchSize.x / 2
  local halfScreenY = UIManager.BackgroundStretchSize.y / 2
  local camPos = UICamera.transform.position
  local uiScaleMin, uiScaleMax, camDisMin, camDisMax = ActLbUtil.GetActLbFlowUIScaleParam()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  for objId, entity in pairs(self._entityDic) do
    local targetTransform = entity:GetLbIntrctEntiUIPintTransform()
    if not IsNull(targetTransform) then
      local posX, posY, inCamBack = UIManager:World2UIPositionOut(targetTransform)
      local enttId = entity:GetLbInteractEntityId()
      local infoItem = self._enttInfoDic[enttId]
      if inCamBack or posX + self._entityHalfSize.x * uiScaleMax < -halfScreenX or halfScreenX < posX - self._entityHalfSize.x * uiScaleMax or posY + self._entityHalfSize.y * uiScaleMax < -halfScreenY or halfScreenY < posY - self._entityHalfSize.y * uiScaleMax then
        if infoItem ~= nil then
          self._enttInfoItemPool:HideOne(infoItem)
          self._enttInfoDic[enttId] = nil
        end
      else
        if infoItem == nil then
          infoItem = self._enttInfoItemPool:GetOne()
          self._enttInfoDic[enttId] = infoItem
          infoItem:InitActLbEntiInfoItem(entity)
          infoItem.gameObject.name = tostring(objId)
        end
        local distance = Vector3.Distance(camPos, targetTransform.position)
        local size = Mathf.Lerp(uiScaleMax, uiScaleMin, (distance - camDisMin) / (camDisMax - camDisMin))
        posY = posY + actLbCtrl.actLbCamCtrl:GetAcbLbFollowUIPosOffset()
        infoItem.transform.anchoredPosition = Vector2.Temp(posX, posY)
        infoItem.transform.localScale = Vector3.one * size
      end
    end
  end
end

function UIActLbFollowInfo:UpdActLbFollowInfoItemState()
  for enttId, infoItem in pairs(self._enttInfoDic) do
    infoItem:UpdActLbEntiInfoItemLock()
    infoItem:UpdActLbEntiInfoItemBlueDot()
  end
end

function UIActLbFollowInfo:UpdActLbFollowInfoItemUnlockById(enttId)
  local infoItem = self._enttInfoDic[enttId]
  if infoItem then
    infoItem:UpdActLbEntiInfoItemLock()
  end
end

function UIActLbFollowInfo:UpdActLbFollowInfoItemBludotById(enttId)
  local infoItem = self._enttInfoDic[enttId]
  if infoItem then
    infoItem:UpdActLbEntiInfoItemBlueDot()
  end
end

function UIActLbFollowInfo:UpdUIActLbFollowInfoExternalShowUI()
  for enttId, infoItem in pairs(self._enttInfoDic) do
    infoItem:ExternalShowUI()
  end
end

function UIActLbFollowInfo:GetActLbFollowInfoItem(enttId)
  return self._enttInfoDic[enttId]
end

function UIActLbFollowInfo:OnDelete()
  self._resLoader:Put2Pool()
  self._resLoader = nil
  base.OnDelete(self)
end

return UIActLbFollowInfo
