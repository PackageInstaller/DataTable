local UINSteinsGateVow = class("UINSteinsGateVow", UIBaseNode)
local base = UIBaseNode
local UINSteinsGateVowItem = require("Game.VowSystem.UI.UINSteinsGateVowItem")
local cs_ResLoader = CS.ResLoader

function UINSteinsGateVow:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__OnClickItem = BindCallback(self, self.OnClickItem)
  self._itemPool = UIItemPool.New(UINSteinsGateVowItem, self.ui.obj_item, false)
  self.resLoader = cs_ResLoader.Create()
end

function UINSteinsGateVow:InitSteinsGateVow(heroId, itemList, clickFunc)
  self._heroId = heroId
  self._itemList = itemList
  self._clickFunc = clickFunc
  for index, itemData in ipairs(itemList) do
    local item = self._itemPool:GetOne()
    item:InitItem(itemData, self.__OnClickItem)
    local isSelect = itemData.isSpecialCost and true or false
    item:SetSelect(isSelect)
    if isSelect then
      self:RefreshItemCostData(itemData)
      if self._clickFunc ~= nil then
        self._clickFunc(itemData.isSpecialCost, itemData.itemId)
      end
    end
  end
  self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_VowSignWindow"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    if IsNull(self.transform) then
      return
    end
    for _, item in ipairs(self._itemPool.listItem) do
      item:InitItemSprite(spriteAtlas)
    end
  end)
end

function UINSteinsGateVow:OnClickItem(itemData)
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetSelect(false)
  end
  self:RefreshItemCostData(itemData)
  if self._clickFunc ~= nil then
    self._clickFunc(itemData.isSpecialCost, itemData.itemId)
  end
end

function UINSteinsGateVow:RefreshItemCostData(itemData)
  local itemId = itemData.itemId
  local itemCfg = ConfigData.item[itemId]
  local haveNum = PlayerDataCenter:GetItemCount(itemId)
  self.ui.tex_itemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_itemNeedNum.text = tostring(itemData.costNum)
  self.ui.tex_itemHaveNum.text = tostring(haveNum)
end

function UINSteinsGateVow:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self._itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINSteinsGateVow
