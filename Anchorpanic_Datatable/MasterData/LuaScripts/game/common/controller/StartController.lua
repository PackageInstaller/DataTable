module("StartController", Class.impl())

--构造函数
function ctor(self)
    self:init()
end

function init(self)
    SetCacheRule()
    self:listNotification()
    self:initModule()
end

--析构函数
function dtor(self)
    self.m_modulePathList = nil
    self.gModuleList = nil
end

--游戏开始的回调
function gameStartCallBack(self)
    Debug:log_info("StartController", "gameStartCallBack")

    local lastTime = self:getPreciseDecimal(gs.Time.realtimeSinceStartup, 3)
    for k, v in ipairs(self.gModuleList) do
        if v ~= nil and next(v) then
            for k2, v2 in ipairs(v) do
                v2:gameStartCallBack()

                if (not web.WebManager:isReleaseApp()) then
                    local curTime = self:getPreciseDecimal(gs.Time.realtimeSinceStartup, 3)
                    local costTime = self:getPreciseDecimal(curTime - lastTime, 3)
                    lastTime = curTime
                    if (costTime > 1) then
                        print("启动耗时统计：" .. HtmlUtil:color((costTime * 1000) .. "ms", ColorUtil.RED_NUM), v2.__cname)
                    end
                end
            end
        end
    end
end

-- cusNum保留n位小数，不四舍五入
function getPreciseDecimal(self, cusNum, n)
    if type(cusNum) ~= "number" then
        return cusNum
    end
    n = n or 0
    n = math.floor(n)
    if n < 0 then
        n = 0
    end
    local nDecimal = 10 ^ n
    local nTemp = math.floor(cusNum * nDecimal)
    local nRet = nTemp / nDecimal
    return nRet
end

-- 游戏退出，unRequire掉相关init列表
function gameExitCallBack(self)
    GameDispatcher:removeEventListener(EventName.GAME_START, self.gameStartCallBack, self)
    GameDispatcher:removeEventListener(EventName.READY_EXIT_GAME, self.gameExitCallBack, self)

    for i = 1, #self.gModuleList do
        local v = self.gModuleList[i]
        if v ~= nil and next(v) then
            for k2, v2 in ipairs(v) do
                if v2 and v2.reLogin then
                    v2:reLogin()
                end
            end
        end
    end

    -- 此处看情况，是否需要全部unRequire
    -- for i = 1, #self.m_modulePathList do
    -- LuaUtil:unRequire(self.m_modulePathList[i])
    -- end
    -- 此处看情况，某些系统比较大改起来麻烦就部分unRequire
    -- local customPathList = {}
    -- for i = 1, #customPathList do
    -- LuaUtil:unRequire(customPathList[i])
    -- end
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.GAME_START, self.gameStartCallBack, self)
    GameDispatcher:addEventListener(EventName.READY_EXIT_GAME, self.gameExitCallBack, self)
end

--初始化模块
function initModule(self)
    self.m_modulePathList = {

        "game/socket/Init",
        "game/systemSetting/Init",
        "game/sysParam/Init",
        "game/recharge/Init",
        "game/login/Init",
        "game/loginLoad/Init",
        "game/gm/Init",
        "game/read/Init",
        "game/funcopen/Init",
        "game/link/Init",
        "game/remind/Init",
        "game/stamina/Init",
        "game/model/Init",
        "game/props/Init",
        "game/equip/Init",
        "game/bag/Init",
        "game/battleMapHall/Init",
        "game/role/Init",
        "game/activity/Init",

        "game/firstCharge/Init",
        "game/permit/Init",
        "game/purchase/Init",
        "game/dailyCheckIn/Init",
        "game/fashionPermit/Init",
        "game/fashionPermitTwo/Init",
        "game/supercial/Init",
        "game/mainui/Init",
        "game/mail/Init",
        "game/mainCity/Init",
        "game/fight/Init",
        "game/maze/Init",
        "game/dup/Init",
        "game/formation/Init",
        "game/hero/Init",
        "game/arenaHall/Init",
        -- "game/preFight/Init",
        "game/notice/Init",
        "game/monster/Init",
        "game/debugFrames/Init",
        "game/tips/Init",
        "game/chat/Init",
        "game/friend/Init",
        "game/shop/Init",
        "game/equipBuild/Init",
        "game/money/Init",
        "game/recruit/Init",
        "game/storyTalk/Init",
        "game/awardPack/Init",
        "game/task/Init",
        "game/decorate/Init",
        "game/bulletin/Init",
        "game/taptapAward/Init",
        "game/redPoint/Init",
        "game/convert/Init",
        "game/showBoard/Init",
        "game/storyGame/Init",
        "game/guide/Init",
        "game/stepReport/Init",
        "game/funcTips/Init",
        "game/braceletsCommunicate/Init",
        "game/branchStory/Init",
        "game/training/Init",
        "game/webView/Init",
        "game/ikon/Init",
        "game/selectedHero/Init",
        "game/braceletBuild/Init",
        -- 取消之前的
        --"game/braceletsBuild/Init",
        "game/covenant/Init",
        "game/covenantTalent/Init",
        "game/explore/Init",
        -- "game/orderFactory/Init",
        "game/fashion/Init",
        "game/favorable/Init",
        "game/welfareOpt/Init",
        "game/activityTarget/Init",
        "game/mainExplore/Init",
        "game/rank/Init",
        "game/teaching/Init",
        "game/mainPlay/Init",
        "game/rogueLike/Init",
        "game/manual/Init",
        "game/miniFactory/Init",
        "game/note/Init",
        "game/formationLV/Init",
        "game/cycle/Init",

        "game/buildBase/Init",
        "game/dormitory/Init",
        "game/bigHostel/Init",
        "game/noviceActivity/Init",
        "game/fieldExploration/Init",
        "game/ciruit/Init",
        "game/threeSheep/Init",
        "game/sandPlay/Init",
        "game/danke/Init",
        "game/shootBrick/Init",
        "game/putImage/Init",
        "game/linklink/Init",

        "game/mainActivity/Init",
        "game/roundPrize/Init",
        "game/roundPrizeTwo/Init",
        "game/arenaEntrance/Init",
        "game/guildWar/Init",
        "game/guild/Init",
        "game/guildBossImitate/Init",
        "game/returned/Init",

        "game/doundless/Init",

        "game/mining/Init",
        "game/eliminate/Init",
        "game/disaster/Init",
        "game/seabed/Init",

        "game/dna/Init",

        --移至最后
        "game/fightUI/Init",
        --屏蔽模块
        --"game/rogueLike/Init",
        --"game/infiniteCity/Init",
        "game/subPack/Init",
        "game/organizeBackpacks/Init",
    }

    -- self.gModuleList = {}
    -- for i = 1, #self.m_modulePathList do
    --     local path = self.m_modulePathList[i]
    --     local module = require(path)
    --     table.insert(self.gModuleList, module)
    -- end

    self.gModuleList = {}
    local onceCount = 10
    local moduleCount = #self.m_modulePathList
    LoopManager:addFrame(1, math.ceil(moduleCount / onceCount), self,
        function()
            for i = 1, onceCount do
                local index = #self.gModuleList + 1
                local path = self.m_modulePathList[index]
                local module = require(path)
                table.insert(self.gModuleList, module)
                web.WebManager:dispatchEvent(web.WebManager.MODULE_REQUIRE_FINISH, index / moduleCount)

                if (#self.gModuleList >= moduleCount) then
                    web.WebManager:dispatchEvent(web.WebManager.ALL_MODULE_REQUIRE_FINISH)
                    break
                end
            end
        end)
    end

    return _M

    --[[ 替换语言包自动生成，请勿修改！
]]

   