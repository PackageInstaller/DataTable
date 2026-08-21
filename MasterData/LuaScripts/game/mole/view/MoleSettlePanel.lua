-- @FileName:   LinklinkSettlementPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络
module('mole.MoleSettlePanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mole/MoleSettlePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 0 -- 窗口模式下是否需要添加mask (1 添加 0 不添加)

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
isAddMask = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:initData()
end
-- 析构
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

    --
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

-- 激活
function active(self, args)
    super.active(self, args)
    self.m_DupId = args.dupId
    self.m_FirstPass = args.first
    self.m_socre = args.score

    self.m_DupConfigVo = mole.MoleManager:getDupConfig(self.m_DupId)

    GameDispatcher:addEventListener(EventName.UPDATE_MOLE_PASS_DUP, self.updateView, self)

    self.mStar = 0
    for i = 1, #self.m_DupConfigVo.starList do
        local starVo = mole.MoleManager:getStarDataById(self.m_DupConfigVo.starList[i])
        if self.m_socre >= starVo.point then
            self.mStar = self.mStar + 1
        end
    end
    self.m_StarCount = mole.MoleManager:getDupPassStar(self.m_DupId)

    if self.mStar > self.m_StarCount then
        GameDispatcher:dispatchEvent(EventName.REQ_MOLE_PASS_DUP, {
            dupId = self.m_DupId,
            star = self.mStar
        })
    end

    if self.mStar == 0 then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_common_1.prefab")
    else
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_mole_4.prefab")
    end
 
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MOLE_PASS_DUP, self.updateView, self)
    -- GameDispatcher:removeEventListener(EventName.ONRECEIVE_LINKLINK_DATA_REFRESH, self.updateView, self)

    -- GameDispatcher:dispatchEvent(EventName.LINKLINK_UPDATE_PAUSESTATE, false)
end

function onExit(self)
    self:close()
    -- GameDispatcher:dispatchEvent(EventName.LINKLINK_CLOSE_SCENEUI)
    GameDispatcher:dispatchEvent(EventName.CLOSE_MOLE_GAME_PANEL)
end

function onNextDup(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.CLOSE_MOLE_GAME_PANEL)
    if self.m_StarCount > 0 then
        local next_dupId = mole.MoleManager:getNextDupId(self.m_DupId)
        local nextDupConfig = mole.MoleManager:getDupConfig(next_dupId)
        GameDispatcher:dispatchEvent(EventName.OPEN_MOLE_GAME_PANEL, {
            dupId = nextDupConfig.id
        })
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_MOLE_GAME_PANEL, {
            dupId = self.m_DupConfigVo.id
        })
    end
end

function updateView(self)
    self.m_StarCount = mole.MoleManager:getDupPassStar(self.m_DupId)
    if self.mStar then
        self.m_StarCount = self.mStar
    end

    if self.m_StarCount > 0 then
        self:setBtnLabel(self.mBtnFight, 138608)
    else
        self:setBtnLabel(self.mBtnFight, 138609)
    end

    for i = 1, 3 do
        self:getChildGO("mImgStar_" .. i):SetActive(self.m_StarCount >= i)
    end

    local next_dupId = mole.MoleManager:getNextDupId(self.m_DupId)
    if next_dupId then
        local next_configVo = mole.MoleManager:getDupConfig(next_dupId)
        self.mBtnFight:SetActive(next_configVo:isOpen())
    else
        self.mBtnFight:SetActive(false)
    end

    self:updateStarInfo()
    self:updateAward()
end

function updateAward(self)
    self:clearItem()

    -- 是否首通
    if self.m_FirstPass then
        local awardList = AwardPackManager:getAwardListById(self.m_DupConfigVo.firstAward)
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({
                tid = awardList[i].tid,
                num = awardList[i].num,
                parent = self.mGroupAward
            })
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

    local list = self.m_DupConfigVo.starList
    for i = 1, #list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar,
            "MoleSettlementPanelStarItem")

        local isMeet = self.m_StarCount >= i
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end
        item:getChildGO("mImgStar"):SetActive(isMeet)
        local starVo = mole.MoleManager:getStarDataById(list[i])
        local param = list[i]
        item:setText("mTextDesc", nil, _TT(starVo.des))

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
