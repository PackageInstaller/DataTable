--[[ 
-----------------------------------------------------
@Description    : 联盟团战联盟纪录
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module('guildWar.GuildWarGuildLogPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarGuildLogPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(149150))
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mLogItemList = {}
end

-- 初始化
function configUI(self)
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mLogScroll = self:getChildGO("mLogScroll"):GetComponent(ty.ScrollRect)
    self.mLogScrollRect = self.mLogScroll.gameObject:GetComponent(ty.RectTransform)
    self.mLogItem = self:getChildGO("mLogItem")

    self.mLogNo = self:getChildGO("mLogNo")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mPageContent = self:getChildGO("mPageContent")
    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)

    self.mSelectType = self:getChildGO("mSelectType")
    self.mTypeList = {}
    self.mBtnType1 = self:getChildGO("mBtnType1")
    self.mBtnType2 = self:getChildGO("mBtnType2")
    table.insert(self.mTypeList, self.mBtnType1)
    table.insert(self.mTypeList, self.mBtnType2)

   
end

function initViewText(self)
    self.mTxtInfo.text = _TT(149151)
    self.mTxtEmptyTip.text = _TT(149152)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPreClick)
    self:addUIEvent(self.mNextBtn, self.onNextClick)
    self:addUIEvent(self.mBtnType1, self.onBtnType1Click)
    self:addUIEvent(self.mBtnType2, self.onBtnType2Click)
end

function onBtnType1Click(self)
    self:updateClickType(1)
end

function onBtnType2Click(self)
    self:updateClickType(2)
end

function updateClickType(self, index)
    self.defIndex = index
    for i = 1, #self.mTypeList do
        if i ~= index then
            self.mTypeList[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("2d3646FF")
            self.mTypeList[i].transform:Find("Text"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("ddddddFF")
        else
            self.mTypeList[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFFFFFF")
            self.mTypeList[i].transform:Find("Text"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("40484bFF")
        end
    end
    self.curPage = 1
    self:updatePageInfo()
end

function onPreClick(self)
    if self.curPage > 1 then
        self.curPage = self.curPage - 1
    else
        gs.Message.Show(_TT(149153))
        return
    end
    self:updatePageInfo()
end

function updatePageInfo(self)
    if self.defIndex == guildWar.GuildWarType.Normal then
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_GUILD_LOG, {
            page = {(self.curPage - 1) * 5 + 1, self.curPage * 5}
        })
    else
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_TOP_LOG, {
            page = {(self.curPage - 1) * 5 + 1, self.curPage * 5}
        })
    end
end

function onNextClick(self)
    if self.curPage * 5 < self.mLogCount then
        self.curPage = self.curPage + 1
    else
        gs.Message.Show(_TT(149154))
        return
    end
    self:updatePageInfo()
end

function active(self, args)
    super.active(self)
    self.curPage = 1
    self.defIndex = guildWar.GuildWarManager:getSeasonType()
    for i = 1, #self.mTypeList do
        self.mTypeList[i].transform:Find("Text"):GetComponent(ty.Text).text = i == guildWar.GuildWarType.Normal and _TT(149238) or _TT(149239)
    end
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_GUILD_LOG_PANEL, self.updateLogInfo, self)
    self:updateClickType(self.defIndex)
    --self:updatePageInfo()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearLogList()
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_GUILD_LOG_PANEL, self.updateLogInfo, self)
end

function updateLogInfo(self, args)
    self:clearLogList()

    self.mLogCount = args.logNum
    self.mLogList = args.logList
    self.mLogNo:SetActive(#self.mLogList == 0)

    self.mTxtNum.text = self.curPage

    self.mPageContent:SetActive(self.mLogCount > 5)

    gs.TransQuick:SizeDelta02(self.mLogScrollRect, self.mLogCount > 5 and 350 or 410)

    for i = 1, #self.mLogList do
        local item = SimpleInsItem:create(self.mLogItem, self.mLogScroll.content, "mGuildWarGuildLogItem")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = self.mLogList[i].self_name
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361) .. self.mLogList[i].self_lv
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = self.defIndex == guildWar.GuildWarType.Normal and
            _TT(149158, self.mLogList[i].old_point, self.mLogList[i].add_point) or _TT(149155).. self.mLogList[i].self_day_point


        item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(
            guild.GuildManager:getIconDataById(self.mLogList[i].self_icon).icon), false)

        item:getChildGO("mTxtName2"):GetComponent(ty.Text).text = self.mLogList[i].enemy_name
        item:getChildGO("mTxtLv2"):GetComponent(ty.Text).text = _TT(1361) .. self.mLogList[i].enemy_lv
        item:getChildGO("mIcon2"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(
            guild.GuildManager:getIconDataById(self.mLogList[i].enemy_icon).icon), false)

        item:getChildGO("mTxtPoint2"):GetComponent(ty.Text).text = self.defIndex == guildWar.GuildWarType.Normal and
            "" or _TT(149155).. self.mLogList[i].enemy_day_point
        item:getChildGO("mTxtPoint2"):SetActive(self.defIndex == guildWar.GuildWarType.Top)
        local text = item:getChildGO("mTxtResult"):GetComponent(ty.Text)

        if self.mLogList[i].result == 1 then
            text.text = _TT(149115)
        elseif self.mLogList[i].result == 2 then
            text.text = _TT(149116)
        else
            text.text = _TT(149117)
        end

        item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text =
            TimeUtil.getFormatTimeBySeconds_12(self.mLogList[i].time)

        table.insert(self.mLogItemList, item)
    end

end

function clearLogList(self)
    for i = 1, #self.mLogItemList, 1 do
        self.mLogItemList[i]:poolRecover()
    end
    self.mLogItemList = {}
end

return _M
