local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local SIGN_IN_CFG = require("gamelogic.sign_in.sign_in_cfg")
local icon_path_prefix = "Icon/item/%s"
local already_received_alpha = 0.2
local unreceived_alpha = 1

function M:set_data(src_data)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local item_icon = ucom.ItemIcon_img
  local amount = ucom.Amount_txt
  local day_num = ucom.DayNum_txt
  local select_btn = self:get_button(nil, nil)
  local done_obj = uobj.Done
  local choose_obj = uobj.Choose
  local amount_layout_obj = uobj.AmountBg
  local item_effect_obj = uobj.ItemEffect
  local icon_path = string.format(icon_path_prefix, src_data.item_cfg.Icon)
  local idx = src_data.idx
  local state = src_data.state
  local is_sign = src_data.is_sign
  local num = src_data.num
  local today_num = src_data.sign_data.MonthSignDay
  ResMgr:load_set_icon(item_icon, icon_path)
  amount.text = num
  day_num.text = today_num
  choose_obj:SetActive(false)
  if state == SIGN_IN_CFG.SIGN_ITEM_STATE.PRE_DAY then
    done_obj:SetActive(true)
  elseif state == SIGN_IN_CFG.SIGN_ITEM_STATE.TODAY then
    if is_sign then
      if SignInMgr:is_change_sign_in_state() then
        item_effect_obj:SetActive(true)
        SignInMgr:reset_change_sign_in_state()
      end
      done_obj:SetActive(true)
    else
      done_obj:SetActive(false)
    end
  elseif state == SIGN_IN_CFG.SIGN_ITEM_STATE.FOLLOW_DAY then
    done_obj:SetActive(false)
  end
  self:set_button_listener(select_btn, function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECTED_SING_IN_REWARD)
    msg.mm_obj = src_data
  end)
  self.v_idx = idx
end

function M:on_clear()
  self:unbind_all_auto_mq()
end

function M:set_selected(is_select)
  self.v_uiobjects.Choose:SetActive(is_select)
end

return M
