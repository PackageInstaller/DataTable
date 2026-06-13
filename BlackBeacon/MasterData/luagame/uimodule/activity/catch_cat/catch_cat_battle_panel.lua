local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CatchCatHelper = require("uimodule.activity.catch_cat.catch_cat_helper")
local Catch_Cat_Row_Tem_Key = "Catch_Cat_Row_Tem_Key"
local Catch_Cat_Node_Tem_Key = "Catch_Cat_Node_Tem_Key"
local CatchCatNodeItem = require("uimodule.activity.catch_cat.catch_cat_node_item")
local HorizontalLayoutGroup = typeof(UnityEngine.UI.HorizontalLayoutGroup)
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder

function ui:on_click_BtnReset()
  local function cb()
    self:start_new(self.v_stage_cfg)
  end
  
  Util.show_conform_tip("是否重新开始", nil, nil, nil, cb)
end

function ui:on_click_BtnRet1()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnReset", function()
    self:on_click_BtnReset()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("MapNode", function()
    self:on_click_MapNode()
  end)
  local row_item_horizontal_layout = Util.get_component(nil, self.v_uiobjects.MapRow, HorizontalLayoutGroup)
  self.v_row_offset = (self.v_uicompents.MapNode_rect.rect.width + row_item_horizontal_layout.spacing) / 2
  self:register_exist_auto_template(Catch_Cat_Row_Tem_Key, self.v_uiobjects.MapRow, self.v_uiobjects.MapBegin)
  self:register_exist_auto_template(Catch_Cat_Node_Tem_Key, self.v_uiobjects.MapNode, self.v_uiobjects.MapBegin)
end

function ui:ui_on_hide()
  self:clear_wrap_items()
  self:clear_squence()
  UIMgr:try_hide_ui("catch_cat_result_tips")
end

function ui:ui_on_destroy()
end

function ui:clear_wrap_items()
  if self.v_node_item_list then
    for row = #self.v_node_item_list, 1, -1 do
      local row_list = self.v_node_item_list[row]
      for column = #row_list, 1, -1 do
        local item = row_list[column]
        item:ui_hide()
        item:ui_destroy()
        row_list[column] = nil
      end
      self.v_node_item_list[row] = nil
    end
    self.v_node_item_list = nil
  end
end

function ui:start_new(stage_cfg)
  self:ui_on_show(stage_cfg, self.v_is_gm_show, self.v_activity_id)
end

function ui:ui_on_show(stage_cfg, is_gm_show, activity_id)
  self.v_activity_id = activity_id
  self.v_uiobjects.TurnLeftAnim:SetActive(false)
  self.v_uiobjects.TurnRightAnim:SetActive(false)
  self.v_uiobjects.Ani_UIEnjiEscapeBattle_In:SetActiveEx(false)
  self.v_uiobjects.Ani_UIEnjiEscapeBattle_In:SetActive(true)
  self.v_id = stage_cfg.id
  self.v_stage_cfg = stage_cfg
  self.v_is_gm_show = is_gm_show
  self.v_is_searching = false
  self:refresh_info()
  local start_pos = stage_cfg.StartPos
  if not start_pos or 2 ~= #start_pos then
    Log.Error("围住小猫关卡起点配置错误", self.v_id)
    return
  end
  local start_node_trans
  self:give_back_auto_cache(Catch_Cat_Row_Tem_Key)
  self:give_back_auto_cache(Catch_Cat_Node_Tem_Key)
  local grids, goals_list = CatchCatHelper.create_grid(stage_cfg)
  self:clear_wrap_items()
  self.v_node_item_list = {}
  for row, row_grids in ipairs(grids) do
    if not self.v_node_item_list[row] then
      self.v_node_item_list[row] = {}
    end
    local row_obj = self:get_auto_cache(Catch_Cat_Row_Tem_Key)
    row_obj.name = row
    local row_offset = 0 == row % 2 and math.ceil(self.v_row_offset) or 0
    Util.get_component(nil, row_obj, HorizontalLayoutGroup).padding.left = -row_offset
    for column, node in ipairs(row_grids) do
      local node_obj = self:get_auto_cache(Catch_Cat_Node_Tem_Key)
      node_obj.name = string.format("%s,%s", row, column)
      node_obj.transform:SetParent(row_obj.transform)
      local item = CatchCatNodeItem:ui_wrap_ex(self, node_obj, true)
      self.v_node_item_list[row][column] = item
      item:bind_node(node)
      if row == start_pos[1] and column == start_pos[2] then
        start_node_trans = node_obj.transform
      end
      if self.v_is_gm_show then
        item.v_txt_obj:SetActive(true)
        item.v_txt.text = node_obj.name
      end
    end
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.MapBegin_rect)
  self.v_uicompents.MoveNode_rect.position = start_node_trans.position
  self.v_uiobjects.MoveNode:SetActive(true)
  if self.v_stage_cfg.BgIcon then
    ResMgr:load_set_icon(self.v_uicompents.MapBg_img, self.v_stage_cfg.BgIcon, nil, true)
  end
  self.v_grids = grids
  self.v_start_pos = start_pos
  self.v_goals_list = goals_list
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:refresh_info()
  self.v_uicompents.StageNum_txt.text = self.v_stage_cfg.NumTxt
  self.v_uicompents.StageName_txt.text = self.v_stage_cfg.Name
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

function ui:is_searching_path(set_true_if_not_searching)
  if set_true_if_not_searching and not self.v_is_searching then
    self.v_is_searching = true
    return false
  end
  return self.v_is_searching
end

function ui:do_search_path()
  local path_grids = CatchCatHelper.get_shortest_path(self.v_grids, self.v_start_pos, self.v_goals_list)
  if path_grids then
    self:move_to_next(path_grids)
  else
    self:do_success()
  end
end

function ui:move_to_next(path_grids)
  local next_node = path_grids[2]
  local next_node_item = self.v_node_item_list[next_node.x][next_node.y]
  if not next_node_item then
    Log.Error("路径节点错误", next_node)
    return
  end
  local is_over = 3 == #path_grids
  self.v_start_pos = {
    next_node.x,
    next_node.y
  }
  self:clear_squence()
  local sequence = Util.create_sequence()
  sequence:Append(self.v_uicompents.MoveNode_rect:DOMove(next_node_item.v_object_transform.position, 0.4))
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.catch_cat_move_UI_SOUND)
  if not is_over then
    sequence:InsertCallback(0.3, function()
      self.v_is_searching = false
    end)
  else
    local end_node = path_grids[3]
    local end_node_item = self.v_node_item_list[end_node.x][end_node.y]
    sequence:AppendInterval(0.2)
    sequence:Append(self.v_uicompents.MoveNode_rect:DOMove(end_node_item.v_object_transform.position, 0.3))
    sequence:AppendCallback(function()
      UIMgr:get_ui("catch_cat_result_tips"):ui_show(self.v_stage_cfg, false)
    end)
  end
  self.v_sequence = sequence
end

function ui:do_success()
  if self.v_is_gm_show or CatchCatMgr:is_stage_passed(self.v_stage_cfg.Id) then
    UIMgr:get_ui("catch_cat_result_tips"):ui_show(self.v_stage_cfg, true, self.v_is_gm_show)
    return
  end
  CatchCatMgr:req_complete_stage(self.v_stage_cfg.Id, function()
    UIMgr:get_ui("catch_cat_result_tips"):ui_show(self.v_stage_cfg, true)
  end)
end

function ui:clear_squence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:switch_left_icon_anim()
  local is_right = self.v_uiobjects.TurnRightAnim.activeSelf
  self.v_uiobjects.TurnRightAnim:SetActive(not is_right)
  self.v_uiobjects.TurnLeftAnim:SetActive(is_right)
end

return ui
