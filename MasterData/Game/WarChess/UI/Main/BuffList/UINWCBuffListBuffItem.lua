local base = UIBaseNode
local UINWCBuffListBuffItem = class("UINWCBuffListBuffItem", UIBaseNode)
local OnPressScale = Vector3.New(1.5, 1.5, 1)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINWCBuffListBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_buffItem.onPress:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btn_buffItem.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
  self.ui.obj_buffNum:SetActive(false)
end

function UINWCBuffListBuffItem:RefreshWCBuffItem(buffData)
  self.buffData = buffData
  local buffIcon = buffData:GetWCBuffIcon()
  if string.IsNullOrEmpty(buffIcon) then
    return
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(buffIcon, CommonAtlasType.ExplorationIcon)
end

function UINWCBuffListBuffItem:__OnSkillLongPress()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(self.buffData:GetWCBuffName(), self.buffData:GetWCBuffDes())
  win:FloatTo(self.transform, HAType.autoCenter, VAType.down)
  self.transform.localScale = OnPressScale
end

function UINWCBuffListBuffItem:__OnSkillPressUp()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
  self.transform.localScale = Vector3.one
end

function UINWCBuffListBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINWCBuffListBuffItem
