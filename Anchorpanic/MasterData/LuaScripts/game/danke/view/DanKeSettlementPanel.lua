-- @FileName:   DanKeSettlementPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.view.DanKeSettlementPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("danke/DanKeSettlementPanel.prefab")

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
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.props = self:getChildTrans("props")
    self.mImgFail = self:getChildGO("mImgFail")
    self.mImgWin = self:getChildGO("mImgWin")

    self.mTargetItem = self:getChildGO("mTargetItem")
    self.mTartgetGroup = self:getChildTrans("mTartgetGroup")

end

function initViewText(self)

end

--激活
function active(self, star_count)
    super.active(self)

    local isWin = star_count > 0
    self.mImgFail:SetActive(not isWin)
    self.mImgWin:SetActive(isWin)

    local curStageConfigVo = danke.DanKeManager:getCurStageVo()

    self:clearItem()
    if isWin then
        --如果没有星星证明是首次通关
        local firstPass = danke.DanKeManager:isPassStage(danke.DanKeManager:getStage_id())
        self.props.gameObject:SetActive(not firstPass)
        --是否首通
        if not firstPass then
            local awardList = curStageConfigVo:getAward()
            for i = 1, #awardList do
                local vo = awardList[i]
                local propsGrid = PropsGrid:createByData({tid = vo.tid, num = vo.num, parent = self.props, showUseInTip = true})
                table.insert(self.mPropsGridList, propsGrid)
            end
        end
    end
    
    self.m_starList = {}
    local starList = curStageConfigVo:getStageStarConfigList()
    for i = 1, #starList do
        local item = SimpleInsItem:create(self.mTargetItem, self.mTartgetGroup, "DanKePausePanel_starItem")
        table.insert(self.m_starList, item)

        local vo = starList[i]
        item:setText("mTextDesc", nil, vo:getDesc())
        item:getChildGO("mImgStar"):SetActive(star_count >= i)
    end

    GameDispatcher:dispatchEvent(EventName.DANKE_GAME_OVER)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnFight, self.onOver_Again)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItem()

     if self.m_starList then
        for k, v in pairs(self.m_starList) do
            v:poolRecover()
        end
    end

    self.m_starList = {}
end

function clearItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

function onExit(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.MainActivity})
end

function onOver_Again(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.DANKE_GAME_AGIN)
end

-- function close(self)
--     super.close(self)
--     fight.FightManager:setupTimeScale(self.m_lastTimeScale or 1)
-- end

return _M
