local M = Util.create_class()

function M:_init(npc)
  if get_cur_room_id() == 329031 then
    cast_missile(get_come_on_hero(), self.npc, nil, nil, 32903010201, 1)
    
    function M.on_self_missile_end_pos(M, pos_x, pos_z, missile_cfg, missile)
      if missile_cfg.Id == 32903010201 then
        cast_missile(get_come_on_hero(), self.npc, nil, nil, 32903010201, 1)
        abort_magic_by_id(get_come_on_hero(), 3290301)
      end
    end
  end
end

return M
