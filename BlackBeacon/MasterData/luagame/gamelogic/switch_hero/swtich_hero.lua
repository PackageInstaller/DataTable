local M = {}

function M.check_switch_hero(hero_uuid, keycode, cur_hero_background)
  if M.is_switching then
    return
  end
  M.is_switching = true
  local go_out_hero_uuid = hero_uuid
  Network:call("c2gs_check_switch_hero", {uuid = go_out_hero_uuid}, function(ok, resp)
  end)
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  SceneMgr:switch_hero(hero_uuid, keycode, cur_hero_background)
end

function M.check_switch_robot_hero()
  M.do_switch_robot_hero()
end

function M.do_switch_robot_hero()
  MsgGame:mq_publish2(Const.MSG_DO_SWITCH_OPERATE_CHAR)
  Network:call("c2gs_switch_replace_hero", {})
end

function M.clear_switch_flag()
  M.is_switching = false
end

return M
