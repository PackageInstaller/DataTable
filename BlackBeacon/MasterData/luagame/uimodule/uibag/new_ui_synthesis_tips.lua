local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local T_MATERIAL_ITEM_TEM = "T_MATERIAL_ITEM_TEM"
local CONSUMETEM_CLASS = require("uimodule.character.consumeTem")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")

function ui:ui_finish_load()
  self:register_exist_auto_template(T_MATERIAL_ITEM_TEM, self.v_uiobjects.Material, self.v_uiobjects.MaterialLayout)
  self:set_button("BgBtn", function()
    self:ui_hide()
  end)
  self:set_button("BtnCancel", function()
    self:ui_hide()
  end)
  self:set_button("BtnConfirm", function()
    if not self.v_exchange_id or self.v_exchange_count < 1 then
      return
    end
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.synthesis_UI_SOUND)
    self.v_send_data = {
      cid = self.v_exchange_id,
      num = self.v_exchange_count
    }
    self.v_uicompents.OutPd_pd:Stop()
    self.v_uicompents.OutPd_pd:Play()
    local duration = self.v_uicompents.OutPd_pd.duration
    if self.v_out_pd_timer then
      Timer:remove_timer(self.v_out_pd_timer)
      self.v_out_pd_timer = nil
    end
    self.v_out_pd_timer = Timer:add_timer(nil, duration, function()
      local new_ui_item_synthesis = UIMgr:get_ui("new_ui_item_synthesis")
      new_ui_item_synthesis:play_synthesis_effect(self.v_send_data)
      self.v_uiobjects.SkipEffect:SetActive(false)
      self:ui_hide()
      self.v_out_pd_timer = nil
    end)
    self.v_uiobjects.SkipEffect:SetActive(true)
  end)
  self:set_button("SkipEffect", function()
    if self.v_out_pd_timer then
      Timer:remove_timer(self.v_out_pd_timer)
      self.v_out_pd_timer = nil
    end
    local new_ui_item_synthesis = UIMgr:get_ui("new_ui_item_synthesis")
    new_ui_item_synthesis:skip_effect_synthesis(self.v_send_data)
    self:ui_hide()
    self.v_uiobjects.SkipEffect:SetActive(false)
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self.v_material_item_list = {}
end

function ui:ui_on_show(show_item_list, show_coin_count, data, select_count)
  self.v_uiobjects.SkipEffect:SetActive(false)
  self.v_exchange_id = data.targetInfo.Id
  self.v_exchange_count = select_count
  self:set_show_data(show_item_list, show_coin_count, data, select_count)
end

function ui:ui_on_hide()
  self:remove_all_material_item()
end

function ui:ui_on_destroy()
end

function ui:set_show_data(show_item_list, show_coin_count, data, select_count)
  local coin_num = show_coin_count
  for i = 1, #show_item_list do
    local show_data = show_item_list[i]
    local item
    local obj = self:get_auto_cache(T_MATERIAL_ITEM_TEM)
    item = CONSUMETEM_CLASS:ui_wrap(self, obj, true)
    item:set_data(show_data, true, true)
    self.v_material_item_list[i] = item
  end
  if coin_num > 0 then
    self.v_uicompents.GoldNum_txt.text = coin_num
  end
  self.v_uiobjects.GoldConsume:SetActive(coin_num > 0)
  local item = ITEM_OBJ_COM:ui_wrap(self, self.v_uiobjects.ProductTem, true)
  local info = {
    data.targetInfo.item_id,
    select_count
  }
  item:set_data(info, true)
  self.v_material_item_list[#self.v_material_item_list + 1] = item
  local cfg = UtilUI.get_item_cfg(data.targetInfo.item_id)
  self.v_uicompents.Desc_txt.text = string.format("确认消耗以下物品制作<color=#ff3843>%sx%s</color>吗？", cfg.Name, select_count)
end

function ui:remove_all_material_item()
  self:give_back_auto_cache(T_MATERIAL_ITEM_TEM)
  for key, item in pairs(self.v_material_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_material_item_list[key] = nil
  end
end

return ui
