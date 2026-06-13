local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TEMP_KEY_INDEX = 0
local EQUITION_BRANCH_TEM = "EQUITION_BRANCH_TEM"
local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local EQUATION_BRANCH_ITEM = require("uimodule.stage_activity.fate_book.equation_branch_item")
local EQUATION_OPERATION_TYPE = ccd.EQUATION_OPERATION_TYPE
local DEFATULE_REFRESH_FUNC_NAME = "refresh_equation_data"
local BUTTON_ENABLED_MAP = {
  [EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP] = true,
  [EQUATION_OPERATION_TYPE.ILLUSTATED] = true
}
local OPERATION_REFRESH_FUNC_NAME = {
  [EQUATION_OPERATION_TYPE.ILLUSTATED] = "refresh_equation_illustated_data"
}

local function get_obj_map(uicontainer)
  local obj_map = {}
  local list_name = uicontainer.ListName
  local list_objects = uicontainer.ListObj
  for i = 0, list_name.Count - 1 do
    obj_map[list_name[i]] = list_objects[i]
  end
  return obj_map
end

function ui:on_click_btn()
  local data = self.v_equation_show_data
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION then
    self.v_parent_ui:on_click_equation_item(data.key, data.index, data.equation_id)
  elseif self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE then
    self.v_parent_ui:on_click_equation_item(data.key, data.branch_id)
  end
end

function ui:on_click_comfirm_btn()
  self:on_click_btn()
  self.v_parent_ui:on_click_choose_btn()
end

function ui:on_click_BtnKeyWord(key_id_list)
  if UtilTable.is_empty(key_id_list) then
    key_id_list = self.v_key_id_list
  end
  if UtilTable.is_empty(key_id_list) then
    return
  end
  UIMgr:try_show_ui("keyword_tips_v2", nil, key_id_list)
end

function ui:on_click_SectLayoutTop()
  if self.v_operation_type == EQUATION_OPERATION_TYPE.ILLUSTATED then
    return
  end
  self:on_click_btn()
  if UtilTable.is_empty(self.v_sect_info_list) then
    return
  end
  UIMgr:try_show_ui("equation_condition_tips", nil, self.v_sect_info_list, self.v_equation_show_data.ability_count_map)
end

function ui:ui_finish_load()
  self:set_button("BasicEffectDesc", function()
    self:on_click_BtnKeyWord()
  end)
  self:set_button("SectLayoutTop", function()
    self:on_click_SectLayoutTop()
  end)
  self:set_button("BtnChoose", function()
    self:on_click_comfirm_btn()
  end)
  self.v_equation_branch_item_list = {}
  TEMP_KEY_INDEX = TEMP_KEY_INDEX + 1
  self.v_temp_key = EQUITION_BRANCH_TEM .. TEMP_KEY_INDEX
  self:register_exist_auto_template(self.v_temp_key, self.v_uiobjects.BranchTem, self.v_uiobjects.BranchDescContent)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_temp_key = nil
  for key, item in pairs(self.v_equation_branch_item_list) do
    item:ui_destroy()
    self.v_equation_branch_item_list[key] = nil
  end
end

function ui:set_data(show_data, show_brief_info, show_base_info, operation_type)
  self.v_equation_show_data = show_data
  self.v_equation_id = show_data.equation_id
  local equation_cfg = ShareRes.get_curse_equation_cfg(self.v_equation_id)
  self.v_equation_cfg = equation_cfg
  self.v_operation_type = operation_type
  self.v_uiobjects.Select:SetActive(false)
  self:play_in_pd()
  self:refersh_info(show_brief_info, show_base_info)
  self:set_button_listener(nil, function()
    self:on_click_btn()
  end)
end

function ui:refersh_info(show_brief_info, show_base_info)
  self.v_show_base_info = show_base_info
  self.v_show_brief_info = show_brief_info
  self:get_button().interactable = not BUTTON_ENABLED_MAP[self.v_operation_type]
  self.v_uiobjects.New:SetActive(false)
  local refresh_fun_name = OPERATION_REFRESH_FUNC_NAME[self.v_operation_type] or DEFATULE_REFRESH_FUNC_NAME
  if self[refresh_fun_name] then
    self[refresh_fun_name](self)
  end
end

function ui:refresh_equation_illustated_data()
  self.v_uiobjects.LvIcon:SetActive(false)
  local SectName = "SectName"
  local SectIcon = "SectIcon"
  local Condition = "Condition"
  local Sect = "Sect"
  local _txt = "_txt"
  local _img = "_img"
  local equation_cfg = self.v_equation_cfg
  self.v_key_id_list = self.v_equation_cfg.KeyIDList
  local sect_info_list = equation_cfg.Sect
  for i = 1, self.v_uicompents.SectLayoutTop_rect.childCount do
    local sect_info = sect_info_list[i]
    local is_show = nil ~= sect_info
    local sect_obj_name = SectName .. i
    self.v_uiobjects[Sect .. i]:SetActive(is_show)
    if is_show then
      local genres_cfg = ShareRes.get_genres_cfg(sect_info.Sect)
      self.v_uiobjects[sect_obj_name]:SetActive(true)
      self.v_uicompents[sect_obj_name .. _txt].text = genres_cfg.Name
      self.v_uiobjects[Condition .. i]:SetActive(false)
      ResMgr:load_set_icon(self.v_uicompents[SectIcon .. i .. _img], genres_cfg.IconPath, nil, true, self)
    end
  end
  self.v_uiobjects.BasicEffect:SetActive(true)
  self.v_uicompents.Name_txt.text = self.v_equation_cfg.Name
  self.v_uicompents.BasicEffectDesc_txt.text = self.v_equation_cfg.DetailDesc
  EQUATION_BRANCH_ITEM.refresh_desc_color(self.v_uicompents.BasicEffectDesc_txt, false)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, equation_cfg.Icon, nil, true, self)
  self.v_uiobjects.New:SetActive(self.v_equation_show_data.is_red)
  if self.v_uiobjects.BtnKeyWord then
    self.v_uiobjects.BtnKeyWord:SetActive(false)
  end
  self.v_uiobjects.BranchLock:SetActive(false)
end

function ui:refresh_equation_data()
  self:give_back_auto_cache(self.v_temp_key)
  local data = self.v_equation_show_data
  local is_active = nil ~= data and data.level >= 1
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, self.v_equation_cfg.Icon, nil, true, self)
  self.v_uicompents.Name_txt.text = self.v_equation_cfg.Name
  self.v_key_id_list = self.v_equation_cfg.KeyIDList
  self.v_uiobjects.BasicEffect:SetActive(self.v_show_base_info)
  local is_new = self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION and not FateBookMgr:check_illustrated_is_unlock(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EQUATION, self.v_equation_id)
  self.v_uiobjects.New:SetActive(is_new)
  if self.v_show_base_info then
    self.v_uicompents.BasicEffectDesc_txt.text = self.v_show_brief_info and self.v_equation_cfg.BriefDesc or self.v_equation_cfg.DetailDesc
    EQUATION_BRANCH_ITEM.refresh_desc_color(self.v_uicompents.BasicEffectDesc_txt, false)
  end
  self.v_uiobjects.BranchLock:SetActive(not is_active)
  self.v_uiobjects.BtnChoose:SetActive(self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION or self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE)
  if is_active then
    self:refresh_branch_level()
    self:refresh_top_sect_info()
  else
    self:refresh_lock_branch()
  end
end

function ui:refresh_lock_branch()
  local equation_cfg = self.v_equation_cfg
  local sect = equation_cfg.Sect
  self.v_sect_info_list = sect
  local star_obj, light_obj
  local uicontainer = self.v_uiobjects.BranchLock:GetComponent(typeof(CS.UIContainer))
  local obj_map = get_obj_map(uicontainer)
  local LvIcon_rect = self.v_uicompents.LvIcon_rect
  local lock_count, top_count, star_count = obj_map.SectLayoutLock.transform.childCount, self.v_uicompents.SectLayoutTop_rect.childCount, LvIcon_rect.childCount
  local max_count = math.max(lock_count, top_count, star_count)
  local light_name = "Light"
  local sect_info
  for i = 1, max_count do
    local genres_id, ability_need_count
    sect_info = sect[i]
    if sect_info then
      genres_id, ability_need_count = sect_info.Sect, sect_info.Count
    end
    if i <= top_count then
      EQUATION_BRANCH_ITEM.refresh_sect_layout(self, self.v_uicompents, i, genres_id, ability_need_count, self.v_equation_show_data.ability_count_map)
    end
    if i <= star_count then
      star_obj = LvIcon_rect:GetChild(i - 1)
      light_obj = self:get_child_gameobj(light_name, star_obj)
      light_obj.gameObject:SetActive(false)
    end
  end
end

function ui:refresh_branch_level()
  local level = self.v_equation_show_data.level
  local branch_id = self.v_equation_show_data.branch_id
  local max_level = ShareRes.get_curse_equation_branch_max_level(branch_id)
  local LvIcon_rect = self.v_uicompents.LvIcon_rect
  local obj, star_obj, light_obj, branch_cfg
  local star_count = LvIcon_rect.childCount
  local light_name = "Light"
  local all_branch_cfg = ShareRes.get_curse_equation_branch_cfg(branch_id)
  local max_count = math.max(star_count, max_level)
  local height = 0
  for key, item in pairs(self.v_equation_branch_item_list) do
    item:ui_destroy()
    self.v_equation_branch_item_list[key] = nil
  end
  for i = 1, max_count do
    if max_level >= i then
      branch_cfg = all_branch_cfg[i]
      obj = self:get_auto_cache(self.v_temp_key)
      local item = EQUATION_BRANCH_ITEM:ui_wrap_ex(self, obj, true)
      item:set_data(branch_cfg, self.v_show_brief_info, level < i)
      self.v_equation_branch_item_list[i] = item
    end
    if star_count >= i then
      star_obj = LvIcon_rect:GetChild(i - 1)
      light_obj = self:get_child_gameobj(light_name, star_obj)
      light_obj.gameObject:SetActive(level >= i)
    end
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.BranchDescContent_rect)
  if self.v_show_base_info then
    height = self.v_uicompents.BasicEffect_rect.rect.height
  end
  for i = 1, max_count do
    if self.v_equation_branch_item_list[i] then
      self.v_equation_branch_item_list[i]:get_rect_transform()
      local rect = self:get_rect_transform(nil, obj)
      if level > i then
        height = rect.rect.height + height
      end
    end
  end
  if self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION or self.v_operation_type == EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE or self.v_operation_type == EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP then
    local ox, _, oz = self.v_uicompents.BranchDescContent_rect:GetLocalPositionA3()
    if self.v_parent_ui:on_refresh() then
      self.v_uicompents.BranchDescScrollView_rect:ResetContentPosition()
      self.v_uicompents.BranchDescContent_rect:DOLocalMoveA(ox, height, oz, 1)
    else
      self.v_uicompents.BranchDescContent_rect:SetLocalPositionA(ox, height, oz)
    end
  end
end

function ui:refresh_top_sect_info()
  local show_level = self.v_equation_show_data.level
  local branch_id = self.v_equation_show_data.branch_id
  local all_branch_cfg = ShareRes.get_curse_equation_branch_cfg(branch_id)
  if not all_branch_cfg then
    Log.Error("获取全部分支配置失败， 分支ID", branch_id, debug.traceback())
    return
  end
  local next_level = math.min(#all_branch_cfg, show_level + 1)
  local sect_info_list = all_branch_cfg[next_level].Sect
  self.v_sect_info_list = sect_info_list
  local sect_root = self.v_uicompents.SectLayoutTop_rect
  local sect_info
  for i = 1, sect_root.childCount do
    sect_info = sect_info_list[i]
    local genres_id, ability_need_count
    if sect_info then
      genres_id, ability_need_count = sect_info.Sect, sect_info.Count
    end
    EQUATION_BRANCH_ITEM.refresh_sect_layout(self, self.v_uicompents, i, genres_id, ability_need_count, self.v_equation_show_data.ability_count_map)
  end
end

function ui:play_in_pd()
  self.v_uicompents.Ani_EquationTem_In_pd:ResetPD()
  self.v_uicompents.Ani_EquationTem_In_pd:Play()
end

function ui:set_select(select_key)
  self.v_uiobjects.Select:SetActive(self.v_equation_show_data.key == select_key)
end

return ui
