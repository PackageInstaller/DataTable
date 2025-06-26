-- @FileName:   SandPlayFishingAwardTab.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-21 10:35:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.sandPlay.view.SandPlayFishingAwardTab", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("sandPlay/tab/SandPlayFishingAwardTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(sandPlay.SandPlayFishRewardItem)
end

function active(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_RECEIVE_INFO, self.refreshItem, self)

    self:refreshItem(true)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_RECEIVE_INFO, self.refreshItem, self)

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
    local rewardDic = sandPlay.SandPlayManager:getFishRewardConfigVoDic()
    local data = {}

    for id, config in pairs(rewardDic) do
        local getState = 0
        if sandPlay.SandPlayManager:getFishingAwardState(config.id) then
            getState = 2
        else
            for i = 1, #config.fish_list do
                local info = sandPlay.SandPlayManager:getFishingFishInfo(config.fish_list[i])
                if not info or info.count <= 0 then
                    getState = 1
                    break
                end
            end
        end
        table.insert(data, {config = config, getState = getState}) --getState  2 已领取 1 未完成 0 可领取
    end

    table.sort(data, function (a, b)
        if a.getState == b.getState then
            return a.config.id < b.config.id
        else
            return a.getState < b.getState
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
