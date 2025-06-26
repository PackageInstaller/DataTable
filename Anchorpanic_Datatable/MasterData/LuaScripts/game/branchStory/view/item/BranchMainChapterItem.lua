module("branchStory.BranchMainChapterItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mAwardList = {}
    self.mGroupLock = self:getChildGO("GroupLock")
	self.mGroupUnlock = self:getChildGO("GroupUnlock")
	self.mTextName = self:getChildGO("TextName"):GetComponent(ty.Text)
	self.mTextChapterPro = self:getChildGO("TextChapterPro"):GetComponent(ty.Text)
    self.mLockTxt = self:getChildGO("LockTxt"):GetComponent(ty.Text)
    self.mSliderBg = self:getChildGO("SliderBg"):GetComponent(ty.RectTransform)
    self.mSlider = self:getChildGO("Slider"):GetComponent(ty.RectTransform)
    self.mIconImg = self:getChildGO("Icon"):GetComponent(ty.AutoRefImage)
    self.mIconCanvasGroup = self.mIconImg.gameObject:GetComponent(ty.CanvasGroup)
    self.mLockImg = self:getChildGO("LockImg")
    
	self.mImgName = self:getChildGO("mImgName"):GetComponent(ty.Image)
    self.mImgIndex = self:getChildGO("mImgIndex"):GetComponent(ty.AutoRefImage)
    self.mGroupAward = self:getChildGO("mGroupAward")
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
    self.mTxtAward.text = _TT(116)
    self.mAwardNode = self:getChildTrans("mAwardLayout")
    self:addOnClick(self.UIObject, self.onClickItemHandler)
end

function getGO(self)
    return self.UIObject
end

function updateAwardShow(self)
    self:recoverAward()
    local canFight = branchStory.BranchStoryManager:canChapterFight(self.data.chapterId)

    if(canFight ~= 3) then 
        self.mGroupAward:SetActive(false)
        return
    end
    self.mGroupAward:SetActive(true)
    local propsList = AwardPackManager:getAwardListById(self.data.dropId)
    for k,v in pairs(propsList) do
        local propsGrid = PropsGrid:createByData({ tid = v.tid, num = v.num, parent = self.mAwardNode, scale = 1, showUseInTip = true })
        table.insert(self.mAwardList, propsGrid)
    end
    self:updateRedPoint()
end

function updateRedPoint(self)
    local passCount = branchStory.BranchStoryManager:getPassStageCount(self.data.chapterId)
    local isFull = passCount >= #self.data.stageIdList
    if (isFull) then
        local hasRec = branchStory.BranchStoryManager:hasRecChapterAward(self.data.chapterId)
        if (not hasRec) then
            RedPointManager:add(self.mGroupItem.transform, nil, -144, 151.5)
        else
            RedPointManager:remove(self.mGroupItem.transform)
        end
    else
        RedPointManager:remove(self.mGroupItem.transformm)
    end
end

function onClickItemHandler(self)
    local chapterVo = self.data
    self.type = chapterVo.type
    if(chapterVo)then
        local canFight = branchStory.BranchMainManager:canMainChapterFight(chapterVo.chapterId)
        if canFight == 1 then
            gs.Message.Show2(chapterVo:getUnLockText())
        elseif canFight == 2 then
            gs.Message.Show2(_TT(3403))
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_MAIN_PANEL, {chapterVo = chapterVo, stageVo = nil,type = self.type})
        end
    end
end

function recoverAward(self)
    for i=1, #self.mAwardList do
        self.mAwardList[i]:poolRecover()
    end
    self.mAwardList = {}
end

function onDelete(self)
    super.onDelete(self)
    if self:getGO() then
        RedPointManager:remove(self.mGroupItem.transform)
    end
    self:recoverAward()
end

function setData(self, param)
    super.setData(self, param)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
