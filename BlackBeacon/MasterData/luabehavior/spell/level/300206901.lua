local M = Util.create_class()

function M:_init()
  set_skill_ban_use(2, true)
  set_skill_ban_use(5, true)
  set_skill_ban_use(7, true)
  cast_magic(get_come_on_hero(), get_come_on_hero(), 4032905, 1)
  self.penetrateNum = 0
  self.rewardList = {
    [1] = {score = 1, floatId = 300206902},
    [2] = {score = 2, floatId = 300206903},
    [3] = {score = 4, floatId = 300206904},
    [4] = {score = 8, floatId = 300206905},
    [5] = {score = 16, floatId = 300206906}
  }
end

function M:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  if 100100421 == skill_id and get_npc_id(hit_target) ~= 3002072 then
    self.penetrateNum = self.penetrateNum + 1
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if 100100421 == skill_id then
    local ninjaScore
    if self.penetrateNum >= 2 then
      ninjaScore = 2 ^ (self.penetrateNum - 2)
    else
      ninjaScore = 0
    end
    print("贯穿", self.penetrateNum, "得分", ninjaScore)
    for i = 1, #self.rewardList do
      if ninjaScore == self.rewardList[i].score then
        cast_magic(get_come_on_hero(), get_come_on_hero(), self.rewardList[i].floatId, 1, 1)
      end
    end
    if get_cur_room_id() == 800601 then
      add_task_progress(8006011, ninjaScore)
      add_task_progress(8006012, ninjaScore)
      add_task_progress(8006013, ninjaScore)
    end
    if get_cur_room_id() == 800602 then
      add_task_progress(8006021, ninjaScore)
      add_task_progress(8006022, ninjaScore)
      add_task_progress(8006023, ninjaScore)
    end
    if get_cur_room_id() == 800603 then
      add_task_progress(8006031, ninjaScore)
      add_task_progress(8006032, ninjaScore)
      add_task_progress(8006033, ninjaScore)
    end
    if get_cur_room_id() == 800604 then
      add_task_progress(8006041, ninjaScore)
      add_task_progress(8006042, ninjaScore)
      add_task_progress(8006043, ninjaScore)
    end
    self.penetrateNum = 0
  end
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if 300207108 == magic_id then
    set_skill_ban_use(3, true)
  end
end

function M:on_target_self_magic_end(npc, magic_id, magic_kind, magic_type, is_break)
  if 300207108 == magic_id then
    set_skill_ban_use(3, false)
  end
end

return M
