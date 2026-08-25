local CS = _ENV.CS
local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local CommonSideTipsItem, Super = System.NewComponent("CommonSideTipsItem")

function CommonSideTipsItem:ctor(uiNode, data, posIndex)
  Super.ctor(self)
  self.ui = Popup_Public_Tip_3Resource(uiNode)
  self.data = data
  self.posIndex = posIndex
  if self.posIndex == nil or self.posIndex < 1 or self.posIndex > 3 then
    self.posIndex = 1
  end
  self.isPlayingAnim = false
  self.playCb = nil
end

function CommonSideTipsItem:OnBind(binder)
  self.binder = binder
  self.animator = self.ui.uiNode:GetComponent(typeof(Animator))
  self:SetAnimEndBehavior()
  local icon = self.data.icon or ""
  binder:SetImage(self.ui.Image_Icon, icon)
  binder:SetActive(self.ui.Image_Icon, "" ~= icon)
  local desc = self.data.desc or ""
  binder:SetText(self.ui.Text_Bubble_Info, desc)
end

function CommonSideTipsItem:SetAnimEndBehavior()
  local function animCb()
    if self.playCb then
      self.playCb()
    end
    self.isPlayingAnim = false
  end
  
  local animName = "pos_" .. self.posIndex
  AnimatorUtils.SetStateEndInBehavior(self.animator, animName, function()
    animCb()
  end)
end

function CommonSideTipsItem:PlayAnim()
  if self.isPlayingAnim then
    return
  end
  local stateName = "Base Layer.UA_Public_Tip_Level3_" .. self.posIndex
  AnimatorUtils.PlayState(self.animator, stateName)
  self.isPlayingAnim = true
end

function CommonSideTipsItem:SetPlayCallback(callback)
  self.playCb = callback
end

return CommonSideTipsItem
