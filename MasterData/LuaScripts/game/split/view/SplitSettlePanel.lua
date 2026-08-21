-- @FileName:   SplitSettlePanel.lua
-- @Description:   大西瓜结算界面
-- @Copyright:   (LY) 2023 雷焰网络
module('split.SplitSettlePanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("split/SplitSettlePanel.prefab")

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

    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)
    self.mIsTarget = self:getChildGO("mIsTarget")

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

    self.m_DupConfigVo = split.SplitManager:getDupConfig(self.m_DupId)
    self.mTxtCurrentScore.text = _TT(151209) .. self.m_socre
    self.mTxtTargetScore.text = _TT(151208) .. self.m_DupConfigVo.targetScore
    self.isPass = self.m_socre >= self.m_DupConfigVo.targetScore
    self.mIsTarget:SetActive(self.isPass)

    GameDispatcher:addEventListener(EventName.UPDATE_SPLIT_PASS_DUP, self.updateView, self)
    if self.isPass then
        GameDispatcher:dispatchEvent(EventName.REQ_SPLIT_PASS_DUP, {
            dupId = self.m_DupId,
            point = self.m_socre
        })
    end

    if self.m_socre < self.m_DupConfigVo.targetScore then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_common_1.prefab")
    else
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_mole_4.prefab")
    end

    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SPLIT_PASS_DUP, self.updateView, self)
    -- GameDispatcher:removeEventListener(EventName.ONRECEIVE_LINKLINK_DATA_REFRESH, self.updateView, self)

    -- GameDispatcher:dispatchEvent(EventName.LINKLINK_UPDATE_PAUSESTATE, false)
end

function onExit(self)
    self:close()
    -- GameDispatcher:dispatchEvent(EventName.LINKLINK_CLOSE_SCENEUI)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SPLIT_GAME_PANEL)
end

function onNextDup(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.CLOSE_SPLIT_GAME_PANEL)


        if self.isPass then
            local next_dupId = split.SplitManager:getNextDupId(self.m_DupId)
            local nextDupConfig = split.SplitManager:getDupConfig(next_dupId)
            GameDispatcher:dispatchEvent(EventName.OPEN_SPLIT_GAME_PANEL, {
                dupId = nextDupConfig.id
            })
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_SPLIT_GAME_PANEL, {
                dupId = self.m_DupConfigVo.id
            })
        end
  

   
end

function updateView(self)
    self.isPass = self.m_socre >= self.m_DupConfigVo.targetScore
    local next_dupId = split.SplitManager:getNextDupId(self.m_DupId)
    if next_dupId and self.isPass then
        local next_configVo = split.SplitManager:getDupConfig(next_dupId)
        self.mBtnFight:SetActive(next_configVo:isOpen())
    else
        self.mBtnFight:SetActive(false)
    end

    -- self:updateStarInfo()
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

return _M
