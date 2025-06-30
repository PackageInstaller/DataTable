module("guild.GuildManagerTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildManagerTabView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(guild.GuildManagerItem)
    -- mLyManagerItem
    self.mBtnQuit = self:getChildGO("mBtnQuit")

    self.mBtnCloseJob = self:getChildGO("mBtnCloseJob")
    self.mJobBtnsRT = self:getChildGO("mJobBtns"):GetComponent(ty.RectTransform)
    self.mBtnJob0 = self:getChildGO("mBtnJob0")
    self.mBtnJob2 = self:getChildGO("mBtnJob2")
    self.mBtnJob1 = self:getChildGO("mBtnJob1")

    self.mTxtJob0 = self:getChildGO("mTxtJob0"):GetComponent(ty.Text)
    self.mTxtJob1 = self:getChildGO("mTxtJob1"):GetComponent(ty.Text)
    self.mTxtJob2 = self:getChildGO("mTxtJob2"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_JOB_TRANS_PANEL, self.onOpenJobTrans, self)

    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.OPEN_GUILD_JOB_TRANS_PANEL, self.onOpenJobTrans, self)
    if (self.mLyScroller) then
        self.mLyScroller:CleanAllItem()
    end
    self.mBtnCloseJob:SetActive(false)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtJob0.text = _TT(94993)
    self.mTxtJob1.text = _TT(94995)
    self.mTxtJob2.text = _TT(94994)
end

function onOpenJobTrans(self, args)
    self.mSelectData = args.data

    gs.TransQuick:Pos(self.mJobBtnsRT.transform, args.trans)
    self.mBtnCloseJob:SetActive(true)

    self.mBtnJob0:SetActive(self.mSelectData.job ~= guild.GuildJobType.Default)
    self.mBtnJob2:SetActive(self.mSelectData.job ~= guild.GuildJobType.Chairman)
    self.mBtnJob1:SetActive(self.mSelectData.job ~= guild.GuildJobType.Leader)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnQuit, self.onBtnQuitClick)

    self:addUIEvent(self.mBtnCloseJob, self.onCloseJobClick)

    self:addUIEvent(self.mBtnJob1, self.onBtnJobClick, nil, 1)
    self:addUIEvent(self.mBtnJob2, self.onBtnJobClick, nil, 2)
    self:addUIEvent(self.mBtnJob0, self.onBtnJobClick, nil, 0)
end

function onCloseJobClick(self)
    self.mBtnCloseJob:SetActive(false)
end

function onBtnJobClick(self, job)
    if job == guild.GuildJobType.Leader then
        UIFactory:alertMessge(_TT(94526, self.mSelectData.player_name), true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_TRANSFER_LEADER, {
                applyPlayerId = self.mSelectData.player_id
            })
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        if job == guild.GuildJobType.Chairman then
            local chairNum = guild.GuildManager:getChairmanNum()
            if chairNum == sysParam.SysParamManager:getValue(SysParamType.GUILD_CHAIRMAN_NUM) then
                gs.Message.Show(_TT(94990))
                return
            end

            UIFactory:alertMessge(_TT(94992, self.mSelectData.player_name), true, function()
                GameDispatcher:dispatchEvent(EventName.REQ_COMMISSION_JOB, {
                    applyPlayerId = self.mSelectData.player_id,
                    job = job
                })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        else
            GameDispatcher:dispatchEvent(EventName.REQ_COMMISSION_JOB, {
                applyPlayerId = self.mSelectData.player_id,
                job = job
            })
        end
    end

    self.mBtnCloseJob:SetActive(false)
end

function onBtnQuitClick(self)
    if guild.GuildManager:getGuildBossIsOpen() then
        gs.Message.Show(_TT(94595))
        return
    end

    if guild.GuildManager:getIsJoinGuildWar() then
        gs.Message.Show(_TT(149195))
        return
    end

    self.guildInfo = guild.GuildManager:getGuildInfo()
    if #self.guildInfo.members > 1 then
        gs.Message.Show(_TT(94528))
    else
        UIFactory:alertMessge(_TT(94527), true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_LEAVE_GUILD)
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtNameTip"):GetComponent(ty.Text).text = _TT(48012)
    self:getChildGO("mTxtPostsTip"):GetComponent(ty.Text).text = _TT(94541)
    self:getChildGO("mTxtTimeTip"):GetComponent(ty.Text).text = _TT(94540)
    self:getChildGO("mTxtActiveTip"):GetComponent(ty.Text).text = _TT(94539)

end

function showPanel(self)
    self.guildInfo = guild.GuildManager:getGuildInfo()

    local list = self.guildInfo.members
    for i = 1, #list do
        list[i].tweenId = 2 + (i - 1) * 2.5
    end

    -- if (self.mLyScroller) then
    --     self.mLyScroller:CleanAllItem()
    -- end

    -- if (self.mLyScroller.Count <= 0) then
    self.mLyScroller.DataProvider = list
    -- else
    --    self.mLyScroller:ReplaceAllDataProvider(list)
    -- end
end

return _M
