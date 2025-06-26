-- @FileName:   LinklinkCardItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.linklink.view.LinklinkCardItem", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, col, row)
    self.m_go.name = col .. "_" .. row

    self.m_col = col
    self.m_row = row

    self:getChildGO("mGroup"):SetActive(false)
    self:getChildGO("mEffect"):SetActive(false)
end

function onHitGroupInfo(self, showEffect)
    self.m_TimerOutSn = LoopManager:setTimeout(0.2, self, function ()
        if showEffect then
            self:getChildGO("mEffect"):SetActive(true)
        end
        self:getChildGO("mGroup"):SetActive(false)
    end)

    self.m_Type = nil
    self.m_CallClass = nil
    self.m_CallBack = nil
end

function setType(self, type, callClass, callback)
    self.m_Type = type

    self.m_CallClass = callClass
    self.m_CallBack = callback

    self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/linklink/icon (%s).png", self.m_Type))
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mClick = self:getChildGO("mClick")
    if self.m_Type == 0 then
        self.mClick:SetActive(false)
    else
        self.mClick:SetActive(true)
        self:addUIEvent("mClick", self.onClick, "arts/audio/UI/minigames/mng_linklink_1.prefab")
    end

    self:getChildGO("mGroup"):SetActive(true)
    self:getChildGO("mEffect"):SetActive(false)

    self:recoverSelect()
end

function recover(self)
    super.recover(self)

    self.m_col = nil
    self.m_row = nil
    self.m_Type = nil

    self.m_CallClass = nil
    self.m_CallBack = nil

    if self.m_TimerOutSn then
        LoopManager:clearTimeout(self.m_TimerOutSn)
        self.m_TimerOutSn = nil
    end
end

function onClick(self)
    self.m_Select = not self.m_Select
    self.mImgSelect:SetActive(self.m_Select)

    if self.m_CallBack then
        self.m_CallBack(self.m_CallClass, self)
    end
end

function recoverSelect(self)
    self.m_Select = false
    self.mImgSelect:SetActive(self.m_Select)
end

function getData(self)
    return {type = self.m_Type, row = self.m_row, col = self.m_col}
end

function getUIPos(self)
    return self.m_trans:GetComponent(ty.RectTransform).anchoredPosition
end

function getPosition(self)
    return self.m_trans.localPosition
end

return _M
