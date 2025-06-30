module("branchStory.BranchMainTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("branchStory/tab/BranchMainTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.BranchStoryMain)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mScroll = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroll:SetItemRender(self:setChapterItem())
end

function setChapterItem(self)
    return branchStory.BranchMainChapterItem
end

function active(self, args)
    super.active(self, args)
    self:setLastIndex()
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
end

function setLastIndex(self)
    branchStory.BranchStoryManager:setLastIndex(branchStory.BranchStoryConst.MAIN)
end

function getBranchType(self)
    return branchStory.TabType.MAIN
end

function updateView(self, isInit)
    local list = branchStory.BranchMainManager:getMainChapterConfig()
    if (isInit or self.mScroll.Count <= 0) then
        self.mScroll.DataProvider = list
    else
        self.mScroll:ReplaceAllDataProvider(list)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]