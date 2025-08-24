local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)

function M:ui_finish_load()
  self.v_btn = Util.get_button(nil, self.v_object)
  self.v_btn_del = Util.get_button("Choose_/BtnDel_", self.v_object)
  self.v_cg = self:get_canvas_group()
end

function M:ui_on_hide()
  self.v_data = nil
end

function M:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function M:on_data_update(msg)
  if self.v_data and msg.mm_x == self.v_data.uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(msg.mm_x)
    self.v_data.buddy_id = puzzle_data.buddy_id
    self.v_data.quality = puzzle_data.quality
    self:update_view()
  end
end

function M:do_fade_in()
  self.v_cg.alpha = 0
  self.v_cg:DOFade(1, 0.4):SetDelay(math.floor((self.v_index - 6) / 5) * 0.1)
end

function M:set_data(go, data_list, index)
  self.v_index = index
  self:set_data_ex(data_list[index])
  self.v_cg.alpha = 1
end

function M:set_data_ex(data)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_ITEM_UPDATE, self.on_data_update, self)
  self.v_data = data
  self:update_view()
  self:set_button_listener(self.v_btn, function()
    if self.v_uiobjects.BanMask.activeSelf then
      return
    end
    Util.show_puzzle_tip(self.v_data.uuid, {
      offset = Config.PUZZLE_TIPS_OFFSET.MIDDLE,
      show_up_lv_btn = true,
      show_decompose_btn = true,
      show_remove_btn = false,
      show_select_btn = false,
      show_dark_mask = true
    })
  end)
  self.v_uiobjects.Select:SetActiveEx(false)
  self.v_uiobjects.ItsSet:SetActiveEx(false)
  self.v_uiobjects.BanMask:SetActiveEx(false)
  self.v_uiobjects.Choose:SetActiveEx(false)
end

function M:on_data_update(msg)
  if self.v_data and msg.mm_x == self.v_data.uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(msg.mm_x)
    self.v_data.buddy_id = puzzle_data.buddy_id
    self.v_data.quality = puzzle_data.quality
    self:update_view()
  end
end

function M:update_view()
  local item_id = self.v_data.id
  local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
  local graph_show_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(self.v_data.graph_id)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_quality_path(self.v_data.quality)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, item_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.Quality_img, item_quality_path)
  ResMgr:load_set_icon(self.v_uicompents.Size_img, graph_show_cfg.SmallIcon, nil, true)
  self.v_uicompents.Name_txt.text = puzzle_cfg.Name
  local owner = self.v_data.buddy_id or 0
  self.v_uiobjects.Hero:SetActive(0 ~= owner)
  if 0 ~= owner then
    local path = CharacterMgr:get_buddy_icon_path(owner)
    ResMgr:load_set_icon(self.v_uicompents.hero_head_icon_img, path)
  end
  self:update_attr_preview()
end

function M:update_attr_preview()
  local attr_list = self.v_data.attr_list
  for i = 1, 3 do
    local id = attr_list[i]
    if id then
      local attr_id = ShareRes.get_buddy_puzzle_attr_cfg(id).AttrId
      Util.load_attr_icon(self.v_uicompents["AttrIcon" .. i .. "_img"], ShareRes.get_attr_icon(attr_id))
    end
    self.v_uiobjects["AttrTem" .. i]:SetActiveEx(nil ~= id)
  end
end

function M:is_visible_item()
  return self.v_visible
end

return M
