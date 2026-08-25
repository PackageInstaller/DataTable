local RectTransform = CS.UnityEngine.RectTransform
local ItemDetailTipBase, Super = System.NewComponent("ItemDetailTipBase")

function ItemDetailTipBase.Create(binder, dataSourceType, data, relativeNode)
  local configData
  if dataSourceType == CommonDefine.ItemDataSourceType.Config then
    configData = data
  else
    configData = DT.Item[data.tid]
  end
  local parentNode = UIManager.GetTipPopRoot()
  local detailComp
  if configData.Type == CommonDefine.ItemType.Weapon then
    detailComp = binder:BindNewComponentWithMask(parentNode, Item2DetailTip, UI_Awaker_Item_Weapon_TipResource, dataSourceType, data)
  end
  if relativeNode then
    detailComp:AjustPosition(relativeNode)
  end
  return detailComp
end

function ItemDetailTipBase:ctor(uiNode, uiRes, dataSourceType, data)
  self.ui = uiRes(uiNode)
  self.data = data
  self.dataSourceType = dataSourceType
  if 2 == dataSourceType then
    self.configData = data
    self.runtimeData = Vue.reactive({})
  else
    self.configData = DT.Item[data.tid]
    self.runtimeData = Vue.reactive(data)
  end
end

function ItemDetailTipBase:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Weapon_Icon, function()
    local iconPath = ItemDataUtils.GetItemIcon(self.configData.ID)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Weapon_Name, function()
    do return LT.Text end
    return LT.Text, self.configData.Name
  end)
  binder:BindToImage(self.ui.Image_Bg_Quality, function()
    return DT.ItemQuality[self.configData.Quality].ItemQualityColor
  end)
  local color = "#" .. DT.ItemQuality[self.configData.Quality].ItemTipColor
  binder:SetImageColorByHtml(self.ui.Image_Title_Quality, color)
end

function ItemDetailTipBase:AjustPosition(relativeNode)
  local relativeNodeTransform = relativeNode:GetComponent(typeof(RectTransform))
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(relativeNodeTransform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = relativeNodeTransform.sizeDelta
  local pivot = relativeNodeTransform.pivot
  local rootPosition = CS.UnityEngine.Vector2(localPos.x - pivot.x * rootSize.x, localPos.y + (1 - pivot.y) * rootSize.y)
  local margin = 10
  local rootHeight = rootSize.y
  local sizeDelta = self.ui.uiNode:GetComponent(typeof(RectTransform)).sizeDelta
  self.width = sizeDelta.x
  self.height = sizeDelta.y
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local UIwidth = UISize.x
  local UIheight = UISize.y
  if rootPosition.y + self.height + margin > UIheight / 2 then
    rootPosition.y = rootPosition.y - rootHeight - self.height / 2 - margin
  else
    rootPosition.y = rootPosition.y + self.height / 2 + margin
  end
  if rootPosition.x + self.width / 2 > UIwidth / 2 then
    rootPosition.x = rootPosition.x - (self.width / 2 + rootPosition.x + margin - UIwidth / 2)
  elseif rootPosition.x - self.width / 2 < -UIwidth / 2 then
    rootPosition.x = rootPosition.x + margin + (self.width / 2 - rootPosition.x - UIwidth / 2)
  end
  self.ui.uiNode.transform.anchoredPosition = rootPosition
end

function ItemDetailTipBase:OnMaskClicked()
  self.binder:teardown()
end

return ItemDetailTipBase
