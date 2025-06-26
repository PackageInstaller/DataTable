--[[ 
-----------------------------------------------------
@filename       : MiningDupPanel
@Description    : 挖矿关卡界面
@date           : 2023-12-07 10:46:03
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.MiningDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mining/MiningDupPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(95006))
    self:setBg("activity_main_bg_mining.png", false, "mainActivity")
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO("aa"):GetComponent(ty.Image)
    -- self.bb = self:getChildTrans("bb")
    self.mContent = self:getChildTrans("Content")

    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mBtnReward = self:getChildGO("mBtnReward")

    self.mTextStarCount = self:getChildGO("mTextStarCount"):GetComponent(ty.Text)
    self.ImEffect = self:getChildGO("ImEffect")
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})

    mining.MiningManager:addEventListener(mining.MiningManager.EVENT_STAR_AWARD_UPDATE, self.refreshAwardState, self)
    mining.MiningManager:addEventListener(mining.MiningManager.EVENT_TASK_UPDATE, self.updateTaskAward, self)

    self:updateView()
    self:refreshStarCount()
    self:refreshAwardState()
    self:updateTaskAward()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    mining.MiningManager:removeEventListener(mining.MiningManager.EVENT_STAR_AWARD_UPDATE, self.refreshAwardState, self)
    mining.MiningManager:removeEventListener(mining.MiningManager.EVENT_TASK_UPDATE, self.updateTaskAward, self)

    self:recoverItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReward, self.onClickReward)
    self:addUIEvent(self.mBtnRank, self.onClickRank)
    self:addUIEvent(self.mBtnTask, self.onClickTask)
end

function updateView(self)
    self:recoverItem()
    local list = mining.MiningManager:getDupList()
    local lastItem = nil
    for i, vo in ipairs(list) do
        local item = mining.MiningDupItem:poolGet()
        item:setData(self.mContent, vo, i)
        item:addEventListener(item.EVENT_CLICK_SELECT, self.onOpenDupInfoHandler, self)
        table.insert(self.mDupItemList, item)
        lastItem = item
    end
    if lastItem then
        lastItem:setLastItem()
    end
end

function recoverItem(self)
    if self.mDupItemList then
        for i, item in ipairs(self.mDupItemList) do
            item:removeEventListener(item.EVENT_CLICK_SELECT, self.onOpenDupInfoHandler, self)
            item:poolRecover()
        end
    end
    self.mDupItemList = {}
end

-- 选择副本变化
function onOpenDupInfoHandler(self, dupVo)
    for i, item in ipairs(self.mDupItemList) do
        item:setSelect(false)
        if item:getDupVo().id == dupVo.id then
            item:setSelect(true)
        end
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_DUP_INFO, dupVo)
end

function onClickReward(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_STAR_REWARD)
end

function onClickRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_RANK_PANEL)
end

function onClickTask(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_TASK_PANEL)
end

-- 刷新星数显示
function refreshStarCount(self)
    local maxStarCount = 0

    local currStarCount = 0
    local dupList = mining.MiningManager:getDupList()

    for _, dupVo in pairs(dupList) do
        maxStarCount = maxStarCount + #dupVo.starList
        currStarCount = currStarCount + mining.MiningManager:getPlayerDupStar(dupVo.id)
    end

    self.mTextStarCount.text = string.format("%s<size=20>/%s</size>", currStarCount, maxStarCount)
end

-- 星级奖励是否可领取
function refreshAwardState(self)
    local isHaveAward = mining.MiningManager:getStarHaveAward()
    self.ImEffect:SetActive(isHaveAward)
end

-- 更新任务红点
function updateTaskAward(self)
    local hasAward = mining.MiningManager:hasTaskAward()
    if hasAward then
        RedPointManager:add(self.mBtnTask.transform, UrlManager:getCommon5Path("common_0013.png"), 23.6, 23.4)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end

end

return _M