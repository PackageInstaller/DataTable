module("guild.GuildMemberItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mBg = self:getChildGO("mBg")
    self.mHeadContent = self:getChildTrans("mHeadContent")
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtJob = self:getChildGO("mTxtJob"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtActive = self:getChildGO("mTxtActive"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mBtnRecall = self:getChildGO("mBtnRecall")

    self.mImpeachInfo = self:getChildGO("mImpeachInfo")
    self.mTxtImpeach = self:getChildGO("mTxtImpeach"):GetComponent(ty.Text)
    self.mTxtImpeachTime = self:getChildGO("mTxtImpeachTime"):GetComponent(ty.Text)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecall, self.onClickRecall)
end

function onClickRecall(self)
    UIFactory:alertMessge(_TT(94991), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_IMPEACH_LEADER)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

function setData(self, data)
    super.setData(self, data)
    self.mTxtImpeach.text = _TT(94996)
    self.mData = data

    if self.mPlayerHeadGrid == nil then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end

    self.mPlayerHeadGrid:setData(data.avatar_id)
    self.mPlayerHeadGrid:setHeadFrame(data.avatar_frame_id)
    self.mPlayerHeadGrid:setScale(0.4)
    self.mPlayerHeadGrid:setParent(self.mHeadContent)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)

    self.mTxtName.text = data.player_name
    self.mTxtJob.text = guild.getGuildJobName(data.job) -- (data.job == 0) and _TT(94523) or _TT(94524)

    local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_IMPEACH_NEED_TIME)
    local canRecall = GameManager:getClientTime() - data.offline_time > needTime
    self.impeachTime = guild.GuildManager:getImpeachMsgTime()
    local isImpeaching = guild.GuildManager:getImpeaching()
    self.mBtnRecall:SetActive(data.job == guild.GuildJobType.Leader and canRecall and isImpeaching == false and data.is_online ~= 1)
    self.mImpeachInfo:SetActive(data.job == guild.GuildJobType.Leader and isImpeaching)

    self.mTxtLv.text = _TT(1003) .. data.player_lv
    self.mTxtActive.text = data.activation

    self.mTxtTime.text = data.is_online == 1 and _TT(25126) or TimeUtil.getTimeDescToDate(data.offline_time)
    self.mTxtTime.color = data.is_online == 1 and gs.ColorUtil.GetColor("18EC68ff") or gs.ColorUtil.GetColor("C6D4E1ff")

    if data.job == guild.GuildJobType.Leader and isImpeaching then
        self.impeachWaitTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_IMPEACH_TIME)
        self:updateTime()
        self.updateImpeachSn = LoopManager:addTimer(1,0,self,self.updateTime)
    end
end

function updateTime(self)
    local needTime = self.impeachWaitTime - (GameManager:getClientTime() - self.impeachTime)
    if needTime <= 0 then
        gs.Message.Show("公会信息变更")
        GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_MEMBER_PANEL)
    else
        self.mTxtImpeachTime.text = TimeUtil.getHMSByTime(self.impeachWaitTime - (GameManager:getClientTime() - self.impeachTime))
    end
end

function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, {
        id = self.data.player_id
    })
end

function onDelete(self)
    super.onDelete(self)
    if self.updateImpeachSn then
        LoopManager:removeTimerByIndex(self.updateImpeachSn)
        self.updateImpeachSn = nil
    end
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

return _M
