module('task.AchievementItem', Class.impl('lib.component.BaseItemRender'))

--构造函数
function ctor(self)
    super.ctor(self)
end

function onInit(self, go)
    super.onInit(self, go)
    self.mPropsGridList = {}
    self.mItemList = {}
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mGroupPro = self:getChildGO("mGroupPro")
    self.mBtnTravel = self:getChildGO("mBtnTravel")
    self.mGroupContent = self:getChildTrans("Content")
    self.mGroupHasRec = self:getChildGO("mGroupHasRec")
    self.mTxtIng = self:getChildGO("mTxtIng"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.AutoRefImage)
    self.mImgStateLine = self:getChildGO("mImgStateLine"):GetComponent(ty.AutoRefImage)
    self.mGroupItem = self:getChildGO("mGroupItem")
    self.mTxtIng.text = _TT(36520)--进行中
    self:addOnClick(self.mBtnGet, self.onClickGetHandler)
    self:addOnClick(self.mBtnTravel, self.onClickTravelHandler)
    self:getChildGO("mTxtGet"):GetComponent(ty.Text).text = _TT(3)
    self:getChildGO("mTxtTravel"):GetComponent(ty.Text).text = _TT(4)
end
function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()
    local achievementVo = self.data
    local achievementConfigVo = task.AchievementManager:getAchievementConfigVo(achievementVo.id, achievementVo.step)
    local curCount = 0
    local color = "202226"
    if (achievementVo) then
        if achievementVo.isChild then
            curCount = achievementConfigVo.targetCount
        else
            curCount = achievementVo.count
        end
        local state = achievementVo:getState()
        self.mBtnGet:SetActive(state == task.AwardRecState.CAN_REC)
        self.mBtnTravel:SetActive(state == task.AwardRecState.UN_REC)
        self.mGroupHasRec:SetActive(state == task.AwardRecState.HAS_REC)
        if (state == task.AwardRecState.CAN_REC) then
            color = "202226"
        elseif (state == task.AwardRecState.HAS_REC) then
            color = "202226"
        end
        self.mImgStateLine.color = (state == task.AwardRecState.CAN_REC) and gs.ColorUtil.GetColor("FFB847ff") or gs.ColorUtil.GetColor("202226ff")
        self.mImgStateLine.gameObject:SetActive((state ~= task.AwardRecState.HAS_REC))
    else
        self.mBtnGet:SetActive(false)
        self.mBtnTravel:SetActive(true)
        self.mGroupHasRec:SetActive(false)
        self.mImgStateLine.gameObject:SetActive(false)
        self.mImgStateLine.color = gs.ColorUtil.GetColor("202226ff")
    end
    self.mTxtPro.text = HtmlUtil:colorAndSize(curCount, color, 30) .. HtmlUtil:color("/" .. achievementConfigVo.targetCount, "202226")
    self.mProgressBar.fillAmount = curCount / achievementConfigVo.targetCount
    self.mImgIcon:SetImg(UrlManager:getPackPath(string.format("achievement/achievement_item_icon_%s.png", achievementConfigVo.tabType)), true)
    self.mTxtName.text = achievementConfigVo:getName()
    self.mTxtDes.text = achievementConfigVo:getDes()
    if self.mBtnTravel.activeSelf == true then
        self.mBtnTravel:SetActive(achievementConfigVo.uicode ~= 0)
        self.mGroupIng:SetActive(achievementConfigVo.uicode == 0)
    else
        self.mGroupIng:SetActive(false)
    end
    local awardList = achievementConfigVo:getAwardList()
    for i = 1, #awardList do
        local propsGrid = PropsGrid:create(self.mGroupContent, awardList[i], 1)
        propsGrid:setCountTextSize(26)
        table.insert(self.mPropsGridList, propsGrid)
    end

end
--领取函数
function onClickGetHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_REC_ACHIEVEMENT_AWARD, { id = self.data.id, step = self.data.step })
end
--前往函数
function onClickTravelHandler(self)
    local achievementConfigVo = task.AchievementManager:getAchievementConfigVo(self.data.id, self.data.step)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = achievementConfigVo.uicode })
end

function recoverAllGrid(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}

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
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]