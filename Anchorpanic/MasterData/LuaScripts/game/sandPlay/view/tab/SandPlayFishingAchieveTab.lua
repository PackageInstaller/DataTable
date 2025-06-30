-- @FileName:   SandPlayFishingAchieveTab.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-21 10:35:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.sandPlay.view.SandPlayFishingAchieveTab", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("sandPlay/tab/SandPlayFishingAchieveTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(sandPlay.SandPlayFishAchieveItem)
end

function active(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_RECEIVE_ACHIEVE, self.refreshItem, self)

    self:refreshItem(true)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_RECEIVE_ACHIEVE, self.refreshItem, self)

    self:clearFrameSn()
    if (self.mLyScroller) then
        self.mLyScroller:CleanAllItem()
    end
end

function initViewText(self)

end

function addAllUIEvent(self)

end

function refreshItem(self, isInit)
    local taskDic = sandPlay.SandPlayManager:getFishTaskConfigVoDic()
    local data = {}

    for id, config in pairs(taskDic) do
        local achieveInfo = sandPlay.SandPlayManager:getFishingAchieveInfo(config.id)
        table.insert(data, {info = achieveInfo, config = config}) --getState  2 已领取 1 未完成 0领取
    end

    table.sort(data, function (a, b)
        if a.info.state == b.info.state then
            return a.config.id < b.config.id
        else
            return a.info.state < b.info.state
        end
    end)

    if isInit then
        self:clearFrameSn()

        self.mFrameSn = LoopManager:addFrame(3, 1, self, function()

            for i = 1, 4 do
                data[i].tweenId = 2 + (i - 1) * 4
            end
            if (self.mLyScroller.Count <= 0 or isInit) then
                self.mLyScroller.DataProvider = data
            else
                self.mLyScroller:ReplaceAllDataProvider(data)
            end
        end)
    else
        self.mLyScroller:ReplaceAllDataProvider(data)
    end
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

return _M
