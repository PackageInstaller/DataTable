module("branchStory.BranchPowerTabView", Class.impl(branchStory.BranchMainTabView))

UIRes = UrlManager:getUIPrefabPath("branchStory/tab/BranchPowerTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.BranchPower)
end

function setChapterItem(self)
    return branchStory.BranchPowerChapterItem
end

function active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_BRANCH_POWER_PANEL, self.onUpdatePanelHandler, self)
    super.active(self, args)
end

function setLastIndex(self)
    branchStory.BranchStoryManager:setLastIndex(branchStory.BranchStoryConst.POWER)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BRANCH_POWER_PANEL, self.onUpdatePanelHandler, self)
end

function getBranchType(self)
    return branchStory.BranchStoryConst.EQUIP
end

function onUpdatePanelHandler(self, args)
    self:updateView(false)
end

function updateView(self, isInit)
    local list = branchStory.BranchPowerManager:getPowerChapterConfig()
    
    table.sort(list, function(v1, v2)
        local v1Ispass = branchStory.BranchPowerManager:isPass(v1.chapterId)
        local v2Ispass = branchStory.BranchPowerManager:isPass(v2.chapterId)
        if(not v1Ispass and not v2Ispass) then 
            return v1.chapterId < v2.chapterId
        elseif(v1Ispass and v2Ispass) then 
            return v1.chapterId < v2.chapterId
        else
            return v2Ispass 
        end
    end)
    local isReshow = branchStory.BranchStoryManager:getBranchStoryReshow()
    for i = 1, #list do
        if isReshow then
            list[i].tweenId = nil
        else
            list[i].tweenId = i
        end
    end
    self.mScroll.DataProvider = list

end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]