
--[[
-----------------------------------------------------
@filename       : AlertStoryMessgeView
@Description    : 低层级弹窗信息提示 剧情
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
--
module('game.common.logic_ui.AlertStoryMessgeView', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/AlertMessgeStoryView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isAddMask = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 530)
    self:setTxtTitle('')
end
-- 析构
function dtor(self)
end

function initData(self)
    self.mIsNotRemind = false
end

-- 初始化
function configUI(self)
    self.mGroupOp = self:getChildGO("mGroupOp")
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.TMP_Text)
    self.mTxtContentElement = self:getChildGO("mTxtContent"):GetComponent(ty.LayoutElement)
    self.mTxtContentTrans = self:getChildTrans("mTxtContent")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    self.mTxtNotRemind = self:getChildGO("mTxtNotRemind"):GetComponent(ty.Text)
    self.mBtnNotRemind = self:getChildGO("mBtnNotRemind")
    self.mImgTipsLitleDes = self:getChildGO("mImgTipsLitleDes")
    self.mTxtTipsLitleDes = self:getChildGO("mTxtTipsLitleDes"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mImgSelect = self:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage)

    self.mBtnClose = self:getChildGO("mBtnClose")

    self:setGuideTrans("guide_AlertMessgeView_BtnConfirm", self.mBtnConfirm.transform)

    self.mTxtStoryTitle = self:getChildGO("MsgStoryTitle"):GetComponent(ty.Text)
    self.mTxtStoryDes = self:getChildGO("MsgStoryDes"):GetComponent(ty.Text)
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_basic_prompt.prefab")
end

-- 设置ui节点名称（ui通过节点名拿ui节点）
function getUiNodeName(self)
    return "ALERT"
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.data = args
    self:setData()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearCancelTimeSn()
    --LoopManager:removeFrame( self, self.updateTxt)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnConfirm, self.onConfirm)
    self:addUIEvent(self.mBtnCancel, self.onCancel)
    self:addUIEvent(self.mBtnNotRemind, self.onClickNotRemindHandler)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function onConfirm(self)
    self:close()
    if self.data.notRemindType then
        if (self.mIsNotRemind) then
            GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {
                moduleId = self.data.notRemindType
            })
        end
    end
    if self.data.confirmCallBack then
        self.data.confirmCallBack(self.data.confirmParam)
    end
end

function onCancel(self)
    self:close()
    if self.data.cancelCallBack then
        self.data.cancelCallBack()
    end
end

function onClickClose(self)
    if self.data.isShowCancel == true then
        self:onCancel()
    else
        self:close()
    end
end

function setData(self)

    self.mTxtStoryTitle.text = self.data.storyTitle
    self.mTxtStoryDes.text = self.data.storyDes
    if self.data.isShowConfirm or self.data.isShowCancel then
        self.mShowType = 1
        self.mGroupOp:SetActive(true)
    else
        self.mShowType = 2
        self.mGroupOp:SetActive(false)
    end

    -- 显示标题
    if self.mShowType == 2 then
    end

    -- 显示内容
    if self.mShowType == 1 then
        if self.data.tipsLitleDes then
            self.mTxtContent.text = self.data.msg .. "<color=#404548>" .. self.data.tipsLitleDes.."</color>"
        else
            self.mTxtContent.text = self.data.msg
        end

        -- if self.data.tipsLitleDes then
        --     self.mImgTipsLitleDes:SetActive(true)
        --     self.mTxtTipsLitleDes.text = self.data.tipsLitleDes
        -- else
        --     self.mImgTipsLitleDes:SetActive(false)
        --     self.mTxtTipsLitleDes.text = ""
        -- end
        --LoopManager:addFrame(2, 1, self, self.updateTxt)
    end

    -- 显示确定按钮
    if self.data.isShowConfirm == false then
        self.mBtnConfirm:SetActive(false)
    else
        self.mBtnConfirm:SetActive(true)
        if self.data.confirmLabel then
            self:setBtnLabel(self.mBtnConfirm, nil, self.data.confirmLabel)
        end
    end
    -- 显示取消按钮
    if self.data.isShowCancel == true then
        self.mBtnCancel:SetActive(true)

        if self.data.cancelTime == nil then
            if self.data.cancelLabel then
                self:setBtnLabel(self.mBtnCancel, nil, self.data.cancelLabel)
            end
        else
            self.m_CancelTime = self.data.cancelTime
            self:refreshCancelLabel(_TT(self.data.cancelLabel, self.data.cancelTime))
            self:clearCancelTimeSn()
            self.m_CancelTimeSn = self:addTimer(1, -1, self.refreshCancelTimeLabel)
        end
    else
        self.mBtnCancel:SetActive(false)
    end
    -- 显示今日是否不再提示
    if self.data.notRemindType == nil then
        self.mBtnNotRemind:SetActive(false)
    else
        self.mBtnNotRemind:SetActive(true)
        -- self.mIsNotRemind = remind.RemindManager:isTodayNotRemain(self.data.notRemindType)
        self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0018.png"), false)
    end

    if self.data.title then
        self.mTxtTips.text = self.data.title
    end

    -- if self.mIsNotRemind then
    --     self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0017.png"), false)
    -- else

    -- end
    -- self:doTween()
end

function refreshCancelTimeLabel(self)
    self.m_CancelTime = self.m_CancelTime - 1
    self:refreshCancelLabel(_TT(self.data.cancelLabel, self.m_CancelTime))
    if self.m_CancelTime <= 0 then
        self:onCancel()
    end
end

function refreshCancelLabel(self, label)
    self:setBtnLabel(self.mBtnCancel, nil, label)
end

function clearCancelTimeSn(self)
    if self.m_CancelTimeSn then
        self:clearTimeout(self.m_CancelTimeSn)
        self.m_CancelTimeSn = nil
    end
end

-- 切换滑动类型
function setMovementType(self)
    local h = self.mTxtContent.preferredHeight + 6
    local scrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    local scrollTrans = self:getChildGO("Scroll View"):GetComponent(ty.RectTransform)
    if h > scrollTrans.sizeDelta.y then
        scrollRect.movementType = gs.ScrollRect.MovementType.Elastic
    else
        scrollRect.movementType = gs.ScrollRect.MovementType.Clamped
    end
end

function onClickNotRemindHandler(self)
    self.mIsNotRemind = not self.mIsNotRemind
    if self.mIsNotRemind then
        self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0017.png"), false)
    else
        self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0018.png"), false)
    end
end

function doTween(self)
    if self.mShowType == 2 then
        gs.TransQuick:LPosX(self.mGroupMessge.transform, -1800)
        TweenFactory:move2LPosX(self.mGroupMessge.transform, -457.36, 0.2, gs.DT.Ease.OutSine)
    end
end
--延迟刷新函数
-- function updateTxt(self)
--     if self.mTxtContentTrans.rect.width >= 650 then
--         self.mTxtContentElement.enabled = true
--     else
--         self.mTxtContentElement.enabled = false
--     end
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mGroupFit"))
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
