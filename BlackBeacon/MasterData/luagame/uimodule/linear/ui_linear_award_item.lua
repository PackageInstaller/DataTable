local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Item_Helper = require("utils.item_helper")
local ITEM_ICON_PATH = "Icon/Item/"
local bagConfig = require("gamelogic.character.fight_bag_configs")

function ui:set_data(curr_star, cfg)
  self.v_cfg = cfg
  self.v_curr_star = curr_star > cfg.StarNum and cfg.StarNum or curr_star
  local ucom = self.v_uicompents
  ucom.Need_txt.text = cfg.StarNum
  ucom.Now_txt.text = self.v_curr_star
  self:refresh_award(cfg)
end

function ui:refresh_task_item()
  local star_id = self.v_cfg.Id
  local award_state = LinearMgr:get_award_state(star_id)
  local is_can_receive = award_state == Config.CommonDefine.JOURNEY_STATE.COMPLETE
  local is_received = award_state == Config.CommonDefine.JOURNEY_STATE.GAINED
  local objs = self.v_uiobjects
  local coms = self.v_uicompents
  objs.Bg:SetActive(not is_can_receive)
  objs.BgComplete:SetActive(is_can_receive)
  local desc_txt = coms.CtContent_txt
  desc_txt.text = Util.format_str(self.v_cfg.TaskDesc, self.v_cfg.TaskDescParam)
  local color = self.v_parent_ui:get_color(is_can_receive)
  Util.set_color(desc_txt, color)
  local max = self.v_cfg.StarNum
  local now_progress_txt = coms.Now_txt
  now_progress_txt.text = self.v_curr_star
  Util.set_color(now_progress_txt, color)
  local need_progress_text = coms.Need_txt
  need_progress_text.text = max
  Util.set_color(need_progress_text, color)
  local slider_img = coms.CtTaskDone_img
  slider_img.fillAmount = self.v_curr_star / max
  objs.NowText:SetActive(not is_can_receive and not is_received)
  local btn_obj = objs.CtGet
  btn_obj:SetActive(is_can_receive)
  local suc_obj = objs.FinishText
  suc_obj:SetActive(is_received)
  local complete_img = objs.TaskComplete
  complete_img:SetActive(is_received)
  local split = coms.split_txt
  Util.set_color(split, color)
  local finish = objs.FinishMask
  finish:SetActive(false)
  if is_received then
    finish:SetActive(true)
    btn_obj:SetActive(false)
  end
end

function ui:refresh_award(cfg)
  local star_id = cfg.Id
  local award_state = LinearMgr:get_award_state(star_id)
  local item_parent = self.v_uiobjects.AwardContent
  local award_data = ShareRes.get_award_item_data(cfg.AwardGroup)
  for _, data in ipairs(award_data) do
    local award_ui = self.v_parent_ui:get_award_item()
    award_ui.transform:SetParent(item_parent.transform)
    local item_id = data[1]
    local icon_path, quality_path = UtilUI.get_item_images(item_id)
    local quality_img = Util.get_image("CiPz", award_ui)
    self:update_item_img(quality_img, quality_path)
    local icon = Util.get_image("CiItemIcon", award_ui.transform)
    self:update_item_img(icon, icon_path)
    local mask = self:get_child_gameobj("Mask_", award_ui)
    mask.gameObject:SetActive(award_state == Config.CommonDefine.JOURNEY_STATE.GAINED)
    local amount_txt = Util.get_text("AmoBg/CiItemAmount", award_ui)
    amount_txt.text = data[2]
    self:set_button_listener(Util.get_button(nil, award_ui), function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_id,
        jump_cb = self.jump_callback
      })
    end)
  end
  self:set_button_listener(self.v_uicompents.CtGet_btn, function()
    LinearMgr:request_linear_award(star_id)
  end)
end

function ui:update_item_img(icon, path)
  icon.gameObject:SetActive(true)
  ResMgr:load_set_icon(icon, path)
end

return ui
