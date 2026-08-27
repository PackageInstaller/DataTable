local UINWarehouseTab = class("UINWarehouseTab", UIBaseNode)
local base = UIBaseNode
local eWareHouseType = require("Game.Warehouse.eWareHouseType")

function UINWarehouseTab:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Page, self, self.OnClickWarehouseTab)
end

function UINWarehouseTab:InitWarehouseTab(warehouseTabCfg, clickAction, resloader)
  self.clickAction = clickAction
  self.warehouseTabCfg = warehouseTabCfg
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.warehouseTabCfg.name)
  self.ui.img_Icon.gameObject:SetActive(false)
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_Warehouse"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self.warehouseTabCfg.icon)
    self.ui.img_Icon.gameObject:SetActive(true)
  end)
  self:SetSelectState(false)
  self:RefreshRedDotState()
end

function UINWarehouseTab:OnClickWarehouseTab()
  if self.clickAction ~= nil then
    self.clickAction(self.warehouseTabCfg.id)
  end
end

function UINWarehouseTab:SetSelectState(flag)
  if self.warehouseTabCfg.id == eWareHouseType.wharehouseType.LimitTimeItem then
    self.ui.img_Buttom.color = flag and self.ui.color_BtnSelected or self.ui.color_SpecialBtnUnSelect
    self.ui.tex_Name.color = flag and self.ui.color_TextSelected or self.ui.color_SpecialTexUnSelect
    self.ui.img_Icon.color = flag and self.ui.color_ImgSelected or self.ui.color_SpecialImgUnSelect
  else
    self.ui.img_Buttom.color = flag and self.ui.color_BtnSelected or self.ui.color_BtnUnSelect
    self.ui.tex_Name.color = flag and self.ui.color_TextSelected or self.ui.color_TextUnSelect
    self.ui.img_Icon.color = flag and self.ui.color_ImgSelected or self.ui.color_ImgUnSelect
  end
end

function UINWarehouseTab:RefreshRedDotState()
  if self.warehouseTabCfg.id == 1 then
    self.ui.blueDot:SetActive(false)
    return
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, self.warehouseTabCfg.id)
  self.ui.blueDot:SetActive(ok and node:GetRedDotCount() > 0)
end

return UINWarehouseTab
