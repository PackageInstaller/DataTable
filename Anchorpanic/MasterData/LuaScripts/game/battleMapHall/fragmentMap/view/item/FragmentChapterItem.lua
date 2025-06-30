--[[ 
    主线关卡章节item
]]
module("battleMap.FragmentChapterItem", Class.impl(lib.component.BaseItemRender))

function onInit(self, go)
    super.onInit(self, go)
    self.mNormal = self:getChildGO("mNormal")
    self.mSelect = self:getChildGO("mSelect")
    self.mLock = self:getChildGO("mLock")
    self.mNameNormal = self:getChildGO("mNameNormal"):GetComponent(ty.Text)
    self.mNameSelect = self:getChildGO("mNameSelect"):GetComponent(ty.Text)
    self.mNameLock = self:getChildGO("mNameLock"):GetComponent(ty.Text)
    self.mIconSelect = self:getChildGO("mIconSelect")
    self.mImgCompleteNormal = self:getChildGO("mImgCompleteNormal")
    self.mImgCompleteSelect = self:getChildGO("mImgCompleteSelect")
    self.mLine = self:getChildGO("mLine")
    self:addUIEvent(self.UIObject, self.onClick)
    self.mNew = self:getChildGO("mNew")
    self.mNewSelect = self:getChildGO("mNewSelect")
    self.mNewLock = self:getChildGO("mNewLock")
end

function deActive(self)
    super.deActive(self)
end

function setData(self, param)
    super.setData(self, param)
    local chapterVo = self.data
    self.mLine:SetActive(not self.data.isEnd) 
    self.showRed = battleMap.FragmentMapManager:getChapterRed(self.data.chapterId)
    self.mNameNormal.text = _TT(chapterVo.m_name)
    self.mNameSelect.text = _TT(chapterVo.m_name)
    self.mNameLock.text = _TT(chapterVo.m_name)
    local lock = battleMap.FragmentMapManager:getChapterIsLock(self.data.chapterId)
    self.mIconSelect:SetActive(lock)
    local complete = battleMap.FragmentMapManager:getChapterComplete(self.data.chapterId)
    self.mImgCompleteNormal:SetActive(complete)
    self.mImgCompleteSelect:SetActive(complete)
    if battleMap.FragmentMapManager:getNowSelectChapter() == self.data.chapterId then 
        if self.showRed then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.FRAGMENTS, id = self.data.chapterId })
        end 
        self.mNormal:SetActive(false)
        self.mSelect:SetActive(true)
        self.mLock:SetActive(false)
    elseif lock then 
        self.mNormal:SetActive(false)
        self.mSelect:SetActive(false)
        self.mLock:SetActive(true)
    else
        self.mNormal:SetActive(true)
        self.mSelect:SetActive(false)
        self.mLock:SetActive(false)
    end 
    self.mNew:SetActive(self.showRed)
    self.mNewSelect:SetActive(self.showRed)
    self.mNewLock:SetActive(self.showRed)
end

function onClick(self)
    battleMap.FragmentMapManager:setNowSelectChapter(self.data.chapterId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]