local M = {
  {
    name = "通用",
    cmds = {
      {
        name = "加道具",
        Instruct = "award_item",
        ParamsKey = {
          "uuid",
          "item_id",
          "count",
          "arg1",
          "arg2",
          "arg3"
        },
        Tips = "发放奖励:玩家ID = {0},道具ID = {1},道具数量 = {2}"
      },
      {
        name = "一键添加道具",
        Instruct = "add_test_item",
        ParamsKey = {"uuid"},
        Tips = "该GM添加大量角色和武器培养道具"
      },
      {
        name = "跳过场景历程",
        Instruct = "complete_scene_journey",
        ParamsKey = {"uuid"},
        Tips = "该GM跳过所有场景历程"
      },
      {
        name = "一键高级号(慎用)",
        Instruct = "jump_newbie_data",
        ParamsKey = {"uuid"},
        Tips = "uuid = {0}"
      },
      {
        name = "一键低级号(慎用)",
        Instruct = "min_account",
        ParamsKey = {"uuid"},
        Tips = "uuid = {0}"
      },
      {
        name = "添加角色",
        Instruct = "award_item",
        ParamsKey = {
          "uuid",
          "item_id",
          "count"
        },
        Tips = "玩家ID = {0},角色ID = {1},数量 = {2}"
      },
      {
        name = "添加所有角色",
        Instruct = "add_all_hero",
        IsFunction = true
      },
      {
        name = "添加战斗中道具/装备",
        Instruct = "add_battle_item",
        ParamsKey = {
          "uuid",
          "item_id",
          "count"
        },
        Tips = "玩家ID = {0},道具ID = {1},道具数量 = {2}"
      },
      {
        name = "批量加道具",
        Instruct = "multi_add_item",
        ParamsKey = {
          "uuid",
          "item_id",
          "count"
        },
        Tips = "批量发道具,玩家ID={0},道具ID={1,2,4},道具数量={2,9,1},数量可对应匹配",
        IsFunction = true
      },
      {
        name = "开启所有系统",
        Instruct = "open_role_all_sys",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "重置关卡挑战次数",
        Instruct = "reset_challenge",
        ParamsKey = {
          "uuid",
          "chapter",
          "episode"
        },
        Tips = "玩家ID = {0},章节ID = {1}, 关卡ID = {2}"
      },
      {
        name = "跳过新手塔",
        Instruct = "skip_newbie_guide",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "自动跳过剧情",
        Instruct = "auto_skip_story",
        IsFunction = true
      },
      {
        name = "跳过见缝插针小游戏",
        Instruct = "auto_skip_insert_needle_game",
        IsFunction = true
      },
      {
        name = "播放剧情",
        Instruct = "play_story",
        ParamsKey = {"剧情ID"},
        IsFunction = true
      },
      {
        name = "播放文本剧情",
        Instruct = "play_desc_story",
        ParamsKey = {
          "文本剧情ID"
        },
        IsFunction = true
      },
      {
        name = "开始引导",
        Instruct = "enter_guide",
        ParamsKey = {"guide_id"},
        Tips = "引导id = {0}",
        IsFunction = true
      },
      {
        name = "完成当前引导",
        Instruct = "jump_guide",
        ParamsKey = {"guide_id"},
        Tips = "引导id = {0}",
        IsFunction = true
      },
      {
        name = "跳过所有引导",
        Instruct = "jump_all_guide",
        ParamsKey = {""},
        Tips = "",
        IsFunction = true
      },
      {
        name = "播放看板动作",
        Instruct = "signboard_action",
        ParamsKey = {"idx"},
        Tips = "看板反应ID {0}",
        IsFunction = true
      },
      {
        name = "音乐块回放",
        Instruct = "switch_block",
        ParamsKey = {"sound_name", "block_id"},
        Tips = "sound_name{0}, 块id{1}",
        IsFunction = true
      },
      {
        name = "BGM频道音量",
        Instruct = "set_aisac",
        ParamsKey = {
          "control_name",
          "set_value"
        },
        Tips = "控制名{0}, 设置值{1}",
        IsFunction = true
      },
      {
        name = "播放音频",
        Instruct = "play_sound_gm",
        ParamsKey = {"sound_name"},
        Tips = "sound_name{0}",
        IsFunction = true
      },
      {
        name = "音频BUS",
        Instruct = "set_bus",
        ParamsKey = {"bus_name", "level"},
        Tips = "sound_name{0}, level{1}",
        IsFunction = true
      },
      {
        name = "Spine动作组测试",
        Instruct = "open_uigm_spine",
        ParamsKey = {""},
        Tips = "",
        IsFunction = true
      },
      {
        name = "测试指定引导",
        Instruct = "test_guide",
        ParamsKey = {"guide_id"},
        Tips = "引导id={0}",
        IsFunction = true
      },
      {
        name = "跳过切层界面",
        Instruct = "jump_floor_ui",
        ParamsKey = {""},
        Tips = "",
        IsFunction = true
      },
      {
        name = "重置基建数据",
        Instruct = "clean_building",
        ParamsKey = {"uuid"},
        Tips = "玩家ID={0}"
      },
      {
        name = "所有添加线索",
        Instruct = "add_building_adventure_clue",
        ParamsKey = {"uuid"},
        Tips = "玩家ID={0}"
      },
      {
        name = "添加战斗中任务",
        Instruct = "add_battle_task",
        ParamsKey = {"uuid", "task_id"},
        Tips = "uuid = {0}, 任务id = {1}"
      },
      {
        name = "完成战斗中任务",
        Instruct = "complete_battle_task",
        ParamsKey = {"uuid", "task_id"},
        Tips = "uuid = {0}, 任务id = {1}"
      },
      {
        name = "背包武器全满级",
        Instruct = "force_equip_upgrade",
        ParamsKey = {"uuid"},
        Tips = "uuid = {0}"
      },
      {
        name = "背包角色全满级",
        Instruct = "force_buddy_upgrade",
        ParamsKey = {"uuid"},
        Tips = "uuid = {0}"
      },
      {
        name = "完成任务",
        Instruct = "complete_task",
        ParamsKey = {"uuid", "task"},
        Tips = "uuid = {0}, 任务id = {1}"
      },
      {
        name = "完成所有角色技能任务",
        Instruct = "complete_skill_task",
        ParamsKey = {"uuid"},
        Tips = "uuid = {0}"
      },
      {
        name = "清空仓库",
        Instruct = "clear_bag",
        IsFunction = true
      },
      {
        name = "修改陀螺仪影响系数",
        Instruct = "change_gyro_num",
        ParamsKey = {"左右", "上下"},
        Tips = "第一个是左右，第二个是上下",
        IsFunction = true
      },
      {
        name = "添加一个无尽排行榜数据",
        Instruct = "create_rank_data_infinite_new",
        ParamsKey = {
          "uuid",
          "infinite_id",
          "floor_num",
          "fight_time",
          "buddy1",
          "power1"
        },
        Tips = "玩家ID,无尽塔ID,层数,战斗时间,角色ID,战力"
      },
      {
        name = "清除无尽排行榜数据",
        Instruct = "clean_new_infinite_rank_data",
        ParamsKey = {
          "infinite_id"
        },
        Tips = "无尽塔ID"
      },
      {
        name = "批量添加无尽排行榜数据",
        Instruct = "create_rank_data_infinite_new_batch",
        ParamsKey = {
          "uuid",
          "infinite_id",
          "floor_num",
          "count",
          "start_uuid",
          "fight_time"
        },
        Tips = "玩家ID,无尽塔ID,层数,批量添加数据的数量,随便填一个数,战斗时间(不填就随机)"
      },
      {
        name = "开启周常pvp玩法",
        Instruct = "open_week_acty_pvp",
        ParamsKey = {"uuid"}
      },
      {
        name = "打开水管解谜游戏界面",
        Instruct = "open_water_pipe_game",
        IsFunction = true,
        ParamsKey = {"uuid"}
      },
      {
        name = "周常进入下一阶段",
        Instruct = "week_acty_open_next_state",
        ParamsKey = {"uuid"}
      },
      {
        name = "解锁全部档案",
        Instruct = "fininsh_all_enemy",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "测试CRI视频",
        Instruct = "play_cri_video",
        IsFunction = true,
        ParamsKey = {"video_name", "sound_name"},
        Tips = "测试cri视频:视频名 = {0},音效名(可不填,播放视频中的音频) = {1}"
      },
      {
        name = "执行场景历程事件",
        Instruct = "run_journey_event",
        ParamsKey = {"uuid"},
        IsFunction = true
      },
      {
        name = "测试 回归活动",
        Instruct = "run_return_act_test",
        ParamsKey = {""},
        IsFunction = true
      },
      {
        name = "切换场景氛围(输入主场景皮肤Id)",
        Instruct = "change_main_scene_fashion",
        ParamsKey = {
          "scene_fashion_id"
        },
        IsFunction = true
      },
      {
        name = "打开夏日活动主界面",
        Instruct = "open_summer_main_win",
        ParamsKey = {""},
        IsFunction = true
      },
      {
        name = "打开1.2版本主界面",
        Instruct = "open_version_win_1_2",
        ParamsKey = {""},
        IsFunction = true
      },
      {
        name = "重置扫雷",
        Instruct = "reset_minespeer",
        ParamsKey = {
          "uuid",
          "activity_id"
        },
        Tips = "玩家ID = {0},活动id = {1}"
      },
      {
        name = "测试 扫雷",
        Instruct = "run_minesweeper_act_test",
        ParamsKey = {""},
        IsFunction = true
      },
      {
        name = "扫雷跳层",
        Instruct = "minespeer_jump_to_floor",
        ParamsKey = {
          "uuid",
          "activity_id",
          "floor_idx"
        },
        Tips = "玩家ID = {0},活动id = {1}, 层{2}"
      },
      {
        name = "扫雷加见闻积分",
        Instruct = "minespeer_level_add_score",
        ParamsKey = {
          "uuid",
          "activity_id",
          "score"
        },
        Tips = "玩家ID = {0},活动id = {1}, 积分{2}"
      },
      {
        name = "设置最大积分",
        Instruct = "minespeer_set_max_score",
        ParamsKey = {
          "uuid",
          "activity_id",
          "score"
        },
        Tips = "玩家ID = {0},活动id = {1}, 积分{2}"
      },
      {
        name = "扫雷排行榜上榜",
        Instruct = "update_minesweeper_rank",
        ParamsKey = {
          "uuid",
          "activity_id",
          "score",
          "floor"
        },
        Tips = "玩家ID = {0},活动id = {1}, 积分{2}, 层{3}"
      }
    }
  },
  {
    name = "爬塔",
    cmds = {
      {
        name = "爬塔清除进度",
        Instruct = "clean_tower_info",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "爬塔直达指定类型房间",
        Instruct = "direct_to_target_room",
        ParamsKey = {
          "uuid",
          "tower_id",
          "target_floor",
          "room_id"
        },
        Tips = "玩家ID = {0},爬塔ID = {1},目标层数 = {2},房间号(非地图上的序号) = {3}"
      },
      {
        name = "爬塔一键通关",
        Instruct = "fight_through_tower",
        ParamsKey = {
          "uuid",
          "tower_id",
          "floor_idx",
          "room_num"
        },
        Tips = "玩家ID = {0},爬塔ID = {1},楼层索引 = {2},层索引 = {3}"
      },
      {
        name = "GM信息打印",
        Instruct = "print_gm_info",
        ParamsKey = {""},
        Tips = "GM信息打印",
        IsFunction = true
      }
    }
  },
  {
    name = "其他",
    cmds = {
      {
        name = "重置账号信息",
        Instruct = "reset_player",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "设置账号等级",
        Instruct = "set_level",
        ParamsKey = {"uuid", "lv"},
        Tips = "玩家ID = {0},目标等级 = {1}"
      },
      {
        name = "设置玩家账号对应版署等级",
        Instruct = "set_role_publish_level",
        ParamsKey = {"uuid", "game_level"},
        Tips = "玩家ID = {0},版署等级 = {1}"
      },
      {
        name = "更新资源",
        Instruct = "update_res",
        ParamsKey = {},
        Tips = "更新资源(CS协议, 配置)"
      },
      {
        name = "查看当前服务器时间",
        Instruct = "get_time",
        ParamsKey = {},
        Tips = ""
      },
      {
        name = "创建全服公告",
        Instruct = "create_notice",
        ParamsKey = {
          "title",
          "content",
          "start_time",
          "end_time",
          "notice_type"
        },
        Tips = "标题 = {0},内容 = {1},公告开始时间 = {2},公告结束时间 = {3},公告类型 = {4}"
      },
      {
        name = "删除全服公告",
        Instruct = "del_notice",
        ParamsKey = {"index"},
        Tips = "编号 = {0}"
      },
      {
        name = "备份账号",
        Instruct = "creat_player_snapshot",
        ParamsKey = {"uuid"},
        Tips = ""
      },
      {
        name = "恢复账号",
        Instruct = "restore_player_snapshot",
        ParamsKey = {"uuid"},
        Tips = ""
      },
      {
        name = "报错上传开关",
        Instruct = "upload_error",
        IsFunction = true
      },
      {
        name = "寻路调试开启",
        Instruct = "open_find_path_debug",
        IsFunction = true
      },
      {
        name = "主界面陀螺仪调试",
        Instruct = "gyro_debug",
        ParamsKey = {"idx", "value"},
        Tips = "idx = 1速度 2转角限制 3冷却 4触发阈值 5回弹速度",
        IsFunction = true
      },
      {
        name = "档案缩放调试",
        Instruct = "archive_debug",
        ParamsKey = {"idx", "value"},
        Tips = "idx = 1缩放速度 2缩放最大值 3缩放最小值",
        IsFunction = true
      },
      {
        name = "获取\n机器人战力",
        Instruct = "get_fixed_buddy_power",
        ParamsKey = {
          "uuid",
          "fixed_buddy_id"
        },
        Tips = "机器人ID"
      },
      {
        name = "插针小游戏",
        Instruct = "play_insert_needle",
        ParamsKey = {"id"},
        Tips = "id",
        IsFunction = true
      },
      {
        name = "恩基大逃亡",
        Instruct = "play_catch_cat",
        ParamsKey = {"id"},
        Tips = "关卡id",
        IsFunction = true
      },
      {
        name = "拼图小游戏",
        Instruct = "play_puzzle_game",
        ParamsKey = {"stage_id"},
        Tips = "（留空则打开关卡列表界面）关卡Id",
        IsFunction = true
      },
      {
        name = "音游小游戏",
        Instruct = "play_music_game",
        ParamsKey = {"chapter_id", "stage_id"},
        Tips = "（留空则打开副本界面）副本Id, 关卡Id",
        IsFunction = true
      },
      {
        name = "钓鱼小游戏",
        Instruct = "play_fish_game",
        IsFunction = true
      },
      {
        name = "幽思迷宫小游戏",
        Instruct = "play_ponder_maze_game",
        Tips = "传入活动ID",
        ParamsKey = {
          "activity_id"
        },
        IsFunction = true
      },
      {
        name = "完成任务组",
        Instruct = "complete_task_group",
        ParamsKey = {"uuid", "task"},
        Tips = "uuid = {0}, 任务id = {1}",
        IsFunction = true
      },
      {
        name = "主界面登录镜头速度",
        Instruct = "signboard_movie_speed",
        ParamsKey = {
          "speed_times"
        },
        Tips = "speed_times 倍速",
        IsFunction = true
      },
      {
        name = "相框缩放调试",
        Instruct = "photo_scale_debug",
        ParamsKey = {"idx", "value"},
        Tips = "idx = 1双指缩放速度 2鼠标滚轮缩放速度 0,0重置为配置速度",
        IsFunction = true
      },
      {
        name = "关系网缩放调试",
        Instruct = "char_map_debug",
        ParamsKey = {"idx", "value"},
        Tips = "idx = 1缩放速度 2缩放最大值 3缩放最小值",
        IsFunction = true
      },
      {
        name = "角色展示\n拖拽旋转限速",
        Instruct = "set_char_rotate_limit",
        ParamsKey = {"value"},
        Tips = " 速度上限 (公共配置CharRtViewRotateSpeedMax)",
        IsFunction = true
      },
      {
        name = "跳过部分新号流程",
        Instruct = "skip_new_player_flow",
        ParamsKey = {"uuid"},
        IsFunction = true
      },
      {
        name = "接中台任务组",
        Instruct = "accept_center_task",
        Tips = " uuid: 玩家ID, 中台任务组id",
        ParamsKey = {"uuid", "group_id"}
      },
      {
        name = "接所有中台任务组",
        Instruct = "accept_all_center_task",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "开启相机遮挡剔除",
        Instruct = "enable_camera_occlusion_culling",
        IsFunction = true
      },
      {
        name = "开启纹理流",
        Instruct = "enable_texture_streaming",
        IsFunction = true
      },
      {
        name = "开启shader预加载",
        Instruct = "enable_shader_prewarm",
        IsFunction = true
      },
      {
        name = "刷新基建入口绑定坐标",
        Instruct = "refresh_building_bind",
        Tips = "移动场景中的绑定节点后刷新",
        ParamsKey = {"uuid"},
        IsFunction = true
      },
      {
        name = "基建陀螺仪调试",
        Instruct = "building_gyro_debug",
        ParamsKey = {"idx", "value"},
        Tips = "idx = 1速度 2转角限制 3冷却 4触发阈值 5回弹速度",
        IsFunction = true
      }
    }
  },
  {
    name = "调试",
    cmds = {
      {
        name = "设置Windows滚动条灵敏度",
        Instruct = "set_windows_scroll_rect_sensitivity",
        ParamsKey = {
          "sensitivity"
        },
        IsFunction = true,
        Tips = "sensitivity = {0}"
      },
      {
        name = "设置窗口模式",
        Instruct = "set_window_mode",
        ParamsKey = {"width", "height"},
        IsFunction = true,
        Tips = "width = {0}, height = {1}"
      },
      {
        name = "设置无边框模式",
        Instruct = "set_borderless_mode",
        ParamsKey = {"width", "height"},
        IsFunction = true,
        Tips = "width = {0}, height = {1}"
      },
      {
        name = "设置全屏模式",
        Instruct = "set_fullscreen_mode",
        ParamsKey = {"width", "height"},
        IsFunction = true,
        Tips = "width = {0}, height = {1}"
      },
      {
        name = "显示patch版本信息",
        Instruct = "show_patch_version_info",
        IsFunction = true
      },
      {
        name = "显示build版本信息",
        Instruct = "show_build_version_info",
        IsFunction = true
      },
      {
        name = "请求天成live update md5",
        Instruct = "request_tsi_update_md5",
        IsFunction = true
      },
      {
        name = "请求天成官服服务器列表",
        Instruct = "request_tsi_live_server_list",
        IsFunction = true
      },
      {
        name = "请求天成渠道服服务器列表",
        Instruct = "request_tsi_live_qd_server_list",
        IsFunction = true
      },
      {
        name = "重启游戏",
        Instruct = "restart_game",
        IsFunction = true
      },
      {
        name = "退出游戏",
        Instruct = "quit_game",
        IsFunction = true
      },
      {
        name = "启动UWA",
        Instruct = "start_uwa",
        IsFunction = true
      },
      {
        name = "创建GooglePlayGamesInputor",
        Instruct = "instantiate_google_play_games_inputor",
        IsFunction = true
      },
      {
        name = "设置Hive SDK 沙盒",
        Instruct = "set_hive_zone",
        IsFunction = true
      },
      {
        name = "显示对游戏评分弹窗",
        Instruct = "show_review",
        IsFunction = true
      },
      {
        name = "是否是平板",
        Instruct = "is_tablet",
        IsFunction = true
      },
      {
        name = "设置QualitySettings.antiAliasing",
        Instruct = "set_antialiasing",
        ParamsKey = {
          "anti_aliasing"
        },
        IsFunction = true
      },
      {
        name = "设置RenderTexture MSAA等级",
        Instruct = "set_render_texture_msaa",
        IsFunction = true
      },
      {
        name = "隐藏ui",
        Instruct = "cull_ui",
        IsFunction = true
      },
      {
        name = "关闭CustomResolveCamera",
        Instruct = "disable_custom_resolve_camera",
        IsFunction = true
      },
      {
        name = "RT渲染 深度图调试",
        Instruct = "gm_rt_test",
        ParamsKey = {"tex_select"},
        Tips = "贴图选择 1-colorPost  2-color  3-depthTex  4-depth",
        IsFunction = true
      },
      {
        name = "隐藏特效",
        Instruct = "hide_effect",
        IsFunction = true
      },
      {
        name = "每隔1秒输出功率到日志",
        Instruct = "enable_log_power",
        IsFunction = true
      },
      {
        name = "开关草地",
        Instruct = "set_grass_enable",
        IsFunction = true
      },
      {
        name = "草地裁剪距离",
        Instruct = "set_grass_draw_distance",
        IsFunction = true,
        ParamsKey = {"distance"}
      },
      {
        name = "相机剔除",
        Instruct = "camera_cull",
        IsFunction = true
      },
      {
        name = "调试冗余预加载特效",
        Instruct = "start_debug_uesless_preload_fx",
        IsFunction = true
      },
      {
        name = "输出冗余预加载特效",
        Instruct = "log_uesless_preload_fx",
        IsFunction = true
      },
      {
        name = "输出设备唯一标识符",
        Instruct = "log_device_unique_identifier",
        IsFunction = true
      },
      {
        name = "调试未预加载npc",
        Instruct = "set_debug_preload_npc",
        IsFunction = true
      },
      {
        name = "调试未预加载资源",
        Instruct = "set_debug_res",
        IsFunction = true
      },
      {
        name = "显示dynamic ui ",
        Instruct = "set_dynamic_ui_enable",
        IsFunction = true
      },
      {
        name = "显示伤害跳字",
        Instruct = "set_hurt_root_enable",
        IsFunction = true
      },
      {
        name = "显示血条",
        Instruct = "set_hp_root_enable",
        IsFunction = true
      },
      {
        name = "开关物体",
        Instruct = "set_obj_visible",
        IsFunction = true,
        ParamsKey = {"name"}
      },
      {
        name = "相机裁剪距离",
        Instruct = "camera_cull_distance",
        IsFunction = true,
        ParamsKey = {"distance"}
      },
      {
        name = "开关箭头特效",
        Instruct = "set_all_arrow_fx_visibility",
        IsFunction = true
      },
      {
        name = "上传log",
        Instruct = "upload_log",
        IsFunction = true
      },
      {
        name = "显示内存信息",
        Instruct = "switch_memory_stat",
        IsFunction = true
      },
      {
        name = "设置帧率",
        Instruct = "set_fps",
        ParamsKey = {"fps"},
        IsFunction = true
      },
      {
        name = "创建敌军怪物",
        Instruct = "create_enemy_monster",
        ParamsKey = {"monster_id", "num"},
        IsFunction = true,
        Tips = "怪物Id,数量"
      },
      {
        name = "创建友军怪物",
        Instruct = "create_friend_monster",
        ParamsKey = {"monster_id", "num"},
        IsFunction = true,
        Tips = "怪物Id,数量"
      },
      {
        name = "创建测试模型",
        Instruct = "create_test_model_pnl",
        IsFunction = true
      },
      {
        name = "设置配置等级",
        Instruct = "set_quality_level",
        ParamsKey = {
          "quality_level"
        },
        IsFunction = true
      },
      {
        name = "开关transparent clip",
        Instruct = "toggle_transparent_clip",
        IsFunction = true
      },
      {
        name = "开关后处理",
        Instruct = "toggle_post_process",
        IsFunction = true
      },
      {
        name = "开关hdr",
        Instruct = "enable_hdr",
        IsFunction = true
      },
      {
        name = "开关Bloom",
        Instruct = "toggle_bloom",
        IsFunction = true
      },
      {
        name = "开关DepthOfField",
        Instruct = "toggle_depth_of_field",
        IsFunction = true
      },
      {
        name = "开关FXAA",
        Instruct = "toggle_fxaa",
        IsFunction = true
      },
      {
        name = "开关阴影",
        Instruct = "toggle_shadow",
        IsFunction = true
      },
      {
        name = "开关LUT",
        Instruct = "toggle_lut",
        IsFunction = true
      },
      {
        name = "开关扭曲",
        Instruct = "toggle_distortion",
        IsFunction = true
      },
      {
        name = "开关曲线调试",
        Instruct = "toggle_spline_debug",
        IsFunction = true
      },
      {
        name = "开启战斗中测试日志",
        Instruct = "open_battle_test_log_push",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "关闭战斗中测试日志",
        Instruct = "close_battle_test_log_push",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "显示systeminfo",
        Instruct = "show_systeminfo",
        IsFunction = true
      },
      {
        name = "开关看板娘位置变换",
        Instruct = "change_signboard_camera",
        IsFunction = true
      },
      {
        name = "停止更新",
        Instruct = "stop_update",
        IsFunction = true
      },
      {
        name = "隐藏界面",
        Instruct = "hide_all_ui",
        IsFunction = true
      },
      {
        name = "展示角色技能任务",
        Instruct = "show_skill_task_id",
        IsFunction = true
      },
      {
        name = "当前角色自杀",
        Instruct = "cur_hero_suicide",
        IsFunction = true
      },
      {
        name = "场景内怪物自杀",
        Instruct = "npc_np_by_1",
        IsFunction = true
      },
      {
        name = "隐藏怪物",
        Instruct = "hide_monster",
        IsFunction = true
      },
      {
        name = "停止behavior",
        Instruct = "stop_behavior",
        IsFunction = true
      },
      {
        name = "收集引用的图片",
        Instruct = "open_img_collect",
        IsFunction = true
      },
      {
        name = "显示地图点位",
        Instruct = "show_scene_position",
        IsFunction = true
      },
      {
        name = "开关触屏提示特效",
        Instruct = "show_touch_effect",
        IsFunction = true
      },
      {
        name = "创建调试代码",
        Instruct = "create_debug_code",
        IsFunction = true,
        ParamsKey = {"file_name", "code_text"}
      },
      {
        name = "播放视频",
        Instruct = "play_video",
        IsFunction = true,
        ParamsKey = {"file_name"}
      },
      {
        name = "停止视频",
        Instruct = "stop_video",
        IsFunction = true
      },
      {
        name = "隐藏怪物指引脚标",
        Instruct = "hide_monster_footmark",
        IsFunction = true
      },
      {
        name = "单机创建\ngodNpc",
        Instruct = "gm_create_god_npc_in_client",
        IsFunction = true,
        Tips = "god npc id = {0}",
        ParamsKey = {"char_id"}
      },
      {
        name = "设置战斗日志输出上限数量",
        Instruct = "set_fight_log_write_length",
        IsFunction = true,
        Tips = "超出上限则写入fightlog文件中 数量 = {0}",
        ParamsKey = {"max_num"}
      },
      {
        name = "开启战斗UI不显示调试",
        Instruct = "gm_open_uifight_test",
        IsFunction = true,
        Tips = "god npc id = {0}",
        ParamsKey = {"char_id"}
      },
      {
        name = "一键999999",
        Instruct = "gm_oen_button_9999999",
        IsFunction = true,
        Tips = ""
      },
      {
        name = "开启magic_param数量调试",
        Instruct = "open_debug_magic_parpam_count",
        IsFunction = true,
        ParamsKey = {"code_text"}
      },
      {
        name = "运行lua调试代码",
        Instruct = "run_debug_code",
        IsFunction = true,
        ParamsKey = {"code_text"}
      },
      {
        name = "设置特效质量",
        Instruct = "set_effect_quality",
        IsFunction = true,
        Tips = "从低到高 1 2 3 4",
        ParamsKey = {"quality_lv"}
      },
      {
        name = "双指缩放调试",
        Instruct = "pinch_debug",
        IsFunction = true,
        ParamsKey = {
          "pinch_limit_min",
          "pinch_limit_max",
          "d2s_distance",
          "s2d_distance"
        },
        Tips = "单次操作下界,单次操作上界,俯视角到自由距离,自由到俯视角距离"
      },
      {
        name = "输出动画融合配置所用名",
        Instruct = "debug_transition_cfg_name",
        IsFunction = true,
        ParamsKey = {}
      },
      {
        name = "开始接收lua调试代码",
        Instruct = "start_listen_lua_code",
        IsFunction = true,
        ParamsKey = {"port"},
        Tips = "通过工具/开发/Lua代码调试器发送lua代码在真机上执行. 参数：端口号默认65535"
      },
      {
        name = "开启LuaProfiler调试",
        Instruct = "enable_luaprofiler_debug",
        IsFunction = true
      },
      {
        name = "显示GPG参数",
        Instruct = "show_google_utility_params",
        IsFunction = true,
        ParamsKey = {},
        Tips = "显示GPG参数"
      },
      {
        name = "启用时间缩放调试",
        Instruct = "enable_time_scale_debug",
        IsFunction = true,
        Tips = "启用时间缩放调试"
      }
    }
  },
  {
    name = "后端GM",
    cmds = {
      {
        name = "置顶指定卡牌",
        Instruct = "force_choose_card",
        ParamsKey = {"uuid", "card_id"},
        Tips = "uuid = {0},目标卡牌 = {1}"
      },
      {
        name = "系统通知",
        Instruct = "system_notify",
        ParamsKey = {"type", "msg"},
        Tips = "消息类型(0:文字, 1:语音, 2:组队邀请, 3:跑马灯消息)={0} , 通知内容={1} "
      },
      {
        name = "生成排行榜数据",
        Instruct = "create_rank_data",
        ParamsKey = {
          "uuid",
          "rank_name",
          "count",
          "min_score",
          "max_score",
          "base_name"
        },
        Tips = "玩家ID = {0},排行榜名称={1},数量={2},积分下限={3},积分上限={4},角色基础名字={5} "
      },
      {
        name = "增加全服对怪物评论支持数",
        Instruct = "add_monster_gesture",
        ParamsKey = {
          "uuid",
          "monster_id",
          "gesture",
          "playernum"
        },
        Tips = "玩家ID={0},怪物ID={1},1踩2赞 ={2},增加的人数={3}"
      },
      {
        name = "增加全服对怪物评论分数",
        Instruct = "add_monster_fraction",
        ParamsKey = {
          "uuid",
          "monster_id",
          "fraction",
          "difficulty"
        },
        Tips = "玩家ID={0},怪物ID={1},评分 ={2},难度={3}"
      },
      {
        name = "添加好感度道具",
        Instruct = "add_buddy_favorability",
        ParamsKey = {
          "uuid",
          "buddy_id",
          "count"
        },
        Tips = "玩家ID={0},角色ID={1},数量 ={2}"
      },
      {
        name = "开启战力Log",
        Instruct = "open_buddy_attr_log",
        ParamsKey = {"uuid", "is_open"},
        Tips = "玩家ID={0},状态={1开/0关}"
      }
    }
  },
  {
    name = "充值",
    cmds = {
      {
        name = "充值",
        Instruct = "recharge_sdkkey",
        ParamsKey = {"uuid", "sdk_key"},
        Tips = "uuid = {0}, sdk_key = {1}"
      },
      {
        name = "tsi sdk 充值",
        Instruct = "tsi_pay",
        ParamsKey = {"product_id"},
        Tips = "product_id={0}",
        IsFunction = true
      },
      {
        name = "hive sdk 充值",
        Instruct = "hive_pay",
        ParamsKey = {"product_id"},
        Tips = "product_id={0}",
        IsFunction = true
      }
    }
  },
  {
    name = "掉落调试",
    cmds = {
      {
        name = "掉落调试",
        Instruct = "check_drop_data",
        ParamsKey = {
          "uuid",
          "drop_id",
          "num",
          "is_reset"
        },
        Tips = "uuid = {0},掉落Id={1},次数={2}, 是否重置={3}（重置1 不重置0）"
      },
      {
        name = "添加战斗饰品",
        Instruct = "add_battle_ornaments",
        ParamsKey = {
          "uuid",
          "ornaments_id",
          "pos"
        },
        Tips = "添加战斗饰品,玩家ID={0},饰品ID={1},位置={2}"
      },
      {
        name = "批量添加战斗饰品",
        Instruct = "add_battle_ornament_list",
        ParamsKey = {
          "uuid",
          "ornament_list_str"
        },
        Tips = "玩家ID={0},饰品ID列表={1}",
        IsFunction = true
      },
      {
        name = "添加buff",
        Instruct = "add_battle_buff",
        ParamsKey = {"uuid", "id"},
        Tips = "玩家ID={0},BUFF ID={1}"
      },
      {
        name = "移除buff",
        Instruct = "remove_battle_buff",
        ParamsKey = {"uuid", "id"},
        Tips = "玩家ID={0},BUFF ID={1}"
      },
      {
        name = "打印身上存在buff",
        Instruct = "dump_buff",
        ParamsKey = {"uuid"},
        Tips = "玩家ID={0}"
      },
      {
        name = "损坏指定饰品",
        Instruct = "break_ornament",
        ParamsKey = {
          "uuid",
          "ornament_id"
        },
        Tips = "损坏指定饰品,玩家ID={0},饰品 ID={1}"
      },
      {
        name = "修复指定饰品",
        Instruct = "refresh_ornament",
        ParamsKey = {
          "uuid",
          "ornament_id"
        },
        Tips = "修复指定饰品,玩家ID={0},饰品 ID={1}"
      },
      {
        name = "移除指定饰品",
        Instruct = "remove_ornament",
        ParamsKey = {
          "uuid",
          "ornament_id"
        },
        Tips = "移除指定饰品,玩家ID={0},饰品 ID={1}"
      },
      {
        name = "清除关卡宝箱",
        Instruct = "clean_episode_box_data",
        ParamsKey = {"uuid", "box_id"},
        Tips = "玩家ID={0},box_id={1}"
      },
      {
        name = "清除全部关卡宝箱",
        Instruct = "clean_all_episode_box_data",
        ParamsKey = {"uuid"},
        Tips = "玩家ID={0}",
        IsFunction = true
      }
    }
  },
  {
    name = "发放资源",
    cmds = {
      {
        name = "一键发圣遗物",
        Instruct = "add_relic_item",
        ParamsKey = {"uuid"},
        Tips = "发放所有圣遗物道具,玩家ID={0}"
      },
      {
        name = "一键发放宝石",
        Instruct = "add_gemstone_item",
        ParamsKey = {"uuid"},
        Tips = "发放所有镶嵌宝石,玩家ID={0}"
      }
    }
  },
  {
    name = "命运之书",
    cmds = {
      {
        name = "添加能力",
        Instruct = "add_ability",
        ParamsKey = {"uuid", "ability_id"},
        Tips = "玩家ID={0},能力ID={1}"
      },
      {
        name = "添加所有能力",
        Instruct = "add_all_ability",
        ParamsKey = {"uuid"},
        Tips = "玩家ID = {0}"
      },
      {
        name = "升级指定能力",
        Instruct = "upgrade_ability",
        ParamsKey = {"uuid", "ability_id"},
        Tips = "玩家ID = {0},能力ID={1}"
      },
      {
        name = "开启环跳过按钮",
        Instruct = "gm_oepn_ring_skip_btn",
        IsFunction = true,
        Tips = "god npc id = {0}",
        ParamsKey = {"char_id"}
      },
      {
        name = "增减迷失值",
        Instruct = "operation_curse_cicle_value",
        Tips = "uuid: 玩家ID, value: 诅咒值数值",
        ParamsKey = {"uuid", "value"}
      },
      {
        name = "替换指定诅咒",
        Instruct = "replace_curse_buff",
        Tips = "uuid: 玩家ID, buff: buff id pos:位置",
        ParamsKey = {
          "uuid",
          "buff",
          "pos"
        }
      },
      {
        name = "跳转至指定事件",
        Instruct = "curse_change_card_event_id",
        Tips = " uuid: 玩家ID, event: 事件id",
        ParamsKey = {"uuid", "event"}
      },
      {
        name = "替换指定任务",
        Instruct = "curse_change_card_task_id",
        Tips = "uuid: 玩家ID, old_task: old任务ID task:任务ID",
        ParamsKey = {
          "uuid",
          "old_task",
          "task"
        }
      },
      {
        name = "增减金币（光尘）",
        Instruct = "operation_curse_cicle_money_value",
        Tips = " uuid: 玩家ID, value: 数值",
        ParamsKey = {"uuid", "value"}
      },
      {
        name = "设置命运等级",
        Instruct = "set_destiny_level",
        Tips = " uuid: 玩家ID, ring_id: 数值, level: 数值",
        ParamsKey = {
          "uuid",
          "curse_id",
          "level"
        }
      },
      {
        name = "方程升级",
        Instruct = "equation_level_up",
        Tips = " uuid: 玩家ID, equation_id: 方程ID",
        ParamsKey = {
          "uuid",
          "equation_id"
        },
        IsFunction = true
      },
      {
        name = "方程掉落",
        Instruct = "drop_equation",
        Tips = " uuid: 玩家ID, drop_id: 掉落ID",
        ParamsKey = {"uuid", "drop_id"}
      },
      {
        name = "添加方程",
        Instruct = "add_equation",
        Tips = " uuid: 玩家ID, equation_id: 方程ID",
        ParamsKey = {
          "uuid",
          "equation_id"
        }
      },
      {
        name = "添加多个指定流派能力",
        Instruct = "add_genres_ability",
        Tips = " uuid: 玩家ID, genres_id: count:",
        ParamsKey = {
          "uuid",
          "genres_id",
          "count"
        },
        IsFunction = true
      },
      {
        name = "返回环界面调试",
        Instruct = "back_ring_debug",
        Tips = "返回环界面调试",
        ParamsKey = {},
        IsFunction = true
      },
      {
        name = "开放所有环",
        Instruct = "finish_target_curse",
        ParamsKey = {"uuid"},
        Tips = "开放所有环"
      }
    }
  },
  {
    name = "主线gm",
    cmds = {
      {
        name = "完成所有主线章节",
        Instruct = "complete_all_chapter",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成主线章节",
        Instruct = "complete_to_chapter",
        Tips = " uuid: 玩家ID, 章(1-n), 节(1-n), 类型(1主线,2挑战关,3困难模式)",
        ParamsKey = {
          "uuid",
          "chapter_index",
          "index",
          "type"
        }
      },
      {
        name = "完成番外",
        Instruct = "complete_to_extra_chapter",
        Tips = " uuid: 玩家ID, 章(1-n), 节(1-n)",
        ParamsKey = {
          "uuid",
          "chapter_index",
          "index"
        }
      },
      {
        name = "清空主线(需要重登)",
        Instruct = "clean_all_chapter",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前主线",
        Instruct = "complete_long_chapter",
        Tips = " uuid: 玩家ID， ",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前挑战关",
        Instruct = "complete_challenge_chapter",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前困难模式",
        Instruct = "complete_diff_chapter",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前番外",
        Instruct = "complete_extra_chapter",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前(预开启)主线",
        Instruct = "complete_long_chapter_preopen",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前(预开启)挑战关",
        Instruct = "complete_challenge_chapter_preopen",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前(预开启)困难模式",
        Instruct = "complete_diff_chapter_preopen",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "完成当前(预开启)番外",
        Instruct = "complete_extra_chapter_preopen",
        Tips = " uuid: 玩家ID",
        ParamsKey = {"uuid"}
      },
      {
        name = "获取第n章奖励",
        Instruct = "gain_chapter_award_by_index",
        Tips = " uuid: 玩家ID, 第n章奖励(1-n)-包括节点,挑战关,困难关奖励",
        ParamsKey = {"uuid", "index"}
      },
      {
        name = "获取前n章奖励",
        Instruct = "gain_pre_chapter_award_by_index",
        Tips = " uuid: 玩家ID, 前n章奖励(1-n)-包括节点,挑战关,困难关奖励",
        ParamsKey = {"uuid", "index"}
      },
      {
        name = "获取具体章奖励",
        Instruct = "gain_chapter_award_by_id",
        Tips = " uuid: 玩家ID, 章节id-只获取指定章,例如30011-只获取第一章困难关奖励",
        ParamsKey = {"uuid", "id"}
      }
    }
  }
}
return M
