--[[ 
-----------------------------------------------------
@filename       : CycleStoryPanel
@Description    : 事影循回剧情界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("cycle.CycleStoryPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleStoryPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗


-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(4550))
    self:setBg("cycle_bg_004.jpg", false, "cycle")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mStoryItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mStoryScroll = self:getChildGO("mStoryScroll"):GetComponent(ty.ScrollRect)
    self.mBtnAward = self:getChildGO("mBtnAward")
end

-- 激活
function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_RED,self.updateRed,self)
    MoneyManager:setMoneyTidList({})
    self:showPanel()

    self:updateRed()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_RED,self.updateRed,self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearStoryItems()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAward,self.mBtnAwardClick)
end

function mBtnAwardClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_STORY_AWARD_PANEL)
end

function showPanel(self)

    local storyData = cycle.CycleManager:getCycleStoryData()
    local storyList = {}
    for k, v in pairs(storyData) do
        table.insert(storyList,v)
    end

    self:clearStoryItems()
    for i = 1, #storyList do
        local item = cycle.CycleStoryItem:poolGet()
        storyList[i].index = i
        item:setData(self.mStoryScroll.content,storyList[i])
        table.insert(self.mStoryItemList,item)
    end
    

end

function clearStoryItems(self)
    for i = 1, #self.mStoryItemList do
        self.mStoryItemList[i]:poolRecover()
    end
    self.mStoryItemList = {}
end


function updateRed(self)
    if cycle.CycleManager:canGetStory() then
        RedPointManager:add(self.mBtnAward.transform, nil, -29.8, 31.3)
    else
        RedPointManager:remove(self.mBtnAward.transform)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
