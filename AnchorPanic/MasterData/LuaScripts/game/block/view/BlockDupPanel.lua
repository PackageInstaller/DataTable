-- @FileName:   BlockDupPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.block.view.BlockDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("block/BlockDupPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
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
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.item_Score = self:getChildGO("item_Score")
    self.listGroup = self:getChildTrans("listGroup")

    self.mTxtTitle_1 = self:getChildGO("mTxtTitle_1"):GetComponent(ty.Text)
    self.mTxtTitle_2 = self:getChildGO("mTxtTitle_2"):GetComponent(ty.Text)

    self.mTextTargetScore = self:getChildGO("mTextTargetScore"):GetComponent(ty.Text)
    self.mTextCurScore = self:getChildGO("mTextCurScore"):GetComponent(ty.Text)

    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

function initViewText(self)
    self.mTxtTitle_1.text = _TT(101015)
    self.mTxtTitle_2.text = _TT(71311)
end

--激活
function active(self, args)
    super.active(self)
    self:updateView(args, true)
end

function updateView(self, args, noShow)
    if not noShow then
        self.mAnimator:SetTrigger("show")
    end

    self.m_DupConfigVo = args

    self.mTxtTitle.text = self.m_DupConfigVo:getName()

    self.mTextTargetScore.text = _TT(151203) .. self.m_DupConfigVo.target_score
    self.mTextCurScore.text = _TT(151204) .. block.BlockManager:getPassStageScore(self.m_DupConfigVo.id)

    local isGet = block.BlockManager:isPassDup(self.m_DupConfigVo.id)

    self:clearPropsGrid()
    self.mPropsGridList = {}
    local awardList = AwardPackManager:getAwardListById(self.m_DupConfigVo.first_award)
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.mGorpLevelAward})
        propsGrid:setHasRec(isGet)
        propsGrid:setIsFirstPass(true)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function clearPropsGrid(self)
    if self.mPropsGridList then
        for k, v in pairs(self.mPropsGridList) do
            v:poolRecover()
        end
    end
    self.mPropsGridList = nil
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnFight, self.onFight)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearPropsGrid()
end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    self.mAnimator:SetTrigger("exit")
    local AniTime = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "LinklinkDupPanel_Exit")

    self:setTimeout(AniTime, function()
        self:close()
    end)
end

function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.ONCLOSE_BLOCK_DUPPANEL)
end

function onFight(self)
    local activity_id = activity.ActivityId.Block
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    if activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") --活动已结束
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_BLOCK_SCENEUI, self.m_DupConfigVo)
    self:close()
end

return _M
