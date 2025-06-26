--[[
-----------------------------------------------------
@filename       : RecruitShowAllView
@Description    : 招募十连抽总览
@date           : 2021-03-23 16:32:36
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.RecruitShowAllView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/RecruitShowAllView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0 --是否开启适配刘海
isScreensave = 0
isAddMask = 0

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
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mScrollContent = self:getChildTrans("Content")
    self.mBtnGroup = self:getChildGO("mBtnGroup")
    self.mBtn_Confirm = self:getChildGO("mBtn_Confirm")
    self.mBtn_OneTwo = self:getChildGO("mBtn_OneTwo")

    self.mItemList = {}
    for i = 1, 10 do
        self.mItemList[i] = self:getChildGO("mItem_" .. i)
    end

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

--激活
function active(self, heroVoList)
    super.active(self)

    self.heroVoList = recruit.RecruitManager:getRecruitHeroResultList()

    self.isComplete = false

    self:updateView()

    AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_show02.prefab")

    self.isCanClose = false
    self:setTimeout(1, function()
        self.isCanClose = true
    end)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtn_Confirm, 28040, "确认")
    self:setBtnLabel(self.mBtn_OneTwo, 28041, "再次链接")

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtn_Confirm, self.onConfirmRecruit)
    self:addUIEvent(self.mBtn_OneTwo, self.onOneTwoRecruit)
end

--确认链接
function onConfirmRecruit(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUITNEWPLAYRESULIT_PANEL)
end

--再次链接
function onOneTwoRecruit(self)
    UIFactory:alertMessge(_TT(28045), true, function()
        local recruit_id = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
        GameDispatcher:dispatchEvent(EventName.REQ_RECRUIT_HERO, {recruitId = recruit_id, times = 10})
        self:close()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.NEWPLAYRECRUITRESULT)
end

function onClickClose(self)
    if self.isCanClose then
        local curType = recruit.RecruitManager:getRecruitActionType()
        if curType == recruit.RecruitType.RECRUIT_NEW_PLAYER then return end

        self:recoverItem()
        self:close()

        GameDispatcher:dispatchEvent(EventName.RECRUIT_FINISH)
    end
end

function close(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = 0.3
        -- gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)

        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end

        if (self.base_childGos and self.base_childGos["GameAction"]) then
            local canvasGroup = self.base_childGos["GameAction"]:GetComponent(ty.CanvasGroup)
            if (self.m_groupTweener) then
                self.m_groupTweener:Kill()
                self.m_groupTweener = nil
            end
            local _groupTweenFinishCall = function()
                if self.isPop == 1 then
                    super.close(self)
                end
            end
            self.m_groupTweener = TweenFactory:canvasGroupAlphaTo(canvasGroup, 1, 0, tweenTime, nil, _groupTweenFinishCall)
            self.m_groupTweener:SetUpdate(true)

        elseif self.UIObject then
            local viewCanvasGroup = gs.GoUtil.AddComponent(self.UIObject, ty.CanvasGroup)
            if (self.m_viewTweener) then
                self.m_viewTweener:Kill()
                self.m_viewTweener = nil
            end
            local _viewTweenFinishCall = function()
                if self.isPop == 1 then
                    super.close(self)
                end
            end
            self.m_viewTweener = TweenFactory:canvasGroupAlphaTo(viewCanvasGroup, 1, 0, tweenTime, nil, _viewTweenFinishCall)
            self.m_viewTweener:SetUpdate(true)
        end
    else
        if self.isPop == 1 then
            super.close(self)
        end
    end
end

function updateView(self)
    self:recoverItem()
    for i, v in ipairs(self.heroVoList) do
        local item = recruit.RecruitShowAllItem:poolGet()
        item:setData(self.mItemList[i], v)

        table.insert(self.mShowItemList, item)
    end

    local curType = recruit.RecruitManager:getRecruitActionType()
    self.mBtnGroup:SetActive(curType == recruit.RecruitType.RECRUIT_NEW_PLAYER)
end

-- 回收项
function recoverItem(self)
    if self.mShowItemList then
        for i, v in pairs(self.mShowItemList) do
            v:removeEffect()
            v:poolRecover()
        end
    end
    self.mShowItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
