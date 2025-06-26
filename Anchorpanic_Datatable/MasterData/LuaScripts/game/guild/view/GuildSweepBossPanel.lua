module("guild.GuildSweepBossPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildSweepBossPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(100001))

    self:setUICode(LinkCode.GuildSweep)
end

function initData(self)
    super.initData(self)

    self.mAwardItemList = {}
    self.mAwardPropsList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtBossName = self:getChildGO("mTxtBossName"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
    self.mSlideBgRt = self:getChildGO("mSlideBg"):GetComponent(ty.RectTransform)
    self.mSliderRt = self:getChildGO("mSlider"):GetComponent(ty.RectTransform)
    self.mStepAwardContent = self:getChildTrans("mStepAwardContent")
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)

    self.mAwardItem = self:getChildGO("mAwardItem")

    self.mBtnCloseAward = self:getChildGO("mBtnCloseAward")
    self.mAwardTipsRT = self:getChildGO("mAwardTips"):GetComponent(ty.RectTransform)
    self.mTxtAwardInfo = self:getChildGO("mTxtAwardInfo"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mBtnHideAward = self:getChildGO("mBtnHideAward")

    self.mBtnInfo = self:getChildGO("mBtnInfo")
    self.mBtnLog = self:getChildGO("mBtnLog")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mTxtTimes = self:getChildGO("mTxtTimes"):GetComponent(ty.Text)
    self.mModelScenePlayer = ModelScenePlayer.new()

    self:setGuideTrans("functips_sweep_level", self:getChildTrans("functips_sweep_level"))
    self:setGuideTrans("functips_sweep_award", self:getChildTrans("functips_sweep_award"))
    self:setGuideTrans("functips_sweep_fight", self:getChildTrans("functips_sweep_fight"))
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_SWEEP_BOSS_PANEL, self.showPanel, self)
    self.data = guild.GuildManager: getClickVo()
    self.monConfig = monster.MonsterManager:getMonsterVo01(self.data.modelTid)
    guild.GuildManager:setSweepBossName(self.monConfig.name)

    self.dif = guild.GuildManager:getGuildSweepNowLevel()
    self.mDupId = self.data.stage[self.dif]
    self.mDupVo = guild.GuildManager:getSweepDupDataByDupId(self.mDupId)

    self:showPanel()
end

function onOpenFormationPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {
        dupVo = self.mDupVo
    })
end

function onOpenLogPanel(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_SWEEP_LOG_INFO)
end

-- 反激活（销毁工作）
function deActive(self)
    self:recoverModel(true)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_SWEEP_BOSS_PANEL, self.showPanel, self)


    self:clearAwardProps()
    self:clearAwardItemList()

    if self.mSweepSn then
        LoopManager:removeTimerByIndex(self.mSweepSn)
        self.mSweepSn = nil
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHideAward, self.onHideAwardClick)
    self:addUIEvent(self.mBtnInfo, self.onOpenFormationPanel)
    self:addUIEvent(self.mBtnLog, self.onOpenLogPanel)
    self:addUIEvent(self.mBtnFight, self.onFightHandler)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {id = LinkCode.GuildSweep})
end

function onFightHandler(self)
    if self.remTimes <= 0 then
        gs.Message.Show(_TT(100002))
        return
    end

    if  self.remHp <= 0 then
        gs.Message.Show(_TT(100003))
        return
    end

    formation.checkFormationFight(PreFightBattleType.Guild_Sweep, DupType.Guild_Sweep, self.mDupId,
        formation.TYPE.GUILD_SWEEP, nil, nil)
end

function onHideAwardClick(self)
    self.mBtnCloseAward:SetActive(false)
end

function showPanel(self)
    local difId = guild.GuildManager:getGuildSweepNowLevel()
    self.mTxtBossName.text = self.monConfig.name
    self.mTxtLevel.text = _TT(100004,difId)
    self:clearAwardItemList()
  
    local diffVo = guild.GuildManager:getSweepDifficultyDataByDifId(difId)

    local awardList = diffVo.mStepList

    self.maxTimes = sysParam.SysParamManager:getValue(SysParamType.GUILD_SEEP_MAX_TIMES)
    self.remTimes = guild.GuildManager:getGuildSweepChallengeTimes()
    self.mTxtTimes.text = string.substitute(_TT(100005), self.remTimes, self.maxTimes) 

    local singleX = self.mSlideBgRt.sizeDelta.x / #awardList
    local needX = 0
    local needed = false

    self.remHp = guild.GuildManager:getGuildSweepHpRate()
    local curHp = 100 - self.remHp

    self.mTxtCount.text = self.remHp .. "%"

    for i = 1, #awardList do
        local awardVo = awardList[i]
        local awardItem = SimpleInsItem:create(self.mAwardItem, self.mStepAwardContent, "mGuildSweepAwardItem")

        awardItem:getChildGO("mTxtScore"):GetComponent(ty.Text).text = awardVo.remainingHp

        local isPass = guild.GuildManager:getGuildSweepRewardGeted(i)
        awardItem:getChildGO("isPass"):SetActive(isPass)
    
        awardItem:addUIEvent(nil, function()
            self:openAwardInfo(awardVo, isPass, awardItem.m_trans)
        end)

        local redTran = awardItem:getChildTrans("mClickBg")
        if guild.GuildManager:canGetSingleRewardRed(awardVo) then
            RedPointManager:add(redTran, nil, 35.6, 29)
            awardItem:getChildGO("mCanGet"):SetActive(true)
        else
            RedPointManager:remove(redTran, nil, 0, 0)
            awardItem:getChildGO("mCanGet"):SetActive(false)
        end

        table.insert(self.mAwardItemList, awardItem)

        local needAtkHp = 100 - awardVo.remainingHp
        if needed == false then
            if curHp > needAtkHp then
                needX = needX + singleX
            else
                local v = 0
                if i == 1 then
                    v = curHp / needAtkHp
                else
                    local firstV = 100 - awardList[i - 1].remainingHp
                    v = (curHp - firstV) / (needAtkHp - firstV)
                end
                needX = needX + v * singleX
                needed = true
            end
        end
    end

    if self.remHp <= 0 then
        gs.TransQuick:SizeDelta01(self.mSliderRt, self.mSlideBgRt.sizeDelta.x)
    else
        gs.TransQuick:SizeDelta01(self.mSliderRt, needX)
    end

    self:refreshGuildSweepTime()
    --self:setTimeout(0.1, function()
        self:updateModelView()
    --end)
end

function openAwardInfo(self, awardVo, isPass, trans)
    if isPass == false and self.remHp <= awardVo.remainingHp then
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_SWEEP_REWARD, {
            id = awardVo.id
        })
        return
    end

    self.mBtnCloseAward:SetActive(true)
    self.mTxtAwardInfo.text = _TT(100012,awardVo.remainingHp)
    gs.TransQuick:Pos(self.mAwardTipsRT.transform, trans)

    self:clearAwardProps()
    for i = 1, #awardVo.award do
        local vo = awardVo.award[i]
        local propsItem = PropsGrid:create(self.mAwardContent, {vo[1], vo[2]}, 0.7, false)
        propsItem:setHasRec(isPass)
        table.insert(self.mAwardPropsList, propsItem)
    end
end

function clearAwardItemList(self)
    for i = 1, #self.mAwardItemList do
        self.mAwardItemList[i]:poolRecover()
    end
    self.mAwardItemList = {}
end

function clearAwardProps(self)
    for i = 1, #self.mAwardPropsList do
        self.mAwardPropsList[i]:poolRecover()
    end
    self.mAwardPropsList = {}
end

-- 更新模型
function updateModelView(self)
    --self:recoverModel(false)
    local modelId = self.monConfig.model

        --self.mModelPlayer:setModelData(modelId, true, false, 1, true, MainCityConst.APOSTLE_MONSTER_UI, UrlManager:getBgPath("dupApoWar/DE_bg_01.jpg"), nil, true, nil)
    self.mModelScenePlayer:setModelData(modelId, true, false, 1, true, MainCityConst.APOSTLE_MONSTER_UI,
            UrlManager:getBgPath("guild/guild_boss_bg_01.jpg"), nil, true, nil)

end

function recoverModel(self, isResetMaincity)
    self.mModelScenePlayer:reset(isResetMaincity)
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
