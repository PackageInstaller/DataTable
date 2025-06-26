--[[   
     主城数据管理
]]
module("mainCity.MainCityManager", Class.impl(Manager))

--构造函数
function ctor(self)
	super.ctor(self)
     Perset3dHandler:createRoot()
     self:__init()
     self.isLoadCompleted = false
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

function __init(self)
end

function setup(self)
     -- if self.m_isFirstLoaded==false then
     --      self.m_isFirstLoaded = true
     --      -- if not storyTalk.StoryTalkManager:lanuchFirstStory() then
     --           guide.GuideManager:checkResetGuide()
     --      -- end
     -- end
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
