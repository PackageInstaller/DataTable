module("branchStory.BranchTactivsTabView", Class.impl(branchStory.BranchMainTabView))

UIRes = UrlManager:getUIPrefabPath("branchStory/tab/BranchTactivsTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.BranchTactivs)
end

function setChapterItem(self) 
    return branchStory.BranchTactivsChapterItem
end

function setLastIndex(self)
    branchStory.BranchStoryManager:setLastIndex(branchStory.BranchStoryConst.TACTIVS)
end

function updateView(self,isInit)
    local list = branchStory.BranchTactivsManager:getTactivsChapterConfig()
    local isReshow = branchStory.BranchStoryManager:getBranchStoryReshow()
    for i = 1, #list do 
        if isReshow then 
            list[i].tweenId = nil
        else
            list[i].tweenId = i 
        end
    end

    self.mScroll.DataProvider = list
    -- if (isInit or self.mScroll.Count <= 0) then
    -- else
    --     self.mScroll:ReplaceAllDataProvider(list)
    -- end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
