-- @FileName:   ShootBrickStagePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.view.ShootBrickStagePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("shootBrick/ShootBrickStagePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(138701))
    self:setUICode(LinkCode.ShootBrick)
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
    self.mScrollLyScroll:SetItemRender(shootBrick.ShootBrickStageItem)

    self.mStarTaskGroup = self:getChildTrans("mStarTaskGroup")
    self.mItemTask = self:getChildGO("mItemTask")

    self.mTextStarCount = self:getChildGO("mTextStarCount"):GetComponent(ty.Text)
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self.m_StageItems = {}

    local select_Index = 1
    local dupDic = shootBrick.ShootBrickManager:getDupConfigVoDic()
    local dupList = {}
    for dup_id, dupConfig in pairs(dupDic) do
        local isPass = shootBrick.ShootBrickManager:isPassDup(dup_id)
        local lock = false
        if not dupConfig:isOpen() then
            lock = true
        else
            if dupConfig.pre_id ~= 0 then
                lock = not shootBrick.ShootBrickManager:isPassDup(dupConfig.pre_id)
            end
        end
        table.insert(dupList, {config = dupConfig, pass = isPass, lock = lock})
    end

    table.sort(dupList, function (a, b)
        return a.config.id < b.config.id
    end)

    self.mScrollLyScroll.DataProvider = dupList
    local select_Index = 1
    for i = 1, #dupList do
        if not dupList[i].lock then
            if not dupList[i].pass then
                select_Index = i
                break
            end
        else
            select_Index = i - 1
            break
        end
    end

    GameDispatcher:dispatchEvent(EventName.SHOOTBRICK_STAGE_SELECT, dupList[select_Index].config.id)
    LoopManager:setFrameout(3, self, function ()
        self.mScrollLyScroll:ScrollToImmediately(select_Index - 2)
    end)

    self:updataRedState()
    self:refreshStarCount()

    StorageUtil:saveNumber1(gstor.SANDPLAY_SHOOTBRICK_OPENRED, GameManager:getClientTime())
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mImgTask, self.onTask)
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.SHOOTBRICK_STAGE_SELECT, self.onStageSelect, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)
    GameDispatcher:addEventListener(EventName.SHOOTBRICK_RECEIVE_REWARD, self.refreshStarCount, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.SHOOTBRICK_STAGE_SELECT, self.onStageSelect, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)
    GameDispatcher:removeEventListener(EventName.SHOOTBRICK_RECEIVE_REWARD, self.refreshStarCount, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()
end

function onCloseAllCall(self)
    super.onCloseAllCall(self)

    sandPlay.SandPlayManager:setLinkCode(LinkCode.ShootBrick)
end

function refreshStarCount(self)
    local passStarCount = shootBrick.ShootBrickManager:getPassAllStarCount()
    local maxStarCount = 0

    local rewardConfigDic = shootBrick.ShootBrickManager:getRewardConfigVoDic()
    for rewardId, rewardConfigVo in pairs(rewardConfigDic) do
        if maxStarCount < rewardConfigVo.star_num then
            maxStarCount = rewardConfigVo.star_num
        end
    end
    self.mTextStarCount.text = string.format("<size=26><color=#202226>%s</color></size>/%s", passStarCount, maxStarCount)
end

function updataRedState(self)
    self:getChildGO("ImEffect"):SetActive(shootBrick.ShootBrickManager:getStarRewardRedState())
end

function onFight(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_SCENEUI, self.m_selectDupConfigVo)
    -- self:close()
end

function onTask(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_REWARDVIEW)
end

function onStageSelect(self, dupId)
    self.m_selectDupConfigVo = shootBrick.ShootBrickManager:getDupConfigVo(dupId)

    self:createPropsGrid()
    self:createStar()

    self.mImgMapIcon:SetImg(self.m_selectDupConfigVo:getIconPath())

    shootBrick.ShootBrickManager:setSelectDup_id(dupId)
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
    local awardList = self.m_selectDupConfigVo:getAward()
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:createByData({tid = vo.tid, num = vo.num, parent = self.mAwardGroup, showUseInTip = true})
        propsGrid:setHasRec(shootBrick.ShootBrickManager:isPassDup(self.m_selectDupConfigVo.id))
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
    local passStar = shootBrick.ShootBrickManager:getPassStageStar(self.m_selectDupConfigVo.id)

    self:clearStar()
    local starList = self.m_selectDupConfigVo.star_list
    for i = 1, #starList do
        local item = SimpleInsItem:create(self.mItemTask, self.mStarTaskGroup, "ShootBrickStagePanel_starItem")
        table.insert(self.m_starList, item)

        local vo = shootBrick.ShootBrickManager:getStarConfigVo(starList[i])
        item:getChildGO("mImgStar_2"):SetActive(passStar >= i)
        item:getChildGO("mTextDesc"):GetComponent(ty.Text).text = vo:getDesc()
    end
end

return _M
