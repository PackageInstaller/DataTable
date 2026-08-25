local CS = _ENV.CS
local Mathf = CS.UnityEngine.Mathf
local BarrierEventGuideItem, Super = System.NewComponent("BarrierEventGuideItem")

function BarrierEventGuideItem:ctor(res, gear)
  Super.ctor(self)
  self.ui = Func_Course_GuideResource(res)
  self.showDis = Vue.ref(false)
  self.showGuide = Vue.ref(false)
  self.distance = Vue.ref("")
  self.gear = Vue.ref(gear)
end

function BarrierEventGuideItem:OnBind(binder)
  self.binder = binder
  self.transform = self.ui.uiNode.transform
  self.arrowTrans = self.ui.Rotation_Arrow.transform
  binder:BindToImage(self.ui.Image_Course_Guide_Icon, function()
    if self.showDis.value then
      do return DT.GetConstant end
      return DT.GetConstant, "School_Score_Lead_Close"
    end
    do return DT.GetConstant end
    return DT.GetConstant, "School_Score_Lead_Far"
  end)
  binder:BindToVisible(self.ui.Image_Course_Distance_Bg, function()
    return self.showDis.value
  end)
  binder:BindToText(self.ui.Text_Course_Distance, function()
    return self.distance.value
  end)
  binder:BindToRaw(function(_, nowVal)
    binder:SetActive(self.ui.uiNode, nowVal)
  end, function()
    return self.showGuide.value
  end)
end

function BarrierEventGuideItem:SetDistance(distance)
  if not distance or "" == distance then
    self.distance.value = ""
    return
  end
  self.distance.value = distance .. "M"
end

function BarrierEventGuideItem:SetShowGuide(show)
  self.showGuide.value = show
end

function BarrierEventGuideItem:SetShowDis(show)
  self.showDis.value = show
end

function BarrierEventGuideItem:SetArrowRotation(rotation)
  rotation = rotation or 0
  self.arrowTrans.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, rotation)
end

function BarrierEventGuideItem:SetPosition(pos, isAnim)
  local x = pos.x
  local y = pos.y
  if isAnim then
    local now = self.transform.anchoredPosition
    x = Mathf.Lerp(now.x, x, 0.2)
    y = Mathf.Lerp(now.y, y, 0.2)
  end
  self.transform.anchoredPosition = CS.UnityEngine.Vector2(x, y)
end

return BarrierEventGuideItem
