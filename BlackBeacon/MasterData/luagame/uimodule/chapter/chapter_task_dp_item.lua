local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE

function ui:ui_finish_load()
end

function ui:ui_on_hide()
end

function ui:set_data(data, dp_group_id)
  local uobj = self.v_uiobjects
  local ucom = self.v_uicompents
  local get_state = data.get_state
  uobj.HaveGot:SetActive(get_state == TASK_STATE.received)
  uobj.DPBgOn:SetActive(get_state == TASK_STATE.receive)
  uobj.DPBg:SetActive(get_state == TASK_STATE.received)
  uobj.DPBgoff:SetActive(get_state == TASK_STATE.none)
  uobj.DPComplete:SetActive(get_state == TASK_STATE.received)
  uobj.Mask:SetActive(get_state == TASK_STATE.received)
  local award_id = data.AwardId
  local award_num = data.AwardNum
  ucom.DPNum_txt.text = data.NeedDPVal
  ucom.DiItemAmount_txt.text = award_num
  local quality_img = ucom.DiPz_img
  local item_icon_img = ucom.DiItemIcon_img
  local icon_path, quality_path = UtilUI.get_item_images(award_id)
  self:update_item_img(quality_img, quality_path)
  self:update_item_img(item_icon_img, icon_path)
  local item_btn = Util.get_button(nil, self.v_uiobjects.DPItem)
  self:set_button_listener(item_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = award_id})
  end)
  local dp_item_btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(dp_item_btn, function()
    self:click_get_dp_award(dp_group_id, data.Id, award_id)
  end)
end

function ui:update_item_img(icon, path)
  icon.gameObject:SetActive(true)
  ResMgr:load_set_icon(icon, path)
end

function ui:click_get_dp_award(dp_group_id, dp_id)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CLICK_CHAPTER_TASK_ITEM)
  msg.mm_obj = {dp_group_id = dp_group_id, dp_id = dp_id}
end

return ui
