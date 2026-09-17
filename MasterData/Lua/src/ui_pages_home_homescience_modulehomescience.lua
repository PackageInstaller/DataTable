local this = class("moduleHomeScience", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self._flyExpItems = {}
end

function this.bind()
  return {ani_exp = ""}
end

function this.methods()
  return {}
end

function this:created(obj, config)
  this.super.created(self, obj, config)
end

function this:open()
  self._flyParent = self.bindComponents.expFlyNode
  self._curveX = self.bindComponents.curveHolder.curves[0]
  self._curveY = self.bindComponents.curveHolder.curves[1]
  L_ReddotManager:registerReddot(self.bindComponents.trans_reddot, L_ReddotManager.DotDef.HomeScience)
  L_HomeManager:addListener(L_HomeManager.event.cropPlayExp, self.onPlayCropExp, self)
end

function this:unBind()
  this.super.unBind(self)
end

function this:close(options)
  this.super.close(self, options)
  L_ReddotManager:unregisterReddot(self.bindComponents.trans_reddot, L_ReddotManager.DotDef.HomeScience)
  L_TimerManager:clearTimer(self)
  self:killExpTween()
  L_HomeManager:removeListener(L_HomeManager.event.cropPlayExp, self.onPlayCropExp, self)
end

function this:killExpTween()
  if self._tweenCore then
    self._tweenCore:Kill()
  end
end

local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local _worldToScreen = Unity.RectTransformUtility.WorldToScreenPoint

function this:onPlayCropExp(params)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.homeScience) then
    return
  end
  self:addExpFly(params.pos, params.num)
end

function this:addExpFly(worldPos, num)
  local screenPosition = _worldToScreen(C_CameraManager.mainCamera, worldPos)
  local _, uiPos = _screenPosToUI(self._flyParent, screenPosition, C_CameraManager.uiCamera)
  num = math.clamp(num, 1, 10)
  for i = 1, num do
    local item = self:getFlyItem()
    item:ActiveTrans(false)
    local rot = math.random(0, 360)
    item.transform:Find("Root"):SetEulerAngles(0, 0, -rot)
    item.transform:Find("Root/Item"):SetEulerAngles(0, 0, rot)
    local rawImg = item.transform:Find("Root/Item/Icon"):GetComponent(typeof(C_LRawImage))
    rawImg.uvRect = C_Rect(math.random(0, 2) * 0.33, math.random(0, 2) * 0.33, 0.33, 0.33)
    local scale = math.random(95, 105) / 100
    local rectTrans = item:GetComponent(typeof(Unity.RectTransform))
    L_Vector3.setAnchored(rectTrans, uiPos)
    L_Vector3.setScale(rectTrans, {
      x = scale,
      y = scale,
      z = 1
    })
    L_TimerManager:newOrResetTimer(self, tostring(item), function()
      item:ActiveTrans(true)
      local dt = 0.165 / num
      L_TimerManager:newOrResetTimer(self, tostring(item) .. "tween", function()
        rectTrans:DOLocalMoveX(0, 1.667 - dt * (num - i)):SetTarget(item):SetEase(self._curveX)
        item.transform:Find("Root"):DOLocalRotate(L_Vector3.zero, 1)
        rectTrans:DOLocalMoveY(0, 1.667):SetTarget(item):SetEase(self._curveY).onComplete = function()
          self:returnFlyItem(item)
        end
      end, 0.333)
      L_TimerManager:newOrResetTimer(self, tostring(item) .. "done", function()
        if i < num then
          self.bind.ani_exp = "anim_homelevel_lvbg_add"
        end
        if i == num then
          self.bind.ani_exp = "anim_homelevel_lvbg_addout"
        end
      end, 1.5 + 0.6 / (num - 1) * (i + 1))
    end, i * 0.033)
  end
end

function this:getFlyItem()
  local count = #self._flyExpItems
  if 0 < count then
    local item = self._flyExpItems[count]
    table.remove(self._flyExpItems, count)
    return item
  else
    local itemFly = C_UIMgr.uiLoader:Spawn("UI/UIEffect/Home/pre_cell_expFly.prefab", self._flyParent)
    return itemFly
  end
end

function this:returnFlyItem(item)
  L_TimerManager:newOrResetTimer(self, tostring(item), function()
    item:ActiveTrans(false)
    table.insert(self._flyExpItems, item)
  end, 0.5)
end

return this
