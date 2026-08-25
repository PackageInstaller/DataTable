local Vector3 = CS.UnityEngine.Vector3
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local BIG_SIZE = 36
local MID_SIZE = 30
local SMALL_SIZE = 26
local BIG_STRING_LIMIT = 68
local MID_STRING_LIMIT = 80
local SMALL_STRING_LIMIT = 98
local textFontSizeMap = {
  [BIG_STRING_LIMIT] = BIG_SIZE,
  [MID_STRING_LIMIT] = MID_SIZE,
  [SMALL_STRING_LIMIT] = SMALL_SIZE
}
local MonsterBubbleItem, Super = System.NewComponent("MonsterBubbleItem")

function MonsterBubbleItem:ctor(uiNode, content, position, awakerPos)
  Super.ctor(self)
  self.uiNode = uiNode
  self.ui = UI_Battle_Item_Monster_BubbleResource(self.uiNode)
  self.content = content
  local local_pos = self.uiNode.transform:InverseTransformPoint(position)
  if awakerPos then
    local_pos = Vector3(local_pos.x, local_pos.y + 50, local_pos.z)
  end
  self.uiNode.transform.localPosition = local_pos
end

function MonsterBubbleItem:OnBind(binder)
  self.binder = binder
  self.binder:LoadAllLangFont(self.ui.Text_Describe)
  self.binder:SetText(self.ui.Text_Describe, LT.Text(self.content))
  self.binder:BindToTextSize(self.ui.Text_Describe, function()
    local rst = SMALL_SIZE
    local strLen = string.len(LT.Text(self.content))
    for len, size in pairs(textFontSizeMap) do
      if len >= strLen then
        rst = size
        break
      end
    end
    return rst
  end)
end

function MonsterBubbleItem:SetActive(active, dontPlayAni)
  if self.ui then
    if dontPlayAni then
      self.ui.uiNode:SetActive(active)
      return
    end
    local animCtrl = self.ui.uiNode:GetComponent(T_UIAnimationController)
    if animCtrl then
      if active then
        self.ui.uiNode:SetActive(true)
        animCtrl:PlayState("UI_Battle_Item_Monster_Bubble_Open")
      else
        animCtrl:PlayState("UI_Battle_Item_Monster_Bubble_Close", function()
          if self.ui then
            self.ui.uiNode:SetActive(false)
          end
        end)
      end
    else
      self.ui.uiNode:SetActive(active)
    end
  end
end

function MonsterBubbleItem:SetText(content)
  if self.ui then
    self.content = content
    self.binder:SetText(self.ui.Text_Describe, LT.Text(content))
  end
end

return MonsterBubbleItem
