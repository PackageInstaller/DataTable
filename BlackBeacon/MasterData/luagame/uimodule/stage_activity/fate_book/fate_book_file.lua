local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local static_scroll_view = require("ui.widget.static_scroll_view")
local FATE_BOOK_FILE_LIST_ITEM = require("uimodule.stage_activity.fate_book.fate_book_file_list_item")
local EQUATION_HORI_ITEM = require("uimodule.stage_activity.fate_book.equation_hori_item")
local FILE_VIEW_STATE = curse_common_define.FILE_VIEW_STATE
local PREVIEW_PANEL_NAME = curse_common_define.PREVIEW_PANEL_NAME
local MULTISETTIMESROOT_MULTISETTIMESTEM_TEMP_KEY = "MULTISETTIMESROOT_MULTISETTIMESTEM_TEMP_KEY"
local FILE_FILECONTENT_FILETEM_KEY = "FILE_FILECONTENT_FILETEM_KEY"
local FILE_EQUATIONTEM_KEY = "FILE_EQUATIONTEM_KEY"
local FILE_ORNAMENT_KEY = "FILE_ORNAMENT_KEY"
local FILE_TALENTTEM_KEY = "FILE_TALENTTEM_KEY"
local STATE_TO_FUNC = {
  [FILE_VIEW_STATE.NORMAL] = "refresh_normal_state",
  [FILE_VIEW_STATE.QUICK_CHALLENGE] = "refresh_quick_challenge_state",
  [FILE_VIEW_STATE.SETTLE] = "refresh_settle_state"
}

function ui:on_curse_save_data_update()
  self:refresh_view()
end

function ui:on_select_change(select_item)
  if self.v_uiobjects.MultiSetTimesRoot.activeSelf then
    self:refresh_set_times_info()
  end
  self.v_select_temp_data = select_item:get_temp_data_tag()
  self.v_fild_item = select_item
  self.v_file_index = select_item.index
  self:refresh_select_file()
  if self.v_new_file_item then
    local select_new_file = select_item == self.v_new_file_item
    self.v_new_file_item:set_selected(select_new_file)
    if select_new_file then
      self.v_static_scroll_view:on_select_change()
    end
  end
end

function ui:colse_ui()
  self:refresh_challenge_multiple_info(1)
  self.v_ring_id = nil
  self.v_ring_cfg = nil
  self.v_quick_fight_ring_cfg = nil
  self.v_save_id = nil
  self.v_file_index = nil
  self.v_select_temp_data = nil
  self:ui_hide()
end

function ui:on_click_BtnJump()
  self:colse_ui()
end

function ui:on_click_BtnRet1()
  self:colse_ui()
end

function ui:on_click_BtnSaveFile()
  local change_temp_name
  local temp_data = FateBookMgr:get_fate_book_temp_save_data(self.v_save_id)
  local file_name = temp_data and temp_data.name
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  if not Util.is_empty(file_name) and file_name ~= main_cfg.NewFileName then
    change_temp_name = file_name
  end
  
  local function confirm_cb()
    FateBookMgr:request_activity_curse_set_save_data(self.v_save_id, self.v_file_index, function(ok)
      if ok then
        if change_temp_name then
          FateBookMgr:request_activity_curse_change_name(self.v_save_id, self.v_file_index, change_temp_name, function(ok)
            if ok then
              self:colse_ui()
            end
          end)
        else
          self:colse_ui()
        end
      end
    end)
  end
  
  if FateBookMgr:get_fate_book_file_data(self.v_save_id, self.v_file_index) then
    Util.show_conform_tip("是否保存存档", nil, nil, nil, confirm_cb)
  else
    confirm_cb()
  end
end

function ui:on_click_BtnSetTimes()
  self:refresh_set_times_info()
end

function ui:on_click_BtnStart()
  if TowerMgr:check_fight_progress() then
    return
  end
  if not self.v_save_id or not self.v_file_index then
    return
  end
  local file_data = FateBookMgr:get_fate_book_file_data(self.v_save_id, self.v_file_index)
  if not file_data then
    return
  end
  if self.v_quick_fight_ring_cfg.DestinyLevelDropType == Config.CommonDefine.CURSE_DROP_TYPE.SELECT_DROP and not ChallengeRingPlusMgr:get_destiny_drop_index(self.v_quick_fight_ring_cfg.Id) then
    local fate_book_select_drop_tips = UIMgr:get_ui("fate_book_select_drop_tips")
    fate_book_select_drop_tips:ui_show(self.v_quick_fight_ring_cfg.Id)
    Util.show_message_tip("请选择奖励")
    return
  end
  if not self:check_vit_is_enough(true) then
    return
  end
  FateBookMgr:request_activity_curse_set_save_id(self.v_file_index, function(ok)
    if ok then
      UIMgr:get_ui("team"):ui_show(file_data.sect, self.v_quick_fight_ring_cfg.EpisodeId, Config.CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE)
    end
  end)
end

function ui:on_open_previrew(view_name)
  UIMgr:try_show_ui("fate_book_file_preview", nil, view_name, self.v_preview_data_map, self.v_file_main_sect)
end

function ui:on_click_BtnSectPreview()
  self:on_open_previrew(PREVIEW_PANEL_NAME.ability_view)
end

function ui:on_click_BtnOrnPreview()
  self:on_open_previrew(PREVIEW_PANEL_NAME.orn_view)
end

function ui:on_click_BtnTalentPreview()
  self:on_open_previrew(PREVIEW_PANEL_NAME.ability_view)
end

function ui:on_click_BtnEquationPreview()
  self:on_open_previrew(PREVIEW_PANEL_NAME.equation_view)
end

function ui:on_click_BtnRemove()
  Util.show_conform_tip("是否删除存档", nil, nil, nil, function()
    FateBookMgr:request_activity_curse_remove_save_data(self.v_save_id, self.v_file_index, function(ok)
      if ok then
        Util.show_message_tip("删除成功")
      end
    end)
  end)
end

function ui:on_click_enemy_show_btn()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_quick_fight_ring_cfg.EpisodeId)
  if not point_cfg or not point_cfg.EnemyPreviewList then
    return
  end
  UIMgr:get_ui("enemy_info_tips"):ui_show(1, point_cfg.EnemyPreviewList)
end

function ui:on_input_value_edit_end(new_name)
  if self.v_origin_name == new_name then
    return
  end
  Util.show_conform_tip("确认修改存档名？", nil, nil, nil, function()
    if self.v_select_temp_data then
      Util.show_message_tip("修改成功")
      local temp_data = FateBookMgr:get_fate_book_temp_save_data(self.v_save_id)
      if temp_data.name ~= new_name then
        temp_data.name = new_name
      end
    else
      FateBookMgr:request_activity_curse_change_name(self.v_save_id, self.v_file_index, new_name, function(ok)
        if ok then
          Util.show_message_tip("修改成功")
          self.v_origin_name = new_name
        end
      end)
    end
  end)
end

function ui:ui_finish_load()
  self:set_button("BtnIntroduce", function()
    self:on_click_BtnIntroduce()
  end)
  self:set_button("BtnJump", function()
    self:on_click_BtnJump()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnSaveFile", function()
    self:on_click_BtnSaveFile()
  end)
  self:set_button("BtnSetTimes", function()
    self:on_click_BtnSetTimes()
  end)
  self:set_button("BtnStart", function()
    self:on_click_BtnStart()
  end)
  self:set_button("BtnRemove", function()
    self:on_click_BtnRemove()
  end)
  self:set_button("BtnOrnPreview", function()
    self:on_click_BtnOrnPreview()
  end)
  self:set_button("BtnSectPreview", function()
    self:on_click_BtnSectPreview()
  end)
  self:set_button("BtnTalentPreview", function()
    self:on_click_BtnTalentPreview()
  end)
  self:set_button("BtnEquationPreview", function()
    self:on_click_BtnEquationPreview()
  end)
  self:set_button("BtnEnemy", function()
    self:on_click_enemy_show_btn()
  end)
  local inputfield = self:get_inputfield(nil, self.v_uiobjects.NameInput)
  self:set_inputfield_listener(inputfield, nil, function()
    self:on_input_value_edit_end(inputfield.text)
  end)
  self.v_asset_item_info_list = {
    {
      item_id = Config.PLAYER_SP_ITEMID
    },
    {
      item_id = 11,
      func_name = "_onclick_fate_book_tickets"
    }
  }
  self:register_exist_auto_template(MULTISETTIMESROOT_MULTISETTIMESTEM_TEMP_KEY, self.v_uiobjects.MultiSetTimesTem, self.v_uiobjects.MultiSetTimesRoot)
  self:register_exist_auto_template(FILE_ORNAMENT_KEY, self.v_uiobjects.OrnTem, self.v_uiobjects.OrnamentContent)
  self:register_exist_auto_template(FILE_TALENTTEM_KEY, self.v_uiobjects.TalentTem, self.v_uiobjects.TalentContent)
  self.v_static_scroll_view = static_scroll_view:new(self, self.v_uiobjects.FileContent, FATE_BOOK_FILE_LIST_ITEM, FILE_FILECONTENT_FILETEM_KEY)
  self.v_equa_static_scroll_view = static_scroll_view:new(self, self.v_uiobjects.EquationContent, EQUATION_HORI_ITEM, FILE_EQUATIONTEM_KEY)
  self.v_uiobjects.NewFile:SetActive(false)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  self.v_empty_file_name = main_cfg.EmptyFileName
  self.v_equation_content_spacing = 17
  self.v_ornament_content_spacing = 30
  self.v_ability_content_spacing = 7
  self.v_equation_temp_width = self.v_uicompents.EquationTemS_rect:GetRectWH()
  self.v_ornament_temp_width = self.v_uicompents.OrnTem_rect:GetRectWH()
  self.v_ability_temp_width = self.v_uicompents.TalentTem_rect:GetRectWH()
  self.v_equation_content_width = self.v_uicompents.EquationContent_rect:GetRectWH()
  self.v_ornament_content_width = self.v_uicompents.OrnamentContent_rect:GetRectWH()
  self.v_ability_content_width = self.v_uicompents.TalentContent_rect:GetRectWH()
end

function ui:ui_on_show(view_state, ...)
  self:bind_auto_mq(Const.MSG_ON_CURSE_SAVE_DATA_UPDATE, self.on_curse_save_data_update, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.refresh_challenge_cost, self)
  self.v_view_state = view_state
  self.v_cur_multiple_times = FateBookMgr:get_quick_fight_challenge_multiple()
  if self.v_uiobjects.MultiSetTimesRoot.activeSelf then
    self:refresh_set_times_info()
  end
  self:refresh_view(...)
end

function ui:ui_on_hide()
  self.v_static_scroll_view:on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_button()
  self.v_is_normal = self.v_view_state == FILE_VIEW_STATE.NORMAL
  self.v_is_quick = self.v_view_state == FILE_VIEW_STATE.QUICK_CHALLENGE
  self.v_is_settle = self.v_view_state == FILE_VIEW_STATE.SETTLE
  self.v_uiobjects.BtnEnemy:SetActive(self.v_is_quick)
  self.v_uiobjects.SaveFileTips:SetActive(self.v_is_settle)
end

function ui:refresh_view(ring_id, ...)
  self.v_ring_id = ring_id or self.v_ring_id
  self:refresh_save_cfg()
  self:refresh_button()
  self:refresh_file_list()
  local refresh_func = STATE_TO_FUNC[self.v_view_state]
  if self[refresh_func] then
    self[refresh_func](self, ring_id, ...)
  end
end

function ui:refresh_normal_state(ring_id)
end

function ui:refresh_quick_challenge_state(ring_id)
  self:refresh_challenge_multiple_info(self.v_cur_multiple_times)
end

function ui:refresh_settle_state(ring_id)
  self:refresh_new_file()
end

function ui:refresh_new_file()
  self.v_new_file_item = self.v_new_file_item or FATE_BOOK_FILE_LIST_ITEM:ui_wrap_ex(self, self.v_uiobjects.NewFile, true)
  local temp_data = FateBookMgr:get_fate_book_temp_save_data(self.v_save_id)
  local is_limit_time = self:is_select_limit_time_file()
  if temp_data then
    self.v_new_file_item:set_enable(true)
    self.v_new_file_item:set_data(temp_data, is_limit_time)
    self.v_new_file_item:set_selected(true)
    self.v_new_file_item:set_temp_data_tag(true)
    self:on_select_change(self.v_new_file_item)
    self.v_static_scroll_view:on_select_change()
  else
    self.v_new_file_item:set_enable(false)
  end
end

function ui:refresh_save_cfg()
  self.v_ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  if self.v_ring_cfg.FastChallengeId then
    self.v_quick_fight_ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_cfg.FastChallengeId)
  end
  if not self.v_ring_cfg.SaveId then
    Log.Error("获取存档配置失败，请检查环配置：", self.v_ring_id, "是否配有SaveId", debug.traceback())
    return
  end
  self.v_save_id = self.v_ring_cfg.SaveId
  self.v_save_cfg = ShareRes.get_curse_save_cfg(self.v_save_id)
  if not self.v_save_cfg then
    Log.Error("获取存档配置失败，请检查环配置：", self.v_ring_id, "SaveId是否配置正确", debug.traceback())
    return
  end
end

function ui:refresh_file_list()
  local max_count = self.v_save_cfg.Limit
  if self.v_file_data_list then
    UtilTable.clear_list(self.v_file_data_list)
  else
    self.v_file_data_list = {}
  end
  local file_data
  for i = 1, max_count do
    file_data = FateBookMgr:get_fate_book_file_data(self.v_save_id, i)
    if not file_data then
      file_data = {
        index = i,
        name = self.v_empty_file_name
      }
    else
      file_data = UtilTable.copy_table(file_data)
      file_data.name = file_data.name or self.v_save_cfg.DefaultName[i]
    end
    self.v_file_data_list[i] = file_data
  end
  self.v_static_scroll_view:update_list(self.v_file_data_list)
  if self.v_view_state ~= FILE_VIEW_STATE.SETTLE then
    self.v_file_index = self.v_file_index or 1
    self.v_static_scroll_view:select_item(self.v_file_index)
  end
end

function ui:refresh_select_file()
  local file_data
  if self.v_select_temp_data then
    file_data = FateBookMgr:get_fate_book_temp_save_data(self.v_save_id)
    self.v_uiobjects.BtnSaveFile:SetActive(false)
    self.v_uiobjects.SelectSlotTips:SetActive(true)
  else
    file_data = self.v_save_id and self.v_file_index and FateBookMgr:get_fate_book_file_data(self.v_save_id, self.v_file_index)
    if self.v_is_settle then
      local show_str = file_data and "替换为新存档" or "保存存档"
      self.v_uicompents.BtnSaveFileText_txt.text = show_str
    end
    self.v_uiobjects.BtnSaveFile:SetActive(self.v_is_settle)
    self.v_uiobjects.SelectSlotTips:SetActive(false)
  end
  local inputfield = self:get_inputfield(nil, self.v_uiobjects.NameInput)
  if inputfield then
    inputfield.enabled = nil ~= file_data
    local file_name = file_data and (file_data.name or self.v_save_cfg.DefaultName[self.v_file_index]) or self.v_empty_file_name
    self.v_origin_name = file_name
    inputfield:SetTextWithoutNotify(file_name)
  end
  if file_data then
    self.v_uiobjects.BtnStart:SetActive(self.v_is_quick)
    self.v_uiobjects.BtnSetTimes:SetActive(self.v_is_quick)
    self.v_uiobjects.BtnRemove:SetActive(self.v_is_normal)
    self.v_uiobjects.BtnJump:SetActive(false)
    self.v_uiobjects.ChangeName:SetActive(true)
    self.v_uiobjects.MainContent:SetActive(true)
    self.v_uiobjects.NoFile:SetActive(false)
    self:refresh_time_limit(file_data.expire_time)
    self.v_file_main_sect = file_data.sect
    local genres_id = self.v_file_main_sect
    local genres_cfg = ShareRes.get_genres_cfg(genres_id)
    ResMgr:load_set_icon(self.v_uicompents.SectIcon_img, genres_cfg.IconPath, nil, true)
    local skill_id = genres_cfg.Skill
    local skill_level_cfg = ShareRes.get_scene_skill_level_cfg(skill_id)
    ResMgr:load_set_icon(self.v_uicompents.SkillIcon_img, skill_level_cfg[1].IconPath)
    self:build_preview_data(file_data)
    self:refresh_ability_equation()
    self:refresh_ornament(file_data.ornament_list)
  else
    self:refresh_no_data()
  end
end

function ui:refresh_no_data()
  self.v_uiobjects.NoFile:SetActive(true)
  self.v_uiobjects.MainContent:SetActive(false)
  self.v_uiobjects.Time:SetActive(false)
  self.v_uiobjects.BtnRemove:SetActive(false)
  self.v_uiobjects.BtnSetTimes:SetActive(false)
  self.v_uiobjects.BtnStart:SetActive(false)
  self.v_uiobjects.ChangeName:SetActive(false)
  self.v_uiobjects.BtnJump:SetActive(self.v_view_state ~= FILE_VIEW_STATE.SETTLE)
end

function ui:build_preview_data(file_data)
  self.v_preview_data_map = {
    [PREVIEW_PANEL_NAME.ability_view] = {},
    [PREVIEW_PANEL_NAME.orn_view] = {},
    [PREVIEW_PANEL_NAME.equation_view] = {}
  }
  local preview_data = self.v_preview_data_map[PREVIEW_PANEL_NAME.ability_view]
  local SECT_TYPE = Config.CommonDefine.SECT_TYPE
  self.v_ability_count_map = {}
  local ability_cfg
  for index, ability_data in ipairs(file_data.ability_list) do
    ability_cfg = ShareRes.get_ability_cfg(ability_data.id)
    local genres_id = ability_cfg.Sect
    if not self.v_ability_count_map[genres_id] then
      self.v_ability_count_map[genres_id] = 0
    end
    self.v_ability_count_map[genres_id] = self.v_ability_count_map[genres_id] + 1
    local is_main_sect = file_data.sect == genres_id
    local preview_genres_data = preview_data[genres_id] or {
      sect_id = genres_id,
      sect_type = is_main_sect and SECT_TYPE.MAIN_SECT or SECT_TYPE.SUB_SECT,
      sect_ability = {}
    }
    preview_data[genres_id] = preview_genres_data
    local new_ability_data = {
      ability_id = ability_data.id,
      ability_grade = ability_data.level
    }
    table.insert(preview_genres_data.sect_ability, new_ability_data)
    preview_data[0] = preview_data[0] or {
      sect_ability = {}
    }
    table.insert(preview_data[0].sect_ability, new_ability_data)
  end
  preview_data = self.v_preview_data_map[PREVIEW_PANEL_NAME.equation_view]
  self.v_equation_list = {}
  local equation_count = 0
  for index, equation_data in ipairs(file_data.equation_list) do
    local data = {
      branch_id = equation_data.branch_id,
      equation_id = equation_data.id,
      level = equation_data.level,
      ability_count_map = self.v_ability_count_map,
      opeartion_type = curse_common_define.EQUATION_OPERATION_TYPE.FILE_VIEW
    }
    self.v_equation_list[index] = data
    equation_count = equation_count + 1
    preview_data[data.equation_id] = data
  end
  preview_data = self.v_preview_data_map[PREVIEW_PANEL_NAME.orn_view]
  self.v_ornament_list = {}
  self:give_back_auto_cache(FILE_ORNAMENT_KEY)
  for index, ornament_id in ipairs(file_data.ornament_list) do
    preview_data[#preview_data + 1] = {id = index, item_id = ornament_id}
  end
end

function ui:refresh_ability_equation()
  local ability_count = 0
  self:give_back_auto_cache(FILE_TALENTTEM_KEY)
  local genres_count = 0
  for genres_id, count in pairs(self.v_ability_count_map) do
    local genres_cfg = ShareRes.get_genres_cfg(genres_id)
    local obj = self:get_auto_cache(FILE_TALENTTEM_KEY)
    local icon = self:get_image("SectIcon", obj)
    ResMgr:load_set_icon(icon, genres_cfg.IconPath, nil, true, self)
    local num = self:get_text("TalentNum", obj)
    num.text = count
    ability_count = ability_count + count
    genres_count = genres_count + 1
  end
  self.v_uicompents.TalentNum_txt.text = ability_count
  local total_width = self.v_ability_content_spacing * (genres_count - 1) + self.v_ability_temp_width * genres_count
  self.v_uiobjects.TalentBriefIcon:SetActive(total_width > self.v_ability_content_width)
  local equation_count = UtilTable.hash_lenth(self.v_equation_list)
  total_width = self.v_equation_content_spacing * (equation_count - 1) + self.v_equation_temp_width * equation_count
  self.v_uiobjects.EquationBriefIcon:SetActive(total_width > self.v_equation_content_width)
  self.v_equa_static_scroll_view:update_list(self.v_equation_list)
  self.v_uicompents.EquationNum_txt.text = equation_count
end

function ui:refresh_ornament(ornament_list)
  local ornament_cfg
  local ornament_count = 0
  self:give_back_auto_cache(FILE_ORNAMENT_KEY)
  for _, ornament_id in ipairs(ornament_list) do
    local obj = self:get_auto_cache(FILE_ORNAMENT_KEY)
    ornament_cfg = ShareRes.get_ornaments(ornament_id)
    ornament_count = ornament_count + 1
    local icon = self:get_image("OrnIcon", obj)
    ResMgr:load_set_icon(icon, ornament_cfg.Icon)
  end
  self.v_uicompents.OrnNum_txt.text = ornament_count
  local total_width = self.v_ornament_content_spacing * (ornament_count - 1) + self.v_ornament_temp_width * ornament_count
  self.v_uiobjects.OrnBriefIcon:SetActive(total_width > self.v_ornament_content_width)
end

function ui:refresh_challenge_cost()
  local path = ShareRes.get_item_icon_path(self.v_quick_fight_ring_cfg.ConsumeId)
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, path)
  self.v_uicompents.CurrNum_txt.text = self.v_quick_fight_ring_cfg.ConsumeCount * self.v_cur_multiple_times
  if self:check_vit_is_enough(false) then
    Util.set_color(self.v_uicompents.CurrNum_txt, Util.WHITE_COLOR_STR, 1)
    Util.set_color(self.v_uicompents.Negative_txt, Util.WHITE_COLOR_STR, 1)
  else
    Util.set_color(self.v_uicompents.CurrNum_txt, Util.RED_COLOR_STR, 1)
    Util.set_color(self.v_uicompents.Negative_txt, Util.RED_COLOR_STR, 1)
  end
end

function ui:check_vit_is_enough(pop_exchange_view)
  local cost_item = self.v_quick_fight_ring_cfg.ConsumeId
  local cost_count = self.v_quick_fight_ring_cfg.ConsumeCount * self.v_cur_multiple_times
  if not Util.check_item_cost_enough(cost_item, cost_count) then
    if pop_exchange_view then
      local item_num = BagMgr:get_item_num(cost_item)
      local lack_cnt = cost_count - item_num
      Util.show_recharge_box_by_item_id(cost_item, lack_cnt, nil, nil, function()
        local item_config = ShareRes.get_item_cfg(cost_item)
        local exchange_config = CharacterMgr:get_exchange_config_by_target_id(Config.EXCHANGE_TYPE.DEFAULT, cost_item)
        local exchange_config_id = exchange_config.Id
        local exchange_cost_id = exchange_config.Material[1]
        local exchange_cost_cnt = exchange_config.Num[1] * lack_cnt
        local item_maxnum = item_config.MaxCount
        local material_cur_count = BagMgr:get_item_num(exchange_cost_id)
        if item_maxnum < item_num + lack_cnt then
          Util.show_message_tip(2103)
          return
        end
        local fateExchange = UIMgr:try_get_visible_ui("fate_exchange")
        if fateExchange and fateExchange:check_can_exchange() then
          local cur_lack_cnt = fateExchange:get_cur_lack_cnt()
          if cur_lack_cnt ~= lack_cnt then
            fateExchange:response_click_confirm_btn()
            return
          end
        end
        if exchange_cost_cnt > material_cur_count then
          UIMgr:get_ui("uiforcerecharg"):ui_show(nil, exchange_cost_cnt - material_cur_count)
          return
        end
        CharacterMgr:request_exchange_item(exchange_config_id, lack_cnt, function()
          if not self:visible() then
            return
          end
          UIMgr:try_hide_ui("fate_exchange")
          self:on_click_BtnStart()
        end)
      end)
    end
    return false
  end
  return true
end

function ui:refresh_set_times_info()
  local activeSelf = self.v_uiobjects.MultiSetTimesRoot.activeSelf
  self.v_uiobjects.MultiSetTimesRoot:SetActive(not activeSelf)
  if true == activeSelf then
    self.v_uicompents.Arrow_rect:SetLocalEuler(0, 0, -90)
    return
  end
  self.v_uicompents.Arrow_rect:SetLocalEuler(0, 0, 0)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local max_challenge_multiple = main_cfg.MaxMultiChallenge
  if not Util.is_more_than_zero(max_challenge_multiple) then
    return
  end
  self:give_back_auto_cache(MULTISETTIMESROOT_MULTISETTIMESTEM_TEMP_KEY)
  for i = max_challenge_multiple, 1, -1 do
    local task_data = {}
    task_data.num = i
    local obj = self:get_auto_cache(MULTISETTIMESROOT_MULTISETTIMESTEM_TEMP_KEY)
    self:set_multiple_item_data(obj, task_data)
  end
end

function ui:set_multiple_item_data(obj, data)
  local select = Util.get_child_gameobj("Icon", obj)
  local num_text = Util.get_text("Text_", obj)
  select:SetActive(self.v_cur_multiple_times == data.num)
  num_text.text = tostring(data.num) .. "倍"
  if self.v_cur_multiple_times == data.num then
    Util.set_color(num_text, "f5ede2")
  else
    Util.set_color(num_text, "ae9577")
  end
  local btn = Util.get_button(nil, obj)
  self:set_button_listener(btn, function()
    self:refresh_challenge_multiple_info(data.num)
    self:refresh_set_times_info()
  end)
end

function ui:refresh_challenge_multiple_info(select_num)
  self.v_cur_multiple_times = select_num
  FateBookMgr:set_quick_fight_challenge_multiple(select_num)
  self.v_uicompents.TimesNum_txt.text = select_num .. "倍"
  self:refresh_challenge_cost()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_view_state, self.v_ring_id
end

function ui:is_select_limit_time_file()
  return self.v_save_cfg.TimeLimit == curse_common_define.FILE_TIME_LIMIT_TYPE.LIMIT
end

function ui:refresh_time_limit(expire_time)
  local is_limit_time = self:is_select_limit_time_file()
  self.v_uiobjects.Time:SetActive(is_limit_time)
  if is_limit_time then
    local has_disavle_time = Util.is_more_than_zero(expire_time)
    self.v_uiobjects.Time:SetActive(has_disavle_time)
    if has_disavle_time then
      local str = Date.get_time_formate_6(expire_time - Date.server_time(), "%s天%s小时后存档失效", "%s小时%s分后存档失效")
      self.v_uicompents.TimeTips_txt.text = str
    end
  end
end

return ui
