-- @FileName:   ShootBrickPausePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.view.ShootBrickPausePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("shootBrick/ShootBrickPausePanel.prefab")

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
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.GroupTaskItem = self:getChildGO("GroupTaskItem")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)
    self.m_lastTimeScale = gs.Time.timeScale
    fight.FightManager:setupTimeScale(0)

    self.m_starCount = args.star_count
    self.m_dupConfigVo = args.dup_config
    self:updateStarInfo()

    GameDispatcher:dispatchEvent(EventName.SHOOTBRICK_UPDATE_PAUSESTATE, true)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnPlay, self.onPlay)
    self:addUIEvent(self.mBtnFinish, self.onFinish)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearStarItem()

    GameDispatcher:dispatchEvent(EventName.SHOOTBRICK_UPDATE_PAUSESTATE, false)
end

-- 更新星级
function updateStarInfo(self)
    local starCount = self.m_starCount

    local list = self.m_dupConfigVo.star_list
    self:clearStarItem()
    for i = 1, #list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "shootBrickPauseStarItem")
        local starConfig = shootBrick.ShootBrickManager:getStarConfigVo(list[i])

        local isMeet = starCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end
        item:getChildGO("mImgStar"):SetActive(isMeet)
        item:setText("mTextDesc", nil, string.format("<color=#%s>%s</color>", color, _TT(starConfig.des)))

        table.insert(self.mStarItemList, item)
    end
end

function onExit(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.CLOSE_SHOOTBRICK_SCENEUI)
end

function onFinish(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.ONREQ_SHOOTBRICK_PASS_DUP, {dup_id = self.m_dupConfigVo.id, star_count = self.m_starCount})
end

function onPlay(self)
    self:close()
end

function close(self)
    super.close(self)
    fight.FightManager:setupTimeScale(self.m_lastTimeScale or 1)
end

function clearStarItem(self)
    if self.mStarItemList then
        for k, v in pairs(self.mStarItemList) do
            v:poolRecover()
        end
    end
    self.mStarItemList = {}
end

return _M
