local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local character_voice_language_tag_key = "character_voice_language_tag_key"
local character_voice_language_item_key = "character_voice_language_item_key"
local character_voice_right_language_item_key = "character_voice_right_language_item_key"
local character_voice_buddy_item = require("uimodule.character.character_voice_buddy_item")
local HIDE_LANGUAGE_TYPE = {
  [1] = "CN",
  [2] = "EN",
  [3] = "JP",
  [4] = "KR"
}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnScreenType", function()
    self.v_type = 1 == self.v_type and 2 or 1
    self.v_child_type = 0
    self:refresh_all_list()
  end)
  self:set_button("BtnConfirm", function()
    self:on_confirm_click()
  end)
  self.v_cv_language_index_list = BattleSettingMgr:get_show_language_list(Config.CommonDefine.LANGUAGE_TYPE.Voice)
  self:init_template()
end

function ui:init_template()
  self:register_exist_auto_template(character_voice_language_tag_key, self.v_uiobjects.PageTem, self.v_uiobjects.TagContent)
  self:register_exist_auto_template(character_voice_language_item_key, self.v_uiobjects.CharTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(character_voice_right_language_item_key, self.v_uiobjects.LanguageItem, self.v_uiobjects.LanguageContent)
end

function ui:ui_on_show()
  self:refresh_type_and_total_list()
  self.v_type = 1
  self.v_child_type = 0
  self:refresh_all_list()
end

function ui:refresh_type_and_total_list()
  local buddy_config = ShareRes.create("buddy.buddy")
  self.v_buddy_list = {}
  for _, v in pairs(buddy_config) do
    if 1 ~= v.IsShow and CharacterMgr:check_buddy_release(v.Id) then
      table.insert(self.v_buddy_list, v)
    end
  end
  local element_list = {}
  local job_list = {}
  for _, buddy in pairs(self.v_buddy_list) do
    if not element_list[buddy.Element] then
      element_list[buddy.Element] = 1
    end
    if not job_list[buddy.Job] then
      job_list[buddy.Job] = 1
    end
  end
  self.v_element_list = {0}
  self.v_job_list = {0}
  for element, _ in pairs(element_list) do
    table.insert(self.v_element_list, element)
  end
  for job, _ in pairs(job_list) do
    table.insert(self.v_job_list, job)
  end
  table.sort(self.v_element_list)
  table.sort(self.v_job_list)
  self.v_element_buddy_list = {}
  self.v_job_buddy_list = {}
  self.v_element_buddy_list[0] = {}
  self.v_job_buddy_list[0] = {}
  local own_buddy_list = CharacterMgr:get_buddy_map()
  for _, buddy in pairs(self.v_buddy_list) do
    local data = {}
    data.buddy = buddy
    data.quality = buddy.Quality
    data.id = buddy.Id
    data.own = own_buddy_list[data.id] ~= nil
    if not self.v_element_buddy_list[buddy.Element] then
      self.v_element_buddy_list[buddy.Element] = {}
    end
    table.insert(self.v_element_buddy_list[buddy.Element], data)
    table.insert(self.v_element_buddy_list[0], data)
    if not self.v_job_buddy_list[buddy.Job] then
      self.v_job_buddy_list[buddy.Job] = {}
    end
    table.insert(self.v_job_buddy_list[buddy.Job], data)
    table.insert(self.v_job_buddy_list[0], data)
  end
end

function ui:refresh_all_list()
  self.v_uiobjects.EleSelect:SetActive(1 == self.v_type)
  self.v_uiobjects.JobSelect:SetActive(2 == self.v_type)
  self:refresh_right_visible(false)
  self.v_select_item = nil
  self:refresh_tag_list()
  self:refresh_buddy_list()
end

function ui:refresh_right_visible(visible)
  self.v_uiobjects.Right:SetActive(visible)
end

function ui:refresh_tag_list()
  local list = 1 == self.v_type and self.v_element_list or self.v_job_list
  self:give_back_auto_cache(character_voice_language_tag_key)
  for _, tag_type in pairs(list) do
    local item = self:get_auto_cache(character_voice_language_tag_key)
    self:refresh_tag_item(item, tag_type)
  end
end

function ui:refresh_tag_item(item, child_type)
  local select = Util.get_child_gameobj("Select/Image", item)
  select:SetActive(child_type == self.v_child_type)
  local red = Util.get_child_gameobj("TagName/Redpoint", item)
  red:SetActive(false)
  local btn = Util.get_button("touchBtn", item)
  btn.gameObject:SetActive(true)
  self:set_button_listener(btn, function()
    if self.v_child_type == child_type then
      return
    end
    self.v_child_type = child_type
    self:refresh_all_list()
  end)
  if 0 == child_type then
    return
  end
  local icon = Util.get_image("Icon", item)
  local tag_name = Util.get_text("TagName", item)
  local icon_path, name
  if 1 == self.v_type then
    local cfg = ShareRes.get_element_cfg(child_type)
    icon_path = cfg.ElementIconPath
    name = cfg.ElementName
  else
    local cfg = ShareRes.get_job_cfg(child_type)
    icon_path = cfg.IconPath
    name = cfg.Name
  end
  ResMgr:load_set_icon(icon, icon_path)
  tag_name.text = name
end

function ui:refresh_buddy_list()
  self:give_back_auto_cache(character_voice_language_item_key)
  local list = 1 == self.v_type and self.v_element_buddy_list[self.v_child_type] or self.v_job_buddy_list[self.v_child_type]
  
  local function sort_func(a, b)
    if a.own ~= b.own then
      return a.own
    elseif a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end
  
  table.sort(list, sort_func)
  local need_select_voice_buddy_item
  for _, data in pairs(list) do
    local item = self:get_auto_cache(character_voice_language_item_key)
    local voice_buddy_item = character_voice_buddy_item:ui_wrap_ex(self, item)
    voice_buddy_item.go = item
    item:SetActive(true)
    voice_buddy_item:set_data(data)
    local btn = Util.get_button(nil, item)
    self:set_button_listener(btn, function()
      self:on_item_click(voice_buddy_item)
    end)
    need_select_voice_buddy_item = need_select_voice_buddy_item or voice_buddy_item
  end
  if need_select_voice_buddy_item then
    self:on_item_click(need_select_voice_buddy_item)
    need_select_voice_buddy_item = nil
  end
end

function ui:on_item_click(voice_buddy_item)
  local is_can_click = voice_buddy_item:is_can_click()
  if not is_can_click then
    return
  end
  if self.v_select_item then
    if self.v_select_item:get_buddy_id() == voice_buddy_item:get_buddy_id() then
      return
    end
    self.v_select_item:set_select_visible(false)
  end
  self.v_select_item = voice_buddy_item
  self.v_select_item:set_select_visible(true)
  self.v_temp_select_language_index = nil
  self.v_uiobjects.Right:SetActive(true)
  self:refresh_right_language_count_info()
end

function ui:refresh_right_language_text(content)
  self.v_uicompents.NowLanguageTips_txt.text = Util.format_str("当前配音语言为<color=#efc66e>{1}</color>", content)
end

function ui:on_confirm_click()
  if self.v_temp_select_language_index == nil or self.v_select_item:get_language_index() == self.v_temp_select_language_index then
    return
  end
  self:change_cv_language(self.v_select_item:get_buddy_id(), Config.CommonDefine.INDEX_LANGUAGE[self.v_temp_select_language_index])
end

function ui:refresh_right_language_count_info(is_temp)
  self:give_back_auto_cache(character_voice_right_language_item_key)
  for i, language_index in pairs(self.v_cv_language_index_list) do
    local item_obj = self:get_auto_cache(character_voice_right_language_item_key)
    local select = self:get_child_gameobj("Select_", item_obj)
    if is_temp then
      select:SetActive(self.v_temp_select_language_index == language_index)
    else
      select:SetActive(self.v_select_item:get_language_index() == language_index)
    end
    local name = self:get_text("Text", item_obj)
    Util.set_color(name, select.activeSelf and "ffffff" or "909090")
    local language_str = Config.CommonDefine.INDEX_LANGUAGE[language_index]
    local language_id = Config.CommonDefine.LANGUAGE_CV_ID[language_str]
    name.text = LanguageMgr:get_code_text(language_id)
    local un_download = self:get_child_gameobj("UnDownload_", item_obj)
    local no_resourse = self:get_child_gameobj("NoResourse_", item_obj)
    un_download:SetActive(false)
    local select_buddy = self.v_select_item:get_buddy_id()
    local select_buddy_hide = ShareRes.get_buddy_cfg(select_buddy).HideType
    if 0 ~= select_buddy_hide and HIDE_LANGUAGE_TYPE[select_buddy_hide] == language_str then
      no_resourse:SetActive(true)
      local btn = self:get_button(nil, item_obj)
      self:set_button_listener(btn, function()
        Util.show_message_tip("暂未实装")
      end)
    else
      no_resourse:SetActive(false)
      if Game_AssetBundle then
        local format_size = CS.VoiceCheckManager.Instance:GetNeedDownloadSoundSize(language_str)
        un_download:SetActive(format_size and nil ~= format_size and "" ~= format_size)
      else
        un_download:SetActive(false)
      end
      local btn = self:get_button(nil, item_obj)
      self:set_button_listener(btn, function()
        self.v_temp_select_language_index = language_index
        self:refresh_right_language_count_info(true)
        self:play_voice(language_index)
      end)
    end
  end
end

function ui:play_voice(language_index)
  local buddy_id = self.v_select_item:get_buddy_id()
  local list = ShareRes.create("buddy.buddy_voice_client", buddy_id)
  local id
  for _, data in pairs(list) do
    if 20 == data.SortOrder then
      id = data.Id
      break
    end
  end
  if not id then
    return
  end
  local cfg = ShareRes.create("buddy.buddy_cv_preview", buddy_id)
  if not cfg then
    Log.Error("配音预览失败,角色CV语音.xlsm中的角色配音预览分页不存在该角色配置,角色Id:", buddy_id)
    return
  end
  local language_str = Config.CommonDefine.INDEX_LANGUAGE[language_index]
  local language_cfg = cfg[language_str]
  if not language_cfg then
    Log.Error("配音预览失败,角色CV语音.xlsm中的角色配音预览分页不存在该角色的语言配置,角色Id:", buddy_id, "语言:", language_str)
    return
  end
  local sound_name = language_cfg.SoundName
  Global.sound_mgr:remove_cache_voice_sound()
  Global.sound_mgr:play_sound_by_id(sound_name)
end

function ui:change_cv_language(buddy_id, language_str)
  local function cb()
    CharacterMgr:refresh_buddy_cv_language(buddy_id, language_str)
    
    Global.sound_mgr:remove_cache_voice_sound()
    self.v_select_item:refresh_language()
    self:refresh_right_language_count_info()
    Util.show_message_tip("切换成功")
  end
  
  if Game_AssetBundle then
    local format_size = CS.VoiceCheckManager.Instance:GetNeedDownloadSoundSize(language_str)
    if "" == format_size then
      cb()
    else
      Util.show_conform_tip(Util.format_str("切换该语音需要下载{1}对应音频文件,是否退出到登录界面？", format_size), "取消", "确认", function()
      end, function()
        CharacterMgr:refresh_buddy_cv_language(buddy_id, language_str)
        Global.sound_mgr:remove_cache_voice_sound()
        Util.change_to_other_language(Global.curr_language, Config.CommonDefine.LANGUAGE_TYPE.Voice)
      end)
    end
  else
    cb()
  end
end

function ui:ui_on_hide()
  self.v_select_item = nil
  self.v_temp_select_language_index = nil
  Global.sound_mgr:remove_cache_voice_sound()
end

return ui
