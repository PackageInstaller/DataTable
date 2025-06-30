module('battleMap.BiographyItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mSimpleItemList = {}
    self.mLineList = {}
    self.mItemList = {}
    for i=1,4 do 
        self.mLineList[i] = self:getChildGO("Line_"..i)
        self.mItemList[i] = self:getChildGO("BiographyItem_"..i)
    end
end

function setData(self, param)
    super.setData(self, param)
    self:updateView()
end

function updateView(self)
    local dataList = self.data.dataList
    self:recoverItem()
    for i=1,4 do
        if(i > #dataList) then
            self.mLineList[i]:SetActive(false)
        else
            self.mLineList[i]:SetActive(true)
            local heroConfigVo = dataList[i]
            local heroBiographyDataRo = battleMap.BiographyManager:getHeroBiographyConfigVo(heroConfigVo.tid)
            local item = SimpleInsItem:create(self.mItemList[heroBiographyDataRo.type], self.mLineList[i].transform:Find("NodeNext"), "biographyItem"..heroBiographyDataRo.type)
            local mImgBg = item:getChildGO('ImgBg'):GetComponent(ty.AutoRefImage)
            local mGroupUnLock = item:getChildGO('GroupUnLock')
            local mImgNew = item:getChildGO('ImgNew')
            local mProgressBar = item:getChildGO('Bar'):GetComponent(ty.AutoRefImage)
            -- mProgressBar:InitData(3)
            local mShowTxt = item:getChildGO('ShowTxt'):GetComponent(ty.Text)
            local mGroupLock = item:getChildGO('GroupLock')
            local mImgClick = item:getChildGO('ImgClick')
            local TxtName = item:getChildGO('TxtName'):GetComponent(ty.Text)
            local mFollow = item:getChildGO("mImgAttention")
            local mAttention = item:getChildGO("mAttention")
            mImgBg:SetImg(UrlManager:getIconPath("biography/biography_"..heroConfigVo.showModel..".png"), false)
            TxtName.text = heroConfigVo.name
            local isOpen = battleMap.BiographyManager:isBiographyOpen(heroConfigVo.tid)
            local biographyList = battleMap.BiographyManager:getBiographyList(heroConfigVo.tid)
            mAttention:SetActive(isOpen)
            if isOpen then
                local allCount = 0
                local allPassCount = 0
                local isFollow = 0
                for i = 1, #biographyList do
                    local biographyVo = biographyList[i]
                    if(biographyVo.heroTid == heroConfigVo.tid) then 
                        isFollow = biographyVo.isFollow
                    end
                    local dupConfiglist = battleMap.BiographyManager:getDupList(biographyVo.biographyId)
                    allCount = allCount + #dupConfiglist
                    allPassCount = allPassCount + #biographyVo.historyDupList
                end

                mShowTxt.text = math.ceil(allPassCount/allCount*100) .. "%"
                mProgressBar.fillAmount = allPassCount / allCount
                mImgBg:SetGray(false)
                mGroupUnLock:SetActive(true)
                mGroupLock:SetActive(false)
                mFollow:SetActive(isFollow == 1)
            else
                mImgBg:SetGray(true)
                mGroupUnLock:SetActive(false)
                mGroupLock:SetActive(true)
            end

            local function setFollow()
                biographyList[1].isFollow = biographyList[1].isFollow == 0 and 1 or 0
                GameDispatcher:dispatchEvent(EventName.REQ_HERO_FOLLOW, {tid = heroConfigVo.tid, follow = biographyList[1].isFollow})
                -- self:updateView()
                mFollow:SetActive(biographyList[1].isFollow == 1)
            end

            local function click()
                if(isOpen)then  
                    local heroBiographyDataRo = battleMap.BiographyManager:getHeroBiographyConfigVo(heroConfigVo.tid)
                    local biographyId = heroBiographyDataRo:getBiographyList()[1]
                    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_BIOGRAPHY_PANEL, {heroTid = heroConfigVo.tid, biographyId = biographyId})
                else
                    gs.Message.Show2(string.format(_TT(49001), heroConfigVo.name))
                end
            end
            item:addUIEvent("mAttention", setFollow)
            item:addUIEvent(nil, click)
            table.insert(self.mSimpleItemList, item)
        end
    end
end

function deActive(self)
    super.deActive(self)
end

function recoverItem(self)
    for i = 1, #self.mSimpleItemList do 
        if self.mSimpleItemList[i] then 
            self.mSimpleItemList[i]:poolRecover()
        end
    end
    self.mSimpleItemList = {}
end

function onDelete(self)
    super.onDelete(self)
    self:recoverItem()
end

function deActive(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
