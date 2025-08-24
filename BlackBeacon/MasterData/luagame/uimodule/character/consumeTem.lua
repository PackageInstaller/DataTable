local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  if self.v_uiobjects.ItemBtn then
    self:set_button("ItemBtn", function()
      self:on_click_item()
    end)
  end
end

function ui:on_click_item()
  local curr_num = BagMgr:get_item_num(self.v_item_id)
  local jump_cb
  if self.v_hide_source_when_jump then
    function jump_cb()
      if self.v_parent_ui then
        self.v_parent_ui:ui_hide()
      end
    end
  end
  UIMgr:get_ui("itemTip"):ui_show({
    item_id = self.v_item_id,
    jump_cb = jump_cb,
    curr_count = curr_num,
    need_count = self.v_need_count
  })
end

function ui:set_data(data, is_reward, hide_source_when_jump)
  self.v_hide_source_when_jump = hide_source_when_jump
  self.v_need_count = nil
  if not is_reward then
    self.v_item_id = data.item_id
    self.v_item_cfg = ShareRes.get_item_cfg(data.item_id)
    self.v_need_count = data.need_num
    self:set_item_num(data.need_num, data.is_hide_need_text)
  else
    self.v_item_id = data[1]
    self.v_item_cfg = ShareRes.get_item_cfg(data[1])
    self:set_item_num(data[2], false, is_reward)
    if self.v_uiobjects.Got and type(data[3]) == "boolean" then
      self.v_uiobjects.Got:SetActive(data[3])
    end
  end
  self:set_icon()
  self:set_quality_bg()
end

function ui:set_icon()
  local path = string.format("Icon/Item/%s", self.v_item_cfg.Icon)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, path)
end

function ui:set_quality_bg()
  local icon_name = ShareRes.create("item.item_quality", self.v_item_cfg.Quality).QualityIcon
  local quality_path = string.format("UICommon/%s", icon_name)
  ResMgr:load_set_icon(self.v_uicompents.ItemQuality_img, quality_path)
end

function ui:set_item_num(need_num, is_hide_need_text, is_reward)
  local objs = self.v_uiobjects
  local coms = self.v_uicompents
  objs.ItemNow:SetActive(not is_hide_need_text)
  objs.sprit:SetActive(not is_hide_need_text)
  if is_hide_need_text then
    self.v_uicompents.ItemNeed_txt.text = need_num
    return
  end
  if not is_reward then
    local cur_num = BagMgr:get_item_num(self.v_item_id)
    if need_num > cur_num then
      cur_num = "<color=#e0212c>" .. cur_num .. "</color>"
    end
    coms.ItemNow_txt.text = cur_num
    objs.sprit:SetActive(true)
    objs.ItemNow:SetActive(true)
  else
    objs.sprit:SetActive(false)
    objs.ItemNow:SetActive(false)
  end
  coms.ItemNeed_txt.text = need_num
end

return ui
