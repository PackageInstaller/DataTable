module("dormitory.DupCodeHopeLevelItem", Class.impl("lib.component.ArcScrollBaseItem"))

function initData(self)
    super.initData(self)
    self.mImgbg = self:getChildGO("mImgbg")
    self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)
    self.mImgProBg = self:getChildGO("mImgProBg"):GetComponent(ty.AutoRefImage)

    self.mTxtExplore = self:getChildGO("mTxtExplore"):GetComponent(ty.Text)
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mTxtExploreState = self:getChildGO("mTxtExploreState"):GetComponent(ty.Text)

    self.mGroupExplore = self:getChildGO("mGroupExplore")
    self.mImgTime = self:getChildGO("mImgTimeBg")
    self.mReceive = self:getChildGO("mReceive")
    self.mComplete = self:getChildGO("mComplete")
    self.mBtnEnter = self:getChildGO("mBtnEnter")

    self:addOnClick(self.mGroupExplore, self.onShowAward)
    self:addOnClick(self.mBtnEnter, self.onEnter)


    self.mTxtExplore.text = _TT(29106) --"探索率"
end

function onEnter(self)
    local isOpen = dup.DupCodeHopeManager:getChapterIsOpen(self.data.page)
    if not isOpen then 
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_CHAPTER, { chapter = self.data.page })
end

function onUpdate(self)
    self:setGuideTrans("funcTips_dupCode_levelItem_"..self.data.page, self:getChildTrans("mBtnEnter"))

    self.mImgbg:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBgPath(string.format("dup/dup_codeHope_enter_%s.png", self.data.page)))

    local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(self.data.page)
    local isGain = dup.DupCodeHopeManager:chapterAwardIsGain(self.data.page)
    local canGet = dup.DupCodeHopeManager:chapterAwardIsCanGet(self.data.page)

    local passTime = dup.DupCodeHopeManager:getChapterPassTime(self.data.page)
    if isGain then
        self.mImgProBg.color =  gs.ColorUtil.GetColor("A1A1A1ff")
        self.mComplete:SetActive(true)
        self.mReceive:SetActive(false)
    else
        if canGet then
            self.mImgProBg.color =  gs.ColorUtil.GetColor("407EDBff")
            self.mReceive:SetActive(true)
        else
            self.mTxtExploreState.gameObject:SetActive(false)
            self.mImgProBg.color =  gs.ColorUtil.GetColor("A1A1A1ff")
            self.mReceive:SetActive(false)
        end
        self.mComplete:SetActive(false)
    end
    self.mImgProBar.fillAmount = passCount / allCount
    self.mTxtPro.text = string.format("%.2f", passCount / allCount) * 100 .. "%"

    local isFlag = dup.DupCodeHopeManager:getChapterFlag(self.data.page)
    if isFlag then
        RedPointManager:add(self.mGroupExplore.transform, nil, -45, 17)
    else
        RedPointManager:remove(self.mGroupExplore.transform)
    end
end

function onSelect(self)
end

function onNormal(self)

end

function UpdateRedState(self,state)
end

function onShowAward(self)
    local chapterVo = dup.DupCodeHopeManager:getChapterData(self.data.page)
    local canGet = dup.DupCodeHopeManager:chapterAwardIsCanGet(self.data.page)
    if not canGet then
        GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_AWARD, { tip = _TT(29107), propsList = chapterVo:getAwardList() })
    else
        local chapterAwardIsGain = dup.DupCodeHopeManager:chapterAwardIsGain(self.data.page)
        if not chapterAwardIsGain then
            GameDispatcher:dispatchEvent(EventName.REQ_CODE_HOPE_CHAPTER_AWARD, self.data.page)
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_AWARD, { tip = _TT(29108), propsList = chapterVo:getAwardList() })
        end
    end
end

function onDelete(self)
    RedPointManager:remove(self.mGroupExplore.transform)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
