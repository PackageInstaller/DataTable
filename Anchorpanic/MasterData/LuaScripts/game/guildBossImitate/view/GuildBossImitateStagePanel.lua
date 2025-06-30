-- @FileName:   GuildBossImitateStagePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module("game.guildBossImitate.view.GuildBossImitateStagePanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildBossImitate/GuildBossImitateStagePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(108001))

end
--析构
function dtor(self)
end

function initData(self)
    self.m_dupId = 0
end

-- 设置货币栏
function setMoneyBar(self)
end

-- 初始化
function configUI(self)
    self.mBtnLevelSetting = self:getChildGO("mBtnLevelSetting")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mTextLevelSetting = self:getChildGO("mTextLevelSetting"):GetComponent(ty.Text)
    self.mTextRank = self:getChildGO("mTextRank"):GetComponent(ty.Text)
    self.mTextLevel = self:getChildGO("mTextLevel"):GetComponent(ty.Text)
    self.mTextAttr = self:getChildGO("mTextAttr"):GetComponent(ty.Text)
    self.mEleGroup = self:getChildTrans("mEleGroup")
    self.mItemEle = self:getChildGO("mItemEle")
    self.mTextMaxRecord = self:getChildGO("mTextMaxRecord"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
end

function initViewText(self)
    self.mTextLevelSetting.text = _TT(108002)
    self.mTextRank.text = _TT(108003)
    self.mTextAttr.text = _TT(108006)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    local dupId = guildBossImitate.GuildBossImitateManager:getSaveCacheDupId()
    GameDispatcher:dispatchEvent(EventName.REQ_GUILDBOSSIMITATE_DUPINFO, dupId)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self.m_dupId = 0

    self:RemoveEventListener()
    self:recoverModel(true)

    self:clearEleItem()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mBtnLevelSetting, self.onOpenLevelSetting)
    self:addUIEvent(self.mBtnRank, self.onOpenRank)

end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.RECEIVE_GUILDBOSSIMITATE_DUPINFO, self.onReceiveDupInfo, self)

end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.RECEIVE_GUILDBOSSIMITATE_DUPINFO, self.onReceiveDupInfo, self)

end

function onOpenLevelSetting(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_LEVELSELECTPANEL)
end

function onOpenRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_RANKPANEL)
end

function onFight(self)

    local dupId = self.m_dupId
    local function callFun(callReason)
        local isOnGuild = guild.GuildManager:getJoinGuilded()
        if callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE then
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_STAGEPANEL)
        elseif (callReason == formation.CALL_FUN_REASON.CLOSE) then
            if isOnGuild then
                fight.FightManager:reqBattleEnter(PreFightBattleType.Guild_Imitate, dupId, nil)
            else
                gs.Message.Show(_TT(108021))
                return
            end
        end
    end
    -- formation.readyFormationFight(PreFightBattleType.Guild_Imitate, DupType.GuildImitate, self.m_dupId, formation.TYPE.GUILD_IMITATE, nil, nil, callFun)

    local defaultData = {data = nil, battleType = PreFightBattleType.Guild_Imitate, dupType = DupType.GuildImitate, dupId = dupId}
    formation.openFormation(formation.TYPE.GUILD_IMITATE, nil, defaultData, callFun)
    self:close()
end

function onReceiveDupInfo(self, dupId)
    if self.m_dupId == dupId then
        return
    end

    self.m_dupId = dupId
    self.m_dupConfig = guildBossImitate.GuildBossImitateManager:getDupConfig(self.m_dupId)

    self:refreshView()
end

function refreshView(self)
    local monsterConfigVo = monster.MonsterManager:getMonsterVo(self.m_dupConfig.boss_id)
    self.mTextLevel.text = _TT(108005) .. monsterConfigVo.lvl

    local dupInfo = guildBossImitate.GuildBossImitateManager:getDupInfoData()
    self.mTextMaxRecord.text = _TT(108004, tonumber(dupInfo.my_rank_val))

    self:updateModelView()
    self:createEleItem()
end

function createEleItem(self)
    self:clearEleItem()
    local monsterConfigVo = monster.MonsterManager:getMonsterVo(self.m_dupConfig.boss_id)
    local monsterBaseConfigVo = monster.MonsterManager:getMonsterVo01(monsterConfigVo.tid)
    for i = 1, #monsterBaseConfigVo.weak do
        local weak = monsterBaseConfigVo.weak[i]
        local item = SimpleInsItem:create(self.mItemEle, self.mEleGroup, "GuildBossImitateStagePanel_EleItem")
        item:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(weak))

        table.insert(self.m_eleItemList, item)
    end
end

function clearEleItem(self)
    if self.m_eleItemList then
        for k, item in pairs(self.m_eleItemList) do
            item:poolRecover()
        end
    end

    self.m_eleItemList = {}
end

-- 更新模型
function updateModelView(self)
    if not self.mModelPlayer then
        self.mModelPlayer = ModelScenePlayer.new()
    end
    local monsterConfigVo = monster.MonsterManager:getMonsterVo(self.m_dupConfig.boss_id)
    local monsterBaseConfigVo = monster.MonsterManager:getMonsterVo01(monsterConfigVo.tid)
    local model = monsterBaseConfigVo.showModelld
    if (model) then
        self.mModelPlayer:setModelData(model, true, false, 1, true, MainCityConst.APOSTLE_MONSTER_UI, UrlManager:getBgPath("guild/guild_boss_bg_01.jpg"), nil, true, nil)
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    if self.mModelPlayer then
        self.mModelPlayer:reset(isResetMaincity)
        self.mModelPlayer = nil
    end
end

return _M
