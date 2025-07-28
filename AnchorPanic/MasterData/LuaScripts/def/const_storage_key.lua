
gstor = {}

--DEMO_KEY BEGIN--------------------------------------------------------------------
gstor.LOGIN_SERVER_ID = "LOGIN_SERVER_ID" --选中的服务ID
gstor.LOGIN_UDATA = "LOGIN_UDATA" --登录账号/PS
--DEMO_KEY END--------------------------------------------------------------------

--POLICY_AGREEMENT BEGIN--------------------------------------------------------------------
gstor.APP_POLICY_AGREEMENT = "APP_POLICY_AGREEMENT" -- 隐私协议政策相关
--POLICY_AGREEMENT END--------------------------------------------------------------------

--STORY_AUTO_BTN BEGIN--------------------------------------------------------------------
gstor.APP_FIRST_AUTO_QUALITY = "APP_FIRST_AUTO_QUALITY" -- 初次安装自动画质
--STORY_AUTO_BTN END--------------------------------------------------------------------

--FIGHT_KEY BEGIN--------------------------------------------------------------------
gstor.FIGHT_UI_AUTO = "FIGHT_UI_AUTO" --战斗默认是否自动
gstor.FIGHT_UI_SPEED = "FIGHT_UI_SPEED" --战斗默认速度

gstor.FIGHT_JUMP_CAMERA = "FIGHT_JUMP_CAMERA" --跳过镜头
gstor.FIGHT_SKIP_SKILL = "FIGHT_SKIP_SKILL" --跳过后摇
gstor.FIGHT_SHOW_HP = "FIGHT_SHOW_HP" --显示血条
gstor.FIGHT_SHOW_DAMAGE = "FIGHT_SHOW_DAMAGE" --显示伤害
gstor.FIGHT_SHOW_UI = "FIGHT_SHOW_UI" --显示技能按键
gstor.FIGHT_QUEUE10 = "FIGHT_QUEUE10" --切换队列数
gstor.FIGHT_SHOW_PROFESSIONTYPE = "FIGHT_SHOW_PROFESSIONTYPE" --显示职业定位
gstor.FIGHT_HIDE_INFO = "FIGHT_HIDE_INFO" --简化战斗信息
gstor.FIGHT_SHOW_AUTO_HP = "FIGHT_SHOW_AUTO_HP" --显示自动头像血量
gstor.FIGHT_SHOW_AUTO_HP_BUFF = "FIGHT_SHOW_AUTO_HP_BUFF" --显示自动头像详细buff
--FIGHT_KEY END--------------------------------------------------------------------
gstor.RECRUIT_HERO_GUIDE = "recruit_hero_Guide" --抽卡第一次指引

gstor.SANDPLAY_PLAYER_POSITION = "SANDPLAY_PLAYER_POSITION" --圣诞沙盒玩法玩家在场景中的位置
gstor.SANDPLAY_FISHING_OPENRED = "SANDPLAY_FISHING_OPENRED" --钓鱼游戏活动开启的提醒红点记录的时间
gstor.SANDPLAY_DANKE_OPENRED = "SANDPLAY_DANKE_OPENRED" --蛋壳游戏活动开启的提醒红点记录的时间

gstor.GUILDBOSSIMITATE_CACHE_DUPID = "GUILDBOSSIMITATE_CACHE_DUPID" --公会训练上次选择的副本


--STORY_AUTO_BTN BEGIN--------------------------------------------------------------------
gstor.STORY_AUTO = "STORY_AUTO" -- 自动剧情
--STORY_AUTO_BTN END--------------------------------------------------------------------

gstor.ARENA_HELL_SKIP = "ARENA_HELL_SKIP" -- 不进入3v3战斗

gstor.MAINUI_SHOW_DYNAMIC_PIC = "MAINUI_SHOW_DYNAMIC_PIC" --主界面使用动态立绘

local function _checkDuplicateError()
    local t = {}
    for k, v in pairs(gstor) do
        if t[v] == true then
            LOG_ERROR("stroage", "==========STROAGE KEY DUPLICATE %d", v)
        end
        t[v] = true
    end
end

_checkDuplicateError()
