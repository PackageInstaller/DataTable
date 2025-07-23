-- @FileName:   DanKePausePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.view.DanKePausePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("danke/DanKePausePanel.prefab")

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
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnAgain = self:getChildGO("mBtnAgain")
    self.mTargetItem = self:getChildGO("mTargetItem")
    self.mTartgetGroup = self:getChildTrans("mTartgetGroup")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)
    self.m_lastTimeScale = gs.Time.timeScale
    fight.FightManager:setupTimeScale(0)

    self.m_starList = {}

    local curStageConfigVo = danke.DanKeManager:getCurStageVo()
    if curStageConfigVo then
        local dup_id = danke.DanKeManager:getStage_id()
        local kill_count = 0
        local playerThing = danke.DanKeSceneController:getPlayerThing()
        if playerThing then
            local attr = playerThing:getAttr()
            kill_count = attr.kill_num
        end

        local settlementStar_count = danke.DanKeManager:getStageStarByInfo(dup_id, kill_count, 0)

        local starList = curStageConfigVo:getStageStarConfigList()
        for i = 1, #starList do
            local item = SimpleInsItem:create(self.mTargetItem, self.mTartgetGroup, "DanKePausePanel_starItem")
            table.insert(self.m_starList, item)

            local vo = starList[i]
            item:setText("mTextDesc", nil, vo:getDesc())
            item:getChildGO("mImgStar"):SetActive(settlementStar_count >= i)
        end
    end

    GameDispatcher:dispatchEvent(EventName.DANKE_UPDATE_PAUSESTATE, true)
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
    GameDispatcher:dispatchEvent(EventName.DANKE_UPDATE_PAUSESTATE, false)

    if self.m_starList then
        for k, v in pairs(self.m_starList) do
            v:poolRecover()
        end
    end

    self.m_starList = {}
end

function onExit(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.MainActivity})
end

function onOver_Again(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.DANKE_GAME_AGIN)
end

function close(self)
    super.close(self)
    fight.FightManager:setupTimeScale(self.m_lastTimeScale or 1)
end

return _M
