-- @FileName:   SandPlayHappyFarmTaskPanel.lua
-- @Description:   开心农场订单任务界面
-- @Author: ZDH
-- @Date:   2024-01-17 11:40:13
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayHappyFarmTaskPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayHappyFarmTaskPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 519)
    self:setTxtTitle(_TT(137015))
end

-- 初始化数据
function initData(self)
    super.initData(self)

end

--初始化UI
function configUI(self)
    self.mTaskInfoItem = self:getChildGO("mTaskInfoItem")
    self.mTaskInfoContent = self:getChildTrans("mTaskInfoContent")

    self.mTextTaskName = self:getChildGO("mTextTaskName"):GetComponent(ty.Text)

    self.mTaskReward = self:getChildTrans("mTaskReward")

    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(sandPlay.SandPlayHappyFarmTaskItem)

    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mImgNo = self:getChildGO("mImgNo")
    self.mInfoGroup = self:getChildGO("mInfoGroup")
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(137046)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)
end

--激活
function active(self, args)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_TASKSELECT, self.onTaskSelect, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_TASK_REFRESH, self.refreshView, self)

    self:refreshView()
end

--非激活
function deActive(self)
    self:clearTaskInfoItem()
    self:clearPropsItem()

    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_TASKSELECT, self.onTaskSelect, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_TASK_REFRESH, self.refreshView, self)
end

function refreshView(self)
    local list = {}
    local taskConfigVoDic = sandPlay.SandPlayManager:getHappyFarmTaskConfigVoDic()

    for task_id, taskConfigVo in pairs(taskConfigVoDic) do
        if not sandPlay.SandPlayManager:isHappyFarmFinishTask(task_id) then
            table.insert(list, taskConfigVo)
        end
    end

    table.sort(list, function (a, b)
        return a.id < b.id
    end)

    if self.LyScroller.Count <= 0 then
        self.LyScroller.DataProvider = list
    else
        self.LyScroller:ReplaceAllDataProvider(list)
    end

    local isEmpty = table.empty(list)
    self.mImgNo:SetActive(isEmpty)
    self.mInfoGroup:SetActive(not isEmpty)

    if not isEmpty then
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_TASKSELECT, list[1])
    end
end

function onClickFinish(self)
    if not self.mCanFinish then
        gs.Message.Show(_TT(137029))
        return
    end
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_FINISHTASK, self.mSelectId)
end

function onTaskSelect(self, taskData)
    self.mSelectId = taskData.id

    local config = taskData
    self.mTextTaskName.text = config:getName()

    self.mCanFinish = true

    self:clearPropsItem()
    self:clearTaskInfoItem()
    for _, cost in pairs(config.cost) do
        local costTid, costCount = cost[1], cost[2]
        local propsConfigVo = props.PropsManager:getPropsConfigVo(costTid)
        if propsConfigVo then
            local taskInfoItem = SimpleInsItem:create(self.mTaskInfoItem, self.mTaskInfoContent, "sandPlay_HappyFarm_TaskInfoItem")
            table.insert(self.mTaskInfoItemList, taskInfoItem)

            taskInfoItem:getChildGO("mTextName"):GetComponent(ty.Text).text = propsConfigVo:getName()
            local bagCount = bag.BagManager:getPropsCountByTid(costTid, bag.BagType.HappyFarm)
            local color = bagCount >= costCount and "00a407" or "fa3a2b"
            taskInfoItem:getChildGO("mTextCount"):GetComponent(ty.Text).text = string.format("<color=#%s>%s/%s</color>", color, bagCount, costCount)

            local propsGrid = PropsGrid:create(taskInfoItem:getChildTrans("mProps"), {costTid, 0}, 1, false)
            table.insert(self.mPropsList, propsGrid)

            if bagCount < costCount then
                self.mCanFinish = false
            end
        else
            logError("farm_order_data.cost 道具不存在 item_data tid = " .. costTid)
        end
    end

    local awardList = AwardPackManager:getAwardListById(config.award)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mTaskReward, {vo.tid, (vo.num or vo.count)}, 1, false)
        table.insert(self.mPropsList, propsGrid)
    end
end

function clearTaskInfoItem(self)
    if self.mTaskInfoItemList then
        for _, taskInfoItem in pairs(self.mTaskInfoItemList) do
            taskInfoItem:poolRecover()
        end
    end

    self.mTaskInfoItemList = {}
end

function clearPropsItem(self)
    if self.mPropsList then
        for _, propsItem in pairs(self.mPropsList) do
            propsItem:poolRecover()
        end
    end

    self.mPropsList = {}
end

return _M
