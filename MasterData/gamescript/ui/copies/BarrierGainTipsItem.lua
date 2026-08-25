local Animation = typeof(CS.UnityEngine.Animation)
local BarrierGainTipsItem, Super = System.NewComponent("BarrierGainTipsItem")

function BarrierGainTipsItem:ctor(res, configId, desc)
  Super.ctor(self)
  self.ui = Function_ReliqueCount_TipsResource(res)
  self.configId = Vue.ref(configId)
  self.desc = Vue.ref(desc)
  self.isPlayingAnim = false
  self.animation = self.ui.uiNode:GetComponent(Animation)
  self.animTime = self.animation:GetClip("UA_Battle_Relique_Tips").length
end

function BarrierGainTipsItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Icon, function()
    if 0 == self.configId.value then
      return ""
    end
    local config = ItemDataUtils.GetItemConfig(self.configId.value)
    if not config then
      Logger.Debug("config not found, configId  ========> " .. self.configId.value)
      return
    end
    return config.Icon
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    if 0 == self.configId.value then
      return self.desc.value
    end
    local config = ItemDataUtils.GetItemConfig(self.configId.value)
    if not config then
      Logger.Debug("config not found, configId  ========> " .. self.configId.value)
      return
    end
    local str = string.format("%s", self.desc.value)
    if config.Type == CommonDefine.ItemType.TopBarItem then
      str = self.desc.value
    end
    return str
  end)
end

function BarrierGainTipsItem:Reset(configId, desc)
  self.configId.value = configId
  self.desc.value = desc
end

function BarrierGainTipsItem:PlayAnim()
  if self.isPlayingAnim then
    return
  end
  self.isPlayingAnim = true
  if self.animation then
    self.animation:Play("UA_Battle_Relique_Tips")
  end
  self:SetAnimTimer()
end

function BarrierGainTipsItem:SetAnimTimer()
  self.timer = TimerManager.Instance:CreateTimer(self.animTime, 1, nil, function()
    self.isPlayingAnim = false
    TimerManager.Instance:StopTimer(self.timer)
    self.timer = nil
  end)
end

return BarrierGainTipsItem
