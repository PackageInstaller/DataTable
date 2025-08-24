local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CommonDefind = require("cs_share.common_define")
local OBJ_VISIBLE_TYPE = Config.FIGHT_OBJ_VISIBLE_TYPE

function ui:ui_finish_load()
  self:set_button("ReturnBg", function()
    self:ui_hide()
  end)
  self:set_button("BtnGet", function()
    self:click_get_btn()
  end)
end

function ui:ui_on_show(npc_data, cb)
  self.v_npc_data = npc_data
  self.v_cb = cb
  local npc_id = npc_data.npc_id
  local is_get = npc_data.is_get
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local dialogue_txt = ucom.Dialogue_txt
  local name_txt = ucom.Name_txt
  local btn_txt = ucom.BtnGetTxt_txt
  local get_btn_obj = uobj.BtnGet
  name_txt.text = npc_cfg.Name
  local normal_txt = npc_cfg.Dialogue
  local interact_end = npc_cfg.InteractEndDialogue
  if is_get and interact_end then
    normal_txt = interact_end
  end
  dialogue_txt.text = normal_txt
  btn_txt.text = npc_cfg.ButtonText
  if is_get or npc_cfg.Arg[1] == "0" then
    get_btn_obj:SetActive(false)
  else
    get_btn_obj:SetActive(true)
  end
  UIMgr:get_ui("fight"):set_ui_node_visible("Main", OBJ_VISIBLE_TYPE.BUDDY, true)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DEFAULT_TIMER_PAUSE, self.on_fight_timer_pause, self)
end

function ui:on_fight_timer_pause(msg)
  if msg and msg.mm_x then
    self:ui_hide()
  end
end

function ui:click_get_btn()
  if self.v_cb then
    local cb = self.v_cb
    cb()
    self.v_cb = nil
  end
  self:ui_hide()
end

function ui:ui_on_hide()
  UIMgr:get_ui("fight"):set_uiobject_visible("Main", true)
  self.v_npc_data = nil
  self.v_cb = nil
end

return ui
