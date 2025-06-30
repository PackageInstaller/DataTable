--[[
-----------------------------------------------------
@filename       : RecruitCardShowAllView
@Description    : 招募十连抽总览
@date           : 2021-03-23 16:32:36
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.RecruitCardShowAllView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/RecruitCardShowAllView.prefab")

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

    self.mGroupConvert = self:getChildGO("mGroupConvert")
    self.mImgConvert = self:getChildGO("mImgConvert")
    self.mConvertContent = self:getChildTrans("mConvertContent")

    self.mItemList = {}
    for i = 1, 10 do
        self.mItemList[i] = self:getChildGO("item_" .. i)
    end
end

--激活
function active(self, cardVoList)
    super.active(self)
    self.cardVoList = cardVoList

    self.isComplete = false

    AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_bracelets_show.prefab")
    self:updateView()
    self:updateConvertView()

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
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function onClickClose(self)
    if self.isCanClose then
        self:recoverItem()
        self:close(self)
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

    GameDispatcher:dispatchEvent(EventName.RECRUIT_FINISH)
end

function updateView(self)
    self:recoverItem()
    for i, v in ipairs(self.cardVoList) do
        local item = recruit.RecruitCardShowAllItem:poolGet()
        item:setData(self.mItemList[i], v)
        table.insert(self.mShowItemList, item)
    end
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

function updateConvertView(self)
    self:recoverAllGrid()
    self:recoverAllItemGrid()

    local curId = recruit.RecruitManager:getRecruitActionId()
    local recruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(curId)
    local propsList = {{tid = recruitConfigVo.rebate_item[1], num = recruitConfigVo.rebate_item[2] * #self.cardVoList}}

    local isEmpty = table.empty(propsList)
    self.mGroupConvert:SetActive(not isEmpty)
    if not isEmpty then
        for i = 1, #propsList do
            local item = SimpleInsItem:create(self.mImgConvert, self.mConvertContent, "RecruitCardShowAllViewrecruitShowOneItem")
            local propsGrid = PropsGrid:create(item:getChildTrans("mItemPoint"), propsList[i], 1)
            propsGrid:setClickEnable(false)
            table.insert(self.mPropsGridList, propsGrid)
            table.insert(self.mItemConvertList, item)
        end
    end
end

function recoverAllItemGrid(self)
    if (self.mItemConvertList) then
        for i = 1, #self.mItemConvertList do
            self.mItemConvertList[i]:poolRecover()
        end
    end
    self.mItemConvertList = {}
end

function recoverAllGrid(self)
    if (self.mPropsGridList) then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
