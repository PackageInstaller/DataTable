-- @FileName:   ThreeSheepSettlementPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.threeSheep.view.ThreeSheepSettlementPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("threeSheep/ThreeSheepSettlementPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
isAddMask = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:initData()
end
--析构
function dtor(self)
end

function initData(self)
    self.mStarItemList = {}
end

-- 初始化
function configUI(self)
    self.mGroupAward = self:getChildTrans("mGroupAward")

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mGroupStar = self:getChildTrans("mGroupStar")

    GameDispatcher:addEventListener(EventName.ONRECEIVE_THREESHEEP_DATA_REFRESH, self.updateView, self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnFight, self.onNextDup)
end

--激活
function active(self, args)
    super.active(self, args)
    self.m_DupId = args.dupId
    self.m_FirstPass = args.first
    self.m_args = args

    self.m_DupConfigVo = threeSheep.ThreeSheepManager:getDupConfig(self.m_DupId)

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.ONRECEIVE_THREESHEEP_DATA_REFRESH, self.updateView, self)
end

function onExit(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.THREESHEEP_CLOSE_SCENEUI)
    GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_STAGEMAINUI, {})
end

function onNextDup(self)
    self:close()

    if self.m_StarCount > 0 then
        local next_dupId = threeSheep.ThreeSheepManager:getNextDupId(self.m_DupId)
        local nextDupConfig = threeSheep.ThreeSheepManager:getDupConfig(next_dupId)
        GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_SCENEUI, nextDupConfig)
    else
        GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_SCENEUI, self.m_DupConfigVo)
    end
end

function updateView(self)
    self.m_StarCount = threeSheep.ThreeSheepManager:getDupPassStar(self.m_DupId)
    if self.m_args.star then
        self.m_StarCount = self.m_args.star
    end

    if self.m_StarCount > 0 then
        self:setBtnLabel(self.mBtnFight, 138608)
    else
        self:setBtnLabel(self.mBtnFight, 138609)
    end

    for i = 1, 3 do
        self:getChildGO("mImgStar_" .. i):SetActive(self.m_StarCount >= i)
    end

    local next_dupId = threeSheep.ThreeSheepManager:getNextDupId(self.m_DupId)
    if next_dupId then
        local next_configVo = threeSheep.ThreeSheepManager:getDupConfig(next_dupId)
        self.mBtnFight:SetActive(next_configVo:isOpen())
    else
        self.mBtnFight:SetActive(false)
    end

    self:updateStarInfo()
    self:updateAward()
end

function updateAward(self)
    self:clearItem()

    --是否首通
    if self.m_FirstPass then
        local awardList = AwardPackManager:getAwardListById(self.m_DupConfigVo.first_award)
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.mGroupAward})
            propsGrid:setHasRec(false)
            propsGrid:setIsFirstPass(true)
            table.insert(self.mPropsGridList, propsGrid)
        end
        self.mGroupAward.gameObject:SetActive(true)
    else
        self.mGroupAward.gameObject:SetActive(false)
    end
end

function clearItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

-- 更新星级
function updateStarInfo(self, args)
    self:recoverStarItem()

    local list = self.m_DupConfigVo.star_list
    for i = 1, #list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "ThreeSheepSettlementPanelStarItem")
        local starConfig = threeSheep.ThreeSheepManager:getStarConfigVo(list[i])

        local isMeet = self.m_StarCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end
        item:getChildGO("mImgStar"):SetActive(isMeet)
        item:setText("mTextDesc", nil, string.format("<color=#%s>%s</color>", color, _TT(starConfig.des)))

        table.insert(self.mStarItemList, item)
    end
end

function recoverStarItem(self)
    for k, v in pairs(self.mStarItemList) do
        v:poolRecover()
    end
    self.mStarItemList = {}
end

return _M
