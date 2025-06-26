--[[ 
-----------------------------------------------------
@filename       : ManualStoryListView
@Description    : 图鉴-故事
@date           : 2023-3-5 17:43:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualStoryListView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("manual/ManualStoryListView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mStoyItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mStroyContent = self:getChildTrans("mStroyContent")
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mTxtProgressDes = self:getChildGO("mTxtProgressDes")
end

function active(self, args)
    super.active(self, args)
    if args and args.type then
        self.page = args.type
    else
        self.page = 1
    end
    MoneyManager:setMoneyTidList({})
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
    if self.mEffect then
        LoopManager:removeFrameByIndex(self.mEffect)
        self.mEffect = nil
    end
end

function updateView(self)
    self:closeStoryList()
    if self.page == manual.ManualStoryType.ActivityStory then
        self.mTxtProgressDes:SetActive(false)
        self.mTxtProgress.text = ""
    else
        self.mTxtProgressDes:SetActive(true)
        self.mTxtProgress.text = manual.ManualStoryManager:getUnlockNumByType(self.page) .. "%"
    end
    for _, storyVo in ipairs(manual.ManualStoryManager:getManualStoryListByType(self.page)) do
        local storyItem = SimpleInsItem:create(self.mItem, self.mStroyContent, "ManualStoryListViewstoryItem")
        storyItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(storyVo:getImgUrl(), false)
        storyItem:getChildGO("mTxtName"):GetComponent(ty.Text).text = storyVo:getName() .. " " .. storyVo:getUnlockNum()
        local sprite = gs.ResMgr:Load(UrlManager:getBgPath("sDiagramUi/effect_mask.png"))
        if sprite.texture then
            storyItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage).material:SetTexture("_Mask", sprite.texture)
        elseif sprite then
            storyItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage).material:SetTexture("_Mask", sprite)
        end
        storyItem:getChildGO("mTxtNameBlack"):GetComponent(ty.Text).text = storyVo:getName() .. " " .. storyVo:getUnlockNum()
        storyItem:getChildGO("mImgGroup"):SetActive(storyVo:getIsUnlock())
        storyItem:getChildGO("mImgUnLock"):SetActive((not storyVo:getIsUnlock()))
        storyItem:getChildGO("mNewTans"):SetActive(storyVo:getIsNew())
        storyItem:getChildGO("mTxtUnLock"):GetComponent(ty.Text).text = _TT(25204)
        storyItem:addUIEvent(nil, function()
            if not storyVo:getIsUnlock() then
                gs.Message.Show(_TT(25204))--未解锁
                return
            end
            if storyVo:getIsNew() then
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_MAINSTROY, id = storyVo.chapterId })
            end
            GameDispatcher:dispatchEvent(EventName.OPEN_STORY_INFO_VIEW, { type = storyVo.chapterId })
        end)
        storyItem:getGo():SetActive(false)
        table.insert(self.mStoyItemList, storyItem)
    end
    local effectIndex = 1
    self.mEffect = LoopManager:addFrame(2, #self.mStoyItemList, self, function()
        self.mStoyItemList[effectIndex]:getGo():SetActive(true)
        self.mStoyItemList[effectIndex]:getGo():GetComponent(ty.UIDoTween):BeginTween()
        effectIndex = effectIndex + 1
        if effectIndex > #self.mStoyItemList then
            LoopManager:removeFrameByIndex(self.mEffect)
            self.mEffect = nil
        end
    end)
end

function closeStoryList(self)
    if #self.mStoyItemList > 0 then
        for _, item in ipairs(self.mStoyItemList) do
            item:poolRecover()
            item = nil
        end
        self.mStoyItemList = {}
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]