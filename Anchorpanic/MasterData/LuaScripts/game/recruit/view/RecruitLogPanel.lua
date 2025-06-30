--[[   
     英雄招募日志界面
]]
module('recruit.RecruitLogPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('recruit/RecruitLogPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    self:setTxtTitle(_TT(575))--"<size=24>招</size>募记录"
end

-- 初始化数据
function initData(self)
    self.m_recruitId = nil

    self.mCurPage = 1
end

-- 初始化
function configUI(self)
    self.mTxtEmptyTip = self:getChildGO('mTxtEmptyTip'):GetComponent(ty.Text)
    self.mImgNo = self:getChildGO("mImgNo")
    self.m_scroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.m_scroller:SetItemRender(recruit.RecruitLogItem)

    self.mPageContent = self:getChildGO("mPageContent")
    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mTxt = self:getChildGO("mTxt"):GetComponent(ty.Text)

    self.mText_1 = self.m_childTrans['mText_1']:GetComponent(ty.Text)
    self.mText_2 = self.m_childTrans['mText_2']:GetComponent(ty.Text)
    self.mText_3 = self.m_childTrans['mText_3']:GetComponent(ty.Text)

end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_LOG, self.__onUpdateLogHandler, self)
    self.m_recruitId = args.recruitId

    self:requestLog()
    self:setData()
    self:updatePageShow()
    self:udpateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_LOG, self.__onUpdateLogHandler, self)
end

--更新页码显示
function updatePageShow(self)
    self.mTxtNum.text = self.mCurPage
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(566) --"暂无记录"

    self.mTxt.text = _TT(576) -- 可以查看最近200条招募记录

    self.mText_1.text = _TT(577)
    self.mText_2.text = _TT(578)
    self.mText_3.text = _TT(579)

end

function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPretPage)
    self:addUIEvent(self.mNextBtn, self.onNextPage)

end

function onPretPage(self)
    if self.mCurPage <= 1 then return end 
    self.mCurPage = self.mCurPage - 1

    self:updatePageShow()
    self:udpateView()
end

function onNextPage(self)
    if self.mCurPage >= self.mMaxPage then return end 
    self.mCurPage = self.mCurPage + 1

    self:updatePageShow()
    self:udpateView()
end

function __onUpdateLogHandler(self, args)
    local recruit_id = args.recruit_id
    if (recruit_id == self.m_recruitId) then
        self:setData()
        self:udpateView()
    end
end

function setData(self)
    self.mLogData = recruit.RecruitManager:getRecruitLogList(self.m_recruitId)
    self.mMaxPage = math.ceil(#self.mLogData / 10)
    local isEmpty = table.empty(self.mLogData)
    self.mImgNo:SetActive(isEmpty)
    self.mPageContent:SetActive(not isEmpty)
end

function udpateView(self)
    if table.empty(self.mLogData) then return end

    local maxIndex = self.mCurPage * 10
    maxIndex = maxIndex > #self.mLogData and #self.mLogData or maxIndex
    local minIndex = (self.mCurPage - 1) * 10 + 1
    local list = {}
    for i=minIndex,maxIndex do
        table.insert(list,self.mLogData[i])
    end
    self.m_scroller.DataProvider = list
end

function requestLog(self)
    if (self.m_recruitId) then
        GameDispatcher:dispatchEvent(EventName.REQ_RECRUIT_LOG, { recruit_id = self.m_recruitId })
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
