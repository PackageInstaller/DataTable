-- @FileName:   GuildBossDamageLogPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-07 20:09:42
-- @Copyright:   (LY) 2023 雷焰网络

module('guild.GuildBossDamageLogPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('guild/GuildBossDamageLogPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    self:setTxtTitle(_TT(94553))
end

-- 初始化数据
function initData(self)

    self.mCurPage = 1
    self.mMaxPage = 1
end

-- 初始化
function configUI(self)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mText_2 = self:getChildGO("mText_2"):GetComponent(ty.Text)
    self.mText_3 = self:getChildGO("mText_3"):GetComponent(ty.Text)
    self.mText_4 = self:getChildGO("mText_4"):GetComponent(ty.Text)

    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)

    self.mImgNo = self:getChildGO("mImgNo")
    self.mPageContent = self:getChildGO("mPageContent")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mScrollerContent = self:getChildTrans("mScrollerContent")
    self.mItem = self:getChildGO("Item")
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(566) --"暂无记录"

    self.mText_1.text = _TT(94575)
    self.mText_2.text = _TT(94577)
    self.mText_3.text = _TT(94578)
    self.mText_4.text = _TT(94579)

end

function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPretPage)
    self:addUIEvent(self.mNextBtn, self.onNextPage)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.dupId = args
    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSS_DAMAGELOG, self.udpateView, self)

    self:updatePageShow()
end

function udpateView(self)
    self.mLogData = guild.GuildManager:getGuildBossDamageLog(self.dupId)
    if table.empty(self.mLogData) then
        return
    end
    local logList = self.mLogData.logList[self.mCurPage]
    if table.empty(logList) then
        return
    end

    self.mMaxPage = self.mLogData.maxPage

    local isEmpty = table.empty(logList)
    self.mImgNo:SetActive(isEmpty)
    self.mPageContent:SetActive(not isEmpty)

    self:clearItem()
    for i = 1, #logList do
        local item = SimpleInsItem:create(self.mItem, self.mScrollerContent, "GuildBossDamageLogPanel_item")

        item:getChildGO("mTextName"):GetComponent(ty.Text).text = logList[i].player_name
        item:getChildGO("mTextStage"):GetComponent(ty.Text).text = logList[i].round
        item:getChildGO("mTextDamage"):GetComponent(ty.Text).text = logList[i].damage
        item:getChildGO("mTextTime"):GetComponent(ty.Text).text = TimeUtil.getFormatTimeBySeconds_7(logList[i].time)

        table.insert(self.mItemList, item)
    end
end

function clearItem(self)
    if not table.empty(self.mItemList) then
        for _, v in pairs(self.mItemList) do
            v:poolRecover()
        end
    end

    self.mItemList = {}
end

function onPretPage(self)
    if self.mCurPage <= 1 then return end
    self.mCurPage = self.mCurPage - 1

    self:updatePageShow()
end

function onNextPage(self)
    if self.mCurPage >= self.mMaxPage then return end
    self.mCurPage = self.mCurPage + 1

    self:updatePageShow()
end

--更新页码显示
function updatePageShow(self)
    self.mTxtNum.text = self.mCurPage

    self:checkLog()
    self:udpateView()
end

function checkLog(self)
    if table.empty(self.mLogData) or table.empty(self.mLogData.logList[self.mCurPage]) then
        local guildBossInfo = guild.GuildManager:getGuildBossAllInfo()
        if not guildBossInfo then
            return
        end

        GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSS_DAMAGELOG, {stage = guildBossInfo.round, dupId = self.dupId, page = self.mCurPage})
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSS_DAMAGELOG, self.udpateView, self)

    guild.GuildManager:clearGuildBossFightLog()
end

return _M
