local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local UnityTime = UnityEngine.Time
local CanVasGroupType = typeof(UnityEngine.CanvasGroup)
local CSResLoader = CS.ResLoader
local EffectStatus = CSEffectStatus
local type_ui_particle = typeof(CS.UIParticleExtensions.UIParticle)
local _insert = table.insert
local _remove = table.remove

function M:_init(...)
  Base._init(self, ...)
  self.v_time = UnityTime.realtimeSinceStartup
  self.v_delay_cb_list = {}
  self.v_complete_num = 0
  self.v_effect_obj_list = {}
end

function M:on_destroy()
  Base.on_destroy(self)
end

function M:update()
  Base.update(self)
  local now_time = UnityTime.realtimeSinceStartup
  for index = #self.v_delay_cb_list, 1, -1 do
    local data = self.v_delay_cb_list[index]
    if now_time - self.v_time >= data.delay_time then
      if data.cb then
        data.cb()
      end
      _remove(self.v_delay_cb_list, index)
    end
  end
  self:check_effect_play_complete()
end

function M:start()
  local step_cfg = self.v_step_cfg
  self.v_effect_num = UtilTable.hash_lenth(step_cfg)
  self.v_is_play_end = false
  for _, effect_data in pairs(step_cfg) do
    self:update_effect_view(effect_data)
  end
end

function M:update_effect_view(effect_data)
  local effect_parent = Util.get_child_gameobj("SafeArea", self.v_lua_obj.v_object)
  local binding_id = effect_data.Character
  if binding_id and 0 ~= binding_id then
    local char_obj = self.v_uiobjects["Char" .. binding_id]
    if not self.v_lua_obj:check_cur_step_use_spine_res() then
      char_obj = self.v_uiobjects["CharImg" .. binding_id]
    end
    if char_obj then
      effect_parent = char_obj
    end
  end
  local now_time = UnityTime.realtimeSinceStartup
  local show_data = effect_data.show
  local hide_data = effect_data.hide
  if show_data and show_data.Enable then
    local show_delay_time = show_data.Delay
    if show_delay_time <= now_time - self.v_time then
      self:load_effect(effect_data, effect_parent)
    else
      local delat_data = {
        delay_time = show_delay_time,
        cb = function()
          self:load_effect(effect_data, effect_parent)
        end
      }
      _insert(self.v_delay_cb_list, delat_data)
    end
  elseif hide_data and hide_data.Enable then
    if effect_data.fadeOutTime and effect_data.fadeOutTime > 0.1 then
      local delat_data_fade = {
        delay_time = hide_data.Delay - effect_data.fadeOutTime,
        cb = function()
          local obj = self.v_lua_obj:get_effect_obj(effect_data.Res)
          if obj and not obj:IsNull() then
            local canvas_group = obj:GetComponent(CanVasGroupType)
            if not canvas_group or canvas_group:IsNull() ~= false then
              canvas_group = obj:AddComponent(CanVasGroupType)
            end
            local sequence = self:get_new_sequence("effect_fade_in")
            canvas_group.alpha = 1
            sequence:Append(canvas_group:DOFade(0, effect_data.fadeOutTime))
          end
        end
      }
      _insert(self.v_delay_cb_list, delat_data_fade)
    end
    local hide_delay_time = hide_data.Delay
    self.v_is_play_end = true
    if hide_delay_time <= now_time - self.v_time then
      self.v_lua_obj:release_effect_obj(effect_data.Res)
      self:check_complete()
    else
      local delat_data = {
        delay_time = hide_delay_time,
        cb = function()
          self.v_lua_obj:release_effect_obj(effect_data.Res)
          self:check_complete()
        end
      }
      _insert(self.v_delay_cb_list, delat_data)
    end
  else
    self:check_complete()
  end
end

function M:load_effect(effect_data, effect_parent)
  local layer = effect_data.Level
  local res_name = effect_data.Res
  local pos_x, pos_y, rot = effect_data.Pos[1], effect_data.Pos[2], effect_data.Pos[3]
  local flip_type = effect_data.Flip or 0
  local set_alpha = effect_data.effectAlpha or 1
  local need_change_alpha = set_alpha < 0.95
  
  local function callback(obj)
    obj.gameObject:SetActive(false)
    self.v_lua_obj:add_effect_obj(res_name, obj, layer, effect_parent, flip_type)
    obj.gameObject:ResetAttr()
    obj.transform:SetLocalPositionA(pos_x, pos_y, 0)
    obj.transform:SetLocalEuler(0, 0, rot or 0)
    obj.gameObject:SetActive(true)
    local uiPartical = obj:GetComponent(type_ui_particle)
    if uiPartical then
      uiPartical.scale = math.max(uiPartical.scale, math.min(Global.screen_factor, 2))
    end
    if need_change_alpha then
      CSHelper.SetEffectAlpha(obj.gameObject, set_alpha)
    end
    local now_time = UnityTime.realtimeSinceStartup
    local effect_state, length = EffectStatus.Bind(obj.gameObject)
    if effect_data.show and effect_data.show.Loop then
      length = -1
      effect_state:SetLoop(true)
    end
    effect_state:SetSpeed(effect_data.playSpeed or 1)
    local data = {
      effect_obj = obj,
      life_time = length,
      start_time = now_time
    }
    _insert(self.v_effect_obj_list, data)
    self:check_effect_play_complete()
    self:check_complete()
    if effect_data.fadeInTime and effect_data.fadeInTime > 0.1 then
      local canvas_group = obj:GetComponent(CanVasGroupType)
      if not canvas_group or canvas_group:IsNull() ~= false then
        canvas_group = obj:AddComponent(CanVasGroupType)
      end
      local sequence = self:get_new_sequence("effect_fade_in")
      canvas_group.alpha = 0
      sequence:Append(canvas_group:DOFade(1, effect_data.fadeInTime))
    end
  end
  
  ResPoolMgr:get_ui_effect_async(res_name, callback)
end

function M:check_complete()
  self.v_complete_num = self.v_complete_num + 1
  if self.v_complete_num < self.v_effect_num then
    return
  end
  if not self.v_is_play_end then
    return
  end
  self:complete()
end

function M:check_effect_play_complete()
  if self.v_is_play_end then
    return
  end
  if not self.v_lua_obj:check_cur_step_must_play() then
    self.v_is_play_end = true
    return
  end
  if #self.v_effect_obj_list <= 0 then
    self.v_is_play_end = true
    return
  end
  local now_time = UnityTime.realtimeSinceStartup
  local is_play_end = true
  for _, data in pairs(self.v_effect_obj_list) do
    local start_time = data.start_time
    if data.life_time > 0 and now_time - start_time < data.life_time then
      is_play_end = false
      break
    end
  end
  self.v_is_play_end = is_play_end
  if is_play_end then
    self:check_complete()
    self.v_effect_obj_list = {}
  end
end

return M
