module("branchStory.BranchEquipTabView", Class.impl(branchStory.BranchMainTabView))

UIRes = UrlManager:getUIPrefabPath("branchStory/tab/BranchEquipTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.BranchStoryEquip)
end

function setChapterItem(self) 
    return branchStory.BranchEquipChapterItem
end

function active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_BRANCH_STORY_PANEL, self.onUpdatePanelHandler, self)
    super.active(self, args)
end

function setLastIndex(self)
    branchStory.BranchStoryManager:setLastIndex(branchStory.BranchStoryConst.EQUIP)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BRANCH_STORY_PANEL, self.onUpdatePanelHandler, self)
end

function getBranchType(self)
    return branchStory.BranchStoryConst.EQUIP
end

function onUpdatePanelHandler(self, args)
    self:updateView(false)
end

function updateView(self, isInit)
    local list = branchStory.BranchStoryManager:getChapterConfigList()
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
