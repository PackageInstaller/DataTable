local var_0_0 = {}
local var_0_1 = {}

var_0_1 = config._DEBUG and {
	"loadinglayer/icon.png",
	"loadinglayer/max.png",
	"loadinglayer/mid.png",
	"loadinglayer/min.png"
} or {
	"ListButtonLayer",
	"TopcostLayer",
	"FightLayer",
	"fight_elements",
	"Guide",
	"EquipLayer",
	"GUI",
	"loadinglayer",
	"AchievementPop",
	"skill_new0",
	"skill_new1",
	"skill_new2",
	"skill_new3",
	"skill_new4",
	"bubble",
	"PopChangeEquip",
	"public_box",
	"public_button",
	"public_career_icon",
	"public_currency",
	"public_filter",
	"public_panelbg-0",
	"public_panelbg-1",
	"public_panelbg-2",
	"public_rarity",
	"public_reddot",
	"public_rolebg",
	"public_talk",
	"public_title",
	"public_twist"
}

local var_0_2 = {
	"sound/background.ogg",
	"sound/boom.ogg",
	"sound/chui.ogg",
	"sound/dianju.ogg",
	"sound/dun.ogg",
	"sound/fire.ogg",
	"sound/fire1.ogg",
	"sound/fire2.ogg",
	"sound/get_awards.ogg",
	"sound/gun.ogg",
	"sound/gunhit.ogg",
	"sound/horn_fire.ogg",
	"sound/huigunzi.ogg",
	"sound/huiwu.ogg",
	"sound/huiwu_z.ogg",
	"sound/huodejuese.ogg",
	"sound/jiguang.ogg",
	"sound/jiguang1.ogg",
	"sound/leidian.ogg",
	"sound/leidianduan.ogg",
	"sound/leipixia.ogg",
	"sound/liandao.ogg",
	"sound/nengliang.ogg",
	"sound/shilian.ogg",
	"sound/xp.ogg",
	"sound/zaxia.ogg",
	"sound/zhiliao.ogg",
	"sound/zhuangbei.ogg",
	"sound/offlineearningsbg.ogg",
	"sound/offlineearningsroll.ogg",
	"sound/offlineearningsend.ogg",
	"sound/loading_part1.ogg",
	"sound/loading_part2.ogg",
	"sound/loading_part3.ogg"
}
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = 0
local var_0_10

local function var_0_12()
	if config._DEBUG then
		cc.Director:getInstance():getTextureCache():addImageAsync(var_0_1[var_0_4 - var_0_5 + 1], function()
			var_0_4 = var_0_4 + 1

			var_0_10()
		end)
	else
		local var_1_0 = var_0_1[var_0_4 - var_0_5 + 1]

		cc.Director:getInstance():getTextureCache():addImageAsync(var_0_1[var_0_4 - var_0_5 + 1] .. ".png", function()
			cc.SpriteFrameCache:getInstance():addSpriteFrames(var_1_0 .. ".plist")

			var_0_4 = var_0_4 + 1

			var_0_10()
		end)
	end
end

local function var_0_13()
	require("controller.audio_manager"):loadAudio(var_0_2[var_0_4 + 1], function()
		var_0_4 = var_0_4 + 1

		var_0_10()

		if var_0_4 >= var_0_5 then
			load_bgm()
		end
	end)
end

function var_0_10()
	if var_0_4 < var_0_5 then
		var_0_13()
	elseif var_0_4 < var_0_3 then
		var_0_12()
	end
end

function load_bgm()
	local audio_manager = require("controller.audio_manager")

	for iter_7_0, iter_7_1 in pairs({
		"sound/fight.ogg",
		"sound/mainbgm.ogg",
		"sound/fightbgm_b.ogg"
	}) do
		audio_manager:loadAudio(iter_7_1)
	end
end

local function var_0_14()
	if not SensitiveChecker then
		return
	end

	local var_8_0 = cc.FileUtils:getInstance():fullPathForFilename("sensitive_word")

	if not var_8_0 then
		return
	end

	SensitiveChecker.loadFile(var_8_0)
end

function var_0_0.start()
	var_0_5 = #var_0_2
	var_0_6 = #var_0_1
	var_0_3 = var_0_5 + var_0_6
	var_0_4 = 0

	var_0_10()
	var_0_14()
	require("controller.filedownloader.auto_download_helper"):generate_all_assets()
end

function var_0_0.getProcess()
	return var_0_4 / var_0_3 * 100
end

return var_0_0
