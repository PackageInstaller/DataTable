module("branchStory.BranchTactivsChapterItem", Class.impl(branchStory.BranchMainChapterItem))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgAwardBg = self:getChildGO("mImgAwardBg")
    self:addOnClick(self.mImgAwardBg, self.onClickHandler)
end

function onClickItemHandler(self)
    local chapterVo = self.data
    self.type = chapterVo.type
    if (chapterVo) then
        local canFight = branchStory.BranchTactivsManager:canTactivsChapterFight(chapterVo.chapterId)
        if (canFight == 1) then
            gs.Message.Show2(chapterVo:getUnLockText())
        elseif canFight == 2 then
            gs.Message.Show2(_TT(3403))
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_TACIVS_PANEL, { chapterVo = chapterVo, stageVo = nil, type = self.type })
        end
    end
end

function setData(self, param)
    super.setData(self, param)
    local chapterVo = self.data
    local canFight = branchStory.BranchTactivsManager:canTactivsChapterFight(chapterVo.chapterId)
    self.mTxtAward.text = _TT(44212)
    self.mTextName.text = chapterVo:getChapterName()
    self.mIconImg:SetImg(UrlManager:getPackPath(chapterVo.mIconPath))
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
        local current = branchStory.BranchTactivsManager:getPassStageCount(chapterVo.chapterId)
        local max = #chapterVo.stageIdList
        self.mTextChapterPro.text = "<size=36>" .. current .. "</size>/" .. max

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
    else
        color = "c977c5ff"
    end
    self.mImgName.color = gs.ColorUtil.GetColor(color)
    self.mImgIndex:SetImg(UrlManager:getPackPath("tacticeTrain/img_zs_num_0" .. chapterVo.chapterId .. ".png"))
    self.mImgIndex.gameObject:SetActive(true)
    self:setGuideTrans("guide_TactivsChapterItem_" .. chapterVo.chapterId, self.UIObject.transform)
    self:updateAwardShow()
end

function updateAwardShow(self)
    self.mGroupAward:SetActive(true)
    local canFight = branchStory.BranchTactivsManager:canTactivsChapterFight(self.data.chapterId)
    if (canFight ~= 3) then
        self.mGroupAward:SetActive(false)
        return
    end
    -- self:recoverAward()
    -- local propsListVo = branchStory.BranchTactivsManager:getTactivsChapterConfigById(self.data.chapterId).awardList[1]
    -- self.mAwardNode.gameObject:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(propsListVo[1]), true)
end

function onClickHandler(self)
    local propsListVo = branchStory.BranchTactivsManager:getTactivsChapterConfigById(self.data.chapterId).awardList[1]
    local propsVo = props.PropsManager:getPropsVo({ tid = propsListVo[1], num = propsListVo[2] })
    local rect = self.mImgAwardBg.transform
    if (propsVo.type ~= PropsType.EQUIP) then
        TipsFactory:propsTips({ propsVo = propsVo, isShowUseBtn = nil }, { rectTransform = rect })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]