local IceCreamOrdersCtrl = class("IceCreamOrdersCtrl", BaseCtrl)
local IceCreamUtils = require("Game.UI.Play_IceCreamTruck.Play.IceCreamUtils")
local SLOT_CONE = IceCreamUtils.EnumSlotType.SLOT_CONE
local SLOT_SCOOP1 = IceCreamUtils.EnumSlotType.SLOT_SCOOP1
local SLOT_SCOOP2 = IceCreamUtils.EnumSlotType.SLOT_SCOOP2
local SLOT_TOPPING = IceCreamUtils.EnumSlotType.SLOT_TOPPING
local SLOT_COUNT = 6
IceCreamOrdersCtrl._mapNodeConfig = {
  imgIcon_ = {nCount = 6, sComponentName = "Image"}
}
IceCreamOrdersCtrl._mapEventConfig = {}

function IceCreamOrdersCtrl:Awake()
end

function IceCreamOrdersCtrl:OnEnable()
end

function IceCreamOrdersCtrl:OnDestroy()
end

function IceCreamOrdersCtrl:InitNewOrder(bIsSpecial)
  self.nCharacterId = nil
  self.nOrderState = IceCreamUtils.EnumOrderState.Null
  self.tbSlots = {}
  for i = 1, SLOT_COUNT do
    self.tbSlots[i] = 0
  end
  self.nScoopCount = 0
  self.nCurrentStep = 0
  self.bHasMistake = false
  self.bSpecialOrder = bIsSpecial or false
end

function IceCreamOrdersCtrl:SetNewOrder(nCharacterId, nMaxScoop, tbUnlockSlot, bIsSpecial)
  self:InitNewOrder(bIsSpecial)
  self.nCharacterId = nCharacterId
  if self.bSpecialOrder then
    self:HideIceCreamIcon()
    return true
  end
  self:RandomOrder(nMaxScoop, tbUnlockSlot, 100)
  if self.tbSlots[1] == 0 then
    return false
  end
  self:CreatIceCreamIcon()
  return true
end

function IceCreamOrdersCtrl:Clear()
  self.nCharacterId = nil
  self.nOrderState = IceCreamUtils.EnumOrderState.Null
  self.nCurrentStep = 0
  self.bHasMistake = false
  self.nScoopCount = 0
  if self.tbSlots then
    for i = 1, SLOT_COUNT do
      self.tbSlots[i] = 0
    end
  end
end

function IceCreamOrdersCtrl:RandomOrder(nMaxScoop, tbUnlockSlot, nToppingChance)
  nMaxScoop = nMaxScoop or 3
  nToppingChance = nToppingChance or 50
  local tbUnlockSlotSet = {}
  for _, value in pairs(tbUnlockSlot or {}) do
    tbUnlockSlotSet[value] = true
  end
  local tbUnlockScoopSet = {}
  local tbUnlockToppingSet = {}
  for i = 3, 6 do
    if tbUnlockSlotSet[i] then
      tbUnlockScoopSet[#tbUnlockScoopSet + 1] = i
    end
  end
  for i = 8, 11 do
    if tbUnlockSlotSet[i] then
      tbUnlockToppingSet[#tbUnlockToppingSet + 1] = i
    end
  end
  for i = 1, SLOT_COUNT do
    self.tbSlots[i] = 0
  end
  self.tbSlots[SLOT_CONE] = math.random(1, 2)
  self.nScoopCount = math.random(1, nMaxScoop)
  for i = 1, self.nScoopCount do
    self.tbSlots[SLOT_SCOOP1 + i - 1] = tbUnlockScoopSet[math.random(1, #tbUnlockScoopSet)]
  end
  if nToppingChance >= math.random(1, 100) then
    self.tbSlots[SLOT_TOPPING] = tbUnlockToppingSet[math.random(1, #tbUnlockToppingSet)]
  end
end

function IceCreamOrdersCtrl:CheckStep(nSlotIndex, nValue)
  if self.tbSlots[nSlotIndex] == nValue and nSlotIndex == (self:GetNextStepIndex() or -1) then
    self.nCurrentStep = nSlotIndex
    if self:IsOrderComplete() then
      self.nOrderState = self.bHasMistake and IceCreamUtils.EnumOrderState.Normal or IceCreamUtils.EnumOrderState.Perfect
    end
    return true
  else
    self.bHasMistake = true
    self.nCurrentStep = 0
    return false
  end
end

function IceCreamOrdersCtrl:SetFeedPG(bFeed)
  if bFeed then
    self.nOrderState = IceCreamUtils.EnumOrderState.Perfect
  else
    self.nOrderState = IceCreamUtils.EnumOrderState.Lose
  end
end

function IceCreamOrdersCtrl:IsSpecialOrder()
  return self.bSpecialOrder
end

function IceCreamOrdersCtrl:GetOrderState()
  return self.nOrderState
end

function IceCreamOrdersCtrl:GetCharacterId()
  return self.nCharacterId
end

function IceCreamOrdersCtrl:GetDisplayIndex(nSlotIndex)
  if not nSlotIndex or not self.tbSlots then
    return nil
  end
  if (self.tbSlots[nSlotIndex] or 0) == 0 then
    return nil
  end
  local n = 0
  for i = 1, nSlotIndex do
    if self.tbSlots[i] ~= 0 then
      n = n + 1
    end
  end
  return n
end

function IceCreamOrdersCtrl:IsOrderComplete()
  for i = 1, SLOT_COUNT do
    if self.tbSlots[i] ~= 0 and i > self.nCurrentStep then
      return false
    end
  end
  return true
end

function IceCreamOrdersCtrl:GetSlots()
  return self.tbSlots
end

function IceCreamOrdersCtrl:IsFresh()
  return (self.nCurrentStep or 0) == 0
end

function IceCreamOrdersCtrl:IsFinished()
  return self:IsOrderComplete() and 0 < (self.nCurrentStep or 0)
end

function IceCreamOrdersCtrl:MarkPerfectComplete()
  self.nCurrentStep = SLOT_COUNT
  self.bHasMistake = false
  self.nOrderState = IceCreamUtils.EnumOrderState.Perfect
end

function IceCreamOrdersCtrl:GetNextStepIndex()
  if self.nCurrentStep == nil then
    self.nCurrentStep = 0
  end
  for i = self.nCurrentStep + 1, SLOT_COUNT do
    if self.tbSlots[i] ~= 0 then
      return i
    end
  end
  return nil
end

function IceCreamOrdersCtrl:CreatIceCreamIcon()
  self:HideIceCreamIcon()
  for step, v in ipairs(self.tbSlots) do
    if v ~= 0 then
      local nDisplay = self:GetDisplayIndex(step)
      if nDisplay ~= nil then
        local IconPath = IceCreamUtils.SetCondimentIcon(step, v)
        if IconPath == "" then
          printError("资源路径是空的")
          NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgIcon_[nDisplay]:GetComponent("CanvasGroup"), 0)
        else
          self:SetActivityAtlasSprite_New(self._mapNode.imgIcon_[nDisplay], "_400020/SpriteAtlas/Item", IconPath)
          NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgIcon_[nDisplay]:GetComponent("CanvasGroup"), 1)
        end
      end
    end
  end
end

function IceCreamOrdersCtrl:HideIceCreamIcon()
  for _, txt in ipairs(self._mapNode.imgIcon_) do
    local canvasGroup = txt:GetComponent("CanvasGroup")
    NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
  end
end

return IceCreamOrdersCtrl
