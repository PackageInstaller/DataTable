local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local commonDef = require("cs_share.common_define")
local UI_AWARD_NOTICE_ITEM_KEY = "UI_AWARD_NOTICE_ITEM_KEY"
local _sformat = string.format
local CURSE_BOX_STATE = commonDef.CURSE_BOX_STATE
local icon_path_prefix = "Icon/item/%s"
local Quality_Img = {
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
local BIND_TYPE = Config.BIND_TYPE

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("Button_no", function()
    self:ui_hide()
  end)
  self:set_button("Button_yes", function()
    if self.v_cb then
      self.v_cb()
    end
    self:ui_hide()
  end)
  self:register_exist_auto_template(UI_AWARD_NOTICE_ITEM_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
end

function ui:ui_on_show(tips, award_group_id, cb)
  self.v_cb = cb
  if tips and "" ~= tips then
    self.v_uicompents.Tips_txt.text = tips
  end
  local award_item_id_list = ShareRes.get_award_item_data(award_group_id)
  self:give_back_auto_cache(UI_AWARD_NOTICE_ITEM_KEY)
  for _, award_data in ipairs(award_item_id_list) do
    local item_cfg = ShareRes.get_item_cfg(award_data[1])
    local item_obj = self:get_auto_cache(UI_AWARD_NOTICE_ITEM_KEY)
    local item_quality = Util.get_image("ItemQuality_", item_obj)
    local item_icon = Util.get_image("ItemIcon_", item_obj)
    local item_amount = Util.get_text("ItemAmount_/Bg/ItemNum_", item_obj)
    local item_btn = Util.get_button(nil, item_obj)
    ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
    ResMgr:load_set_icon(item_icon, _sformat(icon_path_prefix, item_cfg.Icon))
    item_amount.text = award_data[2]
    self:set_button_listener(item_btn, function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_cfg.Id
      })
    end)
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
