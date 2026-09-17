local this = class("cellPhotoEditStampImg")

function this:init(obj, onClick)
  self.gameObject = obj
  self.rect = self.gameObject:GetComponent(typeof(C_RectTransform))
  self.img = self.gameObject:GetComponent(typeof(C_LImage))
  self.btn = self.gameObject:GetComponent(typeof(C_LButton))
  self.btn.onClick:AddListener(function()
    onClick(self.rect)
  end)
  local width = self.img.sprite.rect.size.x
  local height = self.img.sprite.rect.size.y
  self.rect.sizeDelta = C_Vector2(width, height)
end

function this:refresh()
end

function this:destroy()
  self.btn.onClick:RemoveAllListeners()
  if self.gameObject ~= nil then
    C_BoundGameObject.Destroy(self.gameObject)
  end
end

return this
