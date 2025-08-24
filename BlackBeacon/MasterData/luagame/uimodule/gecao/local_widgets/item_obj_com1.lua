local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local Item_Helper = require("utils.item_helper")

function M:set_data(data)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local item_btn = self:get_button(nil, self.go)
  self:set_button_listener(item_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.ItemId,
      jump_cb = function()
        UIMgr:try_hide_ui("gecao_award_tip")
      end
    })
  end)
  local ItemQuality_img = ucom.ItemQuality_img
  ResMgr:load_set_icon(ItemQuality_img, UtilUI.get_item_quality_icon(data.ItemId))
  local ItemIcon_img = ucom.ItemIcon_img
  ResMgr:load_set_icon(ItemIcon_img, UtilUI.get_item_icon(data.ItemId))
  local ItemAmount_obj = uobj.ItemAmount
  ItemAmount_obj:SetActive(data.Num > 1)
  local ItemNum_txt = ucom.ItemNum_txt
  ItemNum_txt.text = data.Num
end

function M:on_clear()
end

return M
