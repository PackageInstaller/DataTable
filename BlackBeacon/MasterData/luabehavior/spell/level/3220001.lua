local M = Util.create_class()

function M:_init()
end

function M:on_frame()
  if get_npc_attr(get_come_on_hero(), 1) < 10 then
    cast_magic(self.npc, get_come_on_hero(), 399933, 0)
    if get_sync_var("12w") == false and false == get_sync_var("34w") and false == get_sync_var("5w") then
      on_level_counter_add("1f", 0)
    elseif get_sync_var("12w") == true and false == get_sync_var("34w") and false == get_sync_var("5w") then
      on_level_counter_add("2f", 0)
    elseif get_sync_var("12w") == false and get_sync_var("34w") == true and false == get_sync_var("5w") then
      on_level_counter_add("3f", 0)
    elseif get_sync_var("12w") == true and get_sync_var("34w") == true and false == get_sync_var("5w") then
      on_level_counter_add("4f", 0)
    elseif get_sync_var("12w") == false and get_sync_var("34w") == true and get_sync_var("5w") == true then
      on_level_counter_add("5f", 0)
    end
    cast_magic(self.npc, get_come_on_hero(), 3220005, 0)
  end
end

return M
