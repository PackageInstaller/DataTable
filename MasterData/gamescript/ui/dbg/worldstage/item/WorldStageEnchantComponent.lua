local RectTransform = CS.UnityEngine.RectTransform
local WorldStageEnchantComponent, Super = System.NewComponent("WorldStageEnchantComponent")

function WorldStageEnchantComponent:ctor(res, maskNode, enchantTid, rootGameObject)
  Super.ctor(self)
  self.ui = CardKeyWordItem_NewResource(res)
  self.maskNode = maskNode
  self.enchantConfig = DT.EnchantConfig[enchantTid]
  self.rootGameObject = rootGameObject
end

function WorldStageEnchantComponent:OnBind(binder)
  self.binder = binder
  self.transform = self.ui.uiNode.transform
  binder:BindToText(self.ui.Text_Empty_Name, function()
    return self.enchantConfig.Name
  end)
  binder:BindToText(self.ui.Text_Description, function()
    do return SkillUtils.GetEnchantDesc end
    return SkillUtils.GetEnchantDesc, self.enchantConfig.ID
  end)
  binder:BindToText(self.ui.Text_Creation_Creation, function()
    local enchantTypeMap = {
      Orange = LT.Text("OrangeEnchantConfigTypeName"),
      White = LT.Text("WhiteEnchantConfigTypeName"),
      Red = LT.Text("RedEnchantConfigTypeName")
    }
    return enchantTypeMap[self.enchantConfig.Quality] or ""
  end)
  self:AdjustPosition()
end

function WorldStageEnchantComponent:GetRootPosition()
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(self.rootGameObject.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local Pivot = self.rootGameObject.transform.pivot
  do return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x, localPos.y + (1 - Pivot.y) * rootSize.y, (1 - Pivot.y) * rootSize.y, rootSize.y
end

function WorldStageEnchantComponent:AdjustPosition()
  local rootPosition = self:GetRootPosition()
  local margin = 10
  local rootSizeDelta = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local rootHeight = rootSizeDelta.y
  local sizeDelta = self.ui.uiNode:GetComponent(typeof(RectTransform)).sizeDelta
  self.width = sizeDelta.x
  self.height = sizeDelta.y
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UIwidth = bgWidth < UISize.x and bgWidth or UISize.x
  local UIheight = bgHeight < UISize.y and bgHeight or UISize.y
  if rootPosition.y + self.height + margin > UIheight / 2 then
    rootPosition.y = rootPosition.y - rootHeight - self.height / 2 - margin
  else
    rootPosition.y = rootPosition.y + self.height / 2 + margin
  end
  if rootPosition.x + self.width / 2 > UIwidth / 2 then
    rootPosition.x = rootPosition.x - (self.width / 2 + rootPosition.x + margin + 100 - UIwidth / 2)
  elseif rootPosition.x - self.width / 2 < -UIwidth / 2 then
    rootPosition.x = rootPosition.x + margin + (self.width / 2 - rootPosition.x - UIwidth / 2)
  end
  self.transform.anchoredPosition = rootPosition
end

function WorldStageEnchantComponent:OnMaskClicked()
  self.binder:teardown()
end

return WorldStageEnchantComponent
