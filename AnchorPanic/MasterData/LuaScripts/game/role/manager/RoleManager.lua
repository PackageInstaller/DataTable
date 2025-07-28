module("role.RoleManager", Class.impl(Manager))

-------------------事件-----------------------------
------------------------------------------------------------
--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
    self.m_roleInfo:initData()
end

function __init(self)
    -- 个人主页里展示的英雄数量
    self.heroShowNum = 5
    -------------------一些数据-----------------------------
    -- 角色信息
    self.m_roleInfo = self:getRoleVo()
    -- 角色升级字典
    self.m_roleLvlUpDic = nil
    --角色背景字典
    self.mRoleBackGroundDic = nil
    --个人信息列表
    self.mPersonalInfodata = nil
    --获取好友信息
    self.mOtherInfo = nil
    --选中ID
    self.mSelectId = 0
    --设置背景是否打开
    self.mIsBgOpen = false

    -- 是否初始化完成
    self.isRoleDataInit = false
end

-- 解析角色升级表
function praseLvlUpConfig(self)
    self.m_roleLvlUpDic = {}
    self.mRoleMaxLv = 0
    local baseData = RefMgr:getData("player_lvl")
    for lvl, data in pairs(baseData) do
        local vo = role.RoleLvlUpVo.new()
        vo:parseConfigData(lvl, data)
        if self.mRoleMaxLv < lvl then
            self.mRoleMaxLv = lvl
        end
        self.m_roleLvlUpDic[vo.lvl] = vo
    end
end

function getMaxRoleLv(self)
    if self.mRoleMaxLv == nil then
        self:praseLvlUpConfig()
    end
    return self.mRoleMaxLv
end
-- 解析玩家个人信息
function prasePersonalInfoData(self, msg)
    local vo = role.PersonalInfoVo.new()
    vo:parsePersonalInfoMsg(msg)
    self.mPersonalInfodata = vo
    GameDispatcher:dispatchEvent(EventName.UPDATE_ROLE_INFO_VIEW)
end
-- 获取个人信息列表
function getPersonalInfoList(self)
    return self.mPersonalInfodata
end

-- 根据等级获取角色升级vo
function getLvlUpVoByLvl(self, cusLvl)
    if (not self.m_roleLvlUpDic) then
        self:praseLvlUpConfig()
    end
    return self.m_roleLvlUpDic[cusLvl]
end
-- 取当前等级的升级数据
function getCurLvlVo(self)
    local vo = self:getLvlUpVoByLvl(self:getRoleVo():getPlayerLvl())
    return vo
end
-- 获取角色vo
function getRoleVo(self)
    if (not self.m_roleInfo) then
        self.m_roleInfo = role.RoleVo.new()
    end
    return self.m_roleInfo
end
-- 解析背景列表
function parseBackGroundListData(self)
    self.mRoleBackGroundList = {}
    self.mRoleBackGroundKeyDic = {}
    self.mRoleBackGroundDic = {}
    local baseData = RefMgr:getData("background_data")
    for key, data in pairs(baseData) do
        local vo = role.RoleBackGroundVo.new()
        vo:parseBackGroundData(key, data)
        table.insert(self.mRoleBackGroundList, vo)
        self.mRoleBackGroundKeyDic[vo.icon] = key
        self.mRoleBackGroundDic[key] = vo
    end
end
-- 修改其他玩家信息
function setOtherInfo(self, info)
    self.mOtherInfo = info
    friend.FriendManager:dispatchEvent(friend.FriendManager.FRIEND_CHECK_INFO)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SHOWROLE_TIPS)

end
--获取其他玩家信息
function getOtherInfo(self)
    return self.mOtherInfo
end
-- 修改输入框初始文本
function setInputText(self, txt)
    self.mTxt = txt
end
--获取其他玩家信息
function getInputText(self)
    return self.mTxt
end
-- 修改选中id
function setSelectId(self, id)
    self.mSelectId = id
end
--获取选中id
function getSelectId(self)
    return self.mSelectId
end
--获取背景是否打开
function setBgIsOpen(self, isOpen)
    self.mIsBgOpen = isOpen
end
--获取背景是否打开
function getBgIsOpen(self)
    return self.mIsBgOpen
end
-- 获取背景列表
function getBackGroundList(self)
    if (not self.mRoleBackGroundList) then
        self:parseBackGroundListData()
    end
    local lockList = {}
    local unLockList = {}
    for i, vo in ipairs(self.mRoleBackGroundList) do
        if decorate.DecorateManager:getBackGroundIsActive(vo:getUnLockType()) == true then
            table.insert(unLockList, vo)
        else
            table.insert(lockList, vo)
        end
    end
    table.sort(unLockList, function(vo1, vo2) return vo1:getSort() < vo2:getSort() end)
    table.sort(lockList, function(vo1, vo2) return vo1.sort < vo2.sort end)
    for i, vo in ipairs(lockList) do
        table.insert(unLockList, vo)
    end
    return unLockList
end

-- 获取背景列表id
function getBackGroundIdByIcon(self, icon)
    if (not self.mRoleBackGroundKeyDic) then
        self:parseBackGroundListData()
    end
    return self.mRoleBackGroundKeyDic[icon]
end
-- 获取背景数据
function getBackGroundVo(self, key)
    if (not self.mRoleBackGroundDic) then
        self:parseBackGroundListData()
    end
    return self.mRoleBackGroundDic[key]
end

-- 更新玩家属性值
function updateAttrValue(self, cusKey, cusValue)
    if (cusKey == role.AttrKey.PLAYER_LEVEL) then
        local isLvlUp = false
        if (cusValue > self:getRoleVo():getPlayerLvl()) then
            isLvlUp = true
        end
        self:getRoleVo():setPlayerLvl(cusValue)
        if (isLvlUp) then
            sdk.SdkManager:notifyRoleLvlUpSuc()
        end
    elseif (cusKey == role.AttrKey.PLAYER_VIP_LEVEL) then
        self:getRoleVo():setPlayerVipLvl(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_NAME) then
        self:getRoleVo():setPlayerName(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_ITIANIUM) then
        self:getRoleVo():setPlayerItianium(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_GOLD_COIN) then
        self:getRoleVo():setPlayerGoldCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_ARENA_COIN) then
        self:getRoleVo():setPlayerArenaCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_DECORATE_COIN) then
        self:getRoleVo():setPlayerDecorateCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_HERO_GLOBAL_EXP) then
        self:getRoleVo():setPlayerHeroGlobalExp(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_HERO_ZHAN_XUN) then
        -- self:getRoleVo():setPlayerHeroGlobalExp(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_SHOW_BOARD_HERO) then
        self:getRoleVo():setShowBoardHeroId(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_EXP) then
        self:getRoleVo():setPlayerExp(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_MAX_EXP) then
        self:getRoleVo():setPlayerMaxExp(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_AUTOGRAPH) then
        self:getRoleVo():setAutograph(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_HEAD) then
        self:getRoleVo():setAvatarId(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_HEAD_FRAME) then
        self:getRoleVo():setAvatarFrameId(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_TITLE) then
        self:getRoleVo():setTitleId(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_INFINITECITY_COIN) then
        self:getRoleVo():setInfiniteCityCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_PRESTIGE_COIN) then
        self:getRoleVo():setPrestigeCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_COVENANT_HELPER_EXP) then
        self:getRoleVo():setPlayerHelperGlobalExp(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_PAY_ITIANIUM) then
        self:getRoleVo():setPayItianium(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_PRESTIGE_EXP) then
        self:getRoleVo():setPlayerPrestigeExp(cusValue)
        -- elseif (cusKey == role.AttrKey.PLAYER_PRESTIGE_MAX_EXP) then
        --     self:getRoleVo():setPlayerPrestigeMaxExp(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_PRESTIGE_STAGE) then
        self:getRoleVo():setPlayerPerstigeStage(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_ROGUELIKE_FUNCTION) then
        self:getRoleVo():setFunctionCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_ROGUELIKE_COIN) then
        self:getRoleVo():setRogueLikeCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_APOSTLES_COIN) then
        self:getRoleVo():setPlayerApostles2Coin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_FASHION_COIN) then
        self:getRoleVo():setFashionCoin(cusValue)
    elseif (cusKey == role.AttrKey.PLAYER_MAIN_ACTIVITY_COIN) then
        self:getRoleVo():setActivityCoin(cusValue)
    elseif (cusKey == role.AttrKey.PVP_HELL_COIN) then
        self:getRoleVo():setPvpHellCoin(cusValue)
    elseif(cusKey == role.AttrKey.PLAYER_GUILD_COIN) then
        self:getRoleVo():setGuildCoin(cusValue)
    elseif(cusKey == role.AttrKey.DOUNDLESS_COIN) then
        self:getRoleVo():setDoundlessCoin(cusValue)
    elseif(cusKey == role.AttrKey.CHAT_BUBBLE_TID) then
        self:getRoleVo():setChatBubbleTid(cusValue)
    end
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
