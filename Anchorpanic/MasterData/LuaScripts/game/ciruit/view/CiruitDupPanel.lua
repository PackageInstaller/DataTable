-- @FileName:   CiruitDupPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.view.CiruitDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("ciruit/CiruitDupPanel.prefab")

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

    self.mTxtTitle_1 = self:getChildGO("mTxtTitle_1"):GetComponent(ty.Text)
    self.mTxtTitle_2 = self:getChildGO("mTxtTitle_2"):GetComponent(ty.Text)
    self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)

    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mTextFight = self:getChildGO("mTextFight"):GetComponent(ty.Text)

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

function initViewText(self)
    self.mTxtTitle_1.text = _TT(130003)
    self.mTxtTitle_2.text = _TT(130004)
    self.mTextFight.text = _TT(27)
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

    self.mDupConfigVo = args

    self.mTxtTitle.text = self.mDupConfigVo:getName()
    self.mTextDesc.text = self.mDupConfigVo:getDesc()

    self:clearItem()
    self.mPropsGridList = {}
    local isGet = ciruit.CiruitManager:getDupPassState(self.mDupConfigVo.tid)
    local awardList = AwardPackManager:getAwardListById(self.mDupConfigVo.first_award)
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.mGorpLevelAward})
        propsGrid:setHasRec(isGet)
        propsGrid:setIsFirstPass(true)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnFight, self.onFight)

end

function clearItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearItem()
end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    local AniTime = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "CiruitDupPanel_Exit")
    self.mAnimator:SetTrigger("exit")
    self:setTimeout(AniTime, function()
        self:close()
    end)
end

function close(self)
    super.close(self)
    GameDispatcher:dispatchEvent(EventName.CIRUIT_CLOSEDUPINFOPANEL_HANDLER)
end

function onFight(self)
    GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSCENEUI, self.mDupConfigVo)

    self:close()
end

return _M
