local UINLogicPreviewRowBase = class("UINLogicPreviewRowBase", UIBaseNode)
local base = UIBaseNode
local UINLogicPreviewAttrItemBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewAttrItemBase")

function UINLogicPreviewRowBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:RegisterButtonPress()
end

function UINLogicPreviewRowBase:RegisterButtonPress()
  if self.ui.button ~= nil then
    self.__pressDown = BindCallback(self, self.__onPressDown)
    self.ui.button.onPress:AddListener(self.__pressDown)
    self.__pressUp = BindCallback(self, self.__onPressUp)
    self.ui.button.onPressUp:AddListener(self.__pressUp)
  end
end

function UINLogicPreviewRowBase:InjectPressAndUpFunc(pressDownFunc, pressUpFunc)
  self.__pressDownFunc = pressDownFunc
  self.__pressUpFunc = pressUpFunc
end

function UINLogicPreviewRowBase:InitWithClass(AttrItemClass)
  if self.attrPool == nil then
    AttrItemClass = AttrItemClass or UINLogicPreviewAttrItemBase
    self.ui.tex_Attri:SetActive(false)
    self.attrPool = UIItemPool.New(AttrItemClass, self.ui.tex_Attri)
  end
end

function UINLogicPreviewRowBase:__onPressDown()
  if self.__pressDownFunc ~= nil then
    self.__pressDownFunc()
  end
end

function UINLogicPreviewRowBase:__onPressUp()
  if self.__pressUpFunc ~= nil then
    self.__pressUpFunc()
  end
end

function UINLogicPreviewRowBase:__onReleaseButtonListener()
  if self.ui.button ~= nil then
    if self.__pressDown ~= nil then
      self.ui.button.onPress:RemoveListener(self.__pressDown)
    end
    if self.__pressUp ~= nil then
      self.ui.button.onPressUp:RemoveListener(self.__pressUp)
    end
  end
end

function UINLogicPreviewRowBase:OnDelete()
  self:__onReleaseButtonListener()
  if self.attrPool then
    self.attrPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINLogicPreviewRowBase
