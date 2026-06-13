local Base = require("obj.base_component")
local M = Util.create_child_mt(Base)
local LOGIC_FRAME = Config.LOGIC_FRAME
local Application = UnityEngine.Application
local RuntimePackage = require("manager.res.runtime_package")
local CSCriAtom = CS.CriWare.CriAtom
local UnityCurve = UnityEngine.AnimationCurve
local TypeCriAtomSource = typeof(CS.CriWare.CriAtomSource)
local EFFECT_SOUND_TYPE = {
  START = 1,
  LOOP = 2,
  END = 3,
  ANIM = 4
}
local LOAD_STATE = {LOADING = 1, LOADED = 2}
local LOOP_SOUND_TYPE = 4
local _os_time = os.time
local EFFECT_IDX_GO = 1
local EFFECT_IDX_STATUS = 4
local EFFECT_NAME = 14
local _tinsert = table.insert
local _tremove = table.remove

local function get_resouce_path(file, is_not_lower)
  if not is_not_lower then
    file = string.lower(file)
  end
  if not Game_AssetBundle then
    return Path.get_editor_sound_path(file)
  else
    return RuntimePackage.get_sound_path(file)
  end
end

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_char_transform = char.transform
  self.v_criware_obj_list = {}
  self.v_cache_sound_info = {}
  self.v_delay_cb_list = {}
  self.v_effect_go = {}
  Util.bind_msg(self, Const.MSG_ON_GAME_PAUSE, self.pause_scene_fade, self)
end

function M:on_before_destroy()
  if Global.sound_mgr then
    for effgo, effflag in pairs(self.v_effect_go) do
      if effflag then
        Global.sound_mgr:remove_effect_obj(effgo)
      end
    end
  end
  for _, obj_table in pairs(self.v_criware_obj_list) do
    local obj = obj_table.obj
    if obj and not obj:IsNull() then
      self:stop_sound(obj)
      UnityDestroy(obj)
    end
  end
  self.v_criware_obj_list = nil
  if self.v_cache_sound_info then
    for _, info in pairs(self.v_cache_sound_info) do
      CSCriAtom.RemoveCueSheet(info.cue_sheet)
    end
  end
  self.v_cache_sound_info = nil
  self.v_delay_cb_list = nil
  self.v_effect_go = nil
  self.v_char = nil
  self.v_char_transform = nil
  Util.unbind_all_msg(self)
end

function M:remove_effect_obj(obj_key)
  if Global.sound_mgr then
    Global.sound_mgr:remove_effect_obj(obj_key)
    self.v_effect_go[obj_key] = nil
    return
  end
  local obj, fade_time, cri_obj, cri_obj_loop, cri_obj_end, isLoop, is_triple
  if self.v_criware_obj_list[obj_key] then
    obj = self.v_criware_obj_list[obj_key].obj
    cri_obj = self.v_criware_obj_list[obj_key].cri_obj
    cri_obj_loop = self.v_criware_obj_list[obj_key].cri_obj_loop
    cri_obj_end = self.v_criware_obj_list[obj_key].cri_obj_end
    fade_time = self.v_criware_obj_list[obj_key].fade_time
    isLoop = self.v_criware_obj_list[obj_key].isLoop
    is_triple = self.v_criware_obj_list[obj_key].is_triple
  end
  if obj and not obj:IsNull() then
    if fade_time and fade_time > 0 then
      cri_obj.gameObject.transform.parent = nil
      
      local function callback()
        if obj and not obj:IsNull() then
          UnityDestroy(obj)
        end
        self.v_fade_data = nil
      end
      
      local fade_data = {
        cri_obj = cri_obj,
        cri_obj_loop = cri_obj_loop,
        cri_obj_end = cri_obj_end,
        fade_time = fade_time,
        curve = UnityCurve.Linear(0, cri_obj.volume, fade_time, 0),
        callback = callback,
        isLoop = isLoop,
        is_triple = is_triple
      }
      self:set_delay_task(fade_data)
    else
      self:stop_sound(obj)
      UnityDestroy(obj)
    end
  end
  self.v_criware_obj_list[obj_key] = nil
end

function M:stop_sound(criware_obj)
  local sound_source = criware_obj:GetComponents(TypeCriAtomSource)
  if not sound_source then
    return
  end
  if sound_source.Length > 0 then
    for i = 0, sound_source.Length - 1 do
      sound_source[i]:Stop()
    end
  end
end

function M:creat_criware_obj(effect_obj, fade_time, isLoop, is_triple)
  if self.v_criware_obj_list[effect_obj] then
    return
  end
  local obj = UnityGameObject()
  local cri_obj = obj:AddComponent(TypeCriAtomSource)
  local cri_obj_loop, cri_obj_end
  if is_triple then
    cri_obj_loop = obj:AddComponent(TypeCriAtomSource)
    cri_obj_end = obj:AddComponent(TypeCriAtomSource)
  end
  obj.name = "criware_obj"
  if fade_time and fade_time > 0 then
    obj.transform:SetParent(effect_obj.transform, false)
    self.v_criware_obj_list[effect_obj] = {
      obj = obj,
      fade_time = fade_time,
      cri_obj = cri_obj,
      cri_obj_loop = cri_obj_loop,
      cri_obj_end = cri_obj_end,
      isLoop = isLoop,
      is_triple = is_triple
    }
  else
    obj.transform:SetParent(effect_obj.transform, false)
    self.v_criware_obj_list[effect_obj] = {
      obj = obj,
      cri_obj = cri_obj,
      cri_obj_loop = cri_obj_loop,
      cri_obj_end = cri_obj_end,
      is_triple = is_triple
    }
  end
end

function M:play_sound_by_id(id, obj_key, eff_sound_type)
  local sound_acd, sound_name, source_type = ShareRes.get_play_sound_info(id)
  if not sound_name or "" == sound_name then
    return
  end
  self:play_sound(sound_acd, sound_name, obj_key, source_type, eff_sound_type)
end

function M:play_sound(cue_sheet, cue_name, obj_key, source_type, eff_sound_type)
  if DebugSetting:is_no_play_sound() then
    return
  end
  if not cue_sheet or not cue_name then
    return
  end
  local sound_info = self.v_cache_sound_info[cue_sheet]
  if sound_info and sound_info.load_state == LOAD_STATE.LOADING then
    self.v_loaded_callback_sound = self.v_loaded_callback_sound or {}
    
    local function sound_loaded_callback()
      if Util.is_nil(self.v_criware_obj_list[obj_key].obj) then
        return
      end
      self:play_sound(cue_sheet, cue_name, obj_key, source_type, eff_sound_type)
    end
    
    self.v_loaded_callback_sound[cue_sheet] = self.v_loaded_callback_sound[cue_sheet] or {}
    _tinsert(self.v_loaded_callback_sound[cue_sheet], sound_loaded_callback)
    if #self.v_loaded_callback_sound[cue_sheet] > 1000 then
      self.v_loaded_callback_sound[cue_sheet] = nil
      Log.Error("Too many of loaded callback sound effect sound mgr, check out the logic !!!")
    end
    return
  end
  sound_info = sound_info or {
    cue_sheet = cue_sheet,
    load_state = LOAD_STATE.LOADING
  }
  sound_info.cue_name = cue_name
  self.v_cache_sound_info[cue_sheet] = sound_info
  if sound_info.load_state == LOAD_STATE.LOADED then
    self:_play_sound(sound_info, obj_key, source_type, eff_sound_type)
    return
  end
  local cue_sheet_path = get_resouce_path(cue_sheet .. ".acb")
  
  local function callback()
    self.v_cache_sound_info[cue_sheet].load_state = LOAD_STATE.LOADED
    self:_play_sound(self.v_cache_sound_info[cue_sheet], obj_key, source_type, eff_sound_type)
    self:check_play_loading_sound(cue_sheet)
  end
  
  CompExtensions.LoadSound(callback, cue_sheet, cue_sheet_path, cue_name)
end

function M:check_play_loading_sound(cur_sheet)
  if not self.v_loaded_callback_sound or not self.v_loaded_callback_sound[cur_sheet] then
    return
  end
  local target_loaded = self.v_loaded_callback_sound[cur_sheet]
  for _, loaded_callback in pairs(target_loaded) do
    if loaded_callback then
      loaded_callback()
    end
  end
  self.v_loaded_callback_sound[cur_sheet] = nil
end

function M:_play_sound(sound_info, obj_key, source_type, eff_sound_type)
  if not self.v_criware_obj_list[obj_key] then
    return
  end
  local criware_obj = self.v_criware_obj_list[obj_key].obj
  if not criware_obj then
    return
  end
  local data = self.v_criware_obj_list[obj_key]
  local is_triple_effect = data.is_triple
  local sound_source = data.cri_obj
  if is_triple_effect then
    if eff_sound_type == EFFECT_SOUND_TYPE.LOOP then
      sound_source = data.cri_obj_loop
    elseif eff_sound_type == EFFECT_SOUND_TYPE.END then
      local sound_source_loop = data.cri_obj_loop
      sound_source:Stop()
      sound_source_loop:Stop()
      sound_source = data.cri_obj_end
    end
  end
  sound_source.volume = BattleSettingMgr:get_actual_voice_se()
  sound_source.loop = false
  sound_source.cueSheet = sound_info.cue_sheet
  sound_source.cueName = sound_info.cue_name
  sound_source:Play()
end

function M:play_effect_triple_sound(effect_data, play_type)
  if play_type == EFFECT_SOUND_TYPE.LOOP and effect_data.is_loop_sound then
    return
  end
  local effect_status = effect_data[EFFECT_IDX_STATUS]
  local effect_name = effect_data[EFFECT_NAME]
  local effect_obj = effect_data[EFFECT_IDX_GO]
  local effect_sound_cfg = ShareRes.get_effect_sound_cfg(effect_name)
  if not effect_sound_cfg then
    return
  end
  if Global.sound_mgr then
    Global.sound_mgr:play_effect_triple_sound(effect_data, play_type, self.v_char)
    self.v_effect_go[effect_obj] = true
    return
  end
  self:creat_criware_obj(effect_obj, effect_sound_cfg.FadeTime, effect_sound_cfg.IsLoop, effect_sound_cfg.IsTripleEffect)
  local is_triple_effect = effect_sound_cfg.IsTripleEffect
  local sound_list = effect_sound_cfg.EffectSoundName
  if not is_triple_effect and not effect_data.is_play_sound then
    for _, sound_id in pairs(sound_list) do
      if sound_id and "" ~= sound_id then
        self:play_sound_by_id(sound_id, effect_obj, play_type)
      end
    end
    effect_data.is_play_sound = true
    return
  end
  local sound_id = sound_list[play_type]
  if not sound_id or "" == sound_id then
    return
  end
  if play_type == EFFECT_SOUND_TYPE.LOOP and not effect_data.is_loop_sound then
    self:play_sound_by_id(sound_id, effect_obj, play_type)
    effect_data.is_loop_sound = true
  else
    self:play_sound_by_id(sound_id, effect_obj, play_type)
  end
end

function M:low_update()
  self:update_delay_task_cb()
end

function M:fade_sound(cur_fade_data, index)
  if not cur_fade_data then
    return
  end
  local fade_data = cur_fade_data
  fade_data.time = fade_data.time or 0
  if fade_data.time >= fade_data.fade_time then
    if fade_data.callback then
      fade_data.callback()
    end
    _tremove(self.v_delay_cb_list, index)
    return
  end
  fade_data.time = fade_data.time + LOGIC_FRAME
  if fade_data.isLoop and not Util.is_nil(fade_data.cri_obj) then
    fade_data.cri_obj:Stop()
    if fade_data.is_triple then
      fade_data.cri_obj_loop:Stop()
      fade_data.cri_obj_end:Stop()
    end
    fade_data.isLoop = nil
  end
end

function M:update_delay_task_cb()
  for index = #self.v_delay_cb_list, 1, -1 do
    local data = self.v_delay_cb_list[index]
    self:fade_sound(data, index)
  end
end

function M:set_delay_task(fade_data)
  _tinsert(self.v_delay_cb_list, fade_data)
end

function M:pause_scene_fade(pause)
  local sound_pause = false
  if pause.mm_x then
    sound_pause = true
  end
  if self.v_criware_obj_list ~= nil then
    for _, sound_data in pairs(self.v_criware_obj_list) do
      local cri_obj = sound_data.cri_obj
      if not Util.is_nil(cri_obj) then
        cri_obj:Pause(sound_pause)
      end
    end
  end
end

return M
