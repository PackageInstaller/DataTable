local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local monster = Util.create_class()

function monster._init(monster, npc)
  monster.npc = npc
end

function monster.on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  print("magic开始通知" .. tostring(magic_id.id) .. "magic的对象" .. tostring(npc))
  if magic_id.id == 300205702 then
    print("magic开始通知")
    cast_missile_new(get_come_on_hero(), get_come_on_hero(), nil, nil, 30020570101, 1)
  end
end

return monster
