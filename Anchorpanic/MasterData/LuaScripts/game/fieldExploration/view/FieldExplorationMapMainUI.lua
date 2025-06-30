-- @FileName:   FieldExplorationMapMainUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationMapMainUI', Class.impl(View))

--对应的ui文件
UIRes = ""

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")

end
--析构
function dtor(self)
end

function initData(self)
    self.mCurStarCount = 0

end
-- 设置货币栏
function setMoneyBar(self)
end
-- 初始化
function configUI(self)
    self.mGruopMap = self:getChildTrans("mGruopMap")
    self.mItem = self:getChildGO("mItem")

    self.mBtnReward = self:getChildGO("mBtnReward")

    self.mTextStarCount = self:getChildGO("mTextStarCount"):GetComponent(ty.Text)
    self.ImEffect = self:getChildGO("ImEffect")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self, args)

    local map_id = args.map_id or 1
    self.mMapConfigVo = fieldExploration.FieldExplorationManager:getMapConfigVO(args.activity_id, map_id)

    self:addAllEventListener()

    local class = fieldExploration[string.format("FieldExplorationMapItem_%s_%s", self.mMapConfigVo.map_id, self.mMapConfigVo.activity_id)]
    self.mMapItem = class:poolGet()

    self.mMapItem:setData(self.mGruopMap, self.mItem, self.mMapConfigVo)

    self:refreshStarCount()
    self:refreshAwardState()
end

function addAllEventListener(self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_REQGETSTARAWARD_UPDATA, self.refreshAwardState, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_REQ_SCORE_UPDATE, self.refreshStarCount, self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReward, self.onOpenAward)
end

function onOpenAward(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONSTARAWARDVIEW, self.mMapConfigVo.map_id)
end

function refreshStarCount(self)
    local maxStarCount = 0

    self.mCurStarCount = 0

    for _, dup_id in pairs(self.mMapConfigVo.stage_list) do
        local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)
        maxStarCount = maxStarCount + #dupConfigVo.star_list

        self.mCurStarCount = self.mCurStarCount + fieldExploration.FieldExplorationManager:getPlayerDupStar(dup_id)
    end

    self.mTextStarCount.text = string.format("%s<size=20>/%s</size>", self.mCurStarCount, maxStarCount)
end

function refreshAwardState(self)
    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local isHaveAward = fieldExploration.FieldExplorationManager:getMapHaveAward(activity_id, self.mMapConfigVo.map_id)
    self.ImEffect:SetActive(isHaveAward)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:removeAllEventListener()

    GameDispatcher:dispatchEvent(EventName.CLOSE_FIELDEXPLORATIONDUPPANEL)

    self.mMapItem:poolRecover()
    self.mMapItem = nil
end

function removeAllEventListener(self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_REQGETSTARAWARD_UPDATA, self.refreshAwardState, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_REQ_SCORE_UPDATE, self.refreshStarCount, self)
end

return _M
