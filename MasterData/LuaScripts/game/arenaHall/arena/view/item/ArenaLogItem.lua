module("arena.ArenaLogItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnFightData = self:getChildGO("mBtnFightData")
    self.mEnemyHeadNode = self:getChildTrans("mEnemyHeadNode")
    self.mTxtWin = self:getChildGO("mTxtWin"):GetComponent(ty.Text)
    self.mTexLose = self:getChildGO("mTxtLose"):GetComponent(ty.Text)
    self.mTxtDate = self:getChildGO("mTxtDate"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mTxtEnemyNme = self:getChildGO("mTxtEnemyNme"):GetComponent(ty.Text)
    self.mTxtScoreDec = self:getChildGO("mTxtScoreDec"):GetComponent(ty.Text)
    self.mImgLeftTitle = self:getChildGO("mImgLeftTitle"):GetComponent(ty.AutoRefImage)

    self:addOnClick(self.mBtnReplay, self.onClickReplayHandler)
    self:addOnClick(self.mBtnFightData, self.onOpenDataPre)
end

function initViewText(self)
    self.m_textTilteTime.text = _TT(169)
    self.mTxtScoreDec.text = _TT(159)
    self:setBtnLabel(self.mBtnReplay, 48025, "回放")
    self:setBtnLabel(self.mBtnFightData, 48025, "数据")

end

function setData(self, param)
    super.setData(self, param)

    local arenaLogVo = self.data
    self.m_battleID = arenaLogVo.battleId

    -- self.mBtnFightData:SetActive(self.data.can_replay)
    -- self.mBtnReplay:SetActive(self.data.can_replay)

    if (arenaLogVo.isWin) then
        self.mTxtWin.gameObject:SetActive(true)
        self.mTexLose.gameObject:SetActive(false)
        self.mTxtWin.text = arenaLogVo.isSelfAttack == true and _TT(62221) or _TT(62223)
        self.mImgLeftTitle.color = gs.ColorUtil.GetColor("2198FCFF")
        self.mTxtScore.text = "+" .. arenaLogVo.addScore
        self.mTxtScore.color = gs.ColorUtil.GetColor("2198FCFF")
    else
        self.mTxtWin.gameObject:SetActive(false)
        self.mTexLose.gameObject:SetActive(true)
        self.mTexLose.text = arenaLogVo.isSelfAttack == true and _TT(62222) or _TT(62224)
        self.mImgLeftTitle.color = gs.ColorUtil.GetColor("D53529FF")
        self.mTxtScore.text = "-" .. arenaLogVo.delScore
        self.mTxtScore.color = gs.ColorUtil.GetColor("D53529FF")
    end


    if (not self.mRightHeadGrid) then
        self.mRightHeadGrid = PlayerHeadGrid:poolGet()
    end
    if arenaLogVo.isRobat then
        local robotVo = arena.ArenaManager:getRobotData(arenaLogVo.playerId)
        self.mRightHeadGrid:setData(robotVo:getHeadIcon())
    else
        self.mRightHeadGrid:setData(arenaLogVo.avatar)
    end
    self.mRightHeadGrid:setParent(self.mEnemyHeadNode)
    self.mRightHeadGrid:setScale(1)
    self.mRightHeadGrid:setHeadFrame(nil)
    self.mRightHeadGrid:setClickEnable(true)
    self.mRightHeadGrid:setCallBack(self, self.onClickHeadHandler)

    self.mTxtEnemyNme.text = arenaLogVo.name
    -- 时间
    self.mTxtTime.text, self.mTxtDate.text = TimeUtil.getMDHByTime2(arenaLogVo.time)

end

function onOpenDataPre(self)
    if self.data.can_replay == 0 then gs.Message.Show(_TT(198)) return end

    fight.FightController:reqBattleRePlayDate(8, self.data.battleId)
end

function onClickHeadHandler(self, args)
    if not self.data.isRobat then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.playerId })
    end
end

function onClickReplayHandler(self)
    if self.data.can_replay == 0 then gs.Message.Show(_TT(198)) return end
    -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ARENE_REPLAY)
    -- if (isNotRemind) then
    --     self:sendReplay()
    -- else
    -- '是否查看本场斗录像？'
    UIFactory:alertMessge(_TT(178), true, function(cusType)
        self:sendReplay()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.ARENE_REPLAY
    )
    -- end
end

-- 发送回放
function sendReplay(self)
    if self.m_battleID and self.m_battleID ~= 0 and self.m_battleID ~= "0" then
        fight.FightManager:reqReplay(PreFightBattleType.ArenaChallenge, self.m_battleID)
    else
        -- gs.Message.Show("没有回放ID")
        gs.Message.Show(_TT(179))
    end
    GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_LOG_PANEL, {})
end

function onClickChallengeHandler(self, args)
    if (arena.ArenaManager.remainChallengeTimes > 0) then
        self:sendChallenge()
    else
        local costTid = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_TID)
        local costCount = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_COUNT)
        local judgeType = shop.ShopManager:getPropsJudgeType(costTid, costCount)
        if (judgeType == shop.PropsJudge.PROPS_ENOUGH) then
            self:sendChallenge()
        elseif (judgeType ~= shop.PropsJudge.MONEY_ENOUGH and judgeType ~= shop.PropsJudge.MONEY_NOT_ENOUGH) then
            gs.Message.Show(_TT(62219))
        end
    end
end

-- 发送挑战
function sendChallenge(self)
    local arenaEnemyVo = self.data
    formation.checkFormationFight(PreFightBattleType.ArenaChallenge, nil, arenaEnemyVo.playerId, nil, nil, nil)
end

function deActive(self)
    super.deActive(self)

    if (self.mRightHeadGrid) then
        self.mRightHeadGrid:setClickEnable(false)
        self.mRightHeadGrid:setCallBack(nil, nil)
        self.mRightHeadGrid:poolRecover()
        self.mRightHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62219):	"道具不足"
]]