--[[ 
-----------------------------------------------------
@filename       : HeroAssistController
@Description    : 英雄助战控制器
@date           : 2022-3-1 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroAssistController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 推送战员的助战技能 13220
        SC_HERO_ASSIST_FIGHT_SKILL = self.__onResHeroAssistFightSkillHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 推送战员的助战技能 13220
function __onResHeroAssistFightSkillHandler(self, msg)
    hero.HeroAssistManager:parseHeroAssistFightSkill(msg.is_init == 1, msg.hero_af_list)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
