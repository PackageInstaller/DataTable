module("role.RoleVo", Class.impl("lib.event.EventDispatcher"))

function ctor(self)
    self:initData()
end

-- 玩家资产改变
CHANGE_PLAYER_MONEY = "CHANGE_PLAYER_MONEY"

-- 玩家头像改变
CHANGE_PLAYER_AVATAR = "CHANGE_PLAYER_AVATAR"
-- 玩家头像框改变
CHANGE_PLAYER_AVATAR_FRAME = "CHANGE_PLAYER_AVATAR_FRAME"
-- 玩家称号改变
CHANGE_PLAYER_TITLE = "CHANGE_PLAYER_TITLE"
-- 玩家个性签名改变
CHANGE_PLAYER_AUTOGRAPH = "CHANGE_PLAYER_AUTOGRAPH"
-- 玩家展示英雄列表改变
CHANGE_SHOW_HERO_LIST = "CHANGE_SHOW_HERO_LIST"
-- 展示板的展示英雄初始
INIT_SHOW_BOARD_HERO = "INIT_SHOW_BOARD_HERO"
-- 展示板的展示英雄改变
CHANGE_SHOW_BOARD_HERO = "CHANGE_SHOW_BOARD_HERO"
-- 玩家等级改变
CHANGE_PLAYER_LVL = "CHANGE_PLAYER_LVL"
-- 玩家VIP等级改变
CHANGE_PLAYER_VIP_LVL = "CHANGE_PLAYER_VIP_LVL"
-- 玩家名称改变
CHANGE_PLAYER_NAME = "CHANGE_PLAYER_NAME"
-- 玩家经验改变
CHANGE_PLAYER_EXP = "CHANGE_PLAYER_EXP"
-- 玩家经验上限改变
CHANGE_PLAYER_MAXEXP = "CHANGE_PLAYER_MAXEXP"
-- 玩家声望等阶改变
CHANGE_PLAYER_PRESTIGE_STAGE = "CHANGE_PLAYER_PRESTIGE_STAGE"

-- 新增货币类型不用在这里加，这里是属性变化的，货币改变统一调用CHANGE_PLAYER_MONEY

function initData(self)
    -- 玩家id
    self.playerId = nil
    -- 玩家交互识别id
    self.showId = nil
    -- 玩家头像id
    self.m_avatarId = nil
    -- 玩家头像框id
    self.m_avatarFrameId = nil
    -- 玩家称号改变
    self.m_titleId = nil
    -- 玩家个性签名改变
    self.m_autograph = nil
    -- 玩家展示英雄列表改变
    self.m_showHeroList = nil
    -- 展示板展示的英雄id
    self.showBoardHeroId = nil
    -- 玩家等级
    self.m_playerLvl = nil
    -- 玩家Vip等级
    self.m_playerVipLvl = nil
    -- 玩家名字
    self.m_playerName = nil
    -- 玩家钛金石
    self.m_playerItianium = nil
    -- 玩家金币
    self.m_playerGoldCoin = nil
    -- 玩家竞技币
    self.m_playerArenaCoin = nil
    -- 玩家装饰币
    self.m_playerDecorateCoin = nil
    -- 使徒只证
    self.m_playerApostles2Coin = nil
    -- 玩家英雄全局经验
    self.m_playerHeroGlobalExp = nil
    -- 玩家助手全局经验
    self.m_playerHelperGlobalExp = nil
    -- 玩家产能
    self.mPlayerCapacitey = nil
    -- 玩家模组构件
    self.mPlayerModuleMember = nil
    -- 充值货币钛石
    self.m_payItianium = nil
    -- 玩家当前经验
    self.m_playerExp = nil
    -- 玩家经验上限
    self.m_playerMaxExp = nil
    -- 无限币
    self.m_infiniteCity_coin = nil
    -- 玩家声望
    self.m_prestige_coin = nil
    -- 玩家声望经验
    self.m_playerPrestigeExp = nil
    -- 玩家声望经验上限
    self.m_playerPrestigeMaxExp = nil
    -- 玩家声望等阶
    self.m_playerPrestigeStage = nil
    -- 玩家元件
    self.m_playerHeroDis = nil
    -- 函数货币
    self.m_playerFunction = nil
    -- 肉鸽货币
    self.m_rogueLikeCoin = nil
    -- 无人机货币
    self.m_playerDrone = nil
    -- 时装币
    self.m_FashionCoin = nil
    -- 限时活动货币
    self.m_ActivityCoin = nil
    --巅峰竞技场货币
    self.m_PvpHellCoin = nil
    --公会货币
    self.m_GuildCoin = nil
    --无限城
    self.m_DoundlessCoin = nil
    --联盟团战货币
    self.m_GuildWarCoin = nil
end

-- 解析消息
function parseMsgData(self, cusMsgData)
    self.m_isMoneyChange = false
    -- 是否是GM
    self.isOpenGM = cusMsgData.gm == 1
    -- 玩家id
    self.playerId = cusMsgData.player_id
    -- 玩家交互识别id
    self.showId = cusMsgData.show_id
    -- 玩家头像id
    self:setAvatarId(cusMsgData.avatar_id)
    -- 玩家头像框id
    self:setAvatarFrameId(cusMsgData.avatar_frame)
    -- 玩家称号改变
    self:setTitleId(cusMsgData.designation)
    -- 玩家个性签名改变
    self:setAutograph(cusMsgData.signature)
    -- 玩家展示英雄列表改变
    self:setShowHeroList(cusMsgData.show_hero_list)
    -- 展示板展示的英雄id
    self:setShowBoardHeroId(cusMsgData.hero_board_show_id)

    -- 玩家等级
    self:setPlayerLvl(cusMsgData.level)
    -- 玩家Vip等级
    self:setPlayerVipLvl(cusMsgData.vip_lv)
    -- 玩家名字
    self:setPlayerName(cusMsgData.player_name)
    -- 玩家钛金石
    self:setPlayerItianium(cusMsgData.titanium)
    -- 玩家金币
    self:setPlayerGoldCoin(cusMsgData.gold_coin)
    -- 玩家竞技币
    self:setPlayerArenaCoin(cusMsgData.arena_coin)
    -- 玩家装饰币
    self:setPlayerDecorateCoin(cusMsgData.decoreate_coin)
    -- 玩家使徒之证
    self:setPlayerApostles2Coin(cusMsgData.apostles2_coin)
    -- 玩家英雄全局经验
    self:setPlayerHeroGlobalExp(cusMsgData.hero_global_exp)
    -- 玩家研究所全局经验
    self:setPlayerHelperGlobalExp(cusMsgData.inst_global_exp)
    -- 玩家充值货币钛石
    self:setPayItianium(cusMsgData.pay_titanium)
    -- 玩家当前经验
    self:setPlayerExp(cusMsgData.exp)
    -- 玩家经验上限
    self:setPlayerMaxExp(cusMsgData.max_exp)
    -- 无限币
    self:setInfiniteCityCoin(cusMsgData.infinite_coin)
    -- 玩家声望
    self:setPrestigeCoin(cusMsgData.prestige_coin)
    -- 玩家声望经验
    self:setPlayerPrestigeExp(cusMsgData.prestige_exp)
    -- 玩家声望等阶
    self:setPlayerPerstigeStage(cusMsgData.prestige_stage)
    -- 函数货币
    self:setFunctionCoin(cusMsgData.roguelike_function_coin)
    -- 肉鸽货币
    self:setRogueLikeCoin(cusMsgData.roguelike_coin)
    -- 时装币
    self:setFashionCoin(cusMsgData.fashion_coin)
    -- 1.1活动货币
    self:setActivityCoin(cusMsgData.activity_coin)
    -- 需要更新货币栏，请使用role.RoleVo.CHANGE_PLAYER_MONEY
    --巅峰竞技场货币
    self:setPvpHellCoin(cusMsgData.competition_coin)
    --公会货币
    self:setGuildCoin(cusMsgData.guild_coin)
    --无限城货币
    self:setDoundlessCoin(cusMsgData.boundless_city_coin)
    --聊天气泡id
    self:setChatBubbleTid(cusMsgData.dialog_box)
    --开心农场货币
    self:setHappyFarmMoney(cusMsgData.farm_coin)
    --联盟团战货币
    self:setGuildWarCoin(cusMsgData.guild_war_coin)
end

----------------------------------------以下为玩家属性------------------------------------------

-- 展示板展示的英雄tid
function setShowBoardHeroId(self, cusData)
    local num = tonumber(cusData)
    if (self.showBoardHeroId ~= num) then
        if (self.showBoardHeroId == nil) then
            self.showBoardHeroId = num
            self:dispatchEvent(role.RoleVo.INIT_SHOW_BOARD_HERO)
        else
            self.showBoardHeroId = num
            self:dispatchEvent(role.RoleVo.CHANGE_SHOW_BOARD_HERO)
        end
    end
end

function getShowBoardHeroId(self)
    return self.showBoardHeroId
end

-- 玩家头像id
function setAvatarId(self, cusData)
    local num = tonumber(cusData)
    if (self.m_avatarId ~= num) then
        self.m_avatarId = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_AVATAR)
    end
end

function getAvatarId(self)
    return self.m_avatarId
end

-- 玩家头像框id
function setAvatarFrameId(self, cusData)
    local num = tonumber(cusData)
    if (self.m_avatarFrameId ~= num) then
        self.m_avatarFrameId = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME)
    end
end

function getAvatarFrameId(self)
    return self.m_avatarFrameId
end

-- 设置签名
function setTitleId(self, cusData)
    local num = tonumber(cusData)
    if (self.m_titleId ~= num) then
        self.m_titleId = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_TITLE)
    end
end

function getTitleId(self)
    return self.m_titleId
end

-- 修改个性签名
function setAutograph(self, cusData)
    if (self.m_autograph ~= cusData) then
        self.m_autograph = cusData
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_AUTOGRAPH)
    end
end

function getAutograph(self)
    return self.m_autograph
end

-- 设置展示的战员列表
function setShowHeroList(self, cusData)
    self.m_showHeroList = {}
    self.m_showHeroPosDic = {}
    self.m_showHeroIdDic = {}

    self.m_tempShowHeroList = {}
    for i = 1, 5 do
        self.m_tempShowHeroList[i] = -1
    end

    for i = 1, #cusData do
        local data = {}
        data.pos = cusData[i].pos
        data.heroId = cusData[i].hero_id
        self.m_showHeroList[i] = data
        self.m_showHeroPosDic[data.pos] = data.heroId
        self.m_showHeroIdDic[data.heroId] = data.pos

        self.m_tempShowHeroList[i] = data.heroId
    end
    self:dispatchEvent(role.RoleVo.CHANGE_SHOW_HERO_LIST)
    GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
end

-- 更新临时展示
function updateTempShowHeroList(self, list)
    self.m_tempShowHeroList = list
end

function getShowHeroData(self)
    return self.m_showHeroList, self.m_showHeroPosDic, self.m_showHeroIdDic, self.m_tempShowHeroList
end

-- 设置玩家等级
function setPlayerLvl(self, cusData)
    local num = tonumber(cusData)
    local oldValue = self.m_playerLvl
    if (self.m_playerLvl ~= num) then
        self.m_playerLvl = num
    end
    if oldValue ~= nil and oldValue < self.m_playerLvl then
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_LVL, {
            oldLv = oldValue
        })
    end
end

-- 获取玩家等级
function getPlayerLvl(self)
    return self.m_playerLvl
end

-- 设置玩家名
function setPlayerName(self, cusData)
    if (self.m_playerName ~= cusData) then
        self.m_playerName = cusData
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_NAME)
    end
end

-- 获取玩家名
function getPlayerName(self)
    return self.m_playerName
end

-- 设置玩家经验
function setPlayerExp(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerExp ~= num) then
        self.m_playerExp = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_EXP)
    end
end

-- 获取玩家经验
function getPlayerExp(self)
    return self.m_playerExp
end

-- 设置玩家最大经验
function setPlayerMaxExp(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerMaxExp ~= num) then
        self.m_playerMaxExp = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MAXEXP)
    end
end

-- 获取玩家最大经验值
function getPlayerMaxExp(self)
    return self.m_playerMaxExp
end

function setChatBubbleTid(self, tid)
    self.m_playerChatBubbleTid = tid
end

--获取玩家当前使用的气泡tid
function getChatBubbleTid(self)
    return self.m_playerChatBubbleTid or 0
end

-- 设置玩家vip等级
function setPlayerVipLvl(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerVipLvl ~= num) then
        self.m_playerVipLvl = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_VIP_LVL)
    end
end

-- 玩家声望等阶
function setPlayerPerstigeStage(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerPrestigeStage ~= num) then
        self.m_playerPrestigeStage = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_PRESTIGE_STAGE)
    end
end

function getPlayerPerstigeStage(self)
    return self.m_playerPrestigeStage
end

------------------------------------以下为货币信息----------------------------------------------

-- 获取玩家vip等级
function getPlayerVipLvl(self)
    return self.m_playerVipLvl
end

-- 钛金石
function setPlayerItianium(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerItianium ~= num) then
        self.m_playerItianium = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.ITIANIUM_TID)
    end
end

function getPlayerItianium(self)
    return self.m_playerItianium
end

-- 金币
function setPlayerGoldCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerGoldCoin ~= num) then
        self.m_playerGoldCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.GOLD_COIN_TID)
    end
end

function getPlayerGoldCoin(self)
    return self.m_playerGoldCoin
end
-- 产能
function getPlayerCapacitey(self)
    -- self.mPlayerCapacitey = miniFac.MiniFactoryManager:getFactoryCapacityVo().capacity
    -- return self.mPlayerCapacitey
    self.mBuildBasePower = buildBase.BuildBaseManager:getCurrentPower()
    return self.mBuildBasePower
end
-- 模组构件
function getPlayerModuleMember(self)
    self.mPlayerModuleMember = bag.BagManager:getPropsCountByTid(MoneyTid.MODULE_MEMBER_TYPE_TID)
    return self.mPlayerModuleMember
end

-- 竞技币
function setPlayerArenaCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerArenaCoin ~= num) then
        self.m_playerArenaCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.ARENA_COIN_TID)
    end
end

function getPlayerArenaCoin(self)
    return self.m_playerArenaCoin
end

-- 装饰币
function setPlayerDecorateCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerDecorateCoin ~= num) then
        self.m_playerDecorateCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.DECORATE_COIN_TID)
    end
end

function getPlayerDecorateCoin(self)
    return self.m_playerDecorateCoin
end

-- 使徒之证
function setPlayerApostles2Coin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerApostles2Coin ~= num) then
        self.m_playerApostles2Coin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.APOSTLES2COIN)
    end
end

function getPlayerApostles2Coin(self)
    return self.m_playerApostles2Coin
end

-- 战员经验
function setPlayerHeroGlobalExp(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerHeroGlobalExp ~= num) then
        self.m_playerHeroGlobalExp = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.HERO_GLOBAL_EXP_TID)
    end
end

function getPlayerHeroGlobalExp(self)
    return self.m_playerHeroGlobalExp
end

-- 玩家研究所全局经验
function setPlayerHelperGlobalExp(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerHelperGlobalExp ~= num) then
        self.m_playerHelperGlobalExp = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.PLAYER_HELPER_EXP_TID)
    end
end

function getPlayerHelperGlobalExp(self)
    return self.m_playerHelperGlobalExp
end

-- 充值货币钛石
function setPayItianium(self, cusData)
    local num = tonumber(cusData)
    if (self.m_payItianium ~= num) then
        self.m_payItianium = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.PAY_ITIANIUM_TID)
    end
end
-- 充值货币钛石
function getPayItianium(self)
    return self.m_payItianium
end

-- 无限币
function setInfiniteCityCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_infiniteCity_coin ~= num) then
        self.m_infiniteCity_coin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.INFINITECITY_COIN_TID)
    end
end

function getInfiniteCityCoin(self)
    return self.m_infiniteCity_coin
end

-- 声望
function setPrestigeCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_prestige_coin ~= num) then
        self.m_prestige_coin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.PRESTIGE_COIN_TID)
    end
end

function getPrestigeCoin(self)
    return self.m_prestige_coin
end

-- 玩家声望经验值（这里和8的区别，强调的是经验）
function setPlayerPrestigeExp(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerPrestigeExp ~= num) then
        self.m_playerPrestigeExp = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.PLAYER_PRESTIGE_EXP_TID)
    end
end

function getPlayerPrestigeExp(self)
    return self.m_playerPrestigeExp
end

-- 函数币(肉鸽关卡内货币)
function setFunctionCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_playerFunction ~= num) then
        self.m_playerFunction = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.FUNCTION_TID)
    end
end

function getFunctionCoin(self)
    return self.m_playerFunction
end

-- 肉鸽货币m_FashionCoin
function setRogueLikeCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_rogueLikeCoin ~= num) then
        self.m_rogueLikeCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.ROGUELIKE_TID)
    end
end

function getRogueLikeCoin(self)
    return self.m_rogueLikeCoin
end

-- 时装币
function setFashionCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_FashionCoin ~= num) then
        self.m_FashionCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.FASHION_TID)
    end
end

function getFashionCoin(self)
    return self.m_FashionCoin
end
-- 无人机货币
function getPlayerDrone(self)
    self.mPlayerCapacitey = buildBase.BuildBaseManager:getAllDrone()
    return self.mPlayerCapacitey
end

-- 限时活动货币 tid 28
function setActivityCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_ActivityCoin ~= num) then
        self.m_ActivityCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.ACTIVITY_COIN_TID)
    end
end

function getActivityCoin(self)
    return self.m_ActivityCoin
end

function setPvpHellCoin(self, cusData)
    local num = tonumber(cusData)
    if(self.m_PvpHellCoin ~= num) then
        self.m_PvpHellCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.PVP_HELL_TID)
    end
end

function getPvpHellCoin(self)
    return self.m_PvpHellCoin
end

function setGuildCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_GuildCoin ~= num) then
        self.m_GuildCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.GUILD_TID)
    end
end

function getGuildCoin(self)
    return self.m_GuildCoin
end

function setDoundlessCoin(self, cusData)
    local num = tonumber(cusData)
    if (self.m_DoundlessCoin ~= num) then
        self.m_DoundlessCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.DOUNDLESS_TID)
    end
end

function getDoundlessCoin(self)
    return self.m_DoundlessCoin
end

function setHappyFarmMoney(self, money)
    local num = tonumber(money)

    if (self.m_playerHappyFarmMoney ~= num) then
        self.m_playerHappyFarmMoney = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.HAPPYFARM_TID)
    end
end

function getHappyFarmMoney(self)
    return self.m_playerHappyFarmMoney or 0
end

function setGuildWarCoin(self,money)
    local num = tonumber(money)

    if (self.m_GuildWarCoin ~= num) then
        self.m_GuildWarCoin = num
        self:dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.GUILDWAR_TID)
    end
end

function getGuildWarCoin(self)
    return self.m_GuildWarCoin or 0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
