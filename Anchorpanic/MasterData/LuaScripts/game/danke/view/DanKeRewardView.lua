-- @FileName:   DanKeRewardView.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-02-01 11:08:40
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.view.DanKeRewardView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("danke/DanKeRewardView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 1 --窗口模式下是否需要添加mask (1 添加 0 不添加)

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.m_scroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.m_scroller:SetItemRender(danke.DanKeRewardItem)

    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mBtnAll = self:getChildGO("mBtnAll")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTextTitle.text = _TT(95004)
end

--激活
function active(self, map_id)
    super.active(self)
    GameDispatcher:addEventListener(EventName.DANKE_RECEIVE_REWARD, self.udpateView, self)

    self:udpateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.DANKE_RECEIVE_REWARD, self.udpateView, self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAll, self.onGetAll)
end

function udpateView(self)
    self.canGetList = {}

    local passStarCount = danke.DanKeManager:getPassAllStarCount()
    local rewardConfigDic = danke.DanKeManager:getRewardConfigVoDic()
    local reward = {}
    for rewardId, rewardConfigVo in pairs(rewardConfigDic) do
        local rewardState = danke.DanKeManager:getRewardState(rewardId)
        if rewardState == nil then
            if passStarCount >= rewardConfigVo.star_num then
                rewardState = 0

                table.insert(self.canGetList, rewardId)
            else
                rewardState = 1
            end
        end

        table.insert(reward, {config = rewardConfigVo, state = rewardState, star_count = passStarCount})
    end

    table.sort(reward, function (a, b)
        if a.state ~= b.state then
            return a.state < b.state
        else
            return a.config.id < b.config.id
        end
    end)

    for i = 1, #reward do
        reward[i].tweenId = 2 + (i - 1) * 4
    end

    self.m_scroller.DataProvider = reward

    self.mTxtAutoReceive.text = string.format("有%s个可领取的任务奖励", table.nums(self.canGetList))
    self.mBtnAll:SetActive(table.nums(self.canGetList) > 0)

    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.DanKe)
    local overTime = mainActivityVo:getOverTimeDt()
    local t = os.date('*t', overTime)
    self.mTxtTips.text = string.format("活动结束时间：%s月%s日%02d:%02d", t.month, t.day, t.hour, t.min)
end

--全部领取
function onGetAll(self)
    -- logAll("请求全部领取")
    GameDispatcher:dispatchEvent(EventName.DANKE_ONREQ_GETREWARD, self.canGetList)
end

return _M
