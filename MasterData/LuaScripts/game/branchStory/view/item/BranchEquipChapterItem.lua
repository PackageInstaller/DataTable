module("branchStory.BranchEquipChapterItem", Class.impl(branchStory.BranchMainChapterItem))

function onClickItemHandler(self)
    local chapterVo = self.data
    if (chapterVo) then
        local canFight = branchStory.BranchStoryManager:canChapterFight(chapterVo.chapterId)
        if (canFight == 1) then
            gs.Message.Show2(chapterVo:getUnLockText())
        elseif canFight == 2 then
            gs.Message.Show2(_TT(3403))
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_EQUIP_STAGE_PANEL, { chapterVo = chapterVo, stageVo = nil })
        end
    end
end

function setData(self, param)
    super.setData(self, param)

    local chapterVo = self.data
    local canFight = branchStory.BranchStoryManager:canChapterFight(chapterVo.chapterId)

    self.mTextName.text = chapterVo:getChapterName()
    self.mIconImg:SetImg(UrlManager:getIconPath(chapterVo.mIconPath))

    if canFight == 1 then
        self.mLockTxt.text = chapterVo:getUnLockText()
    elseif canFight == 2 then
        self.mLockTxt.text = _TT(3403)
    end

    self.mGroupUnlock:SetActive(canFight == 3)
    self.mLockTxt.gameObject:SetActive(canFight < 3)

    if (canFight == 3) then
        self.mIconCanvasGroup.alpha = 1
        self.mLockImg:SetActive(false)
        local current = branchStory.BranchStoryManager:getPassStageCount(chapterVo.chapterId)
        local max = #chapterVo.stageIdList
        self.mTextChapterPro.text = "<size=30><color=#202226>" .. current .."</color></size>/" .. max
        gs.TransQuick:SizeDelta01(
        self.mSlider,
        current / max * self.mSliderBg.sizeDelta.x
        )
    else
        self.mIconCanvasGroup.alpha = 0.6
        self.mLockImg:SetActive(true)
    end

    local color = nil
    if chapterVo.chapterId == 1 then
        color = "5AAD96ff"
    elseif chapterVo.chapterId == 2 then
        color = "629cd7ff"
    elseif chapterVo.chapterId == 3 then 
        color = "c977c5ff"
    elseif chapterVo.chapterId == 4 then
        color = "FEBB3Aff"
    else
        color = "ffffffff"
    end
    self.mImgName.color = gs.ColorUtil.GetColor(color)
    self:updateAwardShow()
end

function updateRedPoint(self)
    local passCount = branchStory.BranchStoryManager:getPassStageCount(self.data.chapterId)
    local isFull = passCount >= #self.data.stageIdList
    if (isFull) then
        local hasRec = branchStory.BranchStoryManager:hasRecChapterAward(self.data.chapterId)
        if (not hasRec) then
            RedPointManager:add(self.mGroupItem.transform, nil, 149, -212)
        else
            RedPointManager:remove(self.mGroupItem.transform)
        end
    else
        RedPointManager:remove(self.mGroupItem.transform)
    end
end

function onDelete(self)
    super.onDelete(self)
    RedPointManager:remove(self.mGroupItem.transform)
    self:recoverAward()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]