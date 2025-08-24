local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local item_color = {
  select = {color_str = "484243", alpha = 0.8},
  un_select = {color_str = "F5EDE2", alpha = 0.6}
}

function M:set_data(item_data)
  self.item_data = item_data
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  self:refresh_language_info(item_data, ucom.Title_txt)
  uobj.Choose:SetActive(false)
  uobj.RedPoint:SetActive(false)
  local select_btn = self:get_button(nil, nil)
  self:set_button_listener(select_btn, function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECTED_NOTICE_LOGIN_ITEM)
    msg.mm_obj = self
  end)
  self:set_selected(false)
end

function M:refresh_language_info(item_data, title_txt)
  if not (item_data.is_abroad and item_data.other_language) or 0 == #item_data.other_language then
    title_txt.text = item_data.title
    return
  end
  local is_have = false
  for i, v in pairs(item_data.other_language) do
    if v.language_type == Global.curr_text_language then
      title_txt.text = v.title
      is_have = true
      break
    end
  end
  if not is_have then
    title_txt.text = item_data.title
  end
end

function M:on_clear()
  self:unbind_all_auto_mq()
end

function M:set_selected(is_select)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  uobj.Choose:SetActive(is_select)
  local color_str = item_color.select.color_str
  if not is_select then
    color_str = item_color.un_select.color_str
  end
  uobj.Ani_UINotice_Secte:SetActive(is_select)
  uobj.Ani_UINotice_UnSecte:SetActive(not is_select)
  Util.set_color(ucom.Title_txt, color_str)
end

return M
