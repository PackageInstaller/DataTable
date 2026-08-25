local UIAnimationController = CS.Z1Client.UIAnimationController
local AvgActionShowItemAnim, Super = System.NewClass("AvgActionShowItemAnim", AvgActionBase)

function AvgActionShowItemAnim:ctor(...)
  Super.ctor(self, ...)
  self.vueItemId = Vue.ref(0)
  self.itemGameObj = nil
  self.Icon_Article = nil
  self.itemAnimController = nil
  self.binder:BindToRaw(function(_, isCaption)
    if isCaption then
      self:DoAction(_, 0, function()
      end)
    end
  end, function()
    do return self.avgModel.IsCaption end
    return self.avgModel.IsCaption, self.avgModel
  end)
end

function AvgActionShowItemAnim:DoAction(_, itemId, finishCb)
  itemId = itemId or 0
  if self.vueItemId.value == itemId then
    finishCb()
    return
  else
    self.vueItemId.value = itemId or self.vueItemId.value
    if not self.itemGameObj then
      local asset = self.binder:LoadAsset(CommonRes.StoryItem)
      self.itemGameObj = self.binder:Instantiate(asset, self.ui.Group_Item.transform)
      self.Icon_Article = CS.Framework.GameObjectUtil.FindChildByPath(self.itemGameObj, "Scale/Icon_Article")
      self.itemAnimController = self.itemGameObj:GetComponent(typeof(UIAnimationController))
    end
    self.binder:SetImage(self.Icon_Article, ItemDataUtils.GetItemIcon(self.vueItemId.value))
    local itemAnimStateName = 0 ~= itemId and "Item_Public_Article_danru_vx" or "Item_Public_Article_danchu_vx"
    self.itemGameObj:SetActive(true)
    self.ui.Group_Item_Bg:SetActive(true)
    self.itemAnimController:PlayState(itemAnimStateName, function()
      if 0 == itemId then
        self.itemGameObj:SetActive(false)
        self.ui.Group_Item_Bg:SetActive(false)
      end
      finishCb()
    end)
  end
end

return AvgActionShowItemAnim
