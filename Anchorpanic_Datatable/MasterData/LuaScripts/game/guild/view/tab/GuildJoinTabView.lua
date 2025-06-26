module("guild.GuildJoinTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildJoinTabView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 初始化数据
function initData(self)
    self.mReqList = {}
end

function configUI(self)
    super.configUI(self)

    self.mInputID = self:getChildGO("mInputID"):GetComponent(ty.InputField)
    self.mInputPlaceholder = self:getChildGO("mInputPlaceholder"):GetComponent(ty.Text)
    self.mBtnSearch = self:getChildGO("mBtnSearch")
    self.mBtnRefresh = self:getChildGO("mBtnRefresh")

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(guild.GuildSearchItem)

    self.mContent = self:getChildTrans("list")

    self.mTipContent = self:getChildGO("mTipContent")

    self.mGuildInfo = self:getChildGO("mGuildInfo")
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mTxtGuildID = self:getChildGO("mTxtGuildID"):GetComponent(ty.Text)
    self.mBtnCopy = self:getChildGO("mBtnCopy")
    self.mTxtGuildMasterName = self:getChildGO("mTxtGuildMasterName"):GetComponent(ty.Text)
    self.mTxtMemberCount = self:getChildGO("mTxtMemberCount"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mImgShowIcon = self:getChildGO("mImgShowIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtRequestInfo = self:getChildGO("mTxtRequestInfo"):GetComponent(ty.Text)
    self.mBtnJoin = self:getChildGO("mBtnJoin")
    self.mBtnJoined = self:getChildGO("mBtnJoined")

    self.mEmptyInfo = self:getChildGO("mEmptyInfo")
    self.mHideInfo = self:getChildGO("mHideInfo")

    self.mEmptyInfoHide = self:getChildGO("mEmptyInfoHide")

end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_JOIN_TAB_PANEL, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.ONCLICK_GUILD_SEARCHITEM, self.onClickGuildSearchItem, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_JOIN_ERROR_TAB_PANEL, self.errorDataClose, self)

    -- GameDispatcher:dispatchEvent(EventName.REQ_REFRESH_GUILDS,{uid = "0"})

    -- self.mGuildInfo:SetActive(false)
    self.list = guild.GuildManager:getGuilds()
    if self.list == nil or #self.list < 1 then
        local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_REFRESH_LIMIT_TIME) + 1
        local lastTime = guild.GuildManager:getLastClickRefreshTime()
        if lastTime == 0 or GameManager:getClientTime() - lastTime >= needTime then
            guild.GuildManager:setLastClickRefreshTime(GameManager:getClientTime())
            self.mReqList = {}
            self.mSelectData = nil
            GameDispatcher:dispatchEvent(EventName.REQ_REFRESH_GUILDS, {
                uid = "0",
                all = 1
            })
        end
        self:showPanel()
        -- self.mReqList = {}
        -- GameDispatcher:dispatchEvent(EventName.REQ_REFRESH_GUILDS, {
        --     uid = "0",
        --     all = 1
        -- })
    else
        self:showPanel()
    end
end

function errorDataClose(self, args)
    self.mSelectData = nil
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.ONCLICK_GUILD_SEARCHITEM, self.onClickGuildSearchItem, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_JOIN_TAB_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_JOIN_ERROR_TAB_PANEL, self.errorDataClose, self)
    if self.list~=nil then
        for i = 1, #self.list do
            self.list[i].isSelect = false
        end
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSearch, self.onBtnSearchClick)
    self:addUIEvent(self.mBtnRefresh, self.onBtnRefreshClick)
    self:addUIEvent(self.mBtnCopy, self.onBtnCopyClick)
    self:addUIEvent(self.mBtnJoin, self.onBtnJoinClick)
end

function onBtnSearchClick(self)
    if not self.mInputID.text or self.mInputID.text == "" then
        gs.Message.Show("请输入ID") -- 请输入名称
        return
    end

    local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_REFRESH_LIMIT_TIME) + 1
    local lastTime = guild.GuildManager:getLastClickRefreshTime()
    if lastTime == 0 or GameManager:getClientTime() - lastTime >= needTime then
        guild.GuildManager:setLastClickRefreshTime(GameManager:getClientTime())
        self.mReqList = {}
        self.mSelectData = nil
        GameDispatcher:dispatchEvent(EventName.REQ_REFRESH_GUILDS, {

            uid = self.mInputID.text,
            all = 0
        })
    else
        gs.Message.Show(_TT(62228, needTime - (GameManager:getClientTime() - lastTime)))
    end
end

function onBtnRefreshClick(self)
    local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_REFRESH_LIMIT_TIME) + 1
    local lastTime = guild.GuildManager:getLastClickRefreshTime()

    if lastTime == 0 or GameManager:getClientTime() - lastTime >= needTime then
        guild.GuildManager:setLastClickRefreshTime(GameManager:getClientTime())
        self.mInputID.text = ""
        self.mSelectData = nil
        self.mReqList = {}
        GameDispatcher:dispatchEvent(EventName.REQ_REFRESH_GUILDS, {
            uid = "0",
            all = 1
        })
    else
        gs.Message.Show(_TT(62228, needTime - (GameManager:getClientTime() - lastTime)))
    end
end

function onBtnCopyClick(self)
    gs.SdkManager:Copy(self.mSelectData.show_id)
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104)) -- "复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end

function onBtnJoinClick(self)
    -- if guild.GuildManager:getGuildBossIsOpen() then
    --     gs.Message.Show(_TT(94594))
    --     return
    -- end

    local leaveTime = guild.GuildManager:getLeaveTime()
    local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_LEAVE_TIME) * 60 * 60
    if GameManager:getClientTime() - leaveTime < needTime then
        local s = TimeUtil.getFormatTimeBySeconds_1(needTime - (GameManager:getClientTime() - leaveTime))
        gs.Message.Show(_TT(94562, s))
        return
    end

    UIFactory:alertMessge(_TT(94582), true, function()
        table.insert(self.mReqList, self.mSelectData.uid)

        GameDispatcher:dispatchEvent(EventName.REQ_APPLY_GUILD, {
            uid = self.mSelectData.uid
        })

    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mInputPlaceholder.text = _TT(94504)

    self:getChildGO("mTxtNameTip"):GetComponent(ty.Text).text = _TT(94505)
    self:getChildGO("mTxtLvTip"):GetComponent(ty.Text).text = _TT(94506)

    self:getChildGO("mTxtRequest"):GetComponent(ty.Text).text = _TT(94507)
    self:getChildGO("mTxtInfoDes"):GetComponent(ty.Text).text = _TT(94509)
    self:getChildGO("mTxtJoin"):GetComponent(ty.Text).text = _TT(94510)

end

function showPanel(self)
    self.list = guild.GuildManager:getGuilds()

    if (self.list ~= nil) then
        for i = 1, #self.list do
            if self.mSelectData and self.list[i].uid == self.mSelectData.uid then
                self.list[i].isSelect = true
            end
        end

        if self.mSelectData == nil and #self.list > 0 then
            self.list[1].isSelect = true
            self.mSelectData = self.list[1]
            gs.TransQuick:UIPosY(self.mContent, 0)
        end
    
        if (self.mLyScroller.Count <= 0) then
            self.mLyScroller.DataProvider = self.list
        else
            self.mLyScroller:ReplaceAllDataProvider(self.list)
        end
    
        self:onClickGuildSearchItem(self.mSelectData)
    end
end

function onClickGuildSearchItem(self, data)
    self.mSelectData = data
    for i = 1, #self.list do
        if data ~= nil and data.uid == self.list[i].uid then
            self.list[i].isSelect = true
        else
            self.list[i].isSelect = false
        end
    end
    self.mLyScroller:ReplaceAllDataProvider(self.list)

    self:updateGuildInfo()
end

function updateGuildInfo(self)
    -- self.mGuildInfo:SetActive(self.mSelectData ~= nil)
    self.mEmptyInfo:SetActive(#self.list == 0)
    self.mTipContent:SetActive(#self.list > 0)
    self.mHideInfo:SetActive(self.mSelectData ~= nil)
    self.mEmptyInfoHide:SetActive(self.mSelectData == nil)

    if self.mSelectData == nil then
        self.mTxtDes.text = "无"
        self.mTxtRequestInfo.text = "无"
        return
    end

    self.mTxtGuildName.text = self.mSelectData.name
    self.mTxtGuildID.text = _TT(25161) .. self.mSelectData.show_id
    self.mTxtGuildMasterName.text = self.mSelectData.leader_name
    self.mImgShowIcon:SetImg(UrlManager:getIconPath(guild.GuildManager:getIconDataById(self.mSelectData.icon).icon),false)

    self.localData = guild.GuildManager:getGuildData(self.mSelectData.lv)

    self.mTxtMemberCount.text = #self.mSelectData.members .. "/" .. self.localData.peopleNum
    if #self.mSelectData.members >= self.localData.peopleNum then
        self.mTxtMemberCount.color = gs.ColorUtil.GetColor("ffb644ff")
    else
        self.mTxtMemberCount.color = gs.ColorUtil.GetColor("ffffffff")
    end

    self.mTxtDes.text = self.mSelectData.notice
    self.mTxtRequestInfo.text = _TT(94508) .. self.mSelectData.apply_lv_cond

    self.mBtnJoin:SetActive(table.indexof01(self.mReqList, self.mSelectData.uid) == 0)
    self.mBtnJoined:SetActive(table.indexof01(self.mReqList, self.mSelectData.uid) > 0)
end

return _M
