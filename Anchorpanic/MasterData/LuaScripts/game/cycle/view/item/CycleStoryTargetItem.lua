--[[ 
-----------------------------------------------------
@filename       : CycleStoryTargetItem
@Description    : 剧情目标Item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("cycle.CycleStoryTargetItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mPropsGridList = {}

    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroupPro = self:getChildGO("GroupPro")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mGroupContent = self:getChildTrans("Content")
    self.mGroupHasRec = self:getChildGO("GroupHasRec")
    self.mImPro = self:getChildGO("ImPro"):GetComponent(ty.Image)
    self.mTxtIng = self:getChildGO("mTxtIng"):GetComponent(ty.Text)
    -- self.mTextDes = self:getChildGO("TextDes"):GetComponent(ty.Text)
    self.mTextPro = self:getChildGO("TextPro"):GetComponent(ty.Text)
    self.mTextGet = self:getChildGO("TextGet"):GetComponent(ty.Text)
    self.mTextName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    -- self.mScrollView = self:getChildGO("Scroll View"):GetComponent(ty.RectTransform)
    -- self.mScrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    -- self.mGroupContentH = self:getChildGO("Content"):GetComponent(ty.HorizontalLayoutGroup)

    self.mBlackLine = self:getChildGO("mBlackLine"):GetComponent(ty.Image)

    self:addOnClick(self.mBtnGet, self.__onClickRecHandler)

    self.mTextGet.text = _TT(3)
    self.mTxtIng.text = _TT(36520)--进行中
end

function setData(self, param)
    super.setData(self, param)

    self.mData = param
   
    self:recoverAllGrid()
   

        self.mBlackLine.gameObject:SetActive(true)
        if self.mData.state == task.AwardRecState.CAN_REC then
            -- 0:已完成未领奖
            self.mBlackLine.color = gs.ColorUtil.GetColor("ffb644ff")
            self.mBtnGet:SetActive(true)
            self.mGroupHasRec:SetActive(false)
            self.mGroupIng:SetActive(false)
        elseif self.mData.state == task.AwardRecState.UN_REC then
            -- 1:未完成    
            self.mBlackLine.color = gs.ColorUtil.GetColor("000000ff")
            self.mBtnGet:SetActive(false)
            self.mGroupHasRec:SetActive(false)
            self.mGroupIng:SetActive(true)
        else
            -- 2：已领取奖励
            self.mBlackLine.gameObject:SetActive(false)
            self.mBtnGet:SetActive(false)
            self.mGroupHasRec:SetActive(true)
            self.mGroupIng:SetActive(false)
        end

    -- else
    --     self.mBtnGet:SetActive(false)
    --     self.mGroupIng:SetActive(true)
    --     self.mGroupHasRec:SetActive(false)

    --     self.mImPro.fillAmount = 0 / targetConfigVo.targetCount
    --     self.mTextPro.text = 0 .. "/" .. targetConfigVo.targetCount
    -- end
    -- self.mTextName.text = _TT(targetConfigVo.des) -- _TT(1008)
    self.mTextName.text = _TT(self.mData.des)

    local awardList = self.mData.reward
    -- local length = #awardList * 128 + (#awardList - 1) * self.mGroupContentH.spacing
    -- self.mScrollRect.enabled = self.mScrollView.rect.width < length and true or false
    for i = 1, #awardList do
        local propsGrid = PropsGrid:create(self.mGroupContent, awardList[i], 1)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function __onClickRecHandler(self)
    if self.mData.state == task.AwardRecState.CAN_REC then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STORY_AWARD,{id = self.mData.id})
    end
end

function recoverAllGrid(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}
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
	语言包: _TT(1008):	"目标"
]]