local base = UIBaseNode
local UINActCommonMonsterCardLeftNode_TypeItem = class("UINActCommonMonsterCardLeftNode_TypeItem", base)
local ActMonsterCardHelper = require("Game.ActivityFrame.ActivityMonsterCard.ActMonsterCardHelper")
local UINActCommonMonsterCardLeftNode_DesItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardLeftNode_DesItem")

function UINActCommonMonsterCardLeftNode_TypeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.desPool = UIItemPool.New(UINActCommonMonsterCardLeftNode_DesItem, self.ui.obj_Tex_Des, false)
end

function UINActCommonMonsterCardLeftNode_TypeItem:Set_ACMCLNI_Title(isActive)
  local index = isActive and 0 or 1
  self.ui.Tex_BuffTitle:SetIndex(index)
end

function UINActCommonMonsterCardLeftNode_TypeItem:RefreshACMCLNI_CardTypeDes(cardList)
  self.desPool:HideAll()
  if cardList == nil or #cardList == 0 then
    self.ui.NodeEmpty:SetActive(true)
    return
  else
    self.ui.NodeEmpty:SetActive(false)
  end
  local desList = ActMonsterCardHelper.GetShotDesFormCardList(cardList)
  for _, des in ipairs(desList) do
    local desItem = self.desPool:GetOne()
    desItem:Set_ACMCLNID_Des(des)
  end
end

function UINActCommonMonsterCardLeftNode_TypeItem:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardLeftNode_TypeItem
