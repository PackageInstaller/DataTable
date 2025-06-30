--[[ 
-----------------------------------------------------
@filename       : MainActivitySignItem
@Description    : 活动签到item
@date           : 2023-5-29 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("mainActivity.MainActivitySignItem", Class.impl("lib.component.BaseItemRender"))

--构造函数
function ctor(self)
    super.ctor(self)
end

function onInit(self, go)
    super.onInit(self, go)
    self.mItemList = {}
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnNotGet = self:getChildGO("mBtnNotGet")
    self.mBtnRecived = self:getChildGO("mBtnRecived")
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
    self.mTxtDay = self:getChildGO("mTxtDay"):GetComponent(ty.Text)

    self.mTxtDayEnglish = self:getChildGO("mTxtDayEnglish"):GetComponent(ty.Text)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_SIGN_UPDATE, self.updateState, self)
end




function getEnglishDay(self, day)
    if day == 1 then
        return  "one"
    elseif day == 2 then
        return "two"
    elseif day == 3 then
        return "three"
    elseif day == 4 then
        return "four"
    elseif day == 5 then
        return "five"
    elseif day == 6 then
        return "six"
    elseif day == 7 then
        return "seven"
    elseif day == 8 then
        return "eight"
    elseif day == 9 then
        return "nine"
    elseif day == 10 then
        return "ten"
    elseif day == 11 then
        return "eleven"
    elseif day == 12 then
        return "twelve"
    elseif day == 13 then
        return "thirteen"
    elseif day == 14 then
        return "fourteen"
    elseif day == 15 then
        return "fifteen"
    elseif day == 16 then
        return "sixteen"
    elseif day == 17 then
        return "seventeen"
    elseif day == 18 then
        return "eighteen"
    elseif day == 19 then
        return "nineteen"
    elseif day == 20 then
        return "twenty"
    end
end

function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()
    self:updateState()
    self.mTxtDay.text = self.data:getDaily()
    self.mTxtDayEnglish.text = self:getEnglishDay(self.data.daily)
    local awardList = self.data:getAwardList()
    for _, awardVo in ipairs(self.data:getAwardList()) do
        local propsGrid = PropsGrid:create(self.mAwardTrans, { awardVo[1], awardVo[2] }, 1)
        propsGrid:setCountTextSize(26)
        table.insert(self.mItemList, propsGrid)
    end
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onClickGetHandler)
    self:addUIEvent(self.mBtnNotGet, self.onClickHandler, nil, false)
    self:addUIEvent(self.mBtnRecived, self.onClickHandler, nil, true)
end

function updateState(self)
    self.mBtnGet:SetActive(self.data:getCanReceive())
    self.mBtnRecived:SetActive(self.data:getIsSign())
    self.mBtnNotGet:SetActive((not self.data:getCanReceive()) and (not self.data:getIsSign()))
end

--领取函数
function onClickGetHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_MAINACTIVITY_SIGN, self.data.daily)
end

--前往函数
function onClickHandler(self, isNot)
    if isNot then
        gs.Message.Show(_TT(411))--已领取
    else
        gs.Message.Show(_TT(48117))--签到天数不足，无法领取
    end
end

function recoverAllGrid(self)
    for i = 1, #self.mItemList do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_SIGN_UPDATE, self.updateState, self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]