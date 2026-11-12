local GoldenSpyBaseItem = require("Game.UI.Activity.GoldenSpy.GoldenSpyBaseItem")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GoldenSpyBoomItem = class("GoldenSpyBoomItem", GoldenSpyBaseItem)
GoldenSpyBoomItem._mapNodeConfig = {
  BoomArea = {
    sNodeName = "BoomArea",
    sComponentName = "RectTransform"
  },
  Icon = {},
  HitArea = {
    sNodeName = "HitArea",
    sComponentName = "RectTransform"
  },
  Effect_Boom = {}
}
GoldenSpyBoomItem._mapEventConfig = {
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
GoldenSpyBoomItem._mapRedDotConfig = {}

function GoldenSpyBoomItem:Awake()
  self._mapNode.Effect_Boom.gameObject:SetActive(false)
  self.tbTimer = {}
end

function GoldenSpyBoomItem:OnEnable()
end

function GoldenSpyBoomItem:OnDisable()
end

function GoldenSpyBoomItem:OnDestroy()
  for _, v in ipairs(self.tbTimer) do
    if v ~= nil then
      v:Cancel()
    end
  end
  self.tbTimer = {}
end

function GoldenSpyBoomItem:GetHitArea()
  local tr = self.gameObject:GetComponent("RectTransform")
  local hitArea = {
    nType = self.nHitAreaType,
    center = self._mapNode.HitArea.anchoredPosition + tr.anchoredPosition,
    width = self._mapNode.HitArea.sizeDelta.x,
    height = self._mapNode.HitArea.sizeDelta.y
  }
  return hitArea
end

function GoldenSpyBoomItem:GetBoomArea()
  local tr = self.gameObject:GetComponent("RectTransform")
  local boomArea = {
    center = self._mapNode.BoomArea.anchoredPosition + tr.anchoredPosition,
    radius = self._mapNode.BoomArea.sizeDelta.x * 0.5
  }
  return boomArea
end

function GoldenSpyBoomItem:Boom(callback)
  local boomArea = self:GetBoomArea()
  local center = boomArea.center
  local radius = boomArea.radius
  local toHit = {}
  for _, v in ipairs(self.floorCtrl.tbItem) do
    if v.Ctrl and v.Ctrl ~= self then
      local hitArea = v.Ctrl:GetHitArea()
      if hitArea and hitArea.center then
        local offset = hitArea.center - center
        local dist = offset.x * offset.x + offset.y * offset.y
        if dist <= radius * radius then
          table.insert(toHit, v.Ctrl)
        end
      end
    end
  end
  
  local function boom()
    if callback then
      callback()
    end
    for _, ctrl in ipairs(toHit) do
      if ctrl.gameObject ~= nil and ctrl.gameObject.activeSelf ~= false then
        ctrl:OnSkill_Boom(function()
          if ctrl:GetItemCfg().ItemType == GameEnum.GoldenSpyItem.Boom then
            return
          end
          self.floorCtrl:RemoveItem(ctrl, true)
        end)
      end
    end
  end
  
  self._mapNode.Icon:SetActive(false)
  self._mapNode.Effect_Boom.gameObject:SetActive(true)
  local timer = self:AddTimer(1, 0.1, boom, true, true, true)
  table.insert(self.tbTimer, timer)
  local timer2 = self:AddTimer(1, 0.5, function()
    self.gameObject:SetActive(false)
    self.floorCtrl:RemoveItem(self)
  end, true, true, true)
  table.insert(self.tbTimer, timer2)
  WwiseAudioMgr:PostEvent("Mode_steal_boom_big")
  return toHit
end

function GoldenSpyBoomItem:OnSkill_Boom(callback)
  if callback then
    self:Boom()
    callback()
  end
  if self.gameObject then
    self.gameObject:SetActive(false)
  end
end

function GoldenSpyBoomItem:OnSkill_Frozen(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBoomItem:OnSkill_Frozen_Resume(callback)
  if callback then
    callback()
  end
end

function GoldenSpyBoomItem:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.HitArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
  local boomImg = self._mapNode.BoomArea:GetComponent("Image")
  if boomImg then
    boomImg.enabled = true
  end
end

return GoldenSpyBoomItem
