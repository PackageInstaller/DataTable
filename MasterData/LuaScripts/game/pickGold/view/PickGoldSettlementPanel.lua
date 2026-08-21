-- @FileName:   PickGoldSettlementPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.pickGold.view.PickGoldSettlementPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("pickGold/PickGoldSettlementPanel.prefab")

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

    self.mTextCurScore = self:getChildGO("mTextCurScore"):GetComponent(ty.Text)
    self.mTextTargerScore = self:getChildGO("mTextTargerScore"):GetComponent(ty.Text)
    self.mFinish = self:getChildGO("mFinish")
    self.mNoFinish = self:getChildGO("mNoFinish")
    self.mTextFinish = self:getChildGO("mTextFinish"):GetComponent(ty.Text)
    self.mTextNoFinish = self:getChildGO("mTextNoFinish"):GetComponent(ty.Text)

    self.mTextCurScoreTitle = self:getChildGO("mTextCurScoreTitle"):GetComponent(ty.Text)
    self.mTextTargerScoreTitle = self:getChildGO("mTextTargerScoreTitle"):GetComponent(ty.Text)
    self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)
    GameDispatcher:addEventListener(EventName.PICKGOLD_RECEIVE_INFO, self.updateView, self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTextCurScoreTitle.text = _TT(151209)
    self.mTextTargerScoreTitle.text = _TT(151208)

    self.mTextFinish.text = _TT(151245)
    self.mTextNoFinish.text = _TT(98966)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnFight, self.onNextDup)
end

--激活
function active(self, args)
    super.active(self, args)
    self.m_DupId = args.dup_config.id
    self.m_DupConfigVo = args.dup_config
    self.m_FirstPass = args.first
    self.m_args = args

    GameDispatcher:dispatchEvent(EventName.PICKGOLD_UPDATE_PAUSESTATE, true)

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.PICKGOLD_RECEIVE_INFO, self.updateView, self)

    GameDispatcher:dispatchEvent(EventName.PICKGOLD_UPDATE_PAUSESTATE, false)
end

function onExit(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.CLOSE_PICKGOLD_SCENEUI)
    GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_STAGEPANEL, {})
end

function onNextDup(self)
    self:close()

    if self.m_args.score >= self.m_DupConfigVo.target_score then
        local next_configVo = pickGold.PickGoldManager:getNextDupConfig(self.m_DupId)
        GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_SCENEUI, next_configVo)
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_SCENEUI, self.m_DupConfigVo)
    end
end

function updateView(self)
    self.mTextCurScore.text = self.m_args.score
    self.mTextTargerScore.text = self.m_DupConfigVo.target_score

    if self.m_args.score >= self.m_DupConfigVo.target_score then
        self:setBtnLabel(self.mBtnFight, 138608)
        self.mFinish:SetActive(true)
        self.mNoFinish:SetActive(false)
        self.mTextTitle.text = _TT(151234)
    else
        self:setBtnLabel(self.mBtnFight, 138609)
        self.mFinish:SetActive(false)
        self.mNoFinish:SetActive(true)
        self.mTextTitle.text = _TT(151233)
    end

    local next_configVo = pickGold.PickGoldManager:getNextDupConfig(self.m_DupId)
    if next_configVo then
        self.mBtnFight:SetActive(next_configVo:isOpen())
    else
        self.mBtnFight:SetActive(false)
    end

    self:updateAward()
end

function updateAward(self)
    self:clearItem()

    --是否首通
    if self.m_FirstPass then
        local awardList = AwardPackManager:getAwardListById(self.m_DupConfigVo.first_award)
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.mGroupAward, scale = 0.7})
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

return _M
