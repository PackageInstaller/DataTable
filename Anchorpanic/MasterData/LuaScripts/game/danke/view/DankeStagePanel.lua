-- @FileName:   DankeStagePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.view.DankeStagePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("danke/DankeStagePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(95055))

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
    self.mDupItem = self:getChildGO("mDupItem")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mImgTask = self:getChildGO("mImgTask")

    self.mAwardGroup = self:getChildTrans("mAwardGroup")
    self.mImgMapIcon = self:getChildGO("mImgMapIcon"):GetComponent(ty.AutoRefImage)

    self.mScrollLyScroll = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScrollLyScroll:SetItemRender(danke.DanKeStageItem)

    self.mStarTaskGroup = self:getChildTrans("mStarTaskGroup")
    self.mItemTask = self:getChildGO("mItemTask")

    self.mTextStarCount = self:getChildGO("mTextStarCount"):GetComponent(ty.Text)

    self.ImEffect = self:getChildGO("ImEffect")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self.m_StageItems = {}

    local select_Index = 1
    local stageDic = danke.DanKeManager:getStageConfigVoDic()
    local stageList = {}
    for stageId, stageConfig in pairs(stageDic) do
        local isPass = danke.DanKeManager:isPassStage(stageId)
        local lock = not stageConfig:isOpen()
        if not lock then
            if stageConfig.pre_id ~= 0 then
                lock = not danke.DanKeManager:isPassStage(stageConfig.pre_id)
            end
        end
        table.insert(stageList, {config = stageConfig, pass = isPass, lock = lock})
    end

    table.sort(stageList, function (a, b)
        return a.config.id < b.config.id
    end)

    self.mScrollLyScroll.DataProvider = stageList
    local select_Index = 1
    for i = 1, #stageList do
        if not stageList[i].lock then
            if not stageList[i].pass then
                select_Index = i
                break
            end
        else
            select_Index = i - 1
            break
        end
    end
    GameDispatcher:dispatchEvent(EventName.DANKE_STAGE_SELECT, stageList[select_Index].config.id)

    self:updataRedState()
    self:refreshStarCount()

    StorageUtil:saveNumber1(gstor.SANDPLAY_DANKE_OPENRED, GameManager:getClientTime())
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mImgTask, self.onTask)
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.DANKE_STAGE_SELECT, self.onStageSelect, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)
    GameDispatcher:addEventListener(EventName.DANKE_RECEIVE_REWARD, self.refreshStarCount, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.DANKE_STAGE_SELECT, self.onStageSelect, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)
    GameDispatcher:removeEventListener(EventName.DANKE_RECEIVE_REWARD, self.refreshStarCount, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()
end

function onCloseAllCall(self)
    super.onCloseAllCall(self)

    sandPlay.SandPlayManager:setLinkCode(LinkCode.DanKe)
end

function refreshStarCount(self)
    local passStarCount = danke.DanKeManager:getPassAllStarCount()
    local starCount = 0

    local rewardConfigDic = danke.DanKeManager:getRewardConfigVoDic()
    for rewardId, rewardConfigVo in pairs(rewardConfigDic) do
        starCount = rewardConfigVo.star_num

        local rewardState = danke.DanKeManager:getRewardState(rewardId)
        if rewardState == nil then
            starCount = rewardConfigVo.star_num
            break
        end
    end
    self.mTextStarCount.text = string.format("<size=26><color=#202226>%s</color></size>/%s", passStarCount, starCount)
end

function updataRedState(self)
    self.ImEffect:SetActive(danke.DanKeManager:getDankeStarRewardState())
end

function onFight(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.DANKE)
end

function onTask(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DANKE_REWARDVIEW)
end

function onStageSelect(self, stage_id)
    self.m_curSelectStageId = stage_id
    self.m_curSelectStageConfigVo = danke.DanKeManager:getStageConfigVo(stage_id)

    danke.DanKeManager:setStage_id(self.m_curSelectStageId)

    self:createPropsGrid()
    self:createStar()

    self.mImgMapIcon:SetImg(self.m_curSelectStageConfigVo:getIcon())
end

function clearItem(self)
    if self.m_propList then
        for k, v in pairs(self.m_propList) do
            v:poolRecover()
        end
    end

    self.m_propList = {}
end

function createPropsGrid(self)
    self:clearItem()
    local awardList = self.m_curSelectStageConfigVo:getAward()
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:createByData({tid = vo.tid, num = vo.num, parent = self.mAwardGroup, showUseInTip = true})
        propsGrid:setHasRec(danke.DanKeManager:isPassStage(self.m_curSelectStageId))
        table.insert(self.m_propList, propsGrid)
    end
end

function clearStar(self)
    if self.m_starList then
        for k, v in pairs(self.m_starList) do
            v:poolRecover()
        end
    end

    self.m_starList = {}
end

function createStar(self)
    local passStar = danke.DanKeManager:getPassStageMaxStar(self.m_curSelectStageConfigVo.id)

    self:clearStar()
    local starList = self.m_curSelectStageConfigVo:getStageStarConfigList()
    for i = 1, #starList do
        local item = SimpleInsItem:create(self.mItemTask, self.mStarTaskGroup, "DanKeStagePanel_starItem")
        table.insert(self.m_starList, item)

        local vo = starList[i]
        item:getChildGO("mImgStar_2"):SetActive(passStar >= i)
        item:getChildGO("mTextDesc"):GetComponent(ty.Text).text = vo:getDesc()
    end
end

return _M
