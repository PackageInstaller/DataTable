local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local FASHION_HELPER = require("uimodule.ui_fashionable_dress.ui_fashion_helper")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_brand_desc = {
    "BrandDesc",
    BIND_TYPE.TEXT
  },
  v_brand_icon = {
    "BrandIcon",
    BIND_TYPE.IMAGE
  },
  v_brand_name = {
    "BrandName",
    BIND_TYPE.TEXT
  },
  v_btn_close = {
    "BtnClose",
    BIND_TYPE.BUTTON
  },
  v_detail_icon = {
    "Detail_Icon",
    BIND_TYPE.IMAGE
  },
  v_painter_name = {
    "PainterName",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(fashion_id, brand_id)
  self.v_fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
  self.v_brand_cfg = ShareRes.get_buddy_fashion_brand(brand_id)
  self.v_brand_id = brand_id
  self:refresh_brand_name()
  self:refresh_painter_name()
  self:refresh_brand_bg_icon()
  self:refresh_brand_icon()
  self:refresh_brand_desc()
end

function ui:ui_on_hide()
  self.v_brand_cfg = nil
  self.v_fashion_cfg = nil
  self.v_brand_id = nil
end

function ui:refresh_brand_name()
  local brand_name = self.v_brand_cfg.TypeName
  self.v_uicompents.BrandName_txt.text = brand_name
end

function ui:refresh_painter_name()
  local painter_name = self.v_fashion_cfg.Painter
  self.v_uicompents.PainterName_txt.text = painter_name
end

function ui:refresh_brand_icon()
  local brand_icon = FASHION_HELPER.get_fashion_brand_icon(self.v_brand_id)
  local brand_img = self.v_uicompents.BrandIcon_img
  ResMgr:load_set_icon(brand_img, brand_icon)
end

function ui:refresh_brand_bg_icon()
  local brand_icon = FASHION_HELPER.get_fashion_brand_bg_icon(self.v_brand_id)
  local brand_img = self.v_uicompents.Detail_Icon_img
  ResMgr:load_set_icon(brand_img, brand_icon)
end

function ui:refresh_brand_desc()
  local brand_desc = self.v_brand_cfg.desc
  self.v_uicompents.BrandDesc_txt.text = brand_desc
end

function ui:ui_on_destroy()
end

return ui
