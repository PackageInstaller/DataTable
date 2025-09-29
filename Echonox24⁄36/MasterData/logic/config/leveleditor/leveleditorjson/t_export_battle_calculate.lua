-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/leveleditorjson/t_export_battle_calculate.lua

module("logic.config.leveleditor.leveleditorjson.t_export_battle_calculate", package.seeall)

local configData = {
	{
		resName = "sx-s109_factoryscrap_run",
		id = 1001,
		victoryPos = {
			z = -1.9,
			x = -1.1,
			y = 0.5
		},
		victoryRotation = {
			z = 359.1505,
			x = 3.57648,
			y = -101.3281
		}
	},
	{
		resName = "sx-s120_miningarea_boss_run",
		id = 1003,
		victoryPos = {
			z = 1.98,
			x = -19.07,
			y = 0.99
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -106.3983
		}
	},
	{
		resName = "sx-s120_miningarea_run",
		id = 1004,
		victoryPos = {
			z = -1.58,
			x = -3.66,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = 129.22
		}
	},
	{
		resName = "sx-s110_alphastar_run",
		id = 1005,
		victoryPos = {
			z = -5.09,
			x = -7.46,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -130.72
		}
	},
	{
		resName = "sx-s111_city_run",
		id = 1006,
		victoryPos = {
			z = 3.5,
			x = -10.37,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -128
		}
	},
	{
		resName = "sx-s114_blackmonument_run",
		id = 1008,
		victoryPos = {
			z = -5.6,
			x = -20.4,
			y = 0.71
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -113.4895
		}
	},
	{
		resName = "sx-s115_indoor_run",
		id = 1009,
		victoryPos = {
			z = -5.38,
			x = -15.03,
			y = 0.4
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -135.9353
		}
	},
	{
		resName = "sx-s116_abandoned-city_run",
		id = 1010,
		victoryPos = {
			z = -1.008,
			x = 0.348,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -128.19
		}
	},
	{
		resName = "sx-s117_oad_run",
		id = 1011,
		victoryPos = {
			z = -1.8,
			x = 1.37,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -127.37
		}
	},
	{
		resName = "sx-s109_factoryscrap_b_01_run",
		id = 1013,
		victoryPos = {
			z = 0,
			x = 0,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = 90
		}
	},
	{
		resName = "sx-s112_space_run",
		id = 1014,
		victoryPos = {
			z = -3.04,
			x = -18.02,
			y = 0.2
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -114.7773
		}
	},
	{
		resName = "sx-s113_alphachannel_run",
		id = 1017,
		victoryPos = {
			z = -0.7,
			x = -19.79,
			y = 0
		},
		victoryRotation = {
			z = 0,
			x = 0,
			y = -95.92307
		}
	}
}
local configDataDic = {}

configDataDic.configData = configData

for _, v in ipairs(configData) do
	configDataDic[v.resName] = v
end

return configDataDic
