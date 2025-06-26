module("rogueLike.RogueLikeTaskItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    --self.mPropsItems = {}
    --self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtStageDesc"):GetComponent(ty.Text)
    self.mTaskBg = self:getChildGO("mTaskBg"):GetComponent(ty.RectTransform)
    self.mTaskBar = self:getChildGO("mTaskBar"):GetComponent(ty.RectTransform)
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    --self.mTaskScore = self:getChildGO("mTaskScore"):GetComponent(ty.Text)

    --self.mGeted = self:getChildGO("mGeted")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGeted = self:getChildGO("mBtnGeted")
    self.mBtnGoto = self:getChildGO("mBtnGoto")

    self.mImgGoing = self:getChildGO("mImgGoing")

    self.mPropsScroll = self:getChildGO("mPropsScroll"):GetComponent(ty.ScrollRect)

    self:addOnClick(self.mBtnGet, self.onClickHandler)
    self:addOnClick(self.mBtnGeted, self.onClickHandler)
    self:addOnClick(self.mBtnGoto, self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)
    self.vo = param.taskVo

    self.serverVo = param.serverVo

    self.mTxtDes.text = _TT(self.vo.des)
    self.mAllTimes = self.vo.times

    --self.mServerVo = rogueLike.RogueLikeManager:getServerTaskInfo(self.vo.id)
    self.mCurrentTimes = self.serverVo.count
    --0-已完成未领奖，1-进行中，2-已完成已领奖
    self.mBtnGet:SetActive(self.serverVo.state == 0)
    self.mImgGoing:SetActive(self.serverVo.state == 1)
    self.mBtnGoto:SetActive(false)
    self.mBtnGeted:SetActive(self.serverVo.state == 2)

    gs.TransQuick:SizeDelta01(self.mTaskBar, self.mCurrentTimes / self.mAllTimes * self.mTaskBg.sizeDelta.x)
    self.mTxtPro.text = self.mCurrentTimes .. "/" .. self.mAllTimes


    self:clearItems()
   
    local reward = AwardPackManager:getAwardListById(self.vo.reward)
    for i = 1, #reward do
        local rewardVo = reward[i]
        local propsGrid = PropsGrid:create(self.mPropsScroll.content, {rewardVo.tid, rewardVo.num}, 1)
        table.insert(self.mPropsItems, propsGrid)
    end
end

function onClickHandler(self)
    if self.serverVo.state == 0 then
        local list = {}
        table.insert(list,self.vo.id)
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_GAIN_TASK,list)
    elseif self.serverVo.state == 1 then
        gs.Message.Show("暂未完成")
    else
        gs.Message.Show("已经完成了")
    end
end

function onDelete(self)
    super.onDelete(self)

    self:clearItems()
end

function deActive(self)
end

function clearItems(self)
    if self.mPropsItems ~=nil then
        for i = 1, #self.mPropsItems do
            self.mPropsItems[i]:poolRecover()
        end
    end

    self.mPropsItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
