-- @FileName:   GuildBossFightLogPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-07 20:09:42
-- @Copyright:   (LY) 2023 雷焰网络
module('doundless.DoundlessLogPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('doundless/DoundlessLogPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    --self:setTxtTitle(_TT(94553))
end

-- 初始化数据
function initData(self)
    self.mCurPage = 1
    self.mMaxPage = 1

    self.mPlayerList = {}
end

-- 初始化
function configUI(self)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mText_2 = self:getChildGO("mText_2"):GetComponent(ty.Text)
    self.mText_3 = self:getChildGO("mText_3"):GetComponent(ty.Text)

    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)

    self.mImgNo = self:getChildGO("mImgNo")
    self.mPageContent = self:getChildGO("mPageContent")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mScrollerContent = self:getChildTrans("mScrollerContent")
    self.mItem = self:getChildGO("mItem")
    self.mItem:SetActive(false)
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(566) -- "暂无记录"

    self.mText_1.text = _TT(94575)
    self.mText_2.text = _TT(94505)
    self.mText_3.text = _TT(159)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPretPage)
    self:addUIEvent(self.mNextBtn, self.onNextPage)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.stageId = args

    local stageVo = doundless.DoundlessManager:getDoundlessCityStageDataById(self.stageId)
    self.cityId = doundless.DoundlessManager:getServerCityId()
    local name = doundless.getCityName(self.cityId)
    --self.mTxtCity.text = 

    self:setTxtTitle(name .. "-" .. stageVo.indexName)
    self:updatePageShow()
end

function udpateView(self)
    self.mLogData = doundless.DoundlessManager:getMaxDupPlayerList(self.stageId)

    self.mMaxPage = math.ceil(#self.mLogData / 5)

    local logList = {}
    for i = 1 + (self.mCurPage-1) * 5, self.mCurPage * 5 do
        if self.mLogData[i] then
            table.insert(logList, self.mLogData[i])
        end
    end

    local isEmpty = table.empty(logList)
    self.mImgNo:SetActive(isEmpty)
    self.mPageContent:SetActive(not isEmpty)

    self:clearPlayerList()
    self:clearItem()
    for i = 1, #logList do
        local item = SimpleInsItem:create(self.mItem, self.mScrollerContent, "DoundlessLogPanel_item")

        item:getChildGO("mTextName"):GetComponent(ty.Text).text = logList[i].player_name
        item:getChildGO("mTxtGuild"):GetComponent(ty.Text).text =
            logList[i].guild_name == "" and _TT(97053) or logList[i].guild_name
        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = logList[i].point
        local playTrans = item:getChildTrans("mHeadContent")
        local playerGrid = PlayerHeadGrid:create(playTrans, logList[i].avatar_id, 0.5, false)
        playerGrid:setHeadFrame(logList[i].avatar_frame_id)

        table.insert(self.mPlayerList, playerGrid)
        table.insert(self.mItemList, item)
    end
end

function clearPlayerList(self)
    for i = 1, #self.mPlayerList do
        self.mPlayerList[i]:poolRecover()
    end
    self.mPlayerList = {}
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
    if self.mCurPage <= 1 then
        return
    end
    self.mCurPage = self.mCurPage - 1

    self:updatePageShow()
end

function onNextPage(self)
    if self.mCurPage >= self.mMaxPage then
        return
    end
    self.mCurPage = self.mCurPage + 1

    self:updatePageShow()
end

-- 更新页码显示
function updatePageShow(self)
    self.mTxtNum.text = self.mCurPage
    self:udpateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:clearPlayerList()
    self:clearItem()
end

return _M
