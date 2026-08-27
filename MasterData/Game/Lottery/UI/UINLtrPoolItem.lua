local UINLtrPoolItem = class("UINLtrPoolItem", UIBaseNode)
local base = UIBaseNode

function UINLtrPoolItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.__OnClickRoot)
  self:ShowLtrPoolItemReddot(false)
end

function UINLtrPoolItem:InitLtrPoolItem(index, ltrPoolData, resLoader, clickFunc)
  self:SetLtrPoolItemIndex(index)
  self.ltrPoolData = ltrPoolData
  local poolCfg = ltrPoolData.ltrCfg
  self.poolCfg = poolCfg
  self.clickFunc = clickFunc
  self.poolId = poolCfg.lottery_id
  self.gameObject.name = tostring(self.poolId)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(poolCfg.name)
  local iconPath = PathConsts:GetLotteryPicPath("PoolIcon/" .. poolCfg.name_path)
  resLoader:LoadABAssetAsync(iconPath, function(texture)
    if texture == nil then
      return
    end
    self.ui.rawImg.texture = texture
  end)
  local navTag = ltrPoolData:GetLotteryDataNavTag()
  local tagName, index = ltrPoolData:GetTagNameAndIconIndex()
  self.ui.tex_State.text = tagName
  self.ui.img_State:SetIndex(index)
  if ltrPoolData:IsLtrPoolLimitTime() then
    self.ui.obj_State:SetActive(true)
  elseif navTag ~= 0 then
    self.ui.obj_State:SetActive(true)
  else
    self.ui.obj_State:SetActive(false)
  end
  local isSpecailUp = ltrPoolData:IsLtrSpecialUp()
  self.ui.tex_Name.color = isSpecailUp and self.ui.color_Sp or Color.white
end

function UINLtrPoolItem:SetLtrPoolItemIndex(index)
  self.index = index
end

function UINLtrPoolItem:__OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self)
  end
end

function UINLtrPoolItem:ShowLtrPoolItemReddot(isShow)
  self.ui.redDot:SetActive(isShow)
end

function UINLtrPoolItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolItem
