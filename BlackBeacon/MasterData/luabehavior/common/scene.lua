local Class = require("glib.class")
local String = require("glib.extend.string")
local _dgetinfo = debug.getinfo
local _sreplace = String.Replace
local TransmitType = {
  [1] = "Fx_Transmit",
  [2] = "Fx_Transmit2",
  [3] = "Fx_Transmit3"
}

function GetBehaviorClass()
  local info = _dgetinfo(2, "S")
  local source = info.source
  source = source:match(".+common/luaBehavior/scene/(.*).lua$")
  source = _sreplace(source, "/", ".")
  return Class("CSceneBehavior" .. source, "CSceneBaseBehavior")
end

function creat_all_transmit(behavior, points_list, transmit_type, special_tp_list)
  for k, v in ipairs(points_list) do
    if not behavior:is_remove_tp(v) then
      local arg_map = {
        name = "Fx_Transmit3_idel"
      }
      if special_tp_list and special_tp_list[v] then
        arg_map.name = special_tp_list[v]
      end
      if transmit_type then
        behavior:create_world_model_on_position(TransmitType[transmit_type], "tppoint" .. k, v, nil, nil, arg_map)
      else
        behavior:create_world_model_on_position("Fx_Transmit3", "tppoint" .. k, v, nil, nil, arg_map)
      end
      behavior:open_tp_point(v)
    end
  end
end

function remove_all_transmit(behavior, points_list)
  for k, v in ipairs(points_list) do
    if behavior.m_mOpenTpPoint[v] then
      behavior:remove_tp("tppoint" .. k)
      self:remove_tp_point(v)
    end
  end
end

function judge_all_tp(behavior, points_list, area)
  if string.sub(area.Key, 1, 2) ~= "tp" then
    return
  end
  if not behavior:tp_point_is_open(area.Key) then
    return
  end
  if not behavior:is_pass_room() or behavior:is_in_challenge() then
    behavior:set_scene_tips(100186, true)
    return
  end
  for _, v in pairs(points_list) do
    local dir = tonumber(string.sub(v, -1))
    if v == area.Key and behavior:is_unlock_room_by_dir(dir) then
      behavior:tp_room(dir)
      return dir
    end
  end
end

function fire_and_ice(behavior, area)
  if area.Key == "fire" then
    behavior:timer_call_out_loop("fire_count", function()
      local iceValue = behavior:get_scene_powerbar_val("TYPE1")
      if iceValue > 0 then
        behavior:cast_magic(behavior.m_God, behavior.m_God, 4010202, 1)
      else
        behavior:cast_magic(behavior.m_God, behavior.m_God, 4010201, 1)
      end
    end, 0.5)
  elseif area.Key == "ice" then
    behavior:timer_call_out_loop("ice_count", function()
      local fireValue = behavior:get_scene_powerbar_val("TYPE2")
      if fireValue > 0 then
        behavior:cast_magic(behavior.m_God, behavior.m_God, 4010204, 1)
      else
        behavior:cast_magic(behavior.m_God, behavior.m_God, 4010203, 1)
      end
    end, 0.5)
  end
end

function end_perform(behavior, room_type)
  behavior:cast_magic(behavior.m_Hero, behavior.m_Hero, 1999132, 999)
  behavior:cast_magic(behavior.m_Hero, behavior.m_Hero, 1999133, 999)
  behavior:cast_magic(behavior.m_Hero, behavior.m_Hero, 1999172, 999)
end
