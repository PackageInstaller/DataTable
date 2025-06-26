--[[ 
-----------------------------------------------------
@filename       : DailyCheckInItem
@Description    :签到item
@date           : 2022-03-13 17:18:58
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("dailyCheckIn.DailyCheckInItem", Class.impl("lib.component.BaseItemRender"))

--构造函数
function ctor(self)
    super.ctor(self)
end

function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)

end

function onInit(self, go)
    super.onInit(self, go)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgRecived = self:getChildGO("mImgRecived")
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mTxtDaily = self:getChildGO("mTxtDaily"):GetComponent(ty.Text)
    self.mTxtPropsNum = self:getChildGO("mTxtPropsNum"):GetComponent(ty.Text)
    self.mIconProps = self:getChildGO("mIconProps"):GetComponent(ty.AutoRefImage)
    self:addOnClick(self.UIObject, self.onClickHandler)
    GameDispatcher:addEventListener(EventName.UPDATE_SIGNIN_ITEM, self.updateState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SELECT_STATE, self.updateSelect, self)
end

function setData(self, param)
    super.setData(self, param)
    self:updateSubBtn()
end

function deActive(self)
    super.deActive(self)
    if self.mTime then
        LoopManager:removeTimerByIndex(self.mTime)
        self.mTime = nil
    end
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.UIObject)
    GameDispatcher:removeEventListener(EventName.UPDATE_SIGNIN_ITEM, self.updateState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_STATE, self.updateSelect, self)
end

function updateSubBtn(self)
    self.mImgSelect:SetActive(self.data:getCanRecivedDaily() == self.data:getCurDaily())
    self.mImgRecived:SetActive(self.data:getIsRecived())
    self.mTxtDaily.text = (self.data:getCurDaily() < 10) and ("0" .. self.data:getCurDaily()) or self.data:getCurDaily()
    self.mTxtPropsNum.text = self.data:getDailyItemNum()
    self.mIconProps:SetImg(self.data:getDailyItemUrl(), false)
end

function updateState(self, awardVo)
    if self.data:getCanRecivedDaily() == self.data:getCurDaily() and self.data:getIsRecived() then
        self.mAni:SetTrigger("recive")
        if self.mTime then
            LoopManager:removeTimerByIndex(self.mTime)
            self.mTime = nil
        end
        local time = AnimatorUtil.getAnimatorClipTime(self.mAni, "mDailyCheckItem_Show")
        self.mTime = LoopManager:addTimer(time, time, self, function()
            self.mImgRecived:SetActive(self.data:getIsRecived())
            ShowAwardPanel:showPropsAwardMsg(awardVo)
        end)
    end
    self:updateSelect(self.data, true)
end

function updateSelect(self, dailyVo, isInit)
    local daily = (isInit == true) and dailyVo:getCanRecivedDaily() or dailyVo:getCurDaily()
    self.mImgSelect:SetActive(daily == self.data:getCurDaily())
end

function onClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SELECT_STATE, self.data)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]