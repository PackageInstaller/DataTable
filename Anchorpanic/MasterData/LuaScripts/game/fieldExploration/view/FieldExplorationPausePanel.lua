-- @FileName:   FieldExplorationPausePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationPausePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationPausePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
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
    self.mConditionItem = self:getChildGO("mConditionItem")
    self.mGroupCondition = self:getChildTrans("mGroupCondition")

    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnAgain = self:getChildGO("mBtnAgain")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)
    self.m_lastTimeScale = gs.Time.timeScale
    fight.FightManager:setupTimeScale(0)

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_UPDATE_PAUSESTATE, true)

    local dup_id = fieldExploration.FieldExplorationManager:getDupId()
    self.mDupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)

    local playerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
    if playerTing then
        local attr = playerTing:getAttr()
        local score = attr.score

        self.mConditionItemList = {}
        for i = 1, #self.mDupConfigVo.star_list do
            local conditionItem = SimpleInsItem:create(self.mConditionItem, self.mGroupCondition, "FieldExplorationPausePanel_ConditionItem")
            self.mConditionItemList[i] = conditionItem

            local starConfigVo = fieldExploration.FieldExplorationManager:getStarConfigVO(self.mDupConfigVo.star_list[i])

            local color = "82898C"
            if score >= starConfigVo.point then
                color = "FFFFFF"
            end

            conditionItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = string.format("<color=#%s>%s</color>", color, _TT(starConfigVo.des))
            conditionItem:getChildGO("mImgStar"):SetActive(score >= starConfigVo.point)
        end
    end
end

function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnAgain, self.onOver_Again)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_UPDATE_PAUSESTATE, false)

    if self.mConditionItemList then
        for k, v in pairs(self.mConditionItemList) do
            v:poolRecover()
        end
        self.mConditionItemList = nil
    end
end

function onExit(self)
    self:close()

    -- mainui.MainUIManager:setWaitOpenUIcode(LinkCode.MainActivityGameplayMap)
    -- GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.MainActivity})
end

function onOver_Again(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_AGIN)
end

function close(self)
    super.close(self)
    fight.FightManager:setupTimeScale(self.m_lastTimeScale or 1)
end

return _M
