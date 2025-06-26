-- @FileName:   ThreeSheepCardItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.threeSheep.view.ThreeSheepCardItem", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, data)
    self.m_data = data

    self:getGo().name = self.m_data.id
    self:setPos(self.m_data.pos.x, self.m_data.pos.y)
    self:getChildGO("mClick"):SetActive(true)
    self:addUIEvent("mClick", self.onClick)

    local cardConfig = threeSheep.ThreeSheepManager:getCardConfig(self.m_data.grid_id)
    if cardConfig then
        self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(cardConfig:getIconPath())
    end
    self:getChildGO("group"):SetActive(true)

    self:setScale(1, 1, 1)

    self.m_Animator = self:getGo():GetComponent(ty.Animator)
end

function onEditor(self, val)
    if val then
        self:getChildGO("mTextEditor"):SetActive(true)
        self:getChildGO("mTextEditor"):GetComponent(ty.Text).text = string.format("图层%s，id%s,坐标（%s,%s）", self.m_data.layer, self.m_data.id, self.m_data.pos.x, self.m_data.pos.y)
    else
        self:getChildGO("mTextEditor"):SetActive(false)
    end
end

function getData(self)
    return self.m_data
end

function recover(self)
    super.recover(self)

    self.m_data = nil
    self:KillMoveUITweener()

    if self.m_RecoverTimeOut then
        LoopManager:clearTimeout(self.m_RecoverTimeOut)
        self.m_RecoverTimeOut = nil
    end

    self.mMaskValue = nil
end

function setActiveFalse(self)
    self:setActive(false)
end

function tweenPoolRecover(self)
    self.m_Animator:Play("ThreeSheepSceneUI_mCardItem_Enter")
    local time = AnimatorUtil.getAnimatorClipTime(self.m_Animator, "ThreeSheepSceneUI_mCardItem_Enter")
    self.m_HideTimeOut = LoopManager:setTimeout(time, self, self.poolRecover)
end

-- 添加到父节点
function addOnParent01(self, parentTrans)
    self.m_trans:SetParent(parentTrans)
end

function moveUIPos(self, go_rect, anchoredPosition, duration, finishCall)
    self:KillMoveUITweener()

    self.m_MoveUIPosTweener = go_rect:DOMoveUI(anchoredPosition, duration)

    if finishCall then
        self.m_MoveUIPosTweener:OnComplete(finishCall)
    end
end

function KillMoveUITweener(self)
    if self.m_MoveUIPosTweener then
        self.m_MoveUIPosTweener:Kill()
        self.m_MoveUIPosTweener = nil
    end
end

function onClick(self)
    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_yang_1.prefab")

    self:getChildGO("mClick"):SetActive(false)

    if self.m_data.click_call then
        self.m_data.click_call(self.m_data.call_class, self.m_data, self)
    end
end

function recoverClick(self)
    self:getChildGO("mClick"):SetActive(true)
end

function refreshMask(self, value)
    if self.mMaskValue == value then
        return
    end

    self.mMaskValue = value
    self:getChildGO("mMask"):SetActive(value)
end

function refreshInfo(self, value)
    self:getChildGO("group"):SetActive(value)
end

----下层go，上层go
function checkCardMask(self, upperCardGo)
    local underCard_RectTrans = self:getGo():GetComponent(ty.RectTransform)
    local upperCard_RectTrans = upperCardGo:GetComponent(ty.RectTransform)

    local offset = 4--缩进来一点，避免两张卡片平行遮挡，检测不到

    --下层
    local underCard_anchoredPosition = underCard_RectTrans.anchoredPosition
    local underCard_Width, underCard_Height = underCard_RectTrans.rect.width / 2, underCard_RectTrans.rect.height / 2
    local underLTPoint = {x = underCard_anchoredPosition.x - underCard_Width + offset, y = underCard_anchoredPosition.y + underCard_Height - offset} --左上
    local underLDPoint = {x = underCard_anchoredPosition.x - underCard_Width + offset, y = underCard_anchoredPosition.y - underCard_Height + offset}--左下
    local underRDPoint = {x = underCard_anchoredPosition.x + underCard_Width - offset, y = underCard_anchoredPosition.y - underCard_Height + offset}--右下
    local underRTPoint = {x = underCard_anchoredPosition.x + underCard_Width - offset, y = underCard_anchoredPosition.y + underCard_Height - offset} --右上

    --上层
    local upperCard_anchoredPosition = upperCard_RectTrans.anchoredPosition
    local upperCard_Width, upperCard_Height = upperCard_RectTrans.rect.width / 2, upperCard_RectTrans.rect.height / 2
    local upperLTPoint = {x = upperCard_anchoredPosition.x - upperCard_Width, y = upperCard_anchoredPosition.y + upperCard_Height} --左上
    -- local upperLDPoint = {x = upperCard_anchoredPosition.x - upperCard_Width , y = upperCard_anchoredPosition.y - upperCard_Height }--左下
    local upperRDPoint = {x = upperCard_anchoredPosition.x + upperCard_Width, y = upperCard_anchoredPosition.y - upperCard_Height}--右下
    -- local upperRTPoint = {x = upperCard_anchoredPosition.x + upperCard_Width , y = upperCard_anchoredPosition.y + upperCard_Height } --右上

    --下层的四个点是不是在上层的左上跟右下范围内
    if (underLTPoint.x > upperLTPoint.x and underLTPoint.x < upperRDPoint.x) and (underLTPoint.y > upperRDPoint.y and underLTPoint.y < upperLTPoint.y) then
        return true
    elseif (underLDPoint.x > upperLTPoint.x and underLDPoint.x < upperRDPoint.x) and (underLDPoint.y > upperRDPoint.y and underLDPoint.y < upperLTPoint.y) then
        return true
    elseif (underRDPoint.x > upperLTPoint.x and underRDPoint.x < upperRDPoint.x) and (underRDPoint.y > upperRDPoint.y and underRDPoint.y < upperLTPoint.y) then
        return true
    elseif (underRTPoint.x > upperLTPoint.x and underRTPoint.x < upperRDPoint.x) and (underRTPoint.y > upperRDPoint.y and underRTPoint.y < upperLTPoint.y) then
        return true
    end

    return false
end

return _M
