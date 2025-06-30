-- @FileName:   FieldExplorationSettlementPanel_3.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationSettlementPanel_3', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationSettlementPanel_3.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)

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
    self.mBtnNextFight = self:getChildGO("mBtnNextFight")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.props = self:getChildTrans("props")
    self.mDescItem = self:getChildGO("mDescItem")
    self.descLayer = self:getChildTrans("descLayer")
    self.mImgWin = self:getChildGO("mImgWin")

end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    local starCount = fieldExploration.FieldExplorationManager:getPlayerDupStar(args.dup_id, args.newRecord)
    self.mImgWin:SetActive(true)

    local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(args.dup_id)

    self:clearItem()
    --是否首通
    if args.oldRecord == 0 and args.newRecord > 0 then
        local awardList = AwardPackManager:getAwardListById(dupConfigVo.first_award)

        self.mPropsGridList = {}
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.props})
            propsGrid:setHasRec(false)
            propsGrid:setIsFirstPass(true)
            table.insert(self.mPropsGridList, propsGrid)
        end
        self.props.gameObject:SetActive(true)
    else
        self.props.gameObject:SetActive(false)
    end

    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local map_id = fieldExploration.FieldExplorationManager:getMap_id()
    local mapConfigVo = fieldExploration.FieldExplorationManager:getMapConfigVO(activity_id, map_id)
    local maxDup = #mapConfigVo.stage_list
    for i = 1, maxDup do
        if args.dup_id == mapConfigVo.stage_list[i] and i < maxDup then
            self.m_NextDupId = mapConfigVo.stage_list[i + 1]
        end
    end
    if self.m_NextDupId ~= nil then
        local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(self.m_NextDupId)

        local isOpen = true
        if not table.empty(dupConfigVo.begin_time) then
            local openDt = os.time(dupConfigVo.begin_time)
            isOpen = GameManager:getClientTime() > openDt
        end

        self.mBtnNextFight:SetActive(isOpen)
    else
        self.mBtnNextFight:SetActive(false)
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnNextFight, self.onNextFight)
end

function clearItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItem()
end

function onExit(self)
    self:close()

    -- mainui.MainUIManager:setWaitOpenUIcode(LinkCode.MainActivityGameplayMap)
    -- GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.MainActivity})
end

function onNextFight(self)
    if self.m_NextDupId == nil then
        return
    end

    self:close()

    map.MapLoader:setIsForceLoad(true)
    fieldExploration.FieldExplorationManager:setDupId(self.m_NextDupId)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.FIELD_EXPLORATION)
end

return _M
