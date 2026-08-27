local __rt_1 = {}
local warchess_entity_res = {
  [1001] = {
    id = 1001,
    is_monster = false,
    prefeb = 263925
  },
  [1002] = {
    icon = 4,
    id = 1002,
    is_monster = false,
    prefeb = "007_Arena_001_B_barrel01"
  },
  [1003] = {
    height = 0.3,
    icon = 2,
    id = 1003,
    prefeb = "raider/model_raider"
  },
  [1004] = {
    icon = 4,
    id = 1004,
    is_monster = false,
    prefeb = "007_Arena_001_B_barrel01"
  },
  [1005] = {
    height = 0.3,
    icon = 2,
    id = 1005
  },
  [10003] = {
    aniAudioDic = {
      [2] = 1260
    },
    is_monster = false,
    prefeb = "007_Arena_001_I_Barricades01"
  },
  [10010] = {
    id = 10010,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_Event"
  },
  [10011] = {
    id = 10011,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_HealthRecover"
  },
  [10012] = {
    id = 10012,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_Story"
  },
  [10013] = {
    id = 10013,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_MovePointLoop"
  },
  [10014] = {
    id = 10014,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_CoinLoop",
    successAudio = 1262
  },
  [10024] = {
    id = 10024,
    is_monster = false,
    prefeb = "007_Arena_001_I_Bomb"
  },
  [10044] = {
    client_cat = 5,
    icon = 4,
    id = 10044,
    is_monster = false,
    prefeb = "007_Arena_001_I_MoveBox01",
    successAudio = 1255
  },
  [10049] = {
    id = 10049,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_CatchCoinLoop",
    successAudio = 1262
  },
  [10055] = {
    client_cat = 6,
    icon = 6,
    id = 10055,
    is_monster = false,
    prefeb = "007_Arena_001_I_Treasure",
    successAudio = 1261
  },
  [10056] = {
    client_cat = 6,
    icon = 6,
    id = 10056,
    is_monster = false,
    prefeb = "007_Arena_001_I_Treasure_big",
    successAudio = 1261
  },
  [10057] = {
    icon = 4,
    id = 10057,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_JiaoHu"
  },
  [10058] = {
    id = 10058,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_ShanghuaGrid"
  },
  [10060] = {
    client_cat = 6,
    icon = 6,
    id = 10060,
    is_monster = false,
    prefeb = "007_Arena_001_I_Treasure_big2",
    successAudio = 1261
  },
  [11001] = {
    id = 11001,
    is_monster = false,
    prefeb = "007_Arena_001_B_Wall02"
  },
  [11002] = {
    id = 11002,
    is_monster = false,
    prefeb = "007_Arena_001_I_Pipe02"
  },
  [11003] = {icon = 2, id = 11003},
  [11004] = {icon = 2, id = 11004},
  [11005] = {icon = 2, id = 11005},
  [11006] = {
    id = 11006,
    is_monster = false,
    prefeb = "007_Arena_001_I_OrganDoor01"
  },
  [11007] = {
    icon = 6,
    id = 11007,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_wansheng_lv1",
    successAudio = 1268
  },
  [11008] = {
    icon = 6,
    id = 11008,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_wansheng_lv2",
    successAudio = 1268
  },
  [11009] = {
    icon = 6,
    id = 11009,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_wansheng_lv4",
    successAudio = 1268
  },
  [11010] = {
    icon = 6,
    id = 11010,
    is_monster = false,
    prefeb = "007_Arena_001_I_Treasure02",
    successAudio = 1261
  },
  [11011] = {
    id = 11011,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_CatchCoinwenhaoLoop"
  },
  [11014] = {
    icon = 6,
    id = 11014,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_shengdan_lv1",
    successAudio = 1274
  },
  [11015] = {
    icon = 6,
    id = 11015,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_shengdan_lv2",
    successAudio = 1274
  },
  [11016] = {
    id = 11016,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_soul_02"
  },
  [11017] = {
    icon = 6,
    id = 11017,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_lvzhou_lv1",
    successAudio = 1274
  },
  [11018] = {
    icon = 6,
    id = 11018,
    is_effect = true,
    is_monster = false,
    prefeb = "FXP_lvzhou_lv2",
    successAudio = 1274
  },
  [21000] = {
    id = 21000,
    prefeb = "agent/model_agent"
  },
  [21001] = {
    id = 21001,
    prefeb = "persicaria/model_persicaria"
  },
  [21002] = {
    id = 21002,
    prefeb = "anna/model_anna"
  },
  [21003] = {
    id = 21003,
    prefeb = "sol/model_sol"
  },
  [21004] = {
    id = 21004,
    prefeb = "simo/model_simo"
  },
  [21005] = {
    id = 21005,
    prefeb = "croque/model_croque"
  },
  [21006] = {
    id = 21006,
    prefeb = "fresnel/model_fresnel"
  },
  [21007] = {
    id = 21007,
    prefeb = "chelsea/model_chelsea"
  },
  [21008] = {
    id = 21008,
    prefeb = "gin/model_gin"
  },
  [21009] = {
    id = 21009,
    prefeb = "mai/model_mai"
  },
  [21010] = {
    id = 21010,
    prefeb = "evelyn/model_evelyn"
  },
  [21011] = {
    id = 21011,
    prefeb = "camellia/model_camellia"
  },
  [21012] = {
    id = 21012,
    prefeb = "max/model_max"
  },
  [21013] = {
    id = 21013,
    prefeb = "betty/model_betty"
  },
  [21014] = {
    id = 21014,
    prefeb = "choco/model_choco"
  },
  [21015] = {
    id = 21015,
    prefeb = "panakeia/model_panakeia"
  },
  [21016] = {
    id = 21016,
    prefeb = "banxsy/model_banxsy"
  },
  [21017] = {
    id = 21017,
    prefeb = "angela/model_angela"
  },
  [21018] = {
    id = 21018,
    prefeb = "florence/model_florence"
  },
  [21019] = {
    id = 21019,
    prefeb = "fern/model_fern"
  },
  [21020] = {
    id = 21020,
    prefeb = "yanny/model_yanny"
  },
  [21021] = {
    id = 21021,
    prefeb = "groove/model_groove"
  },
  [21022] = {
    id = 21022,
    prefeb = "aki/model_aki"
  },
  [21023] = {
    id = 21023,
    prefeb = "bonee/model_bonee"
  },
  [21024] = {
    id = 21024,
    prefeb = "earhart/model_earhart"
  },
  [21025] = {
    id = 21025,
    prefeb = "twigs/model_twigs"
  },
  [21026] = {
    id = 21026,
    prefeb = "nanaka/model_nanaka"
  },
  [21027] = {
    id = 21027,
    prefeb = "zion/model_zion"
  },
  [21028] = {
    id = 21028,
    prefeb = "vee/model_vee"
  },
  [21029] = {
    id = 21029,
    prefeb = "willow/model_willow"
  },
  [21030] = {
    id = 21030,
    prefeb = "ksenia/model_ksenia"
  },
  [21031] = {
    id = 21031,
    prefeb = "imhotep/model_imhotep"
  },
  [21032] = {
    id = 21032,
    prefeb = "octogen/model_octogen"
  },
  [21033] = {
    id = 21033,
    prefeb = "rise/model_rise"
  },
  [21034] = {
    id = 21034,
    prefeb = "abigail/model_abigail"
  },
  [21035] = {
    id = 21035,
    prefeb = "jessie/model_jessie"
  },
  [21036] = {
    id = 21036,
    prefeb = "lam/model_lam"
  },
  [21037] = {
    id = 21037,
    prefeb = "hubble/model_hubble"
  },
  [21038] = {
    id = 21038,
    prefeb = "sakuya/model_sakuya"
  },
  [21039] = {
    id = 21039,
    prefeb = "centaureissi/model_centaureissi"
  },
  [21040] = {
    id = 21040,
    prefeb = "dusevnyj/model_dusevnyj"
  },
  [21041] = {
    id = 21041,
    prefeb = "delacey/model_delacey"
  },
  [21042] = {
    id = 21042,
    prefeb = "hatsuchiri/model_hatsuchiri"
  },
  [21043] = {
    id = 21043,
    prefeb = "python/model_python"
  },
  [21044] = {
    id = 21044,
    prefeb = "kuro/model_kuro"
  },
  [21045] = {
    id = 21045,
    prefeb = "sueyoi/model_sueyoi"
  },
  [21046] = {
    id = 21046,
    prefeb = "haze/model_haze"
  },
  [21047] = {
    id = 21047,
    prefeb = "sockdolager/model_sockdolager"
  },
  [21048] = {
    id = 21048,
    prefeb = "nora/model_nora"
  },
  [21049] = {
    id = 21049,
    prefeb = "magnhilda/model_magnhilda"
  },
  [21050] = {
    id = 21050,
    prefeb = "puzzle/model_puzzle"
  },
  [21051] = {
    id = 21051,
    prefeb = "nascita/model_nascita"
  },
  [21052] = {
    id = 21052,
    prefeb = "helix/model_helix"
  },
  [21053] = {
    id = 21053,
    prefeb = "crypter/model_crypter"
  },
  [21054] = {
    id = 21054,
    prefeb = "gastronomie/model_gastronomie"
  },
  [21055] = {
    id = 21055,
    prefeb = "hanna/model_hanna"
  },
  [21056] = {
    id = 21056,
    prefeb = "uranus/model_uranus"
  },
  [22001] = {
    id = 22001,
    prefeb = "raider/model_raider"
  },
  [22002] = {
    id = 22002,
    prefeb = "purger/model_purger"
  },
  [22003] = {
    id = 22003,
    prefeb = "patience/model_patience"
  },
  [22004] = {
    id = 22004,
    prefeb = "reverence/model_reverence"
  },
  [22005] = {
    id = 22005,
    prefeb = "faith/model_faith"
  },
  [22006] = {
    id = 22006,
    prefeb = "refactor/model_refactor"
  },
  [22007] = {
    id = 22007,
    prefeb = "defender/model_defender"
  },
  [22008] = {
    id = 22008,
    prefeb = "fortitude/model_fortitude"
  },
  [22009] = {
    id = 22009,
    prefeb = "mara/model_mara"
  },
  [22010] = {
    id = 22010,
    prefeb = "mara-blue/model_mara-blue"
  },
  [22011] = {
    id = 22011,
    prefeb = "protector/model_protector"
  },
  [22012] = {
    id = 22012,
    prefeb = "temperance/model_temperance"
  },
  [22013] = {
    id = 22013,
    prefeb = "raider2/model_raider2"
  },
  [22014] = {
    id = 22014,
    prefeb = "purger2/model_purger2"
  },
  [22015] = {
    id = 22015,
    prefeb = "defender2/model_defender2"
  },
  [22016] = {
    id = 22016,
    prefeb = "protector2/model_protector2"
  },
  [22017] = {
    id = 22017,
    prefeb = "refactor2/model_refactor2"
  },
  [22018] = {
    id = 22018,
    prefeb = "portal/model_portal"
  },
  [22019] = {
    id = 22019,
    prefeb = "beelneith/model_beelneith"
  },
  [22020] = {
    id = 22020,
    prefeb = "gabrie/model_gabrie"
  },
  [22021] = {
    id = 22021,
    prefeb = "hesperus/model_hesperus"
  },
  [22022] = {
    id = 22022,
    prefeb = "hope/model_hope"
  },
  [22023] = {
    id = 22023,
    prefeb = "love/model_love"
  },
  [22024] = {
    id = 22024,
    prefeb = "diligence/model_diligence"
  },
  [22025] = {
    id = 22025,
    prefeb = "kindness/model_kindness"
  },
  [22026] = {
    id = 22026,
    prefeb = "wisdom/model_wisdom"
  },
  [22027] = {
    id = 22027,
    prefeb = "imhotep_bird/model_imhotep_bird"
  },
  [22028] = {
    id = 22028,
    prefeb = "imhotep_snake/model_imhotep_snake"
  },
  [22029] = {
    id = 22029,
    prefeb = "twiner/model_twiner"
  },
  [22030] = {
    id = 22030,
    prefeb = "impactor/model_impactor"
  },
  [22031] = {
    id = 22031,
    prefeb = "patience_entropy/model_patience_entropy"
  },
  [22032] = {
    id = 22032,
    prefeb = "wisdom_entropy/model_wisdom_entropy"
  },
  [22033] = {
    id = 22033,
    prefeb = "fern_dragon/model_fern_dragon"
  },
  [22034] = {
    id = 22034,
    prefeb = "hope_low/model_hope_low"
  },
  [22035] = {
    id = 22035,
    prefeb = "mercy/model_mercy"
  },
  [22036] = {
    id = 22036,
    prefeb = "thrower/model_thrower"
  },
  [22037] = {
    id = 22037,
    prefeb = "mercy_effect/model_mercy_effect"
  },
  [22038] = {
    id = 22038,
    prefeb = "thrower2/model_thrower2"
  },
  [22039] = {
    id = 22039,
    prefeb = "purger3/model_purger3"
  },
  [22040] = {
    id = 22040,
    prefeb = "digimine_red/model_digimine_red"
  },
  [22041] = {
    id = 22041,
    prefeb = "simo_shadow/model_simo_shadow"
  },
  [22042] = {
    id = 22042,
    prefeb = "cocytus/model_cocytus"
  },
  [22043] = {
    id = 22043,
    prefeb = "snooper/model_snooper"
  },
  [22044] = {
    id = 22044,
    prefeb = "splasher/model_splasher"
  },
  [22045] = {
    id = 22045,
    prefeb = "styx/model_styx"
  },
  [22046] = {
    id = 22046,
    prefeb = "portal_entropy/model_portal_entropy"
  },
  [22047] = {
    id = 22047,
    prefeb = "eosphorus/model_eosphorus"
  },
  [22048] = {
    id = 22048,
    prefeb = "demiurge/model_demiurge"
  },
  [22049] = {
    id = 22049,
    prefeb = "impactor_red/model_impactor_red"
  },
  [22050] = {
    id = 22050,
    prefeb = "patience_red/model_patience_red"
  },
  [22051] = {
    id = 22051,
    prefeb = "portal_red/model_portal_red"
  },
  [22052] = {
    id = 22052,
    prefeb = "purger_red/model_purger_red"
  },
  [22053] = {
    id = 22053,
    prefeb = "cocytus_red/model_cocytus_red"
  },
  [22054] = {
    id = 22054,
    prefeb = "snooper_red/model_snooper_red"
  },
  [22055] = {
    id = 22055,
    prefeb = "splasher_red/model_splasher_red"
  },
  [22056] = {
    id = 22056,
    prefeb = "styx_red/model_styx_red"
  },
  [22057] = {
    id = 22057,
    prefeb = "twiner_red/model_twiner_red"
  },
  [22058] = {
    id = 22058,
    prefeb = "demiurge_tentacle_a/model_demiurge_tentacle_a"
  },
  [22059] = {
    id = 22059,
    prefeb = "raider_entropy/model_raider_entropy"
  },
  [22060] = {
    id = 22060,
    prefeb = "refactor_entropy/model_refactor_entropy"
  },
  [22061] = {
    id = 22061,
    prefeb = "fortitude_entropy/model_fortitude_entropy"
  },
  [22062] = {
    id = 22062,
    prefeb = "demiurge_tentacle_b/model_demiurge_tentacle_b"
  },
  [22063] = {
    id = 22063,
    prefeb = "demiurge_a/model_demiurge_a"
  },
  [22064] = {
    id = 22064,
    prefeb = "odile_entropy/model_odile_entropy"
  },
  [22065] = {
    id = 22065,
    prefeb = "crime/model_crime"
  },
  [22066] = {
    id = 22066,
    prefeb = "punishment/model_punishment"
  },
  [22067] = {id = 22067},
  [22068] = {
    id = 22068,
    prefeb = "judge/model_judge"
  },
  [22069] = {
    id = 22069,
    prefeb = "memechan_anna/model_memechan_anna"
  },
  [22070] = {
    id = 22070,
    prefeb = "memechan_betty/model_memechan_betty"
  },
  [22071] = {
    id = 22071,
    prefeb = "memechan_bonee/model_memechan_bonee"
  },
  [22072] = {
    id = 22072,
    prefeb = "memechan_sakuya/model_memechan_sakuya"
  },
  [22073] = {
    id = 22073,
    prefeb = "whisper/model_whisper"
  },
  [22074] = {
    id = 22074,
    prefeb = "pursuer/model_pursuer"
  },
  [22076] = {
    id = 22076,
    prefeb = "splitter/model_splitter"
  },
  [22077] = {
    id = 22077,
    prefeb = "silence/model_silence"
  },
  [22078] = {
    id = 22078,
    prefeb = "blesser/model_blesser"
  },
  [22079] = {
    id = 22079,
    prefeb = "ranko_entropy/model_ranko_entropy"
  },
  [22080] = {
    id = 22080,
    prefeb = "kamenrider/model_kamenrider"
  },
  [22081] = {
    id = 22081,
    prefeb = "puzzle_statue/model_puzzle_statue"
  },
  [22082] = {
    id = 22082,
    prefeb = "silence_summoner/model_silence_summoner"
  },
  [22083] = {
    id = 22083,
    prefeb = "memechan_lam/model_memechan_lam"
  },
  [22084] = {
    id = 22084,
    prefeb = "memechan_magnhilda/model_memechan_magnhilda"
  },
  [22085] = {
    id = 22085,
    prefeb = "memechan_nora/model_memechan_nora"
  },
  [22086] = {
    id = 22086,
    prefeb = "occulator/model_occulator"
  },
  [22087] = {
    id = 22087,
    prefeb = "firechaser/model_firechaser"
  },
  [22088] = {
    id = 22088,
    prefeb = "evilsower/model_evilsower"
  },
  [22089] = {
    id = 22089,
    prefeb = "dusteater/model_dusteater"
  },
  [22090] = {
    id = 22090,
    prefeb = "tyrannis/model_tyrannis"
  },
  [22091] = {
    id = 22091,
    prefeb = "acedia/model_acedia"
  },
  [22092] = {
    id = 22092,
    prefeb = "odile/model_odile"
  },
  [22093] = {
    id = 22093,
    prefeb = "splasher/model_splasher"
  },
  [22094] = {
    id = 22094,
    prefeb = "odette/model_odette"
  },
  [23001] = {
    id = 23001,
    prefeb = "roadblock3/model_roadblock3"
  },
  [23002] = {
    id = 23002,
    prefeb = "roadblock1/model_roadblock1"
  },
  [23003] = {
    id = 23003,
    prefeb = "roadblock4/model_roadblock4"
  },
  [23004] = {
    id = 23004,
    prefeb = "roadblock2/model_roadblock2"
  },
  [23005] = {
    id = 23005,
    prefeb = "sector_obstacles_blue/model_sector_obstacles_blue"
  },
  [23006] = {
    id = 23006,
    prefeb = "sector_obstacles_red/model_sector_obstacles_red"
  },
  [23007] = {
    id = 23007,
    prefeb = "beelneith_cake/model_beelneith_cake"
  },
  [23008] = {
    id = 23008,
    prefeb = "professor/model_professor"
  },
  [23009] = {
    id = 23009,
    prefeb = "digimine/model_digimine"
  },
  [23010] = {
    id = 23010,
    prefeb = "memeko/model_memeko"
  },
  [23011] = {
    id = 23011,
    prefeb = "td_route_monster/model_td_route_monster"
  },
  [23012] = {
    id = 23012,
    prefeb = "tower_defence/model_tower_defence"
  },
  [23013] = {
    id = 23013,
    prefeb = "monstertower_defence/model_monstertower_defence"
  },
  [23014] = {
    id = 23014,
    prefeb = "deco/model_deco"
  },
  [23015] = {
    id = 23015,
    prefeb = "roadblock3_entropy/model_roadblock3_entropy"
  },
  [23016] = {
    id = 23016,
    prefeb = "roadblock1_entropy/model_roadblock1_entropy"
  },
  [23017] = {
    id = 23017,
    prefeb = "roadblock3_shatan/model_roadblock3_shatan"
  },
  [23018] = {
    id = 23018,
    prefeb = "roadblock1_shatan/model_roadblock1_shatan"
  },
  [23019] = {
    id = 23019,
    prefeb = "weapon1/model_weapon1"
  },
  [23020] = {
    id = 23020,
    prefeb = "weapon2/model_weapon2"
  },
  [23021] = {
    id = 23021,
    prefeb = "weapon3/model_weapon3"
  },
  [23022] = {
    id = 23022,
    prefeb = "weapon4_coregreen/model_weapon4_coregreen"
  },
  [23023] = {
    id = 23023,
    prefeb = "weapon4_corered/model_weapon4_corered"
  },
  [23024] = {
    id = 23024,
    prefeb = "agent/model_agent"
  },
  [23025] = {
    id = 23025,
    prefeb = "puzzle_statue2/model_puzzle_statue2"
  },
  [23026] = {
    id = 23026,
    prefeb = "puzzle_statue2_entropy/model_puzzle_statue2_entropy"
  },
  [23027] = {
    id = 23027,
    prefeb = "puzzle_monster/model_puzzle_monster"
  },
  [23028] = {
    id = 23028,
    prefeb = "dusteater_weiba/model_dusteater_weiba"
  },
  [122501] = {
    id = 122501,
    prefeb = "twigs_swimsuit/model_twigs_swimsuit"
  }
}
local __default_values = {
  aniAudioDic = __rt_1,
  client_cat = 0,
  default_anima = "",
  height = 0,
  icon = 0,
  id = 10003,
  is_effect = false,
  is_monster = true,
  prefeb = "fakegod/model_fakegod",
  successAudio = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_entity_res) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_entity_res, {__index = __rawdata})
return warchess_entity_res
