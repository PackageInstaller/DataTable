module("fashionPermit.FashionPermitTaskItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mNoGet = self:getChildGO("mNoGet")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mGroupIng = self:getChildGO("mGroupIng")
    -- self.mContent = self:getChildTrans("mContent")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    --self.mReceivedGroup = self:getChildGO("mReceivedGroup")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtGoto = self:getChildGO("mTxtGoto"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    --self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)
    self.mGroupGuide = self:getChildGO("mGroupGuide"):GetComponent(ty.CanvasGroup)
    self.mImgTitleState = self:getChildGO("mImgTitleState"):GetComponent(ty.AutoRefImage)
    self.mTxtGet.text = _TT(3) -- 领取
    self.mTxtGoto.text = _TT(4) -- 前往

    self.mTxtExp = self:getChildGO("mTxtExp"):GetComponent(ty.Text)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onOpHandler)
    self:addUIEvent(self.mBtnGoto, self.onOpHandler)
end

function setData(self, data)
    super.setData(self, data)
    self.taskVo = data
    self:updateView()
end

function updateView(self)
    self.mTxtName.text = _TT(self.taskVo.title)
    self.mTxtTitle.text = _TT(self.taskVo.des)

    self.mTxtExp.text = "礼遇经验值<size=26><color=#5fff90>EXP </color>+" .. self.taskVo.exp .. "</size>"
    self.mTxtCurNum.text = _TT(45013, HtmlUtil:colorAndSize(self.taskVo.msgData.count, "141c2bff", 40),self.taskVo.times)

    local state = self.taskVo.msgData.state
    self.mImgTitleState.gameObject:SetActive(state ~= 2)
    self.mGroupIng:SetActive(false)
    self.mGroupGeted:SetActive(false)
    if (state == 2) then
        -- 已领取
        self.mBtnGet:SetActive(false)
        self.mBtnGoto:SetActive(false)
        self.mGroupGeted:SetActive(true)
        self.mGroupGuide:GetComponent(ty.CanvasGroup).alpha = 1
        --self.mReceivedGroup:SetActive(true)
    elseif (state == 0) then
        -- 可领取
        self.mImgTitleState.color = gs.ColorUtil.GetColor("FCAD48ff")
        self.mBtnGet:SetActive(true)
        self.mBtnGoto:SetActive(false)
        self.mGroupGuide:GetComponent(ty.CanvasGroup).alpha = 1
    elseif (state == 1) then
        self.mImgTitleState.color = gs.ColorUtil.GetColor("202226ff")
        self.mNoGet:SetActive(true)
        local linkId = self.taskVo.uiCode
        self.mGroupGuide:GetComponent(ty.CanvasGroup).alpha = 1
        if linkId == 0 then
            self.mGroupIng:SetActive(true)
            self.mBtnGoto:SetActive(false)
            self.mBtnGet:SetActive(false)
        else
            self.mGroupIng:SetActive(false)
            -- 未领取
            self.mBtnGet:SetActive(false)
            self.mBtnGoto:SetActive(true)
        end
    end
end

function onDelete(self)
    super.onDelete(self)
end

function onOpHandler(self)
    local taskConfigVo = self.taskVo
    local state = self.taskVo.msgData.state

    if (state == 2) then
        gs.Message.Show(_TT(7))
    elseif (state == 0) then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_FASHION_PERMIT_TASK, { taskId = self.taskVo.id })
    elseif (state == 1) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = taskConfigVo.uiCode })
    end
end

return _M
