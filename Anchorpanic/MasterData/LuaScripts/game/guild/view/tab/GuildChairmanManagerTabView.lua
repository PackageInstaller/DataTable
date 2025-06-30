module("guild.GuildChairmanManagerTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildChairmanManagerTabView.prefab")

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
    self.mLyScroller:SetItemRender(guild.GuildChairmanManagerItem)
    -- mLyManagerItem
    self.mBtnQuit = self:getChildGO("mBtnQuit")

    -- self.mBtnCloseJob = self:getChildGO("mBtnCloseJob")
    -- self.mJobBtnsRT = self:getChildGO("mJobBtns"):GetComponent(ty.RectTransform)
    -- self.mBtnJob0 = self:getChildGO("mBtnJob0")
    -- self.mBtnJob2 = self:getChildGO("mBtnJob2")
    -- self.mBtnJob1 = self:getChildGO("mBtnJob1")

    -- self.mTxtJob0 = self:getChildGO("mTxtJob0"):GetComponent(ty.Text)
    -- self.mTxtJob1 = self:getChildGO("mTxtJob1"):GetComponent(ty.Text)
    -- self.mTxtJob2 = self:getChildGO("mTxtJob2"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MEMBER_PANEL,self.showPanel,self)
    -- GameDispatcher:addEventListener(EventName.OPEN_GUILD_JOB_TRANS_PANEL, self.onOpenJobTrans, self)

    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MEMBER_PANEL,self.showPanel,self)
    -- GameDispatcher:removeEventListener(EventName.OPEN_GUILD_JOB_TRANS_PANEL, self.onOpenJobTrans, self)
    if (self.mLyScroller) then
        self.mLyScroller:CleanAllItem()
    end
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnQuit, self.onBtnQuitClick)
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

    UIFactory:alertMessge(_TT(94527), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_LEAVE_GUILD)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)

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
    self.mLyScroller.DataProvider = list
end

return _M
