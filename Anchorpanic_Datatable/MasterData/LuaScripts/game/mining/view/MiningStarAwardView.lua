--[[
-----------------------------------------------------
@filename       : MiningStarAwardView
@Description    : 捞宝藏小游戏星级奖励
@date           : 2023-12-13 17:08:32
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.MiningStarAwardView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mining/MiningStarAwardView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
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
    self.m_scroller:SetItemRender(mining.MiningStarAwardItem)

    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mBtnAll = self:getChildGO("mBtnAll")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
end

function initViewText(self)

end

--激活
function active(self, map_id)
    super.active(self)
    mining.MiningManager:addEventListener(mining.MiningManager.EVENT_STAR_AWARD_UPDATE, self.udpateView, self)

    self:udpateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    mining.MiningManager:removeEventListener(mining.MiningManager.EVENT_STAR_AWARD_UPDATE, self.udpateView, self)
end

function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAll, self.onGetAll)
end

function udpateView(self)
    local starCount = 0

    local dupList = mining.MiningManager:getDupList()
    for _, vo in pairs(dupList) do
        starCount = starCount + mining.MiningManager:getPlayerDupStar(vo.id)
    end

    local rewardList = mining.MiningManager:getRewardList()
    self.canGetList = {}
    local data = {}
    for i = 1, #rewardList do
        local isGet = mining.MiningManager:getStarAwardState(rewardList[i].id)
        local isCanGet = false
        if starCount >= rewardList[i].star_num and isGet == false then
            isCanGet = true
            table.insert(self.canGetList, rewardList[i].id)
        end
        table.insert(data, {config = rewardList[i], starCount = starCount, isGet = isGet, isCanGet = isCanGet})
    end

    table.sort(data, function(a, b)
        if a.isCanGet ~= b.isCanGet then
            if a.isCanGet then
                return true
            elseif b.isCanGet then
                return false
            end
        else
            if a.isGet ~= b.isGet then
                if not a.isGet and b.isGet then
                    return true
                elseif a.isGet and not b.isGet then
                    return false
                end
            end
        end

        return a.config.star_num < b.config.star_num
    end)

    self.m_scroller.DataProvider = data

    self.mTxtAutoReceive.text = string.format("有%s个可领取的任务奖励", table.nums(self.canGetList))
    self.mBtnAll:SetActive(table.nums(self.canGetList) > 0)

    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Mining)
    local overTime = mainActivityVo:getOverTimeDt()
    local t = os.date('*t', overTime)
    self.mTxtTips.text = string.format("活动结束时间：%s月%s日%02d:%02d", t.month, t.day, t.hour, t.min)
end

--全部领取
function onGetAll(self)
    -- logAll("请求全部领取")
    GameDispatcher:dispatchEvent(EventName.REQ_MINING_GAIN_STAR_REWARD, self.canGetList)
end

return _M
