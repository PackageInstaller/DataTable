module("guild.GuildSweepMainPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildSweepMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(100001))
    self:setSize(0, 0)
    self:setBg("guild_sweep_01.jpg", false, "guild")
end
-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtLevelSelect = self:getChildGO("mTxtLevelSelect"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mGroupLevel1 = self:getChildGO("mGroupLevel1")
    self.mGroupLevel2 = self:getChildGO("mGroupLevel2")
    self.mGroupLevel3 = self:getChildGO("mGroupLevel3")
    self.mGroupLevel4 = self:getChildGO("mGroupLevel4")
    self.mGroupLevel5 = self:getChildGO("mGroupLevel5")
    self.mGroupLevel6 = self:getChildGO("mGroupLevel6")
    self.mGroupLevelList = {}

    table.insert(self.mGroupLevelList, self.mGroupLevel1)
    table.insert(self.mGroupLevelList, self.mGroupLevel2)
    table.insert(self.mGroupLevelList, self.mGroupLevel3)
    table.insert(self.mGroupLevelList, self.mGroupLevel4)
    table.insert(self.mGroupLevelList, self.mGroupLevel5)
    table.insert(self.mGroupLevelList, self.mGroupLevel6)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.mSweepSn then
        LoopManager:removeTimerByIndex(self.mSweepSn)
        self.mSweepSn = nil
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function showPanel(self)

    self.mTxtLevelSelect.text = guild.GuildManager:getGuildSweepNowLevel()
    -- GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SWEEP_LEVEL_SELECT_PANEL)
    local roundId = guild.GuildManager:getGuildSweepRoundId()
    local hpRate = guild.GuildManager:getGuildSweepHpRate()
    local dic = guild.GuildManager:getSweepMapData()
    for i = 1, #self.mGroupLevelList do
        local sweepVo = dic[i]
        local item = SimpleInsItem:create2(self.mGroupLevelList[i])
        if sweepVo.mapId == roundId then
            item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "guild/guild_sweep_type_0" .. sweepVo.mapId .. ".png", false))
            item:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "guild/img_main_map_0" .. sweepVo.mapId .. ".png", false))
            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(sweepVo.name)

            item:getChildGO("mImgPass"):SetActive(hpRate == 0)
            local function callFun()
                self:openBossPanel(sweepVo)
            end
            item:addUIEvent("mGroupClick", callFun)

            local isRed = guild.GuildManager:canGetSweepRewardRed() or guild.GuildManager:canChallengeSweepRed()
            if isRed then
                RedPointManager:add(item:getChildTrans("mGroupClick"), nil, 110.6, 38.2)
            else
                RedPointManager:remove(item:getChildTrans("mGroupClick"))
            end

            item.m_go:SetActive(true)
        else
            item.m_go:SetActive(false)
        end
    end

    self:refreshGuildSweepTime()
end

function openBossPanel(self, vo)
    guild.GuildManager:setClickVo(vo)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_SWEEP_INFO)
end

function refreshGuildSweepTime(self)
    self.lastChangeTime = guild.GuildManager:getGuildSweepChangeTime()

    if self.mSweepSn then
        LoopManager:removeTimerByIndex(self.mSweepSn)
        self.mSweepSn = nil
    end
    self:refreshSweepTime()
    self.mSweepSn = self:addTimer(1, 0, self.refreshSweepTime)
end

function refreshSweepTime(self)
    local sweepState = guild.GuildManager:getGuildSweepState()
    if sweepState == 0 then
        local clientTime = GameManager:getClientTime()
        if self.lastChangeTime - clientTime > 0 then
            self.mTxtTime.text = _TT(100014) .. TimeUtil.getNewRoleShowTime(self.lastChangeTime - clientTime)
        else
            self:close()
        end
    end
end

return _M
