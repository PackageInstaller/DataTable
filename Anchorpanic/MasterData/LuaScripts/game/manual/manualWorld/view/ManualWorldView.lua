--[[ 
-----------------------------------------------------
@filename       : ManualStoryView
@Description    : 图鉴-故事
@date           : 2023-3-5 17:43:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualWorldView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("manual/ManualWorldView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mMaxHeight = 138
    self.mCurShowWordId = 0
    self.mWorldItemList = {}
    self.mWorldMainList = {}
end

function configUI(self)
    super.configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.mMainScrollView = self:getChildTrans("mMainScrollView")
    self.mWorldTotalVTrans = self:getChildGO("mWorldTotalVTrans")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mWorldTotalContent = self:getChildTrans("mWorldTotalContent")
    self.mScrollView = self:getChildTrans("mScrollView")
    self.mTxtCurName = self:getChildGO("mTxtCurName"):GetComponent(ty.Text)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mGroupInfoAni = self:getChildGO("mGroupInfo"):GetComponent(ty.Animator)
    self.mContentRect = self:getChildGO("mTxtContent"):GetComponent(ty.RectTransform)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateNewState, self)
    self.mCurType = args.type
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateNewState, self)
    self:closeStoryList()
    if self.mLoopSn then
        LoopManager:removeFrameByIndex(self.mLoopSn)
        self.mLoopSn = nil
    end
end

function updateView(self)
    self:closeStoryList()
    self.mTxtProgress.text = manual.ManualWorldManager:getCurProgresstByType(self.mCurType) .. "%"
    local curIndex = 1
    local ceilNum = math.ceil(#manual.ManualWorldManager:getTabList(self.mCurType) / 3)
    for i = 1, ceilNum do
        local mainItem = SimpleInsItem:create(self.mWorldTotalVTrans, self.mWorldTotalContent, "ManualStoryViewworldMainItem")
        for k = 1, 3 do
            if curIndex <= #manual.ManualWorldManager:getTabList(self.mCurType) then
                local worldVo = manual.ManualWorldManager:getTabList(self.mCurType)[curIndex]
                worldVo.mainIndex = i
                local item = SimpleInsItem:create(self.mItem, mainItem:getChildTrans("mWorldContent"), "ManualStoryViewworldItem")
                item:setArgs(worldVo)
                item:getChildGO("mTxtName"):GetComponent(ty.Text).text = worldVo:getName()
                item:getChildGO("mImgSelect"):SetActive(false)
                item:getChildGO("mNewTans"):SetActive(worldVo:getIsNew())
                item:addUIEvent(nil, function()
                    if self.mCurShowWordId ~= worldVo.worldId then
                        self:updateDes(worldVo, true)
                    end
                end)
                item:getGo():SetActive(false)
                table.insert(self.mWorldItemList, item)
                curIndex = curIndex + 1
            end
        end
        table.insert(self.mWorldMainList, mainItem)
    end
    curIndex = 1
    self.mLoopSn = LoopManager:addFrame(2, #self.mWorldItemList, self, function()
        self.mWorldItemList[curIndex]:getGo():SetActive(true)
        curIndex = curIndex + 1
        if curIndex > #self.mWorldItemList then
            LoopManager:removeFrameByIndex(self.mLoopSn)
            self.mLoopSn = nil
        end
    end)
    self:updateDes(manual.ManualWorldManager:getTabList(self.mCurType)[1], false)
end

function updateNewState(self)
    if #self.mWorldItemList > 0 then
        for _, WorldItem in ipairs(self.mWorldItemList) do
            WorldItem:getChildGO("mNewTans"):SetActive(WorldItem:getArgs():getIsNew())
        end
    end
end

function updateDes(self, worldVo, isClick)
    for _, item in ipairs(self.mWorldItemList) do
        item:getChildGO("mImgSelect"):SetActive(item:getArgs().worldId == worldVo.worldId)
        if item:getArgs().worldId == worldVo.worldId then
            self.mCurShowWordId = worldVo.worldId
            if isClick then
                self.mGroupInfoAni:SetTrigger("show")
            else
                self.mGroupInfo:SetActive(true)
            end
            self.mGroupInfo.transform:SetParent(self.mWorldMainList[worldVo.mainIndex]:getTrans(), false)
            self.mTxtCurName.text = worldVo:getName()
            self.mTxtDes.text = worldVo:getDes()
            gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mWorldMainList[worldVo.mainIndex]:getTrans())

            LoopManager:addFrame(5, 1, self, function()
                gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupInfo.transform)
                local height = self.mContentRect.rect.height + self:getChildTrans("mGroupName").rect.height
                local VHeight = height > self.mMaxHeight and 155 or height + 20
                local Scrolheight = height > self.mMaxHeight and 243.2 or height + 20
                gs.TransQuick:SizeDelta02(self.mScrollView, Scrolheight)
                gs.TransQuick:SizeDelta02(self:getChildTrans("mTxtViewport"), VHeight)
                gs.TransQuick:SizeDelta02(self:getChildTrans("mGroupInfo"), Scrolheight)
                if #self.mWorldMainList > 0 then
                    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mWorldTotalContent.transform)
                    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mWorldMainList[worldVo.mainIndex]:getTrans())
                    self:checkIsExceed(self.mWorldMainList[worldVo.mainIndex])
                end
            end)
        end
    end
    if worldVo:getIsNew() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_WORLD, id = worldVo.worldId })
    end
end

function checkIsExceed(self, mainItem)
    local locationPosT = math.abs(mainItem:getTrans().anchoredPosition.y) - self.mWorldTotalContent.anchoredPosition.y
    local locationPosD = (locationPosT + mainItem:getTrans().rect.height) - self.mMainScrollView.rect.height
    locationPosT = locationPosT - locationPosT % 0.01
    locationPosD = locationPosD - locationPosD % 0.01
    local movePos = self.mWorldTotalContent.anchoredPosition.y + locationPosT
    movePos = movePos - movePos % 0.01
    if locationPosT < 0 then
        gs.TransQuick:UIPosY(self.mWorldTotalContent, movePos)
    elseif locationPosD > 0 then
        movePos = self.mWorldTotalContent.anchoredPosition.y + locationPosD
        movePos = movePos - movePos % 0.01
        gs.TransQuick:UIPosY(self.mWorldTotalContent, movePos)
    end
end

function closeStoryList(self)
    if #self.mWorldItemList > 0 then
        for _, item in ipairs(self.mWorldItemList) do
            item:getChildGO("mNewTans"):SetActive(item:getArgs():getIsNew())
            item:poolRecover()
            item = nil
        end
        self.mWorldItemList = {}
    end
    if #self.mWorldMainList > 0 then
        self.mGroupInfo.transform:SetParent(self:getChildTrans("Scroll View"), false)
        self.mGroupInfo:SetActive(false)
        for i, item in pairs(self.mWorldMainList) do
            self.mWorldMainList[i]:poolRecover()
            self.mWorldMainList[i] = nil
        end
        self.mWorldMainList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]