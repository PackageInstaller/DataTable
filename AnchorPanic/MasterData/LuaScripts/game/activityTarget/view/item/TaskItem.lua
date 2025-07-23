module("activityTarget.TaskItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mAwardItems = {}

    self.mCanvasGroup = self:getChildGO("CanvasGroup"):GetComponent(ty.CanvasGroup)
    self.mBgImg = self.mCanvasGroup.gameObject:GetComponent(ty.AutoRefImage)
    self.mScoreTxt = self:getChildGO("ScoreTxt"):GetComponent(ty.Text)
    self.mInfoDesTxt = self:getChildGO("InfoDesTxt"):GetComponent(ty.Text)
    self.mSliderBg = self:getChildGO("SliderBg"):GetComponent(ty.RectTransform)
    self.mSliderImg = self:getChildGO("SliderImg"):GetComponent(ty.RectTransform)
    self.mSliderTxt = self:getChildGO("SliderTxt"):GetComponent(ty.Text)
    self.mPropsContent = self:getChildTrans("PropsContent")
    self.mGetBtn = self:getChildGO("GetBtn")
    self.mGetBtnImg = self.mGetBtn:GetComponent(ty.AutoRefImage)
    self.mGetTxt = self:getChildGO("GetBtnTxt"):GetComponent(ty.Text)

    self.mGeted = self:getChildGO("Geted")
    self.mGeted:SetActive(false)
    self:addOnClick(self.mGetBtn, self.__onGetBtnClickHandler)
end

function setData(self, data)
    super.setData(self, data)
    self.data = data
    self.vo = activityTarget.ActivityTargetManager:getTaskVo(data.id)
    if (self.vo == nil) then
        logInfo(data.id .. "的配置不存在")
    end

    self.mScoreTxt.text = data.score
    self.mInfoDesTxt.text = _TT(data.describe)
    self.mSliderTxt.gameObject:SetActive(true)
    self.mSliderTxt.text = "("..self.vo.count .. "/" .. self.data.time ..")"

  
    self.mGetTxt.color =  gs.ColorUtil.GetColor("522500ff")
    if self.vo.m_state == 0 then
        self.mGetTxt.text = _TT(44655) --"领取"
        self.mGetBtnImg:SetImg(UrlManager:getPackPath("activityTarget/activityTarget__3.png"), false)
        --self.mCanvasGroup.alpha = 1
        self.mGetBtn:SetActive(true)
        self.mGeted:SetActive(false)
    elseif self.vo.m_state == 1 then
        self.mGetTxt.text = _TT(44656) --"前往"
        self.mGetTxt.color = gs.COlOR_WHITE
        self.mGetBtnImg:SetImg(UrlManager:getPackPath("activityTarget/activityTarget__4.png"), false)
        self.mCanvasGroup.alpha = 1
        self.mGetBtn:SetActive(true)
        self.mGeted:SetActive(false)
    elseif self.vo.m_state == 2 then
        self.mSliderTxt.gameObject:SetActive(false)
        self.mGetBtn:SetActive(false)
        self.mGeted:SetActive(true)
    end

    gs.TransQuick:SizeDelta01(self.mSliderImg, self.vo.count / data.time * self.mSliderBg.sizeDelta.x)

    self:__clearAwardItems()
    local awardList = data.reward
    for i = 1, #awardList do
        local propsGrid =
            PropsGrid:create(
            self.mPropsContent,
            awardList[i],
            0.6
        )
        table.insert(self.mAwardItems, propsGrid)
    end
end

function onDelete(self)
    super.onDelete(self)

    self:__clearAwardItems()
end

function __clearAwardItems(self)
    for i = 1, #self.mAwardItems do
        self.mAwardItems[i]:poolRecover()
    end
    self.mAwardItems = {}
end

function __onGetBtnClickHandler(self)
    if self.vo.m_state == 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_TARGET_GAIN_AWARD, {id = self.data.id})
    elseif self.vo.m_state == 1 then
        GameDispatcher:dispatchEvent(EventName.HIDE_ACTIVITY_PANEL, {linkId = self.data.uiCode})
    elseif self.vo.m_state == 2 then
        gs.Message.Show(_TT(411))--"已经领取过了")
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
