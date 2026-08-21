-- @FileName:   FieldExplorationMainUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationMainUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationMainUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(92001))

end
--析构
function dtor(self)
end

function initData(self)

end
-- 设置货币栏
function setMoneyBar(self)
end
-- 初始化
function configUI(self)
    self.mText_Time = self:getChildGO("mText_Time"):GetComponent(ty.Text)
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.refreshMapItem, self)

    self.mMapItems = {}

    local mapConfig = fieldExploration.FieldExplorationManager:getMapConfigDic()
    for i = 1, 3 do
        local mapItem = SimpleInsItem:create2(self:getChildGO("mItem_" .. i))
        mapItem.mapConfigVo = mapConfig[i]
        -- mapItem:getChildGO("mImgMask"):GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
        mapItem:getChildGO("mBtn"):GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5

        mapItem:addUIEvent("mBtn", function (_mapItem)
            GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONMAPMAINUI, {activity_id = _mapItem.mapConfigVo.activity_id, map_id = _mapItem.mapConfigVo.map_id})
        end)

        mapItem:addUIEvent("mInfo", function (_mapItem)
            GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONMAPMAINUI, {activity_id = _mapItem.mapConfigVo.activity_id, map_id = _mapItem.mapConfigVo.map_id})
        end)

        self.mMapItems[i] = mapItem
    end

    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    local overTime = mainActivityVo:getOverTimeDt()
    local sTime = overTime - GameManager:getClientTime()
    if sTime > 0 then
        local days = math.floor(sTime / 86400)
        local hours = math.floor((sTime % 86400) / 3600)

        self.mText_Time.text = string.format("%02d天%02d时", days, hours)
    else
        self.mText_Time.text = "--天--时"
    end

    self:refreshMapItem()
end

function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.refreshMapItem, self)
end

function refreshMapItem(self)
    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    for i = 1, 3 do
        local item = self.mMapItems[i]

        local configVo = item.mapConfigVo

        local isLock = false
        if not table.empty(configVo.begin_time) then
            local openDt = os.time(configVo.begin_time)
            isLock = GameManager:getClientTime() < openDt
        end

        if isLock then
            item:setText("mTextOpenTime", nil, string.format("%s/%s %s:%02d开放", configVo.begin_time.month, configVo.begin_time.day, configVo.begin_time.hour, configVo.begin_time.min))
        end

        item:getChildGO("mImgMask"):SetActive(isLock)
        item:getChildGO("mInfo"):SetActive(not isLock)
        item:getChildGO("mTextName"):GetComponent(ty.Text).text = _TT(configVo.name)

        local isFlag, redType = fieldExploration.FieldExplorationManager:getIsMapShowRed(activity_id, i)
        if redType == 1 then
            item:getChildGO("mRedImg"):SetActive(true)
            RedPointManager:remove(item:getTrans())
        elseif redType == 2 then
            item:getChildGO("mRedImg"):SetActive(false)
            RedPointManager:add(item:getTrans(), nil, 100, 50)
        else
            item:getChildGO("mRedImg"):SetActive(false)
            RedPointManager:remove(item:getTrans())
        end

        local count = 0
        for _, dup_id in pairs(configVo.stage_list) do
            if fieldExploration.FieldExplorationManager:getPlayerDupRecord(dup_id) > 0 then
                count = count + 1
            end
        end

        local rate = count / table.nums(configVo.stage_list)
        item:getChildGO("mTextRate"):GetComponent(ty.Text).text = string.format("%s%%", math.ceil(rate * 100))

    end
end

return _M
