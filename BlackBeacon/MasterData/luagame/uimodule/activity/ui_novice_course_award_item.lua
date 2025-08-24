local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local JOURNEY_STATE = Config.CommonDefine.JOURNEY_STATE

function ui:set_data(cfg)
  self.v_object:SetActive(true)
  self.v_uicompents.Name_txt.text = cfg.Name
  local state = NoviceMgr:get_activity_journey_state(cfg.Id)
  self.v_uiobjects.CompleteMask:SetActive(JOURNEY_STATE.GAINED == state)
  self.v_uiobjects.BtnReceive.gameObject:SetActive(JOURNEY_STATE.COMPLETE == state)
  self.v_uiobjects.CanReceive:SetActive(JOURNEY_STATE.COMPLETE == state)
  self.v_uiobjects.HaveGot:SetActive(JOURNEY_STATE.GAINED == state)
  self.v_uiobjects.BtnUnComplete:SetActive(JOURNEY_STATE.UNCOMPLETE == state)
  if JOURNEY_STATE.COMPLETE == state then
    self.v_parent_ui:show_red_point()
    self:set_button_listener(self.v_uicompents.BtnReceive_btn, function()
      self.v_parent_ui:get_stage_award(cfg.Id)
    end)
  else
    self:set_button_listener(self.v_uicompents.BtnReceive_btn, function()
    end)
  end
  local award_cfg = ShareRes.get_award_item_data(cfg.AwardGroup)[1]
  local item_id = award_cfg[1]
  local item_num = award_cfg[2]
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_item_quality_path(item_id)
  local item_obj = self:get_child_gameobj("Container/ItemObjCom1_", self.v_object)
  local item_btn = Util.get_button("Container/ItemObjCom1_", self.v_object)
  self:set_award_item(item_obj, item_icon_path, item_quality_path, item_num)
  self:set_button_listener(item_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end)
end

function ui:set_award_item(obj, item_icon_path, item_quality_path, item_num)
  local item_icon = Util.get_image("ItemIcon_", obj)
  local item_quality = Util.get_image("ItemQuality_", obj)
  local item_num_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", obj)
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  item_num_txt.text = item_num
end

function ui:refresh()
end

function ui:ui_on_hide()
end

return ui
