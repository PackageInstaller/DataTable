-- @FileName:   FieldExplorationStarAwardView.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationStarAwardView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationStarAwardView.prefab")

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
    self.m_scroller:SetItemRender(fieldExploration.FieldExplorationStarAwardItem)

    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mBtnAll = self:getChildGO("mBtnAll")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
end

function initViewText(self)

end

--激活
function active(self, map_id)
    super.active(self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_REQGETSTARAWARD_UPDATA, self.udpateView, self)

    self.map_id = map_id
    self.mStarAwardConfig = fieldExploration.FieldExplorationManager:getStarAward(nil, map_id)
    self:udpateView()
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
    local mapConfigVo = fieldExploration.FieldExplorationManager:getMapConfigVO(nil, self.map_id)
    for _, dup_id in pairs(mapConfigVo.stage_list) do
        starCount = starCount + fieldExploration.FieldExplorationManager:getPlayerDupStar(dup_id)
    end

    self.canGetList = {}
    local data = {}
    for i = 1, #self.mStarAwardConfig do
        local isGet = fieldExploration.FieldExplorationManager:getStarAwardState(self.mStarAwardConfig[i].id)
        local isCanGet = false
        if starCount >= self.mStarAwardConfig[i].star_num and isGet == false then
            isCanGet = true
            table.insert(self.canGetList, self.mStarAwardConfig[i].id)
        end
        table.insert(data, {config = self.mStarAwardConfig[i], starCount = starCount, isGet = isGet, isCanGet = isCanGet})
    end

    table.sort(data, function (a, b)
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

    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    local overTime = mainActivityVo:getOverTimeDt()
    local t = os.date('*t', overTime)
    self.mTxtTips.text = string.format("活动结束时间：%s月%s日%02d:%02d", t.month, t.day, t.hour, t.min)
end

--全部领取
function onGetAll(self)
    -- logAll("请求全部领取")
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_REA_GETSTARAWARD, self.canGetList)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_REQGETSTARAWARD_UPDATA, self.udpateView, self)
end

return _M
