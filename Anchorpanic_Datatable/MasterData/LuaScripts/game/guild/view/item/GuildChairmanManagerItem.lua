module("guild.GuildChairmanManagerItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mBg = self:getChildGO("mBg")
    self.mHeadContent = self:getChildTrans("mHeadContent")
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtJob = self:getChildGO("mTxtJob"):GetComponent(ty.Text)
    -- self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtActive = self:getChildGO("mTxtActive"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    --self.mBtnTransferPlayer = self:getChildGO("mBtnTransferPlayer")
    self.mBtnRemovePlayer = self:getChildGO("mBtnRemovePlayer")

    
    self.mBtnRecall = self:getChildGO("mBtnRecall")

    self.mImpeachInfo = self:getChildGO("mImpeachInfo")
    self.mTxtImpeach = self:getChildGO("mTxtImpeach"):GetComponent(ty.Text)
    self.mTxtImpeachTime = self:getChildGO("mTxtImpeachTime"):GetComponent(ty.Text)

    --self:getChildGO("mTxtTransfer"):GetComponent(ty.Text).text = _TT(94521)
    self:getChildGO("mTxtRemove"):GetComponent(ty.Text).text = _TT(94522)
    self.mTxtImpeach.text = _TT(94996)
end

-- override 虚拟列表被激活时自动调用
function active(self)
    super.active(self)
end

-- override 虚拟列表被非激活时自动调用
function deActive(self)
    super.deActive(self)
end

-- UI事件管理
function addAllUIEvent(self)
    --self:addUIEvent(self.mBtnTransferPlayer, self.onClickTransferPlayer)
    self:addUIEvent(self.mBtnRemovePlayer, self.onClickRemovePlayer)
    self:addUIEvent(self.mBtnRecall, self.onClickRecall)
end

function onClickRecall(self)
    UIFactory:alertMessge(_TT(94991), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_IMPEACH_LEADER)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

-- function onClickTransferPlayer(self)
--     GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_JOB_TRANS_PANEL,{data =self.mData,trans = self.mBtnTransferPlayer.transform})
-- end

function onClickRemovePlayer(self)
    if guild.GuildManager:getGuildBossIsOpen() then
        gs.Message.Show(_TT(94597))
        return
    end

    if guild.GuildManager:getIsJoinGuildWar() then
        gs.Message.Show(_TT(149196))
        return
    end


    UIFactory:alertMessge(_TT(94525, self.data.player_name), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_REMOVE_MEMBER, { applyPlayerId = self.data.player_id })
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)

end
-- function onBgClick(self)
--     GameDispatcher:dispatchEvent(EventName.ONCLICK_GUILD_SEARCHITEM, self.mData)
-- end

function setData(self, data)
    super.setData(self, data)

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
    self.mTxtJob.text = guild.getGuildJobName(data.job) --(data.job == 0) and _TT(94523) or _TT(94524)

    self.mTxtLv.text = _TT(1003) .. data.player_lv
    self.mTxtActive.text = data.activation

    self.mTxtTime.text = data.is_online == 1 and _TT(25126) or TimeUtil.getTimeDescToDate(data.offline_time)
    self.mTxtTime.color = data.is_online == 1 and gs.ColorUtil.GetColor("18EC68ff") or gs.ColorUtil.GetColor("C6D4E1ff")

    local roleId = role.RoleManager:getRoleVo().playerId
    self.mBtnRemovePlayer:SetActive(data.job==guild.GuildJobType.Default)

    local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_IMPEACH_NEED_TIME)
    local canRecall = GameManager:getClientTime() - data.offline_time > needTime
    self.impeachTime = guild.GuildManager:getImpeachMsgTime()
    local isImpeaching = guild.GuildManager:getImpeaching()
    self.mBtnRecall:SetActive(data.job == guild.GuildJobType.Leader and canRecall and isImpeaching == false and data.is_online ~= 1)
    self.mImpeachInfo:SetActive(data.job == guild.GuildJobType.Leader and isImpeaching)

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
        GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_CHAIRMAN_MANAGER_PANEL)
    else
        self.mTxtImpeachTime.text = TimeUtil.getHMSByTime(self.impeachWaitTime - (GameManager:getClientTime() - self.impeachTime))
    end
end

function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.player_id })
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