local AritcleTriggerComponent, Super = System.NewClass("AritcleTriggerComponent", Component, IUpdater)

function AritcleTriggerComponent:ctor()
  Super.ctor(self)
  self.triggerCondition = {}
  self.isCheck = false
end

function AritcleTriggerComponent:Awake()
  Super.Awake(self)
  self:AddTriggerCondition()
end

function AritcleTriggerComponent:AddTriggerCondition()
  for _, value in ipairs(self.triggerCondition or {}) do
    value:OnExit()
  end
  self.triggerCondition = {}
  local hitBoxInfo = MapManager.Instance:GetNodeHitBoxInfo(DT.MapArticleConfig[self.parent.tid].KeyID)
  if hitBoxInfo then
    local availMap = CommonDefine.AvailTriggerType
    for _, value in ipairs(hitBoxInfo) do
      if availMap[value.type] then
        local pos = self.parent:GetPosition()
        local condition = require("GameScript.World.Map.HitBox.HitBox" .. value.type .. "Condition")()
        condition:Awake(value, {
          x = pos.x,
          y = pos.y,
          z = pos.z
        }, self.parent.uid, self.parent:GetGameObject(), CommonDefine.TriggerItems.Article)
        condition:OnEnter()
        table.insert(self.triggerCondition, condition)
      else
        Logger.Warn("不存在HitBox类型：" .. value.type)
      end
    end
  end
  self.isCheck = true
end

function AritcleTriggerComponent:DestroyTirggerCondition()
  for _, value in ipairs(self.triggerCondition) do
    value:OnExit()
  end
  self.triggerCondition = {}
  self.isCheck = false
end

function AritcleTriggerComponent:Update()
  Super.Update(self)
  if not self.isCheck and #self.triggerCondition > 0 then
    return
  end
  local ret = false
  for _, value in ipairs(self.triggerCondition) do
    if value:IsRunning() then
      value:Update()
      local success = value:IsSuccess()
      if success then
        ret = true
        break
      end
    end
  end
  if not ret and self.lastInHitbox then
    self.lastInHitbox = false
  end
  local isEnter = false
  for _, value in ipairs(self.triggerCondition) do
    if value:IsClickBox() and value:GetIsEnter() then
      isEnter = true
    end
  end
  if ret then
    local config = DT.MapArticleConfig[self.parent.tid]
    if config.Repeat and 1 == config.Repeat and self.lastInHitbox then
      return
    end
    self:TriggerArticle()
    if 1 ~= config.EveryFrame then
      self.lastInHitbox = true
    end
  end
end

function AritcleTriggerComponent:TriggerArticle()
  local config = DT.MapArticleConfig[self.parent.tid]
  if not config.Repeat or 0 == config.Repeat then
    self:DestroyTirggerCondition()
  end
  MapArticleManager.Instance:TriggerArticle(self.parent.uid)
end

function AritcleTriggerComponent:OnDestroy()
  Super.OnDestroy(self)
  self:DestroyTirggerCondition()
end

return AritcleTriggerComponent
