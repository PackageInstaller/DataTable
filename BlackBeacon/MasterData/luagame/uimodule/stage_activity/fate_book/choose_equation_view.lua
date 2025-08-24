local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SELECT_ON_WIDTH = 66
local SELECT_OFF_WIDTH = 22
local EQUATION_ITEM = require("uimodule.stage_activity.fate_book.equation_item")
local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local EQUATION_OPERATION_TYPE = ccd.EQUATION_OPERATION_TYPE
local CHOOSE_EQUATION_TEM = "CHOOSE_EQUATION_TEM"
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm

function ui:on_click_equation_item(key, ...)
  if self.v_select_key == key then
    return
  end
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    self.v_select_drop_uuid = self.v_equation_drop_data.uuid
    self.v_select_drop_index = select(1, ...)
    self.v_select_equation_id = select(2, ...)
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE then
    self.v_select_equation_id = self.v_equation_data.id
    self.v_select_drop_branch_id = select(1, ...)
  end
  self.v_select_key = key
end

function ui:set_base_effect_select(show_base_info)
  self.v_show_base_info = show_base_info
  local width = self.v_show_base_info and SELECT_ON_WIDTH or SELECT_OFF_WIDTH
  self.v_uicompents.BaseSelect_rect:SetSizeDeltaWidthA(width)
  self:refresh_all_item_desc()
end

function ui:set_brief_effect_select(show_brief_info)
  self.v_show_brief_info = show_brief_info
  local width = self.v_show_brief_info and SELECT_ON_WIDTH or SELECT_OFF_WIDTH
  self.v_uicompents.BriefSelect_rect:SetSizeDeltaWidthA(width)
  self:refresh_all_item_desc()
end

function ui:on_click_choose_btn()
  if self.v_choose_lock then
    return
  end
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    self.v_choose_lock = true
    FateBookMgr:request_curse_select_equation(self.v_select_drop_uuid, self.v_select_drop_index, self.v_select_equation_id, function()
      if self:has_inited() and self:visible() then
        self:after_opeartion()
      end
    end)
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE then
    self.v_choose_lock = true
    FateBookMgr:request_curse_select_branch(self.v_select_equation_id, self.v_select_drop_branch_id, function()
      if self:has_inited() and self:visible() then
        self:after_opeartion()
      end
    end)
  end
end

function ui:do_hide(not_pd)
  if self.v_is_in_hide_pd then
    return
  end
  if not_pd then
    self:ui_hide()
    return
  end
  if not self.v_hide_cb then
    function self.v_hide_cb()
      self.v_is_in_hide_pd = false
      
      local data = FateBookMgr:dequeue_equation_drop_data()
      if data then
        self:refresh_view(data)
      else
        self:ui_hide()
      end
    end
    
    self.v_uicompents.Ani_UIFB_Equation_Out_pd:stopped("+", self.v_hide_cb)
  end
  self.v_is_in_hide_pd = true
  self.v_uicompents.Ani_UIFB_Equation_Out_pd:ResetPD()
  self.v_uicompents.Ani_UIFB_Equation_Out_pd:Play()
end

function ui:on_click_close_btn()
  self:do_hide()
end

function ui:on_click_refresh_btn()
  if self.v_choose_lock then
    return
  end
  if not self:check_can_refresh(true) then
    return
  end
  self.v_select_drop_uuid = self.v_equation_drop_data.uuid
  FateBookMgr:request_curse_refresh_equation(self.v_select_drop_uuid, function(responce)
    self:refresh_view(responce.equation_drop)
  end)
end

function ui:ui_finish_load()
  self:set_button("BtnBasicEffect", function()
    self:set_base_effect_select(not self.v_show_base_info)
  end)
  self:set_button("BtnBriefDesc", function()
    self:set_brief_effect_select(not self.v_show_brief_info)
  end)
  self:set_button("BtnChoose", function()
    self:on_click_choose_btn()
  end)
  self:set_button("BtnClose", function()
    self:on_click_close_btn()
  end)
  self:set_button("BtnRefresh", function()
    self:on_click_refresh_btn()
  end)
  self.v_equation_item_map = {}
  self.v_asset_item_info_list = {
    {
      item_id = Config.CURSE_GOLD
    }
  }
  self:register_exist_auto_template(CHOOSE_EQUATION_TEM, self.v_uiobjects.EquationTem, self.v_uiobjects.EquationContent)
end

function ui:ui_on_show(data)
  self:set_brief_effect_select(false)
  self:set_base_effect_select(true)
  self:refresh_view(data)
end

function ui:ui_on_hide()
  if self.v_hide_cb then
    self.v_uicompents.Ani_UIFB_Equation_Out_pd:stopped("-", self.v_hide_cb)
    self.v_hide_cb = nil
  end
  self.v_equation_group_cfg = nil
  self.v_equation_drop_data = nil
  self.v_operation_type = nil
  self.v_equation_data = nil
  self.v_equation_cfg = nil
  self.v_choose_lock = nil
  self.v_select_key = nil
  self:clear_equation_item()
  self:clear_select_data()
end

function ui:ui_on_destroy()
end

function ui:refresh_view(data, operation_type)
  self.v_on_refresh = true
  self.v_choose_lock = nil
  data = data or FateBookMgr:dequeue_equation_drop_data()
  if not data then
    Log.Error("获取数据失败", debug.traceback())
    return
  end
  operation_type = operation_type or data.operation_type or self.v_operation_type
  self:clear_equation_item()
  self:clear_select_data()
  if operation_type == EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP or operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE then
    self:set_brief_effect_select(true)
    self:set_base_effect_select(false)
  elseif operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    self:set_brief_effect_select(true)
  end
  self.v_operation_type = operation_type
  self.v_uiobjects.BtnBasicEffect:SetActive(true)
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    self:refresh_drop_equation_data(data)
    self:refresh_drop_equation_content()
    self.v_uiobjects.BtnBasicEffect:SetActive(false)
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE then
    self:refresh_branch_acitve_data(data)
    self:refresh_branch_acitve_content()
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP then
    self:refresh_branch_level_up_data(data)
    self:refresh_branch_level_up_content()
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.SHOW_GET_EQUATION then
    self:refresh_branch_level_up_data(data)
    self:refresh_branch_level_up_content()
  else
    Log.Error("刷新失败，未对改操作类型进行处理, ", tostring(self.v_operation_type), debug.traceback())
  end
  self:refresh_view_layout()
  self:refresh_update_info()
  self:play_in_pd()
  self.v_on_refresh = nil
end

function ui:refresh_update_info()
  if self.v_operation_type ~= EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    self.v_uiobjects.BtnRefresh:SetActive(false)
    return
  end
  local group_cfg = self.v_equation_group_cfg
  local total_refresh_count = self.v_equation_group_cfg.RefreshCount
  local can_refresh = total_refresh_count > 0
  self.v_uiobjects.BtnRefresh:SetActive(can_refresh)
  if can_refresh then
    local need_cost = Util.is_more_than_zero(group_cfg.RefreshItemId) and Util.is_more_than_zero(group_cfg.RefreshItemCount)
    self.v_uiobjects.AmountBg:SetActive(need_cost)
    if need_cost then
      ResMgr:load_set_icon(self.v_uicompents.GoldIcon_img, ShareRes.get_item_icon_path(group_cfg.RefreshItemId))
      local cur_count = BagMgr:get_item_num(group_cfg.RefreshItemId)
      self.v_uicompents.GoldNeed_txt.text = group_cfg.RefreshItemCount
      self.v_uicompents.GoldNow_txt.text = cur_count
      local is_enough = Util.check_item_cost_enough(group_cfg.RefreshItemId, group_cfg.RefreshItemCount)
      self.v_uicompents.GoldNow_txt.color = is_enough and enough_color or not_enough_color
    end
    local remain_count = total_refresh_count - self.v_equation_drop_data.refresh_count
    if 0 ~= remain_count then
      self.v_uicompents.LimitNow_txt.text = remain_count
    else
      self.v_uicompents.LimitNow_txt.text = "<color=#e0212c>" .. remain_count .. "</color>"
    end
    self.v_uicompents.LimitMax_txt.text = total_refresh_count
  end
end

function ui:refresh_view_layout()
  local str, show_button
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    str = self.v_equation_group_cfg.TitleText
    show_button = true
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE then
    str = "融合片段分支解锁"
    show_button = true
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP then
    str = "分支升级"
    show_button = false
  else
    show_button = false
  end
  self.v_uicompents.Tips_txt.text = str
  self.v_uiobjects.ButtonPannel:SetActive(show_button)
  self.v_uiobjects.BtnClose:SetActive(not show_button)
  self.v_uiobjects.CloseTips:SetActive(not show_button)
end

function ui:refresh_branch_level_up_data(data)
  self.v_equation_data = data
  self.v_equation_cfg = ShareRes.get_curse_equation_cfg(data.id)
end

function ui:refresh_branch_level_up_content()
  local build_data
  local obj = self:get_auto_cache(CHOOSE_EQUATION_TEM)
  local equation_id = self.v_equation_cfg.Id
  self.v_equation_item_map[equation_id] = EQUATION_ITEM:ui_wrap_ex(self, obj, true)
  build_data = {
    equation_id = equation_id,
    level = self.v_equation_data.level,
    branch_id = self.v_equation_data.branch_id,
    key = equation_id
  }
  self.v_equation_item_map[equation_id]:set_data(build_data, self.v_show_brief_info, self.v_show_base_info, self.v_operation_type)
end

function ui:refresh_branch_acitve_data(data)
  self.v_equation_data = data
  self.v_equation_cfg = ShareRes.get_curse_equation_cfg(data.id)
end

function ui:refresh_branch_acitve_content()
  local branch_id_list = self.v_equation_cfg.BranchList
  local build_data, obj
  local equation_id = self.v_equation_cfg.Id
  local first_item
  for index, branch_id in ipairs(branch_id_list) do
    obj = self:get_auto_cache(CHOOSE_EQUATION_TEM)
    build_data = {
      equation_id = equation_id,
      level = self.v_equation_data.level,
      branch_id = branch_id,
      key = branch_id
    }
    self.v_equation_item_map[branch_id] = EQUATION_ITEM:ui_wrap(self, obj, true)
    self.v_equation_item_map[branch_id]:set_data(build_data, self.v_show_brief_info, self.v_show_base_info, self.v_operation_type)
    first_item = first_item or self.v_equation_item_map[branch_id]
  end
  if first_item then
    first_item:on_click_btn()
  end
end

function ui:refresh_drop_equation_data(data)
  self.v_equation_drop_data = data
  self.v_equation_group_cfg = ShareRes.get_curse_equation_group_cfg(self.v_equation_drop_data.group_id)
end

function ui:refresh_drop_equation_content()
  local drop_equation_ids = self.v_equation_drop_data.drop_equations
  local equation_cfg, build_data, obj, first_item
  for index, equation_id in ipairs(drop_equation_ids) do
    equation_cfg = ShareRes.get_curse_equation_cfg(equation_id)
    if not equation_cfg then
      Log.Error("获取方程配置失败, 请检查对应方程ID配置是否存在, 方程ID：", equation_id, debug.traceback())
      return
    end
    obj = self:get_auto_cache(CHOOSE_EQUATION_TEM)
    build_data = {
      equation_id = equation_id,
      level = 0,
      branch_id = 0,
      index = index,
      key = equation_id
    }
    self.v_equation_item_map[equation_id] = EQUATION_ITEM:ui_wrap(self, obj, true)
    self.v_equation_item_map[equation_id]:set_data(build_data, self.v_show_brief_info, self.v_show_base_info, self.v_operation_type)
    first_item = first_item or self.v_equation_item_map[equation_id]
  end
  if first_item then
    first_item:on_click_btn()
  end
end

function ui:refresh_all_item_desc()
  for key, equation_item in pairs(self.v_equation_item_map) do
    equation_item:refersh_info(self.v_show_brief_info, self.v_show_base_info)
  end
end

function ui:refresh_all_item_select()
  for key, equation_item in pairs(self.v_equation_item_map) do
    equation_item:set_select(self.v_select_key)
  end
end

function ui:after_opeartion()
  self:do_hide()
end

function ui:play_in_pd()
  self.v_uicompents.Ani_UIFB_Equation_Fx_LevelUp_In_pd:ResetPD()
  self.v_uicompents.Ani_UIFB_Equation_In_pd:ResetPD()
  self.v_uicompents.Ani_UIFB_Equation_In_pd:Play()
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE or self.v_operation_type == EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP then
    self.v_uicompents.Ani_UIFB_Equation_Fx_LevelUp_In_pd:Play()
  end
end

function ui:check_can_refresh(show_tips)
  local can_refresh = false
  local group_cfg = self.v_equation_group_cfg
  local total_refresh_count = self.v_equation_group_cfg.RefreshCount
  self.v_uiobjects.BtnRefresh:SetActive(total_refresh_count > 0)
  if total_refresh_count > 0 then
    if Util.is_more_than_zero(group_cfg.RefreshItemId) and Util.is_more_than_zero(group_cfg.RefreshItemCount) then
      can_refresh = Util.check_item_cost_enough(group_cfg.RefreshItemId, group_cfg.RefreshItemCount)
      if show_tips and not can_refresh then
        local item_name = Util.get_item_name(group_cfg.RefreshItemId)
        Util.show_message_tip(2314, item_name)
      end
    else
      can_refresh = true
    end
  elseif show_tips then
    Util.show_message_tip(2291)
  end
  return can_refresh
end

function ui:clear_equation_item()
  self:give_back_auto_cache(CHOOSE_EQUATION_TEM)
  for key, equation_item in pairs(self.v_equation_item_map) do
    equation_item:ui_hide()
    equation_item:ui_destroy()
    self.v_equation_item_map[key] = nil
  end
end

function ui:clear_select_data()
  self.v_select_drop_uuid = nil
  self.v_select_drop_index = nil
  self.v_select_equation_id = nil
  self.v_select_branch_id = nil
end

function ui:on_refresh()
  return self.v_on_refresh
end

return ui
