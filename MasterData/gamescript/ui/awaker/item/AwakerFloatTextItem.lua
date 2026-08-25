local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local RectTransform = CS.UnityEngine.RectTransform
local Vector3 = CS.UnityEngine.Vector3
local AwakerFloatTextItem, Super = System.NewComponent("AwakerFloatTextItem")

function AwakerFloatTextItem:ctor(res, data)
  Super.ctor(self)
  self.ui = E_se_kouxue_zi_NormalResource(res)
  self.animator = self.ui.Anim:GetComponent(typeof(Animator))
  self.transform = self.ui.uiNode:GetComponent(typeof(RectTransform))
  self.data = data
end

AwakerFloatTextItem.VectorZero = Vector3.zero

function AwakerFloatTextItem:OnBind(binder)
  self.binder = binder
  if self.data.parent then
    self.transform:SetParent(self.data.parent, false)
    self.transform.localPosition = AwakerFloatTextItem.VectorZero
  end
  binder:SetText(self.ui.Text, self.data.showText)
  binder:SetActive(self.ui.uiNode, true)
  
  local function OnAnimEnd()
    binder:SetActive(self.ui.uiNode, false)
    if self.data.callback then
      self.data.callback()
    end
  end
  
  AnimatorUtils.SetStateEndInBehavior(self.animator, "shengji", OnAnimEnd)
  AnimatorUtils.SetTrigger(self.animator, "shengji")
end

return AwakerFloatTextItem
