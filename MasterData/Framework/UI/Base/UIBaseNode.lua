UIBaseNode = class("UIBaseNode")

function UIBaseNode:ctor()
  self.gameObject = nil
  self.transform = nil
  self.name = nil
  self.__inited = false
  self.active = false
  self.ui = {}
end

function UIBaseNode:IsNull()
  return IsNull(self.gameObject)
end

function UIBaseNode:Init(root)
  if IsNull(root) or self.__inited then
    return
  end
  self.__inited = true
  self.transform = root.transform
  self.gameObject = root.gameObject
  self.name = self.gameObject.name
  self.active = self.gameObject.activeSelf
  self:OnInit()
  if self.active then
    self:OnShow()
  end
end

function UIBaseNode:Show()
  if self.active then
    return
  end
  self.active = true
  self.gameObject:SetActive(true)
  self:OnShow()
end

function UIBaseNode:Hide()
  if not self.active then
    return
  end
  self.active = false
  self.gameObject:SetActive(false)
  self:OnHide()
end

function UIBaseNode:Delete()
  if self.active then
    self:OnHide()
  end
  self:OnDelete()
end

function UIBaseNode:OnInit()
end

function UIBaseNode:OnShow()
end

function UIBaseNode:OnHide()
end

function UIBaseNode:OnDelete()
  if self.winTween == nil or self.__typeID == nil then
    self:OnDeleteEntity()
  end
end

function UIBaseNode:OnDeleteEntity()
  DestroyUnityObject(self.gameObject)
  self.ui = nil
  self.active = false
  self.gameObject = nil
  self.transform = nil
  self.winTween = nil
end

function UIBaseNode:FindComponent(path, ctype)
  return self.transform:FindComponent(path, ctype)
end

return UIBaseNode
