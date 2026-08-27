local __rt_1 = {}
local delivery_activity_sector_group = {
  {
    {
      activity_id = 1,
      en_name = "First",
      game_time = 90,
      guide_path_list = "UI_DeliverySimulatorGuide01",
      image_path = "1",
      is_friend_rank = true,
      max_order_num = 4,
      name = 137148,
      num = 1,
      order_num = 1,
      order_pool = 1,
      pre_condition = __rt_1,
      pre_para1 = __rt_1,
      pre_para2 = __rt_1,
      role_group = 2,
      scene_path = "DeliverySimulator_02",
      sector_id = 1,
      tips = __rt_1
    },
    {
      activity_id = 1,
      en_name = "Second",
      game_time = 90,
      guide_path_list = "",
      image_path = "2",
      is_friend_rank = true,
      max_order_num = 4,
      name = 93203,
      num = 2,
      order_num = 1,
      order_pool = 2,
      pre_condition = {12},
      pre_para1 = {1719869880},
      pre_para2 = {1726732799},
      role_group = 3,
      scene_path = "DeliverySimulator_04",
      sector_id = 2,
      tips = __rt_1
    },
    {
      activity_id = 1,
      en_name = "Third",
      game_time = 90,
      guide_path_list = "",
      image_path = "3",
      is_friend_rank = true,
      max_order_num = 4,
      name = 49258,
      num = 2,
      order_num = 1,
      order_pool = 3,
      pre_condition = {12, 45},
      pre_para1 = {1723755600, 1002},
      pre_para2 = {1726732799, 300},
      role_group = 4,
      scene_path = "DeliverySimulator_03",
      sector_id = 3,
      tips = __rt_1
    }
  }
}
return delivery_activity_sector_group
